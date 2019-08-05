--거래 게시글 테이블 삭제
DROP TABLE content;  
--로그인 내역 테이블 삭제
DROP TABLE fgrade;
--회원등급 테이블 삭제
DROP TABLE flogin;
--회원 테이블 삭제
DROP TABLE fmember;

/**********************************/
/* Table Name: 평가 등급 */
/**********************************/
CREATE TABLE fgrade(
		gradeno                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		numgrade                 		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		avggrade                    		NUMBER(2,1)		 DEFAULT 0		 NOT NULL,
		manner                      		NUMBER(2,1)		 DEFAULT 0		 NOT NULL,
		delivery                     		NUMBER(2,1)		 DEFAULT 0		 NOT NULL,
		quality                       		NUMBER(2,1)		 DEFAULT 0		 NOT NULL,
		memberno                    NUMBER(10)		 NOT NULL UNIQUE ,
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

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------


1) 삽입
  
INSERT INTO fgrade(gradeno, numgrade, avggrade, manner, delivery, quality, memberno)
VALUES((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 3.4, 0.4, 3.8, 0.5, 1);

INSERT INTO fgrade(gradeno, numgrade, avggrade, manner, delivery, quality, memberno)
VALUES((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 0, 0, 0, 0, 2);

INSERT INTO fgrade(gradeno, numgrade, avggrade, manner, delivery, quality, memberno)
VALUES((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 0, 0, 0, 0, 3);

-- error 4 memberno 존재x  
INSERT INTO fgrade(gradeno, numgrade, avggrade, manner, delivery, quality, memberno)
VALUES((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 0, 0, 0, 0, 4);
  
 2) 목록

SELECT gradeno, numgrade, avggrade, manner, delivery, quality, memberno
FROM fgrade
ORDER BY gradeno ASC;

-- 전체 목록 member와 join
SELECT m.memberno, m.email, m.nickname, 
          g.gradeno, g.numgrade, g.avggrade, g.manner, g.delivery, g.quality
FROM fmember m, fgrade g
WHERE m.memberno = g.memberno 
ORDER BY gradeno DESC

3-1) 조회
SELECT gradeno, numgrade, avggrade, manner, delivery, quality, memberno
FROM fgrade
WHERE memberno =1;
  
3-2) memberno으로 레코드 수 조회  
SELECT count(gradeno) as cnt
FROM fgrade
WHERE memberno =1

4) 수정
UPDATE fgrade
SET numgrade=numgrade+1, avggrade = 4.5, manner=5,  delivery=4.3, quality=3.5
WHERE memberno = 1;
 
SELECT gradeno, numgrade, avggrade, manner, delivery, quality, memberno
FROM fgrade
ORDER BY gradeno ASC;
 
 
5) 삭제
DELETE FROM fgrade
COMMIT;

DELETE FROM fgrade
WHERE gradeno = 3;

6) 회원 등급 항목 존재 여부 확인
SELECT count(gradeno)
FROM fgrade
WHERE memberno = 3;
