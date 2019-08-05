
DROP TABLE content CASCADE CONSTRAINTS;

1) DDL
/**********************************/
/* Table Name: �ŷ��Խñ� */
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
    views                             NUMBER(10)     DEFAULT 0     NOT NULL, -- ���� ���� ��ȸ���� �����ش�.
    saleA                             CHAR(1)    DEFAULT 'Y'     NOT NULL, --�Ǹ� �Ϸ� ��ư�� �Ǹ��ڰ� ������ ���� ȸ���� ������ǥ�÷� �ٲ���Ѵ�.
    pname                             VARCHAR2(100)    NOT NULL, 
    price                             NUMBER(10)     NOT NULL,
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
COMMENT ON COLUMN content.picsize is '����ũ��';
COMMENT ON COLUMN content.rdate is '��ϳ�¥';
COMMENT ON COLUMN content.views is '��ȸ��';
COMMENT ON COLUMN content.saleA is '�Ǹſ���';
COMMENT ON COLUMN content.pname is '��ǰ�̸�';
COMMENT ON COLUMN content.price is '��ǰ����';

2) SEQUENCE 

-- SEQUENCE ��ü ����
DROP SEQUENCE cont_seq;

CREATE SEQUENCE cont_seq
START WITH   1            --���۹�ȣ
INCREMENT BY 1          --������
MAXVALUE   99999999  --�ִ밪, NUMBER(7) ����
CACHE        2               --������ ����� ���� update�Ǵ� ���� �����ϱ����� ĳ�ð�
NOCYCLE;    


3) ���, C(create)

INSERT INTO content(contentsno, cateno, memberno, title, contents, picture, picsize, rdate, pname, price)
VALUES(cont_seq.nextval, 1, 1,'������ ����', '������ ����', '�����̸�����Ʈ','����ũ�⸮��Ʈ', sysdate);


4) ���, R(Read)
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, views, saleA, pname, price
FROM content
ORDER BY contentsno ASC;

CONTENTSNO CATENO MEMBERNO TITLE  CONTENTS PICTURE RDATE
 ---------- ------ -------- ------ -------- ------- ---------------------
          1      1        1 ������ ���� ������ ����   �����̸�����Ʈ 2019-05-24 09:52:08.0

SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
ORDER BY contentsno DESC;

    SELECT contentsno, cateno, memberno, title, picture, picsize, rdate, pname, price
    FROM content 
    WHERE cateno=1
    ORDER BY contentsno DESC;

4-1) Outer Join��� 

-- ������ ���������� ��� �� ���̸�, ���� ������ �̶� ��ȸ���� �ʴ´�. 
-- content ��ü ��ȸ
SELECT c.cateno, c.catename, 
          t.contentsno, t.cateno, t.title, t.memberno, t.title, t.rdate, t.pname, t.price
FROM category c, content t  
WHERE c.cateno(+) = t.cateno
ORDER BY c.cateno ASC, t.contentsno DESC;

-- content ī�װ��� ��ȸ
SELECT c.cateno, c.catename, 
          t.contentsno, t.cateno, t.title, t.memberno, t.title, t.rdate, t.pname, t.price
FROM category c, content t  
WHERE (c.cateno=1) AND (c.cateno(+) = t.cateno)
ORDER BY c.cateno ASC, t.contentsno DESC;


5) ��ȸ, R(Read)
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE contentsno = 1;

CONTENTSNO CATENO MEMBERNO TITLE  CONTENTS PICTURE RDATE
 ---------- ------ -------- ------ -------- ------- ---------------------
          1      1        1 ������ ���� ������ ����   �����̸�����Ʈ 2019-05-22 16:43:45.0
          
6) ����, U(Update)
UPDATE content
SET title='������ ���� ����', rdate=sysdate
WHERE contentsno = 1;
 
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
ORDER BY contentsno ASC;

CONTENTSNO CATENO MEMBERNO TITLE     CONTENTS PICTURE RDATE
 ---------- ------ -------- --------- -------- ------- ---------------------
          1      1        1 ������ ���� ���� ������ ����   �����̸�����Ʈ 2019-05-22 17:01:51.0

7) ����, D(Delete)
DELETE FROM content
WHERE contentsno = 3;
 
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
ORDER BY contentsno ASC;



