DROP TABLE msg;
DROP TABLE msgroom;

/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE msg(
		msgno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		msgsender                     		NUMBER(10)		 NOT NULL,
		msgreceiver                   		NUMBER(20)		 NOT NULL,
		msgcontent                    		CLOB		 NOT NULL,
		msgtime                       		DATE		 NOT NULL,
		fname                         		VARCHAR2(100)		 NULL ,
		fsize                         		NUMBER(10)		 NULL ,
		mcnt                          		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		contentsno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (msgsender) REFERENCES fmember (memberno),
  FOREIGN KEY (msgreceiver) REFERENCES fmember (memberno),
  FOREIGN KEY (contentsno) REFERENCES content (contentsno)
);

COMMENT ON TABLE msg is '����';
COMMENT ON COLUMN msg.msgno is '���� ��ȣ';
COMMENT ON COLUMN msg.msgsender is '������ ���';
COMMENT ON COLUMN msg.msgreceiver is '�޴� ���';
COMMENT ON COLUMN msg.msgcontent is '�޼��� ����';
COMMENT ON COLUMN msg.msgtime is '�޼��� ���� ��¥';
COMMENT ON COLUMN msg.fname is '���ϸ�';
COMMENT ON COLUMN msg.fsize is '���� ������';
COMMENT ON COLUMN msg.mcnt is '��ȸ����';
COMMENT ON COLUMN msg.contentsno is '������ ��ȣ';


--����--0
--������ -> ���ټ�(contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  2, 1, '���ŷ� �����ұ��?', sysdate, 'spring.jpg', 0, 0, 1);
  
--������ ->���ټ�(contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  3, 1, '���ŷ� �����ұ��?', sysdate, 'spring.jpg', 0, 0, 1);
  
--������ ->���ټ� (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  3, 1, '���ŷ� �����ұ��?', sysdate, 'spring.jpg', 0, 0, 2);
  
--���ټ� -> ������  (contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  1, 2, '�� �����մϴ�.', sysdate, 'spring.jpg', 0, 0, 1);
  
--���ټ� -> ������  (contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  1, 3, '�� �����մϴ�.', sysdate, 'spring.jpg', 0, 0, 1);
  
--���ټ� -> ������  (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  1, 3, '�� �����մϴ�.', sysdate, 'spring.jpg', 0, 0, 2);  



--���
1) �Խñ� ������ ���̰�
���Ǹ����� ��� : ��) ���ټ�
SELECT contentsno, memberno
FROM content
ORDER BY contentsno ASC;
�߰� : �޽����� �� ����� �Խñ� ����Ʈ �������� == �޽���ī��Ʈ�� 0���� ũ�� ����Ʈ ��������
 CONTENTSNO MEMBERNO
 ---------- --------
          1        1
          2        1

select * 
from content
where contentsno IN (select contentsno from msg)
order by contentsno;
CONTENTSNO CATENO MEMBERNO TITLE     CONTENTS      RDATE                 MSGNO
 ---------- ------ -------- --------- ------------- --------------------- -----
          1      1        1 �̾��� �˴ϴ�.  �ù�� ���� ���� 2���� 2019-05-27 10:31:23.0  NULL
          2      1        1 �̾��� �˴ϴ�2. �ù�� ���� ���� 2���� 2019-05-27 10:31:27.0  NULL


         
�豸������ ��� : ��)������
select * 
from content
where contentsno IN (select contentsno from msg where msgsender = 2)
order by contentsno;
CONTENTSNO CATENO MEMBERNO TITLE    CONTENTS      RDATE                 MSGNO
 ---------- ------ -------- -------- ------------- --------------------- -----
          1      1        1 �̾��� �˴ϴ�. �ù�� ���� ���� 2���� 2019-05-27 10:31:23.0  NULL


2)�� �Խñۿ��� �޽����� ���̰� 

1.�ټ��̰��==���� �޽���
SELECT msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno
FROM msg
WHERE msgreceiver=1 and contentsno=1
ORDER BY msgtime ASC;
MSGNO MSGSENDER MSGRECEIVER MSGCONTENT MSGTIME               FNAME      FSIZE MCNT CONTENTSNO
 ----- --------- ----------- ---------- --------------------- ---------- ----- ---- ----------
     1         2           1 ���ŷ� �����ұ��? 2019-05-27 10:34:53.0 spring.jpg     0    0          1
     2         3           1 ���ŷ� �����ұ��? 2019-05-27 10:34:54.0 spring.jpg     0    0          1

     
2.�ټ��� ��� == ���� �޽���
SELECT msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno
FROM msg
WHERE msgsender=1 and contentsno=1
ORDER BY msgtime ASC;
MSGNO MSGSENDER MSGRECEIVER MSGCONTENT MSGTIME               FNAME      FSIZE MCNT CONTENTSNO
 ----- --------- ----------- ---------- --------------------- ---------- ----- ---- ----------
     3         1           2 �� �����մϴ�.   2019-05-27 10:34:55.0 spring.jpg     0    0          1
     4         1           3 �� �����մϴ�.   2019-05-27 10:34:56.0 spring.jpg     0    0          1


--���� : ��ȸ ����
MsgCont����()?)
�޴»������ üũ�ϱ�!
msgreceiver-�޴»�� ��ȣ == ȸ����ȣ�� ������?

UPDATE msg
SET mcnt = mcnt + 1
WHERE msgno = 1;

--mcnt �� 0���� ũ��
String str = "";
mcnt == 0 
str = new;
mcnt != 0
str = ����;
     
--����

DELETE FROM msg
WHERE msgno = 1;

