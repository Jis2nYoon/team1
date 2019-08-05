/* �������� ���̺� */
CREATE TABLE fnotice(
  noticeno        NUMBER(10)       NOT NULL     PRIMARY KEY,
  memberno     NUMBER(10)      NOT NULL,
  title              VARCHAR2(200)   NOT NULL,
  content         CLOB  NOT NULL,
  rdate            DATE                NOT NULL,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE fnotice is '��������';
COMMENT ON COLUMN fnotice.noticeno is '�������� ��ȣ';
COMMENT ON COLUMN fnotice.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN fnotice.title is '����';
COMMENT ON COLUMN fnotice.content is '����';
COMMENT ON COLUMN fnotice.rdate is '��ϳ�¥';

0) ���̺� ����
DROP TABLE fnotice;
DROP TABLE fmember;
DROP TABLE fgrade;

1) FK ���̺� ������ ����
DELETE FROM fnotice;

2) PK ���̺� ������ ����
DELETE FROM fmember;
DELETE FROM fgrade;

3) PK ���̺� ������ �߰�
--> fmember.sql

4) FK ���̺� ������ �߰�
INSERT INTO fnotice(noticeno, memberno, title, content, rdate)
VALUES((SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM fnotice), 
1, '��������', '�����մϴ�', sysdate);

INSERT INTO fnotice(noticeno, memberno, title, content, rdate)
VALUES((SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM fnotice), 
1, '��������2', '���������մϴ�', sysdate);

INSERT INTO fnotice(noticeno, memberno, title, content, rdate)
VALUES((SELECT NVL(MAX(noticeno), 0)+1 as noticeno FROM fnotice), 
1, '��������3', '������ �о��ּ���', sysdate);

5, 6) PK, FK ���̺� ������ Ȯ��
SELECT memberno, email, passwd, thumbs, photo, nickname, mname, tel, zipcode,  address1, address2 , act, stopdate, mdate
FROM fmember
ORDER BY memberno ASC;

SELECT memberno, noticeno, title, content, rdate
FROM fnotice
ORDER BY noticeno DESC;

7) Join ���
SELECT m.memberno, m.thumbs, m.nickname,
          n.memberno, n.noticeno, n.title, n.content, n.rdate
FROM fmember m, fnotice n  
WHERE m.memberno = n.memberno
ORDER BY m.memberno ASC, n.noticeno ASC;

-- �˻�+����¡+join
SELECT memberno, thumbs, nickname,
          noticeno, title, content, rdate, r
FROM(
         SELECT memberno, thumbs, nickname,
                   noticeno, title, content, rdate, rownum as r
         FROM(
                  SELECT m.memberno, m.thumbs, m.nickname,
                            n.noticeno, n.title, n.content, n.rdate
                  FROM fmember m, fnotice n
                  WHERE m.memberno = n.memberno AND n.title LIKE '%����%' OR n.content LIKE '%����%'
                  ORDER BY n.noticeno DESC
         )
)
WHERE r >=1 AND r <= 3;

8) Join ��ȸ
SELECT m.memberno, m.thumbs, m.nickname,
          n.noticeno, n.title, n.content, n.rdate
FROM fmember m, fnotice n
WHERE (n.noticeno = 1) AND (m.memberno = n.memberno); 
 
9) ����
UPDATE fnotice
SET title='����', content='�����մϴ�.'
WHERE noticeno = 6;

10) ����
DELETE FROM fnotice
WHERE noticeno = 1;

--------------------------------------------------

+) �˻�(%: ���ų� �ϳ� �̻��� ��� ����)
-- word LIKE '����' �� word = '����'
   ^����$
-- word LIKE '%����' �� word = '������ ����'
   .*����$
-- word LIKE '����%' �� word = '��������~'
   ^����.*
-- word LIKE '%����%' �� word = '���� �� �о����~'
   .*����.*
 
�˻� �� ���(S:Search List) 
    - ����� ���۽� �˻��� ������� �����ϸ� ��ü ������
      ��ü �˻����� �����ϴ�.
    - title, content �÷� ���

1) ����: 
    - WHERE rname LIKE '�մ���'
       rname �÷��� ���� '�մ���'�� ���ڵ� ���� ���

    - WHERE rname LIKE '%�մ���%'
      rname �÷��� ���� '�մ���'�� �� ���ڵ� ���� ���

    - WHERE rname LIKE '�մ���%'
      rname �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���

    - WHERE rname LIKE '%�մ���'
      rname �÷��� ���� '�մ���'�� �����ϴ� ���ڵ� ���� ���
   

2) �˻��� ���� �ʴ� ��� ��� ���ڵ� ��� 
SELECT noticeno, memberno, title, content, rdate
FROM fnotice
ORDER BY noticeno DESC;
     
3) �������� �˻�   
SELECT noticeno, memberno, title, content, rdate
FROM fnotice
WHERE title LIKE '%����%'
ORDER BY noticeno DESC;
    
4) �������� �˻�
SELECT noticeno, memberno, title, content, rdate
FROM fnotice
WHERE content LIKE '%����%'
ORDER BY noticeno DESC;

5) ����, �������� �˻�
SELECT noticeno, memberno, title, content, rdate
FROM fnotice
WHERE title LIKE '%����%' OR content LIKE '%����%'
ORDER BY noticeno DESC;

- �˻� �� ��ü ���ڵ� ����
-- cateno �÷��� 1���̸� �˻����� �ʴ� ��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM fnotice
 
-- '������' �˻� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM fnotice
WHERE title LIKE '%����%' OR content LIKE '%����%'
 

+) ����¡
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
 
-- �˻� + ����¡
SELECT noticeno, memberno, title, content, rdate, r
FROM(
         SELECT noticeno, memberno, title, content, rdate, rownum as r
         FROM(
                  SELECT noticeno, memberno, title, content, rdate
                  FROM fnotice
                  WHERE title LIKE '%����%' OR content LIKE '%����%'
                  ORDER BY noticeno DESC
         )
)
WHERE r >=1 AND r <= 3;
