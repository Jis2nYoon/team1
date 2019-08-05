/* 공지사항 테이블 */
CREATE TABLE fnotice(
  noticeno        NUMBER(10)       NOT NULL     PRIMARY KEY,
  memberno     NUMBER(10)      NOT NULL,
  title              VARCHAR2(200)   NOT NULL,
  content         CLOB  NOT NULL,
  rdate            DATE                NOT NULL,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE fnotice is '공지사항';
COMMENT ON COLUMN fnotice.noticeno is '공지사항 번호';
COMMENT ON COLUMN fnotice.memberno is '회원 번호';
COMMENT ON COLUMN fnotice.title is '제목';
COMMENT ON COLUMN fnotice.content is '내용';
COMMENT ON COLUMN fnotice.rdate is '등록날짜';

0) 테이블 삭제
DROP TABLE fnotice;
DROP TABLE fmember;
DROP TABLE fgrade;

1) FK 테이블 데이터 삭제
DELETE FROM fnotice;

2) PK 테이블 데이터 삭제
DELETE FROM fmember;
DELETE FROM fgrade;

3) PK 테이블 데이터 추가
--> fmember.sql

4) FK 테이블 데이터 추가
INSERT INTO fnotice(noticeno, memberno, title, content, rdate)
VALUES((SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM fnotice), 
1, '공지사항', '공지합니다', sysdate);

INSERT INTO fnotice(noticeno, memberno, title, content, rdate)
VALUES((SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM fnotice), 
1, '공지사항2', '공지공지합니다', sysdate);

INSERT INTO fnotice(noticeno, memberno, title, content, rdate)
VALUES((SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM fnotice), 
1, '공지사항3', '공지를 읽어주세요', sysdate);

5, 6) PK, FK 테이블 데이터 확인
SELECT memberno, email, passwd, thumbs, photo, nickname, mname, tel, zipcode,  address1, address2 , act, stopdate, mdate
FROM fmember
ORDER BY memberno ASC;

SELECT memberno, noticeno, title, content, rdate
FROM fnotice
ORDER BY noticeno DESC;

7) Join 목록
SELECT m.memberno, m.thumbs, m.nickname,
          n.memberno, n.noticeno, n.title, n.content, n.rdate
FROM fmember m, fnotice n  
WHERE m.memberno = n.memberno
ORDER BY m.memberno ASC, n.noticeno ASC;

-- 검색+페이징+join
SELECT memberno, thumbs, nickname,
          noticeno, title, content, rdate, r
FROM(
         SELECT memberno, thumbs, nickname,
                   noticeno, title, content, rdate, rownum as r
         FROM(
                  SELECT m.memberno, m.thumbs, m.nickname,
                            n.noticeno, n.title, n.content, n.rdate
                  FROM fmember m, fnotice n
                  WHERE m.memberno = n.memberno AND n.title LIKE '%공지%' OR n.content LIKE '%공지%'
                  ORDER BY n.noticeno DESC
         )
)
WHERE r >=1 AND r <= 3;

8) Join 조회
SELECT m.memberno, m.thumbs, m.nickname,
          n.noticeno, n.title, n.content, n.rdate
FROM fmember m, fnotice n
WHERE (n.noticeno = 1) AND (m.memberno = n.memberno); 
 
9) 수정
UPDATE fnotice
SET title='수정', content='수정합니다.'
WHERE noticeno = 6;

10) 삭제
DELETE FROM fnotice
WHERE noticeno = 1;

--------------------------------------------------

+) 검색(%: 없거나 하나 이상의 모든 문자)
-- word LIKE '공지' → word = '공지'
   ^공지$
-- word LIKE '%공지' → word = '봐야할 공지'
   .*공지$
-- word LIKE '공지%' → word = '공지에서~'
   ^공지.*
-- word LIKE '%공지%' → word = '공지 꼭 읽어줘요~'
   .*공지.*
 
검색 글 목록(S:Search List) 
    - 목록은 제작시 검색을 기반으로 제작하며 전체 내용은
      전체 검색과도 같습니다.
    - title, content 컬럼 대상

1) 선언: 
    - WHERE rname LIKE '왕눈이'
       rname 컬럼의 값이 '왕눈이'인 레코드 전부 출력

    - WHERE rname LIKE '%왕눈이%'
      rname 컬럼의 값중 '왕눈이'가 들어간 레코드 전부 출력

    - WHERE rname LIKE '왕눈이%'
      rname 컬럼의 값중 '왕눈이'로 시작하는 레코드 전부 출력

    - WHERE rname LIKE '%왕눈이'
      rname 컬럼의 값중 '왕눈이'로 종료하는 레코드 전부 출력
   

2) 검색을 하지 않는 경우 모든 레코드 출력 
SELECT noticeno, memberno, title, content, rdate
FROM fnotice
ORDER BY noticeno DESC;
     
3) 제목으로 검색   
SELECT noticeno, memberno, title, content, rdate
FROM fnotice
WHERE title LIKE '%공지%'
ORDER BY noticeno DESC;
    
4) 내용으로 검색
SELECT noticeno, memberno, title, content, rdate
FROM fnotice
WHERE content LIKE '%공지%'
ORDER BY noticeno DESC;

5) 제목, 내용으로 검색
SELECT noticeno, memberno, title, content, rdate
FROM fnotice
WHERE title LIKE '%공지%' OR content LIKE '%공지%'
ORDER BY noticeno DESC;

- 검색 및 전체 레코드 갯수
-- cateno 컬럼이 1번이며 검색하지 않는 경우 레코드 갯수
SELECT COUNT(*) as cnt
FROM fnotice
 
-- '스위스' 검색 레코드 갯수
SELECT COUNT(*) as cnt
FROM fnotice
WHERE title LIKE '%공지%' OR content LIKE '%공지%'
 

+) 페이징
-- step 1
SELECT noticeno, memberno, title, content, rdate
FROM fnotice
ORDER BY noticeno DESC;
 
-- step 2         
SELECT noticeno, memberno, title, content, rdate, rownum as r
FROM(
         SELECT noticeno, memberno, title, content, rdate
         FROM fnotice
         ORDER BY noticeno DESC
);
 
-- step 3         
SELECT noticeno, memberno, title, content, rdate, r
FROM(
         SELECT noticeno, memberno, title, content, rdate, rownum as r
         FROM(
                  SELECT noticeno, memberno, title, content, rdate
                  FROM fnotice
                  ORDER BY noticeno DESC
         )
)
WHERE r >=1 AND r <= 3;
 
-- 검색 + 페이징
SELECT noticeno, memberno, title, content, rdate, r
FROM(
         SELECT noticeno, memberno, title, content, rdate, rownum as r
         FROM(
                  SELECT noticeno, memberno, title, content, rdate
                  FROM fnotice
                  WHERE title LIKE '%공지%' OR content LIKE '%공지%'
                  ORDER BY noticeno DESC
         )
)
WHERE r >=1 AND r <= 3;
