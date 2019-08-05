
DROP TABLE content CASCADE CONSTRAINTS;

1) DDL
/**********************************/
/* Table Name: 거래게시글 */
/**********************************/
CREATE TABLE content(
    contentsno                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    cateno                            NUMBER(10)     NOT NULL,
    memberno                          NUMBER(10)     NOT NULL,
    title                             VARCHAR2(200)    NOT NULL,
    contents                          CLOB     NOT NULL,
    picture                           CLOB     NOT NULL ,
    picsize                           CLOB     NOT NULL,
    rdate                             DATE     NOT NULL,
    views                             NUMBER(10)     DEFAULT 0     NOT NULL, -- 제목 옆에 조회수를 보여준다.
    saleA                             CHAR(1)    DEFAULT 'Y'     NOT NULL, --판매 완료 버튼을 판매자가 누르면 글이 회색에 줄쳐짐표시로 바뀌도록한다.
    pname                             VARCHAR2(100)    NOT NULL, 
    price                             NUMBER(10)     NOT NULL,
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
COMMENT ON COLUMN content.picsize is '사진크기';
COMMENT ON COLUMN content.rdate is '등록날짜';
COMMENT ON COLUMN content.views is '조회수';
COMMENT ON COLUMN content.saleA is '판매여부';
COMMENT ON COLUMN content.pname is '상품이름';
COMMENT ON COLUMN content.price is '상품가격';

2) SEQUENCE 

-- SEQUENCE 객체 생성
DROP SEQUENCE cont_seq;

CREATE SEQUENCE cont_seq
START WITH   1            --시작번호
INCREMENT BY 1          --증가값
MAXVALUE   99999999  --최대값, NUMBER(7) 대응
CACHE        2               --시쿼스 변경시 자주 update되는 것을 방지하기위한 캐시값
NOCYCLE;    


3) 등록, C(create)

INSERT INTO content(contentsno, cateno, memberno, title, contents, picture, picsize, rdate, pname, price)
VALUES(cont_seq.nextval, 1, 1,'컨텐츠 제목', '컨텐츠 내용', '사진이름리스트','사진크기리스트', sysdate);


4) 목록, R(Read)
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, views, saleA, pname, price
FROM content
ORDER BY contentsno ASC;

CONTENTSNO CATENO MEMBERNO TITLE  CONTENTS PICTURE RDATE
 ---------- ------ -------- ------ -------- ------- ---------------------
          1      1        1 컨텐츠 제목 컨텐츠 내용   사진이름리스트 2019-05-24 09:52:08.0

SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
ORDER BY contentsno DESC;

    SELECT contentsno, cateno, memberno, title, picture, picsize, rdate, pname, price
    FROM content 
    WHERE cateno=1
    ORDER BY contentsno DESC;

4-1) Outer Join목록 

-- 관리자 페이지에서 사용 될 것이며, 글의 내용은 이때 조회하지 않는다. 
-- content 전체 조회
SELECT c.cateno, c.catename, 
          t.contentsno, t.cateno, t.title, t.memberno, t.title, t.rdate, t.pname, t.price
FROM category c, content t  
WHERE c.cateno(+) = t.cateno
ORDER BY c.cateno ASC, t.contentsno DESC;

-- content 카테고리별 조회
SELECT c.cateno, c.catename, 
          t.contentsno, t.cateno, t.title, t.memberno, t.title, t.rdate, t.pname, t.price
FROM category c, content t  
WHERE (c.cateno=1) AND (c.cateno(+) = t.cateno)
ORDER BY c.cateno ASC, t.contentsno DESC;


5) 조회, R(Read)
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE contentsno = 1;

CONTENTSNO CATENO MEMBERNO TITLE  CONTENTS PICTURE RDATE
 ---------- ------ -------- ------ -------- ------- ---------------------
          1      1        1 컨텐츠 제목 컨텐츠 내용   사진이름리스트 2019-05-22 16:43:45.0
          
6) 수정, U(Update)
UPDATE content
SET title='컨텐츠 제목 수정', rdate=sysdate
WHERE contentsno = 1;
 
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
ORDER BY contentsno ASC;

CONTENTSNO CATENO MEMBERNO TITLE     CONTENTS PICTURE RDATE
 ---------- ------ -------- --------- -------- ------- ---------------------
          1      1        1 컨텐츠 제목 수정 컨텐츠 내용   사진이름리스트 2019-05-22 17:01:51.0

7) 삭제, D(Delete)
DELETE FROM content
WHERE contentsno = 3;
 
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
ORDER BY contentsno ASC;



8) 검색

검색(%: 없거나 하나 이상의 모든 문자)
-- word LIKE '스위스' → word = '스위스'
   ^스위스$
-- word LIKE '%스위스' → word = '잊지 못할 스위스'
   .*스위스$
-- word LIKE '스위스%' → word = '스위스에서~'
   ^스위스.*
-- word LIKE '%스위스%' → word = '유럽 여행은 스위스 꼭 방문해야~'
   .*스위스.*

