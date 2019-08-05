DROP TABLE message CASCADE CONSTRAINTS;
DROP TABLE chatroom CASCADE CONSTRAINTS;
DROP TABLE faq CASCADE CONSTRAINTS;
DROP TABLE notice CASCADE CONSTRAINTS;
DROP TABLE qna CASCADE CONSTRAINTS;
DROP TABLE flogin CASCADE CONSTRAINTS;
DROP TABLE fgrade CASCADE CONSTRAINTS;
DROP TABLE log CASCADE CONSTRAINTS;
DROP TABLE reply CASCADE CONSTRAINTS;
DROP TABLE content CASCADE CONSTRAINTS;
DROP TABLE fmember CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 카테고리 */
/**********************************/
CREATE TABLE category(
		cateno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		catename                      		VARCHAR2(50)		 NULL ,
		contentscnt                   		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		seqno                         		NUMBER(10)		 NULL 
);

COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.cateno is '카테고리 번호';
COMMENT ON COLUMN category.catename is '카테고리명';
COMMENT ON COLUMN category.contentscnt is '컨텐츠개수';
COMMENT ON COLUMN category.seqno is '출력순서';


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE fmember(
		memberno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		email                         		VARCHAR2(50)		 NOT NULL,
		passwd                        		VARCHAR2(60)		 NOT NULL,
		nickname                      		VARCHAR2(30)		 NOT NULL,
		mname                         		VARCHAR2(20)		 NOT NULL,
		tel                           		VARCHAR2(14)		 NOT NULL,
		zipcode                       		VARCHAR2(5)		 NULL ,
		address                       		VARCHAR2(80)		 NULL ,
		act                           		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		stopdate                      		DATE		 NULL ,
		mdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE fmember is '회원';
COMMENT ON COLUMN fmember.memberno is '회원 번호';
COMMENT ON COLUMN fmember.email is '이메일 계정';
COMMENT ON COLUMN fmember.passwd is '패스워드';
COMMENT ON COLUMN fmember.nickname is '닉네임';
COMMENT ON COLUMN fmember.mname is '이름';
COMMENT ON COLUMN fmember.tel is '전화';
COMMENT ON COLUMN fmember.zipcode is '우편번호';
COMMENT ON COLUMN fmember.address is '주소';
COMMENT ON COLUMN fmember.act is '계정 상태';
COMMENT ON COLUMN fmember.stopdate is '계정 정지일';
COMMENT ON COLUMN fmember.mdate is '가입날짜';


/**********************************/
/* Table Name: 거래게시글 */
/**********************************/
CREATE TABLE content(
		contentsno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		cateno                        		NUMBER(10)		 NOT NULL,
		memberno                      		NUMBER(10)		 NOT NULL,
		title                         		VARCHAR2(200)		 NOT NULL,
		contents                      		CLOB		 NOT NULL,
		picture                       		CLOB		 NULL ,
		rdate                         		DATE		 NOT NULL,
  FOREIGN KEY (cateno) REFERENCES category (cateno),
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE content is '거래게시글';
COMMENT ON COLUMN content.contentsno is '컨텐츠 번호';
COMMENT ON COLUMN content.cateno is '카테고리 번호';
COMMENT ON COLUMN content.memberno is '회원 번호';
COMMENT ON COLUMN content.title is '글제목';
COMMENT ON COLUMN content.contents is '글내용';
COMMENT ON COLUMN content.picture is '사진';
COMMENT ON COLUMN content.rdate is '등록날짜';


/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE reply(
		replyno                       		NUMBER(8)		 NOT NULL		 PRIMARY KEY,
		replycont                     		VARCHAR2(512)		 NOT NULL,
		contentsno                    		NUMBER(10)		 NOT NULL,
		memberno                      		NUMBER(10)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		grpno                         		NUMBER(8)		 DEFAULT 0		 NOT NULL,
		indent                        		NUMBER(8)		 DEFAULT 0		 NOT NULL,
		ansnum                        		NUMBER(8)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (contentsno) REFERENCES content (contentsno),
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.replyno is '댓글 번호';
COMMENT ON COLUMN reply.replycont is '댓글 내용';
COMMENT ON COLUMN reply.contentsno is '컨텐츠 번호';
COMMENT ON COLUMN reply.memberno is '회원 번호';
COMMENT ON COLUMN reply.rdate is '댓글등록날짜';
COMMENT ON COLUMN reply.grpno is '댓글순서';
COMMENT ON COLUMN reply.indent is '들여쓰기';
COMMENT ON COLUMN reply.ansnum is '대댓글순서';


/**********************************/
/* Table Name: 로그 */
/**********************************/
CREATE TABLE log(
		logno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE log is '로그';
COMMENT ON COLUMN log.logno is '로그 번호';


/**********************************/
/* Table Name: 평가 등급 */
/**********************************/
CREATE TABLE fgrade(
		gradeno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		numgrade                      		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		avggrade                      		NUMBER(2,1)		 DEFAULT 0		 NOT NULL,
		manner                        		NUMBER(2,1)		 DEFAULT 0		 NOT NULL,
		delivery                      		NUMBER(2,1)		 DEFAULT 0		 NOT NULL,
		quality                       		NUMBER(2,1)		 DEFAULT 0		 NOT NULL,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE fgrade is '평가 등급';
COMMENT ON COLUMN fgrade.gradeno is '평가등급 번호';
COMMENT ON COLUMN fgrade.numgrade is '매겨진 평가 수';
COMMENT ON COLUMN fgrade.avggrade is '전체 평균평점';
COMMENT ON COLUMN fgrade.manner is '판매자태도';
COMMENT ON COLUMN fgrade.delivery is '배송속도';
COMMENT ON COLUMN fgrade.quality is '상품품질';
COMMENT ON COLUMN fgrade.memberno is '회원 번호';


/**********************************/
/* Table Name: 로그인내역 */
/**********************************/
CREATE TABLE flogin(
		loginno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ip                            		VARCHAR2(15)		 NOT NULL,
		ldate                         		DATE		 NOT NULL,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE flogin is '로그인내역';
COMMENT ON COLUMN flogin.loginno is '로그인내역 번호';
COMMENT ON COLUMN flogin.ip is '아이피 주소';
COMMENT ON COLUMN flogin.ldate is '로그인 날짜';
COMMENT ON COLUMN flogin.memberno is '회원 번호';


/**********************************/
/* Table Name: 질문답변 */
/**********************************/
CREATE TABLE qna(
		qnano                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NOT NULL,
		title                         		CLOB(100)		 NOT NULL,
		content                       		CLOB(1000)		 NOT NULL,
		img                           		VARCHAR2(100)		 NULL ,
		rdate                         		DATE		 NOT NULL,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE qna is '질문답변';
COMMENT ON COLUMN qna.qnano is '질문답변 번호';
COMMENT ON COLUMN qna.memberno is '회원 번호';
COMMENT ON COLUMN qna.title is '제목';
COMMENT ON COLUMN qna.content is '내용';
COMMENT ON COLUMN qna.img is '사진파일';
COMMENT ON COLUMN qna.rdate is '등록날짜';


/**********************************/
/* Table Name: 공지사항 */
/**********************************/
CREATE TABLE notice(
		noticeno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		title                         		CLOB(100)		 NOT NULL,
		content                       		CLOB(1000)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE notice is '공지사항';
COMMENT ON COLUMN notice.noticeno is '공지사항 번호';
COMMENT ON COLUMN notice.title is '제목';
COMMENT ON COLUMN notice.content is '내용';
COMMENT ON COLUMN notice.rdate is '등록날짜';
COMMENT ON COLUMN notice.memberno is '회원 번호';


/**********************************/
/* Table Name: 자주찾는질문 */
/**********************************/
CREATE TABLE faq(
		faqno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		question                      		CLOB(100)		 NOT NULL,
		answer                        		CLOB(1000)		 NOT NULL
);

COMMENT ON TABLE faq is '자주찾는질문';
COMMENT ON COLUMN faq.faqno is '질문 번호';
COMMENT ON COLUMN faq.question is '질문';
COMMENT ON COLUMN faq.answer is '답변';


/**********************************/
/* Table Name: 채팅 */
/**********************************/
CREATE TABLE chatroom(
		chatroomno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NOT NULL,
		accessno                      		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE chatroom is '채팅';
COMMENT ON COLUMN chatroom.chatroomno is '채팅방 번호';
COMMENT ON COLUMN chatroom.memberno is '회원 번호';
COMMENT ON COLUMN chatroom.accessno is '접근 회원 번호';


/**********************************/
/* Table Name: 메세지 */
/**********************************/
CREATE TABLE message(
		messageno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		chatroomno                    		NUMBER(10)		 NOT NULL,
		message_sender                		VARCHAR2(20)		 NOT NULL,
		message_receiver              		VARCHAR2(20)		 NOT NULL,
		message_content               		CLOB(100)		 NOT NULL,
		message_time                  		DATE		 NOT NULL,
  FOREIGN KEY (chatroomno) REFERENCES chatroom (chatroomno)
);

COMMENT ON TABLE message is '메세지';
COMMENT ON COLUMN message.messageno is '메세지 번호';
COMMENT ON COLUMN message.chatroomno is '채팅방 번호';
COMMENT ON COLUMN message.message_sender is '보내는 사람';
COMMENT ON COLUMN message.message_receiver is '받는 사람';
COMMENT ON COLUMN message.message_content is '메세지 내용';
COMMENT ON COLUMN message.message_time is '메세지 보낸 시간';


