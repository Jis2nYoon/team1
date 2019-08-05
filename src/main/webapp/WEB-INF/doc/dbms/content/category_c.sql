
-------------------------------------------------------------------------------------------------
1) DDL
DROP TABLE category CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 카테고리 */
/**********************************/
CREATE TABLE category(
    cateno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    catename                          VARCHAR2(50)     NULL ,
    contentscnt                       NUMBER(10)     DEFAULT 0     NOT NULL,
    seqno                             NUMBER(10)     NULL 
);

COMMENT ON TABLE category is '카테고리';
COMMENT ON COLUMN category.cateno is '카테고리 번호';
COMMENT ON COLUMN category.catename is '카테고리명';
COMMENT ON COLUMN category.contentscnt is '컨텐츠개수';
COMMENT ON COLUMN category.seqno is '출력순서';




2) 등록, C(create)
- classification: 
1. 디지털/가전
2. 가구/인테리어
3. 유아동/유아도서
4. 생활/가공식품
5. 여성의류
6. 여성잡화
7. 뷰티/미용
8. 남성패션/잡화
9. 스포츠/레저
10. 게임/취미
11. 도서/티켓/음반
12. 반려동물용품
13. 기타 중고물품

 
INSERT INTO category(cateno, catename, seqno)
VALUES(1, '디지털/가전', 1);
INSERT INTO category(cateno, catename, seqno)
VALUES(2, '가구/인테리어', 2);
INSERT INTO category(cateno, catename, seqno)
VALUES(3, '유아동/유아도서', 3);
INSERT INTO category(cateno, catename, seqno)
VALUES(4, '생활/가공식품', 4);
INSERT INTO category(cateno, catename, seqno)
VALUES(5, '여성의류', 5);
INSERT INTO category(cateno, catename, seqno)
VALUES(6, '여성잡화', 6);
INSERT INTO category(cateno, catename, seqno)
VALUES(7, '뷰티/미용', 7);
INSERT INTO category(cateno, catename, seqno)
VALUES(8, '남성패션/잡화', 8);
INSERT INTO category(cateno, catename, seqno)
VALUES(9, '스포츠/레저', 9);
INSERT INTO category(cateno, catename, seqno)
VALUES(10, '게임/취미', 10);
INSERT INTO category(cateno, catename, seqno)
VALUES(11, '도서/티켓/음반', 11);
INSERT INTO category(cateno, catename, seqno)
VALUES(12, '반려동물용품', 12);
INSERT INTO category(cateno, catename, seqno)
VALUES(13, '기타 중고물품', 13);

 
DELETE FROM category;
 
3) Sequence를 사용하지 않는 일련번호의 자동 생성
SELECT cateno FROM category;
 
 CATENO
 ------
 
SELECT MAX(cateno) FROM category; -- 레코드가 없으면 null
 
 MAX(CATENO)
 -----------
        NULL
           
SELECT MAX(cateno) + 1 FROM category;    -- 레코드가 없으면 의미 없음, null       
           
 MAX(CATENO)+1
 -------------
          NULL
 
-- null인 컬럼의 값을 0으로 변경후 연산, NVL(컬럼명, 0): 컬럼값이 null이면 0으로 변경
SELECT NVL(MAX(cateno), 0) + 1 FROM category;
 
 NVL(MAX(CATENO),0)+1
 --------------------
                    1
                        
-- as: 커럼 별명 지정, SELECT시에만 컬럼명 변경                       
SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category;                       
 
 CATENO
 ------
      1

 

INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '디지털/가전', 1);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '가구/인테리어', 2);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '유아동/유아도서', 3);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '생활/가공식품', 4);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '여성의류', 5);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '여성잡화', 6);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '뷰티/미용', 7);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '남성패션/잡화', 8);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '스포츠/레저', 9);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '게임/취미', 10);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '도서/티켓/음반', 11);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '반려동물용품', 12);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '기타 중고물품', 13);

         
 
4) 목록, R(Read)
SELECT cateno, catename, seqno, contentscnt 
FROM category
ORDER BY cateno ASC;

 
CATENO CATENAME SEQNO CONTENTSCNT
 ------ -------- ----- -----------
      1 디지털/가전       1           0
      2 가구/인테리어      2           0
      3 유아동/유아도서     3           0
      4 생활/가공식품      4           0
      5 여성의류         5           0
      6 여성잡화         6           0
      7 뷰티/미용        7           0
      8 남성패션/잡화      8           0
      9 스포츠/레저       9           0
     10 게임/취미       10           0
     11 도서/티켓/음반    11           0
     12 반려동물용품      12           0
     13 기타 중고물품     13           0

     
5) 조회, R(Read)
SELECT cateno, catename, seqno, contentscnt 
FROM category
WHERE cateno = 1;
 
 CATENO CATENAME SEQNO
 ------ -------- -----
      1 디지털/가전       1
      
      
6) 수정, U(Update)
UPDATE category
SET catename='여성의류'
WHERE cateno = 3;
 
SELECT cateno, catename, seqno, contentscnt 
FROM category
ORDER BY cateno ASC;
 

 
 
7) 삭제, D(Delete)
DELETE FROM category
WHERE cateno = 3;
 
SELECT cateno, catename, seqno, contentscnt 
FROM category
ORDER BY cateno ASC;
 
-- 출력 순서 상향, 10 -> 1
UPDATE category
SET seqno = seqno - 1
WHERE cateno=1;
 
-- 출력순서 하향, 1 -> 10
UPDATE category
SET seqno = seqno + 1
WHERE cateno=1;
 
-- 출력 순서에따른 전체 목록
SELECT cateno, catename, seqno, contentscnt 
FROM category
ORDER BY seqno ASC;
 
CATENO CATENAME SEQNO CONTENTSCNT
 ------ -------- ----- -----------
      1 디지털/가전       1           0
      2 가구/인테리어      2           0
      3 유아동/유아도서     3           0
      4 생활/가공식품      4           0
      5 여성의류         5           0
      6 여성잡화         6           0
      7 뷰티/미용        7           0
      8 남성패션/잡화      8           0
      9 스포츠/레저       9           0
     10 게임/취미       10           0
     11 도서/티켓/음반    11           0
     12 반려동물용품      12           0
     13 기타 중고물품     13           0

          
8) 검색
사용안함.

9) 페이징 
사용안함.
  
10) cate 안에 contents 개수 산출 
SELECT COUNT(*) as cnt
FROM content
WHERE cateno = 1;
 
 CNT
 -----
   3
 
    
11) category 값과 일치하는 다수의 레코드 삭제(많은 레코드가 삭제 될 수 있음)
DELETE FROM content
WHERE cateno = 1;
 
 
12) contents 추가에따른 등록된 글수의 증가
UPDATE category 
SET contentscnt = contentscnt + 1 
WHERE cateno=1;
 
 
13) contents 삭제에따른 등록된 글수의 감소
UPDATE category
SET contentscnt = contentscnt - 1 
WHERE cateno=1;
 
 
14) 전체 글수의 초기화
UPDATE category 
SET contentscnt = 0

--for test)
UPDATE category 
SET contentscnt = 7
WHERE cateno=15;
-----------------------------------------------------------------------------------
 