/*    질문답변 테이블    */
CREATE TABLE fqna(
  qnano           NUMBER(10)      NOT NULL     PRIMARY KEY,
  memberno     NUMBER(10)      NOT NULL,
  title              VARCHAR2(200)  NOT NULL,
  content         CLOB                NOT NULL,
  files              CLOB                NULL ,
  filesizes         CLOB                NULL ,
  thumbs         CLOB                NULL ,
  grpno          NUMBER(10)                           NOT NULL,
  indent          NUMBER(10)      DEFAULT 0      NOT NULL,
  ansnum        NUMBER(10)        DEFAULT 0       NOT NULL,
  rdate            DATE                NOT NULL,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE fqna is '질문답변';
COMMENT ON COLUMN fqna.qnano is '질문답변 번호';
COMMENT ON COLUMN fqna.memberno is '회원 번호';
COMMENT ON COLUMN fqna.title is '제목';
COMMENT ON COLUMN fqna.content is '내용';
COMMENT ON COLUMN fqna.files is '첨부파일';
COMMENT ON COLUMN fqna.filesizes is '첨부파일 크기';
COMMENT ON COLUMN fqna.thumbs is 'Thumb 파일';
COMMENT ON COLUMN fqna.grpno is '그룹번호';
COMMENT ON COLUMN fqna.indent is '답변차수';
COMMENT ON COLUMN fqna.ansnum is '답변 순서';
COMMENT ON COLUMN fqna.rdate is '등록날짜';

0) 테이블 삭제
DROP TABLE fqna;
DROP TABLE fmember;
DROP TABLE fgrade;

1) FK 테이블 데이터 삭제
DELETE FROM fqna;

2) PK 테이블 데이터 삭제
DELETE FROM fmember;
DELETE FROM fgrade;

3) PK 테이블 데이터 추가
--> fmember.sql

4) FK 테이블 데이터 추가
INSERT INTO fqna(qnano, memberno, title, content, files, filesizes, thumbs, 
                        grpno, indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(qnano), 0)+1 as qnano FROM fqna),
            1, '문의합니다', '오류가 나요ㅠㅠ', '사진1.png', 1, '사진1_t.png', 
            1, 0, 0, sysdate);

INSERT INTO fqna(qnano, memberno, title, content, files, filesizes, thumbs, 
                        grpno, indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(qnano), 0)+1 as qnano FROM fqna), 
            1, '이거 어떻게 하는 건가요?', '방법을 알려주세요', '', 0, '', 
            2, 0, 0, sysdate);

5, 6) PK, FK 테이블 데이터 확인
SELECT memberno, email, passwd, thumbs, photo, nickname, mname, tel, zipcode,  address1, address2 , act, stopdate, mdate
FROM fmember
ORDER BY memberno ASC;

SELECT memberno, qnano, title, content, files, filesizes, thumbs, grpno, indent, ansnum, rdate
FROM fqna
ORDER BY grpno DESC, ansnum ASC;

7) Join 목록
SELECT m.memberno, m.thumbs as memthumbs, m.nickname,
          q.memberno, q.qnano, q.title, q.content, 
          q.files, q.filesizes, q.thumbs as qnathumbs, q.grpno, q.indent, q.ansnum, q.rdate
FROM fmember m, fqna q  
WHERE m.memberno = q.memberno
ORDER BY q.grpno DESC, q.ansnum ASC;

8) Join 조회
SELECT m.memberno, m.thumbs as memthumb, m.nickname,
          q.memberno, q.qnano, q.title, q.content, 
          q.files, q.filesizes, q.thumbs as qnathumb, q.grpno, q.indent, q.ansnum, q.rdate
FROM fmember m, fqna q
WHERE m.memberno = q.memberno AND q.qnano = 1;

9) 수정
UPDATE fqna
SET title='문의합니다~', content='여기서 오류가 납니다!', 
      files='사진1_1.png', filesizes=1024, thumbs='사진1_1_t.png'
WHERE qnano = 1;
        
10) 삭제
DELETE FROM fqna
WHERE qnano = 11;


+) 전체 카운트
SELECT COUNT(*) as count
FROM fqna;

   
+) 답변
[답변 쓰기]
-- 1번글 기준 답변 등록예: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
 
-- ① 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE fqna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
② 답변 등록
- mno: FK
 
INSERT INTO fqna(qnano, memberno, title, content, files, filesizes, thumbs, grpno, indent, ansnum, rdate)  
VALUES((SELECT NVL(MAX(qnano), 0) + 1 as qnano FROM fqna),
            1, '답변입니다', '이케이케 하시면 됩니다', '사진1.png', 1, '사진1_t.png', 1, 1, 1, sysdate);
 
 
-- ③ 답변에 따른 정렬 순서 변경(페이징!) 
SELECT qnano, memberno, title, content, files, filesizes, thumbs, grpno, indent, ansnum, rdate, r
FROM(
         SELECT qnano, memberno, title, content, files, filesizes, thumbs, grpno, indent, ansnum, rdate, rownum as r
         FROM(
                  SELECT qnano, memberno, title, content, files, filesizes, thumbs, grpno, indent, ansnum, rdate
                  FROM fqna
                  ORDER BY qnano DESC
         )
)
WHERE r >=1 AND r <= 3;
 
 
16) Join을 통한 id의 출력
-- id 가 출력되지 않는 경우
SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                            replycnt, rdate, word, grpno, indent, ansnum
                  FROM contents
                  WHERE cateno=1
                  ORDER BY grpno DESC, ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
 
-- mno, id 가 출력되는 경우
SELECT mno, id,
          contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT mno, id, 
                   contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT m.mno, m.id,
                            c.contentsno, c.cateno, c.title, c.content, c.good, 
                            c.thumbs, c.files, c.sizes, c.cnt,
                            c.replycnt, c.rdate, c.word, c.grpno, c.indent, c.ansnum
                  FROM member m, contents c 
                  WHERE m.mno = c.mno AND c.cateno=1
                  ORDER BY c.grpno DESC, c.ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
 
-- mno, id 가 출력되고 검색하는 경우
SELECT mno, id,
          contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
          replycnt, rdate, word, grpno, indent, ansnum, r
FROM(
         SELECT mno, id, 
                   contentsno, cateno, title, content, good, thumbs, files, sizes, cnt,
                   replycnt, rdate, word, grpno, indent, ansnum, rownum as r
         FROM(
                  SELECT m.mno, m.id,
                            c.contentsno, c.cateno, c.title, c.content, c.good, 
                            c.thumbs, c.files, c.sizes, c.cnt,
                            c.replycnt, c.rdate, c.word, c.grpno, c.indent, c.ansnum
                  FROM member m, contents c 
                  WHERE m.mno = c.mno AND c.cateno=1 AND word LIKE '%alps%'
                  ORDER BY c.grpno DESC, c.ansnum ASC
         )
)
WHERE r >=1 AND r <= 3;
