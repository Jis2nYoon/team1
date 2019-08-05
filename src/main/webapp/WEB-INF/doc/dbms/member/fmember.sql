--거래 게시글 테이블 삭제
DROP TABLE content;  
--로그인 내역 테이블 삭제
DROP TABLE fgrade;
--회원등급 테이블 삭제
DROP TABLE flogin;
--회원 테이블 삭제
DROP TABLE fmember;


/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE fmember(
		memberno             		NUMBER(10)		   NOT NULL		 PRIMARY KEY,
		email                     		VARCHAR2(50)		 NOT NULL    UNIQUE,
		passwd                  		VARCHAR2(60)		 NOT NULL,
		thumbs                    VARCHAR2(100)       NULL ,
    photo                      VARCHAR2(200)       NULL ,
    sizes                        VARCHAR2(100)       NULL,
		nickname               		VARCHAR2(30)		 NOT NULL,
		mname                  		VARCHAR2(20)		 NOT NULL,
		tel                        		VARCHAR2(14)		 NOT NULL,
		zipcode                  		VARCHAR2(5)		 NULL ,
		address1                   VARCHAR2(80)   NULL, -- 주소 1
    address2                   VARCHAR2(50)   NULL, -- (상세) 주소 2
		act                        		CHAR(1)		         DEFAULT 'Y'		 NOT NULL,
		stopdate                		DATE		             NULL ,
		mdate                   		DATE		             NOT NULL
);

-- stopdate = 계정이 정지되었을 때 날짜 값을 가짐
--  act = M: 마스터, Y: 로그인 가능, N: 로그인 불가, C: 탈퇴

COMMENT ON TABLE fmember is '회원';
COMMENT ON COLUMN fmember.memberno is '회원 번호';
COMMENT ON COLUMN fmember.email is '이메일 계정';
COMMENT ON COLUMN fmember.passwd is '패스워드';
COMMENT ON COLUMN fmember.thumbs is '프로필사진 썸네일';
COMMENT ON COLUMN fmember.photo is '프로필사진 원본';
COMMENT ON COLUMN fmember.sizes is '사진 파일 크기';
COMMENT ON COLUMN fmember.nickname is '닉네임';
COMMENT ON COLUMN fmember.mname is '이름';
COMMENT ON COLUMN fmember.tel is '전화';
COMMENT ON COLUMN fmember.zipcode is '우편번호';
COMMENT ON COLUMN fmember.address1 is '주소';
COMMENT ON COLUMN fmember.address2 is '상세주소';
COMMENT ON COLUMN fmember.act is '계정 상태';
COMMENT ON COLUMN fmember.stopdate is '계정 정지일';
COMMENT ON COLUMN fmember.mdate is '가입날짜';


----------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
1) 삽입*******  (사용/grade 테이블 만들고 난 후 실행)
-- grade 와 함께 insert 되기 위한 insert all 문 ********

INSERT ALL
  INTO fmember VALUES (memberno, 
  'master@mail.com', '123','','','0', '마스터', '마숙허', '010-0000-0101', '11311', 
  '경기도 고양시' , '덕양구', 'M','', sysdate)  
  INTO fgrade VALUES ((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 0, 0, 0, 0, memberno)
 SELECT (NVL(MAX(memberno), 0)+1) as memberno 
 FROM fmember;


--기본 member table 삽입 (참고)
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode, address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'master@mail.com', '123', '왕눈이', '홍길동', '010-0000-0101', '11311', '경기도 고양시' , '덕양구', 'Y','', sysdate);
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode, address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user1@mail.com', '123', '아로미', '홍길봉', '010-0000-0102', '11312', '경기도 고양시', '덕양구', 'Y','', sysdate);
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user2@mail.com', '123', '왕눈스', '봉길홍', '010-0000-0103', '11313', '경기도 고양시', '덕양구', 'Y','', sysdate);
   
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode, address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user3@mail.com', '123', '아로미72', '홍길봉', '010-0000-0102', '11312', '경기도 고양시', '덕양구', 'Y','', sysdate);
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user4@mail.com', '123', '왕눈스4', '봉길홍', '010-0000-0103', '11313', '경기도 고양시', '덕양구', 'Y','', sysdate);
   
  INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode, address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user5@mail.com', '123', '아로미21', '홍길봉', '010-0000-0102', '11312', '경기도 고양시', '덕양구', 'Y','', sysdate);
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user6@mail.com', '123', '왕눈스1', '봉길홍', '010-0000-0103', '11313', '경기도 고양시', '덕양구', 'Y','', sysdate);
   
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'lastuser@mail.com', '123', '왕보스', '부비후', '010-0000-0103', '11313', '경기도 고양시', '덕양구', 'Y','', sysdate);
  
 2) 목록

