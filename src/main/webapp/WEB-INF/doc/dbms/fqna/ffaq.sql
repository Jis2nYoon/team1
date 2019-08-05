/** 테이블 삭제 **/
DROP TABLE ffaq;

/****************************/
/*    자주찾는질문 테이블    */
/****************************/
CREATE TABLE ffaq(
  faqno           NUMBER(10)       NOT NULL     PRIMARY KEY,
  question       CLOB   NOT NULL,
  answer         CLOB  NOT NULL,
  memberno     NUMBER(10)      NOT NULL,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE ffaq is '자주찾는질문';
COMMENT ON COLUMN ffaq.faqno is '질문 번호';
COMMENT ON COLUMN ffaq.question is '질문';
COMMENT ON COLUMN ffaq.answer is '답변';
COMMENT ON COLUMN ffaq.memberno is '회원 번호';

-- 등록
INSERT INTO ffaq(faqno, question, answer, memberno)
VALUES((SELECT NVL(MAX(faqno), 0)+1 as faqno FROM ffaq), 
'FAQ가 뭔가요?', '자주 찾는 질문을 말합니다.', 1);

INSERT INTO ffaq(faqno, question, answer, memberno)
VALUES((SELECT NVL(MAX(faqno), 0)+1 as faqno FROM ffaq), 
'FAQ는 누가 올리나요?', '관리자가 작성해서 올립니다.', 1);

-- 목록
SELECT faqno, question, answer, memberno
FROM ffaq
ORDER BY faqno DESC;

-- 조회
SELECT faqno, question, answer, memberno
FROM ffaq
WHERE faqno = 1;

-- 수정
UPDATE ffaq
SET question='FAQ란?', answer='자주 찾는 질문들(frequently asked questions)'
WHERE faqno = 1;
        
-- 삭제
DELETE FROM ffaq
WHERE faqno = 1;