8) �˻�

�˻�(%: ���ų� �ϳ� �̻��� ��� ����)
-- word LIKE '������' �� word = '������'
   ^������$
-- word LIKE '%������' �� word = '���� ���� ������'
   .*������$
-- word LIKE '������%' �� word = '����������~'
   ^������.*
-- word LIKE '%������%' �� word = '���� ������ ������ �� �湮�ؾ�~'
   .*������.*

--�������� �˻�   
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE title LIKE '%������%'
ORDER BY contentsno DESC;

 CONTENTSNO CATENO MEMBERNO TITLE     CONTENTS RDATE
 ---------- ------ -------- --------- -------- ---------------------
          1      1        1 ������ ���� ���� ������ ����   2019-05-14 10:55:37.0

    
-- �������� �˻�
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE contents LIKE '%����%'
ORDER BY contentsno DESC;

--��ü ����, �������� �˻�
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE title LIKE '%����%' OR contents LIKE '%����%'
ORDER BY contentsno DESC;

 
--ī�װ��� �˻�
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE cateno=11 AND (title LIKE '%����%' OR contents LIKE '%����%')
ORDER BY contentsno DESC;
  


9) ����¡ 
-- ����¡�� �ȵ��ִ� SQL
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE cateno = 1
ORDER BY contentsno DESC;

-- Step 1: ����
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
FROM content
WHERE cateno = 1
ORDER BY contentsno DESC;

-- Step 2: rownum �߻�
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, rownum as r
FROM (
          SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
          FROM content
          WHERE cateno = 11
          ORDER BY contentsno DESC
);         

-- Step 3: 1 ������
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

-- Step 3: 2 ������
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


-- Step 3: 3 ������
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

-- �˻� + ����¡       
SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, r
FROM (
          SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price, rownum as r
          FROM (
                    SELECT contentsno, cateno, memberno, title, contents, picture, rdate, pname, price
                    FROM content
                    WHERE cateno = 1 AND (title LIKE '%����%' OR contents LIKE '%����%')
                    ORDER BY contentsno DESC
          )   
)
WHERE r >= 1 AND r <= 3;

--����!@#!#!#!!!!!!!!!!!!!!!!$#$%#%$@^#$
--�˻� + ����¡ + ����
SELECT c.cateno, c.catename,
           t.contentsno, t.cateno, t.memberno, t.title, t.contents, t.picture, t.picsize, t.rdate, t.pname, t.price, t.r
FROM category c, (
          SELECT contentsno, cateno, memberno, title, contents, picture, picsize, rdate, pname, price, rownum as r
          FROM (
                    SELECT contentsno, cateno, memberno, title, contents, picture, picsize, rdate, pname, price
                    FROM content
                    WHERE cateno = 1 AND (title LIKE '%����%' OR contents LIKE '%����%')
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
                    WHERE title LIKE '%����%' OR contents LIKE '%����%'
                    ORDER BY contentsno DESC
          )   
) t
WHERE c.cateno(+) = t.cateno AND (r >= 4 AND r <= 6);

       
10) �˻��� ���ڵ� ����
SELECT COUNT(*) as cnt 
FROM content
WHERE cateno = 1 AND contents LIKE '%����%'
ORDER BY contentsno DESC;

SELECT COUNT(*) as cnt 
FROM content
WHERE cateno = 1 AND title LIKE '%����%'
ORDER BY contentsno DESC;

SELECT COUNT(*) as cnt 
FROM content
WHERE cateno = 1 AND (title LIKE '%�մ���%' OR contents LIKE '%�մ���%')
ORDER BY contentsno DESC;

-----------------------------------------------------------------------------------



Join �˻�

SELECT c.cateno, c.catename, 
               t.contentsno, t.cateno, t.memberno, t.title, substr(t.contents, 0, 36) as contents, t.picture, t.picsize, t.rdate, t.pname, t.price
    FROM category c, content t 
    WHERE (c.cateno(+) = t.cateno) --�˻� ���Ҷ�
    WHERE (c.cateno(+) = t.cateno) AND (title LIKE '%' || #{word} || '%' OR contents LIKE '%' || #{word} || '%') --�˻��Ҷ�
    ORDER BY c.cateno ASC, t.contentsno DESC
