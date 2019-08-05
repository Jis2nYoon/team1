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
/* Table Name: ī�װ� */
/**********************************/
CREATE TABLE category(
		cateno                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		catename                      		VARCHAR2(50)		 NULL ,
		contentscnt                   		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		seqno                         		NUMBER(10)		 NULL 
);

COMMENT ON TABLE category is 'ī�װ�';
COMMENT ON COLUMN category.cateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN category.catename is 'ī�װ���';
COMMENT ON COLUMN category.contentscnt is '����������';
COMMENT ON COLUMN category.seqno is '��¼���';


/**********************************/
/* Table Name: ȸ�� */
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

COMMENT ON TABLE fmember is 'ȸ��';
COMMENT ON COLUMN fmember.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN fmember.email is '�̸��� ����';
COMMENT ON COLUMN fmember.passwd is '�н�����';
COMMENT ON COLUMN fmember.nickname is '�г���';
COMMENT ON COLUMN fmember.mname is '�̸�';
COMMENT ON COLUMN fmember.tel is '��ȭ';
COMMENT ON COLUMN fmember.zipcode is '�����ȣ';
COMMENT ON COLUMN fmember.address is '�ּ�';
COMMENT ON COLUMN fmember.act is '���� ����';
COMMENT ON COLUMN fmember.stopdate is '���� ������';
COMMENT ON COLUMN fmember.mdate is '���Գ�¥';


/**********************************/
/* Table Name: �ŷ��Խñ� */
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

COMMENT ON TABLE content is '�ŷ��Խñ�';
COMMENT ON COLUMN content.contentsno is '������ ��ȣ';
COMMENT ON COLUMN content.cateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN content.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN content.title is '������';
COMMENT ON COLUMN content.contents is '�۳���';
COMMENT ON COLUMN content.picture is '����';
COMMENT ON COLUMN content.rdate is '��ϳ�¥';


/**********************************/
/* Table Name: ��� */
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

COMMENT ON TABLE reply is '���';
COMMENT ON COLUMN reply.replyno is '��� ��ȣ';
COMMENT ON COLUMN reply.replycont is '��� ����';
COMMENT ON COLUMN reply.contentsno is '������ ��ȣ';
COMMENT ON COLUMN reply.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN reply.rdate is '��۵�ϳ�¥';
COMMENT ON COLUMN reply.grpno is '��ۼ���';
COMMENT ON COLUMN reply.indent is '�鿩����';
COMMENT ON COLUMN reply.ansnum is '���ۼ���';


/**********************************/
/* Table Name: �α� */
/**********************************/
CREATE TABLE log(
		logno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY
);

COMMENT ON TABLE log is '�α�';
COMMENT ON COLUMN log.logno is '�α� ��ȣ';


/**********************************/
/* Table Name: �� ��� */
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

COMMENT ON TABLE fgrade is '�� ���';
COMMENT ON COLUMN fgrade.gradeno is '�򰡵�� ��ȣ';
COMMENT ON COLUMN fgrade.numgrade is '�Ű��� �� ��';
COMMENT ON COLUMN fgrade.avggrade is '��ü �������';
COMMENT ON COLUMN fgrade.manner is '�Ǹ����µ�';
COMMENT ON COLUMN fgrade.delivery is '��ۼӵ�';
COMMENT ON COLUMN fgrade.quality is '��ǰǰ��';
COMMENT ON COLUMN fgrade.memberno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: �α��γ��� */
/**********************************/
CREATE TABLE flogin(
		loginno                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		ip                            		VARCHAR2(15)		 NOT NULL,
		ldate                         		DATE		 NOT NULL,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE flogin is '�α��γ���';
COMMENT ON COLUMN flogin.loginno is '�α��γ��� ��ȣ';
COMMENT ON COLUMN flogin.ip is '������ �ּ�';
COMMENT ON COLUMN flogin.ldate is '�α��� ��¥';
COMMENT ON COLUMN flogin.memberno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: �����亯 */
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

COMMENT ON TABLE qna is '�����亯';
COMMENT ON COLUMN qna.qnano is '�����亯 ��ȣ';
COMMENT ON COLUMN qna.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN qna.title is '����';
COMMENT ON COLUMN qna.content is '����';
COMMENT ON COLUMN qna.img is '��������';
COMMENT ON COLUMN qna.rdate is '��ϳ�¥';


/**********************************/
/* Table Name: �������� */
/**********************************/
CREATE TABLE notice(
		noticeno                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		title                         		CLOB(100)		 NOT NULL,
		content                       		CLOB(1000)		 NOT NULL,
		rdate                         		DATE		 NOT NULL,
		memberno                      		NUMBER(10)		 NULL ,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE notice is '��������';
COMMENT ON COLUMN notice.noticeno is '�������� ��ȣ';
COMMENT ON COLUMN notice.title is '����';
COMMENT ON COLUMN notice.content is '����';
COMMENT ON COLUMN notice.rdate is '��ϳ�¥';
COMMENT ON COLUMN notice.memberno is 'ȸ�� ��ȣ';


/**********************************/
/* Table Name: ����ã������ */
/**********************************/
CREATE TABLE faq(
		faqno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		question                      		CLOB(100)		 NOT NULL,
		answer                        		CLOB(1000)		 NOT NULL
);

COMMENT ON TABLE faq is '����ã������';
COMMENT ON COLUMN faq.faqno is '���� ��ȣ';
COMMENT ON COLUMN faq.question is '����';
COMMENT ON COLUMN faq.answer is '�亯';


/**********************************/
/* Table Name: ä�� */
/**********************************/
CREATE TABLE chatroom(
		chatroomno                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		memberno                      		NUMBER(10)		 NOT NULL,
		accessno                      		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE chatroom is 'ä��';
COMMENT ON COLUMN chatroom.chatroomno is 'ä�ù� ��ȣ';
COMMENT ON COLUMN chatroom.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN chatroom.accessno is '���� ȸ�� ��ȣ';


/**********************************/
/* Table Name: �޼��� */
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

COMMENT ON TABLE message is '�޼���';
COMMENT ON COLUMN message.messageno is '�޼��� ��ȣ';
COMMENT ON COLUMN message.chatroomno is 'ä�ù� ��ȣ';
COMMENT ON COLUMN message.message_sender is '������ ���';
COMMENT ON COLUMN message.message_receiver is '�޴� ���';
COMMENT ON COLUMN message.message_content is '�޼��� ����';
COMMENT ON COLUMN message.message_time is '�޼��� ���� �ð�';