SELECT memberno, email, passwd,  thumbs, photo, sizes, nickname, mname, tel, zipcode,  address1, address2 , act, stopdate, mdate
FROM fmember
ORDER BY memberno ASC;

2-1) 검색
SELECT memberno, email, passwd, thumbs, photo, sizes, nickname, mname, tel, zipcode,  address1, address2 , act, stopdate, mdate
FROM fmember
WHERE email like '%mas%'
ORDER BY memberno ASC;

2-2) 전체목록 페이징
SELECT memberno, email, passwd,  thumbs,  sizes, nickname, mname, tel, zipcode,  
          address1, address2 , act, stopdate, mdate, r
FROM(
         SELECT memberno, email, passwd, thumbs,  sizes, nickname, mname, tel, zipcode,  
                   address1, address2 , act, stopdate, mdate, rownum as r
         FROM(
                  SELECT memberno, email, passwd, thumbs,  sizes, nickname, mname, tel, zipcode,  
                            address1, address2 , act, stopdate, mdate
                  FROM fmember
                  ORDER BY memberno ASC
         )
)
WHERE r >=7 AND r <= 9;

2-3) 전체목록 페이징 + 검색
 SELECT memberno, email, passwd, thumbs,  sizes, nickname, mname, tel, zipcode,  
              address1, address2 , act, stopdate, mdate, r
    FROM(
             SELECT memberno, email, passwd, thumbs, sizes, nickname, mname, tel, zipcode,  
                      address1, address2 , act, stopdate, mdate, rownum as r
             FROM(
                      SELECT memberno, email, passwd, thumbs, sizes, nickname, mname, tel, zipcode,  
                                address1, address2 , act, stopdate, mdate
                      FROM fmember
                      <choose>                        
                        <when test="col == 'email'"> <!-- email 검색 -->
                          WHERE email LIKE '%' || #{word} || '%'
                        </when>
                        <when test="col == 'nickname'"> <!-- nickname 검색 -->
                          WHERE nickname LIKE '%' || #{word} || '%'
                        </when>
                        <when test="col == 'mname'"> <!-- mname 검색 -->
                          WHERE mname LIKE '%' || #{word} || '%'
                        </when>                          
                        <when test="col == 'act'"> <!-- act 필터 -->
                          WHERE act = #{word}
                        </when>       
                        <when test="col == 'stopdate'"><!--  stopdate 정렬 -->
                          ORDER BY stopdate ASC
                        </when>    
                        <otherwise>            
                          ORDER BY memberno ASC
                        </otherwise>         
                      </choose>
             )
    )
    WHERE <![CDATA[r >= #{startNum} AND r <= #{endNum}]]>
    
3) 조회

SELECT memberno, email, passwd, thumbs, photo, sizes, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate
FROM fmember
WHERE memberno =2;

3-1) 프로필 이미지 조회
SELECT thumbs, photo, sizes
FROM fmember
WHERE memberno =1;
  
4) 수정
UPDATE fmember
SET passwd='123', nickname = '아롬스', mname='홍순이', act = 'M' 
WHERE memberno =1;

UPDATE fmember
SET act = 'M'
WHERE memberno =1;

UPDATE fmember
SET thumbs='thumbs.jpg', photo = 'photo.jpg'
WHERE memberno =1;

4-1) 탈퇴 수정
UPDATE fmember
SET nickname = '.', zipcode='',  address1='', address2='', act = 'C', stopdate='' ,thumbs='', photo='', sizes=''
WHERE memberno =2;

4-2)비밀번호 수정
UPDATE fmember
SET passwd='123'
WHERE email ='jjhre@naver.com';
 

SELECT memberno, email, passwd, thumbs, photo, sizes, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate
FROM fmember
ORDER BY memberno ASC; 
 
5) 삭제
DELETE FROM fmember
COMMIT;

DELETE FROM flogin
WHERE memberno = 10;

DELETE FROM fgrade
WHERE memberno = 10;

DELETE FROM fmember
WHERE memberno = 10;

6)날짜 처리
update fmember
set stopdate = TO_DATE('2019-05-25 06:00:00', 'YYYY-MM-DD HH:MI:SS')
where memberno = 5;

7) 이메일 중복 체크
SELECT COUNT(email) as cnt
FROM fmember
WHERE email=#{email};

8) 닉네임 중복 체크
SELECT COUNT(nickname) as cnt
FROM fmember
WHERE nickname=#{nickname};
 
9) 이메일 찾기
SELECT email
FROM fmember
WHERE mname='개발자'
AND tel = '010-0000-0000'
