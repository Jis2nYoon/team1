--�ŷ� �Խñ� ���̺� ����
DROP TABLE content;  
--�α��� ���� ���̺� ����
DROP TABLE fgrade;
--ȸ����� ���̺� ����
DROP TABLE flogin;
--ȸ�� ���̺� ����
DROP TABLE fmember;

/**********************************/
/* Table Name: �� ��� */
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

COMMENT ON TABLE fgrade is '�� ���';
COMMENT ON COLUMN fgrade.gradeno is '�򰡵�� ��ȣ';
COMMENT ON COLUMN fgrade.numgrade is '�Ű��� �� ��';
COMMENT ON COLUMN fgrade.avggrade is '��ü �������';
COMMENT ON COLUMN fgrade.manner is '�Ǹ����µ�';
COMMENT ON COLUMN fgrade.delivery is '��ۼӵ�';
COMMENT ON COLUMN fgrade.quality is '��ǰǰ��';
COMMENT ON COLUMN fgrade.memberno is 'ȸ�� ��ȣ';

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------


1) ����
  
INSERT INTO fgrade(gradeno, numgrade, avggrade, manner, delivery, quality, memberno)
VALUES((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 3.4, 0.4, 3.8, 0.5, 1);

INSERT INTO fgrade(gradeno, numgrade, avggrade, manner, delivery, quality, memberno)
VALUES((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 0, 0, 0, 0, 2);

INSERT INTO fgrade(gradeno, numgrade, avggrade, manner, delivery, quality, memberno)
VALUES((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 0, 0, 0, 0, 3);

-- error 4 memberno ����x  
INSERT INTO fgrade(gradeno, numgrade, avggrade, manner, delivery, quality, memberno)
VALUES((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 0, 0, 0, 0, 4);
  
 2) ���

SELECT gradeno, numgrade, avggrade, manner, delivery, quality, memberno
FROM fgrade
ORDER BY gradeno ASC;

-- ��ü ��� member�� join
SELECT m.memberno, m.email, m.nickname, 
          g.gradeno, g.numgrade, g.avggrade, g.manner, g.delivery, g.quality
FROM fmember m, fgrade g
WHERE m.memberno = g.memberno 
ORDER BY gradeno DESC

3-1) ��ȸ
SELECT gradeno, numgrade, avggrade, manner, delivery, quality, memberno
FROM fgrade
WHERE memberno =1;
  
3-2) memberno���� ���ڵ� �� ��ȸ  
SELECT count(gradeno) as cnt
FROM fgrade
WHERE memberno =1

4) ����
UPDATE fgrade
SET numgrade=numgrade+1, avggrade = 4.5, manner=5,  delivery=4.3, quality=3.5
WHERE memberno = 1;
 
SELECT gradeno, numgrade, avggrade, manner, delivery, quality, memberno
FROM fgrade
ORDER BY gradeno ASC;
 
 
5) ����
DELETE FROM fgrade
COMMIT;

DELETE FROM fgrade
WHERE gradeno = 3;

6) ȸ�� ��� �׸� ���� ���� Ȯ��
SELECT count(gradeno)
FROM fgrade
WHERE memberno = 3;
