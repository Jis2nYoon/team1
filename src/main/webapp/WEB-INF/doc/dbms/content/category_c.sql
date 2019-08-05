
-------------------------------------------------------------------------------------------------
1) DDL
DROP TABLE category CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: ī�װ� */
/**********************************/
CREATE TABLE category(
    cateno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    catename                          VARCHAR2(50)     NULL ,
    contentscnt                       NUMBER(10)     DEFAULT 0     NOT NULL,
    seqno                             NUMBER(10)     NULL 
);

COMMENT ON TABLE category is 'ī�װ�';
COMMENT ON COLUMN category.cateno is 'ī�װ� ��ȣ';
COMMENT ON COLUMN category.catename is 'ī�װ���';
COMMENT ON COLUMN category.contentscnt is '����������';
COMMENT ON COLUMN category.seqno is '��¼���';




2) ���, C(create)
- classification: 
1. ������/����
2. ����/���׸���
3. ���Ƶ�/���Ƶ���
4. ��Ȱ/������ǰ
5. �����Ƿ�
6. ������ȭ
7. ��Ƽ/�̿�
8. �����м�/��ȭ
9. ������/����
10. ����/���
11. ����/Ƽ��/����
12. �ݷ�������ǰ
13. ��Ÿ �߰�ǰ

 
INSERT INTO category(cateno, catename, seqno)
VALUES(1, '������/����', 1);
INSERT INTO category(cateno, catename, seqno)
VALUES(2, '����/���׸���', 2);
INSERT INTO category(cateno, catename, seqno)
VALUES(3, '���Ƶ�/���Ƶ���', 3);
INSERT INTO category(cateno, catename, seqno)
VALUES(4, '��Ȱ/������ǰ', 4);
INSERT INTO category(cateno, catename, seqno)
VALUES(5, '�����Ƿ�', 5);
INSERT INTO category(cateno, catename, seqno)
VALUES(6, '������ȭ', 6);
INSERT INTO category(cateno, catename, seqno)
VALUES(7, '��Ƽ/�̿�', 7);
INSERT INTO category(cateno, catename, seqno)
VALUES(8, '�����м�/��ȭ', 8);
INSERT INTO category(cateno, catename, seqno)
VALUES(9, '������/����', 9);
INSERT INTO category(cateno, catename, seqno)
VALUES(10, '����/���', 10);
INSERT INTO category(cateno, catename, seqno)
VALUES(11, '����/Ƽ��/����', 11);
INSERT INTO category(cateno, catename, seqno)
VALUES(12, '�ݷ�������ǰ', 12);
INSERT INTO category(cateno, catename, seqno)
VALUES(13, '��Ÿ �߰�ǰ', 13);

 
DELETE FROM category;
 
3) Sequence�� ������� �ʴ� �Ϸù�ȣ�� �ڵ� ����
SELECT cateno FROM category;
 
 CATENO
 ------
 
SELECT MAX(cateno) FROM category; -- ���ڵ尡 ������ null
 
 MAX(CATENO)
 -----------
        NULL
           
SELECT MAX(cateno) + 1 FROM category;    -- ���ڵ尡 ������ �ǹ� ����, null       
           
 MAX(CATENO)+1
 -------------
          NULL
 
-- null�� �÷��� ���� 0���� ������ ����, NVL(�÷���, 0): �÷����� null�̸� 0���� ����
SELECT NVL(MAX(cateno), 0) + 1 FROM category;
 
 NVL(MAX(CATENO),0)+1
 --------------------
                    1
                        
-- as: Ŀ�� ���� ����, SELECT�ÿ��� �÷��� ����                       
SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category;                       
 
 CATENO
 ------
      1

 

INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '������/����', 1);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '����/���׸���', 2);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '���Ƶ�/���Ƶ���', 3);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '��Ȱ/������ǰ', 4);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '�����Ƿ�', 5);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '������ȭ', 6);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '��Ƽ/�̿�', 7);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '�����м�/��ȭ', 8);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '������/����', 9);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '����/���', 10);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '����/Ƽ��/����', 11);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '�ݷ�������ǰ', 12);
INSERT INTO category(cateno, catename, seqno)
VALUES((SELECT NVL(MAX(cateno), 0) + 1 as cateno FROM category), '��Ÿ �߰�ǰ', 13);

         
 
4) ���, R(Read)
SELECT cateno, catename, seqno, contentscnt 
FROM category
ORDER BY cateno ASC;

 
CATENO CATENAME SEQNO CONTENTSCNT
 ------ -------- ----- -----------
      1 ������/����       1           0
      2 ����/���׸���      2           0
      3 ���Ƶ�/���Ƶ���     3           0
      4 ��Ȱ/������ǰ      4           0
      5 �����Ƿ�         5           0
      6 ������ȭ         6           0
      7 ��Ƽ/�̿�        7           0
      8 �����м�/��ȭ      8           0
      9 ������/����       9           0
     10 ����/���       10           0
     11 ����/Ƽ��/����    11           0
     12 �ݷ�������ǰ      12           0
     13 ��Ÿ �߰�ǰ     13           0

     
5) ��ȸ, R(Read)
SELECT cateno, catename, seqno, contentscnt 
FROM category
WHERE cateno = 1;
 
 CATENO CATENAME SEQNO
 ------ -------- -----
      1 ������/����       1
      
      
6) ����, U(Update)
UPDATE category
SET catename='�����Ƿ�'
WHERE cateno = 3;
 
SELECT cateno, catename, seqno, contentscnt 
FROM category
ORDER BY cateno ASC;
 

 
 
7) ����, D(Delete)
DELETE FROM category
WHERE cateno = 3;
 
SELECT cateno, catename, seqno, contentscnt 
FROM category
ORDER BY cateno ASC;
 
-- ��� ���� ����, 10 -> 1
UPDATE category
SET seqno = seqno - 1
WHERE cateno=1;
 
-- ��¼��� ����, 1 -> 10
UPDATE category
SET seqno = seqno + 1
WHERE cateno=1;
 
-- ��� ���������� ��ü ���
SELECT cateno, catename, seqno, contentscnt 
FROM category
ORDER BY seqno ASC;
 
CATENO CATENAME SEQNO CONTENTSCNT
 ------ -------- ----- -----------
      1 ������/����       1           0
      2 ����/���׸���      2           0
      3 ���Ƶ�/���Ƶ���     3           0
      4 ��Ȱ/������ǰ      4           0
      5 �����Ƿ�         5           0
      6 ������ȭ         6           0
      7 ��Ƽ/�̿�        7           0
      8 �����м�/��ȭ      8           0
      9 ������/����       9           0
     10 ����/���       10           0
     11 ����/Ƽ��/����    11           0
     12 �ݷ�������ǰ      12           0
     13 ��Ÿ �߰�ǰ     13           0

          
8) �˻�
������.

9) ����¡ 
������.
  
10) cate �ȿ� contents ���� ���� 
SELECT COUNT(*) as cnt
FROM content
WHERE cateno = 1;
 
 CNT
 -----
   3
 
    
11) category ���� ��ġ�ϴ� �ټ��� ���ڵ� ����(���� ���ڵ尡 ���� �� �� ����)
DELETE FROM content
WHERE cateno = 1;
 
 
12) contents �߰������� ��ϵ� �ۼ��� ����
UPDATE category 
SET contentscnt = contentscnt + 1 
WHERE cateno=1;
 
 
13) contents ���������� ��ϵ� �ۼ��� ����
UPDATE category
SET contentscnt = contentscnt - 1 
WHERE cateno=1;
 
 
14) ��ü �ۼ��� �ʱ�ȭ
UPDATE category 
SET contentscnt = 0

--for test)
UPDATE category 
SET contentscnt = 7
WHERE cateno=15;
-----------------------------------------------------------------------------------
 