--제목으로 검색   
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE title LIKE '%컨텐츠%'
ORDER BY contentsno DESC;

 CONTENTSNO CATENO MEMBERNO TITLE     CONTENTS RDATE
 ---------- ------ -------- --------- -------- ---------------------
          1      1        1 컨텐츠 제목 수정 컨텐츠 내용   2019-05-14 10:55:37.0

    
-- 내용으로 검색
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE contents LIKE '%우주%'
ORDER BY contentsno DESC;

--전체 제목, 내용으로 검색
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE title LIKE '%우주%' OR contents LIKE '%우주%'
ORDER BY contentsno DESC;

 
--카테고리별 검색
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE cateno=11 AND (title LIKE '%우주%' OR contents LIKE '%우주%')
ORDER BY contentsno DESC;
  


9) 페이징 
-- 페이징이 안되있는 SQL
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE cateno = 1
ORDER BY contentsno DESC;

-- Step 1: 정렬
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE cateno = 1
ORDER BY contentsno DESC;

-- Step 2: rownum 발생
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, rownum as r
FROM (
          SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
          FROM content
          WHERE cateno = 11
          ORDER BY contentsno DESC
);         

-- Step 3: 1 페이지
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, r
FROM (
          SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, rownum as r
          FROM (
                    SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
                    FROM content
                    ORDER BY contentsno DESC
          )   
)
WHERE r >= 1 AND r <= 3;

-- Step 3: 2 페이지
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, r
FROM (
          SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, rownum as r
          FROM (
                    SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
                    FROM content
                    ORDER BY contentsno DESC
          )   
)
WHERE r >= 4 AND r <= 6;


-- Step 3: 3 페이지
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, r
FROM (
          SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, rownum as r
          FROM (
                    SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
                    FROM content
                    WHERE cateno = 1
                    ORDER BY contentsno DESC
          )   
)
WHERE r >= 7 AND r <= 9;

-- 검색 + 페이징       
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, r
FROM (
          SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, rownum as r
          FROM (
                    SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
                    FROM content
                    WHERE cateno = 1 AND (title LIKE '%버즈%' OR contents LIKE '%버즈%')
                    ORDER BY contentsno DESC
          )   
)
WHERE r >= 1 AND r <= 3;

--최종!@#!#!#!!!!!!!!!!!!!!!!$#$%#%$@^#$
--검색 + 페이징 + 조인
SELECT c.cateno, c.catename,
           t.contentsno, t.cateno, t.memberno, t.title, t.contents, t.picture, t.picsize, t.rdate, t.pname, t.price, t.r
FROM category c, (
          SELECT contentsno, cateno, memberno, title, contents, picture, picsize, rdate, pname, price, rownum as r
          FROM (
                    SELECT contentsno, cateno, memberno, title, contents, picture, picsize, rdate, pname, price
                    FROM content
                    WHERE cateno = 1 AND (title LIKE '%버즈%' OR contents LIKE '%버즈%')
                    ORDER BY contentsno DESC
          )   
) t
WHERE c.cateno(+) = t.cateno AND (r >= 1 AND r <= 3);
           
           
SELECT c.cateno, c.catename,
           t.contentsno, t.cateno, t.memberno, t.title, t.contents, t.picture, t.picsize, t.rdate, t.pname, t.price, t.r
FROM category c, (
          SELECT contentsno, cateno, memberno, title, contents, picture, picsize, rdate, pname, price, rownum as r
          FROM (
                    SELECT contentsno, cateno, memberno, title, contents, picture, picsize, rdate, pname, price
                    FROM content
                    WHERE title LIKE '%버즈%' OR contents LIKE '%버즈%'
                    ORDER BY contentsno DESC
          )   
) t
WHERE c.cateno(+) = t.cateno AND (r >= 4 AND r <= 6);

       
10) 검색된 레코드 갯수
SELECT COUNT(*) as cnt 
FROM content
WHERE cateno = 1 AND contents LIKE '%컨텐%'
ORDER BY contentsno DESC;

SELECT COUNT(*) as cnt 
FROM content
WHERE cateno = 1 AND title LIKE '%컨텐%'
ORDER BY contentsno DESC;

SELECT COUNT(*) as cnt 
FROM content
WHERE cateno = 1 AND (title LIKE '%왕눈이%' OR contents LIKE '%왕눈이%')
ORDER BY contentsno DESC;

-----------------------------------------------------------------------------------



Join 검색

SELECT c.cateno, c.catename, 
               t.contentsno, t.cateno, t.memberno, t.title, substr(t.contents, 0, 36) as contents, t.picture, t.picsize, t.rdate, t.pname, t.price
    FROM category c, content t 
    WHERE (c.cateno(+) = t.cateno) --검색 안할때
    WHERE (c.cateno(+) = t.cateno) AND (title LIKE '%' || #{word} || '%' OR contents LIKE '%' || #{word} || '%') --검색할때
    ORDER BY c.cateno ASC, t.contentsno DESC
