--�ŷ� �Խñ� ���̺� ����
DROP TABLE content;  
--�α��� ���� ���̺� ����
DROP TABLE fgrade;
--ȸ����� ���̺� ����
DROP TABLE flogin;
--ȸ�� ���̺� ����
DROP TABLE fmember;


/**********************************/
/* Table Name: �α��γ��� */
/**********************************/
CREATE TABLE flogin(
		loginno                    		NUMBER(10)		   NOT NULL		 PRIMARY KEY,
		ip                            		VARCHAR2(15)		 NOT NULL,
		ldate                         		DATE		             NOT NULL,
		memberno                 		NUMBER(10)  		 NULL ,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE flogin is '�α��γ���';
COMMENT ON COLUMN flogin.loginno is '�α��γ��� ��ȣ';
COMMENT ON COLUMN flogin.ip is '������ �ּ�';
COMMENT ON COLUMN flogin.ldate is '�α��� ��¥';
COMMENT ON COLUMN flogin.memberno is 'ȸ�� ��ȣ';


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------

1) ����
  
INSERT INTO flogin(loginno, ip, ldate, memberno)
VALUES((SELECT NVL(MAX(loginno), 0)+1 as loginno FROM flogin),
  0, sysdate, 1);  
  
INSERT INTO flogin(loginno, ip, ldate, memberno)
VALUES((SELECT NVL(MAX(loginno), 0)+1 as loginno FROM flogin),
  0, sysdate, 2);  
  
INSERT INTO flogin(loginno, ip, ldate, memberno)
VALUES((SELECT NVL(MAX(loginno), 0)+1 as loginno FROM flogin),
  0, sysdate, 2);
  
  
 2) ���

SELECT loginno, ip, ldate, memberno
FROM flogin
ORDER BY loginno ASC;

 --member join ��ü ���
  --Member_LoginVO
  
SELECT m.memberno, m.email, m.nickname, 
               l.loginno, l.ip, l.ldate
FROM fmember m, flogin l
WHERE m.memberno = l.memberno 
ORDER BY loginno DESC;

3-1) ��ȸ
SELECT loginno, ip, ldate, memberno
FROM flogin
WHERE memberno =1;

3-2) memberno���� ���ڵ� �� ��ȸ 
SELECT count(loginno) as cnt
FROM flogin
WHERE memberno =1
 
5) ����
DELETE FROM flogin
COMMIT;

DELETE FROM flogin
WHERE loginno = 3;

--memberno���� ��ȸ ����
DELETE FROM flogin
WHERE memberno = 1;
 
