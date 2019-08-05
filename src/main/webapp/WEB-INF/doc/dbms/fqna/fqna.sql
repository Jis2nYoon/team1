/*    �����亯 ���̺�    */
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

COMMENT ON TABLE fqna is '�����亯';
COMMENT ON COLUMN fqna.qnano is '�����亯 ��ȣ';
COMMENT ON COLUMN fqna.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN fqna.title is '����';
COMMENT ON COLUMN fqna.content is '����';
COMMENT ON COLUMN fqna.files is '÷������';
COMMENT ON COLUMN fqna.filesizes is '÷������ ũ��';
COMMENT ON COLUMN fqna.thumbs is 'Thumb ����';
COMMENT ON COLUMN fqna.grpno is '�׷��ȣ';
COMMENT ON COLUMN fqna.indent is '�亯����';
COMMENT ON COLUMN fqna.ansnum is '�亯 ����';
COMMENT ON COLUMN fqna.rdate is '��ϳ�¥';

0) ���̺� ����
DROP TABLE fqna;
DROP TABLE fmember;
DROP TABLE fgrade;

1) FK ���̺� ������ ����
DELETE FROM fqna;

2) PK ���̺� ������ ����
DELETE FROM fmember;
DELETE FROM fgrade;

3) PK ���̺� ������ �߰�
--> fmember.sql

4) FK ���̺� ������ �߰�
INSERT INTO fqna(qnano, memberno, title, content, files, filesizes, thumbs, 
                        grpno, indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(qnano), 0)+1 as qnano FROM fqna),
            1, '�����մϴ�', '������ ����Ф�', '����1.png', 1, '����1_t.png', 
            1, 0, 0, sysdate);

INSERT INTO fqna(qnano, memberno, title, content, files, filesizes, thumbs, 
                        grpno, indent, ansnum, rdate)
VALUES((SELECT NVL(MAX(qnano), 0)+1 as qnano FROM fqna), 
            1, '�̰� ��� �ϴ� �ǰ���?', '����� �˷��ּ���', '', 0, '', 
            2, 0, 0, sysdate);

5, 6) PK, FK ���̺� ������ Ȯ��
SELECT memberno, email, passwd, thumbs, photo, nickname, mname, tel, zipcode,  address1, address2 , act, stopdate, mdate
FROM fmember
ORDER BY memberno ASC;

SELECT memberno, qnano, title, content, files, filesizes, thumbs, grpno, indent, ansnum, rdate
FROM fqna
ORDER BY grpno DESC, ansnum ASC;

7) Join ���
SELECT m.memberno, m.thumbs as memthumbs, m.nickname,
          q.memberno, q.qnano, q.title, q.content, 
          q.files, q.filesizes, q.thumbs as qnathumbs, q.grpno, q.indent, q.ansnum, q.rdate
FROM fmember m, fqna q  
WHERE m.memberno = q.memberno
ORDER BY q.grpno DESC, q.ansnum ASC;

8) Join ��ȸ
SELECT m.memberno, m.thumbs as memthumb, m.nickname,
          q.memberno, q.qnano, q.title, q.content, 
          q.files, q.filesizes, q.thumbs as qnathumb, q.grpno, q.indent, q.ansnum, q.rdate
FROM fmember m, fqna q
WHERE m.memberno = q.memberno AND q.qnano = 1;

9) ����
UPDATE fqna
SET title='�����մϴ�~', content='���⼭ ������ ���ϴ�!', 
      files='����1_1.png', filesizes=1024, thumbs='����1_1_t.png'
WHERE qnano = 1;
        
10) ����
DELETE FROM fqna
WHERE qnano = 11;


+) ��ü ī��Ʈ
SELECT COUNT(*) as count
FROM fqna;

   
+) �亯
[�亯 ����]
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
 
-- �� ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE fqna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
�� �亯 ���
- mno: FK
 
INSERT INTO fqna(qnano, memberno, title, content, files, filesizes, thumbs, grpno, indent, ansnum, rdate)  
VALUES((SELECT NVL(MAX(qnano), 0) + 1 as qnano FROM fqna),
            1, '�亯�Դϴ�', '�������� �Ͻø� �˴ϴ�', '����1.png', 1, '����1_t.png', 1, 1, 1, sysdate);
 
 
-- �� �亯�� ���� ���� ���� ����(����¡!) 
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
 
 
16) Join�� ���� id�� ���
-- id �� ��µ��� �ʴ� ���
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
 
-- mno, id �� ��µǴ� ���
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
 
-- mno, id �� ��µǰ� �˻��ϴ� ���
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
