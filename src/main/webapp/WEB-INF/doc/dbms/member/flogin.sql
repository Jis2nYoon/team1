--거래 게시글 테이블 삭제
DROP TABLE content;  
--로그인 내역 테이블 삭제
DROP TABLE fgrade;
--회원등급 테이블 삭제
DROP TABLE flogin;
--회원 테이블 삭제
DROP TABLE fmember;


/**********************************/
/* Table Name: 로그인내역 */
/**********************************/
CREATE TABLE flogin(
		loginno                    		NUMBER(10)		   NOT NULL		 PRIMARY KEY,
		ip                            		VARCHAR2(15)		 NOT NULL,
		ldate                         		DATE		             NOT NULL,
		memberno                 		NUMBER(10)  		 NULL ,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE flogin is '로그인내역';
COMMENT ON COLUMN flogin.loginno is '로그인내역 번호';
COMMENT ON COLUMN flogin.ip is '아이피 주소';
COMMENT ON COLUMN flogin.ldate is '로그인 날짜';
COMMENT ON COLUMN flogin.memberno is '회원 번호';


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

1) 삽입
  
INSERT INTO flogin(loginno, ip, ldate, memberno)
VALUES((SELECT NVL(MAX(loginno), 0)+1 as loginno FROM flogin),
  0, sysdate, 1);  
  
INSERT INTO flogin(loginno, ip, ldate, memberno)
VALUES((SELECT NVL(MAX(loginno), 0)+1 as loginno FROM flogin),
  0, sysdate, 2);  
  
INSERT INTO flogin(loginno, ip, ldate, memberno)
VALUES((SELECT NVL(MAX(loginno), 0)+1 as loginno FROM flogin),
  0, sysdate, 2);
  
  
 2) 목록

SELECT loginno, ip, ldate, memberno
FROM flogin
ORDER BY loginno ASC;

 --member join 전체 목록
  --Member_LoginVO
  
SELECT m.memberno, m.email, m.nickname, 
               l.loginno, l.ip, l.ldate
FROM fmember m, flogin l
WHERE m.memberno = l.memberno 
ORDER BY loginno DESC;

3-1) 조회
SELECT loginno, ip, ldate, memberno
FROM flogin
WHERE memberno =1;

3-2) memberno으로 레코드 수 조회 
SELECT count(loginno) as cnt
FROM flogin
WHERE memberno =1
 
5) 삭제
DELETE FROM flogin
COMMIT;

DELETE FROM flogin
WHERE loginno = 3;

--memberno으로 조회 삭제
DELETE FROM flogin
WHERE memberno = 1;
 
