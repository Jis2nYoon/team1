DROP TABLE msg_samp;

/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE msg_samp(
		msgno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY, -- �޼��� ��ȣ
		msgsender                     		NUMBER(10)		 NOT NULL, -- ������ ���
		msgreceiver                   		NUMBER(20)		 NOT NULL, -- �޴� ���
		msgcontent                    		CLOB		 NOT NULL, -- �޼��� ����
		msgtime                       		DATE		 NOT NULL, -- ���� �ð�
		contentsno                    		NUMBER(10)		 NULL , -- ����� ��ǰ ��ȣ
  FOREIGN KEY (msgsender) REFERENCES fmember (memberno),
  FOREIGN KEY (msgreceiver) REFERENCES fmember (memberno),
  FOREIGN KEY (contentsno) REFERENCES content (contentsno)
);

COMMENT ON TABLE msg_samp is '����';
COMMENT ON COLUMN msg_samp.msgno is '���� ��ȣ';
COMMENT ON COLUMN msg_samp.msgsender is '������ ���';
COMMENT ON COLUMN msg_samp.msgreceiver is '�޴� ���';
COMMENT ON COLUMN msg_samp.msgcontent is '�޼��� ����';
COMMENT ON COLUMN msg_samp.msgtime is '�޼��� ���� ��¥';
COMMENT ON COLUMN msg_samp.contentsno is '������ ��ȣ';


--����--0
--������ -> ���ټ�(contentsno =1)
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2�� ȸ���� 1���� ������ �޼���1', sysdate, 1); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1�� ȸ���� 2���� ������ �޼���1', sysdate, 1); 

INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2�� ȸ���� 1���� ������ �޼���2', sysdate, 1); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1�� ȸ���� 2���� ������ �޼���2', sysdate, 1); 

INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2�� ȸ���� 1���� ������ �޼���3', sysdate, 1); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1�� ȸ���� 2���� ������ �޼���3', sysdate, 1); 

--ȸ�� 3���� ���� �޼���
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 3, 1, '3�� ȸ���� 1���� ������ �޼���1', sysdate, 1); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 3, '1�� ȸ���� 3���� ������ �޼���1', sysdate, 1); 

--ȸ�� 1���� 4������ ���´µ� �оõ� �޼���
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 4, '1�� ȸ���� 4���� ������ �޼���1', sysdate, 1); 

--��ǰ 2�� 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2�� ȸ���� 1���� ������ �޼���1', sysdate, 2); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1�� ȸ���� 2���� ������ �޼���1', sysdate, 2); 

INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2�� ȸ���� 1���� ������ �޼���2', sysdate, 2); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1�� ȸ���� 2���� ������ �޼���2', sysdate, 2); 

INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2�� ȸ���� 1���� ������ �޼���3', sysdate, 2); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1�� ȸ���� 2���� ������ �޼���3', sysdate, 2); 

--���

SELECT msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno
FROM msg_samp

-- ���� �ְ� ���� ����� �θ����� �޴� ��� ��ȣ(user1)�� �����»�� ��ȣ(user2) �ΰ��� �־�� �ϸ�
-- �� ��ǰ�� ����  contentsno=1 AND 
-- (msgsender=2 OR msgsender=1) : msgsender�� user1�̰ų� msgsender�� user2�� ��츦 ��� ã���� �ȴ�.
SELECT msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno
FROM msg_samp
WHERE contentsno=1 AND (msgsender=�����ȣ OR msgsender=����ȣ)
ORDER BY msgtime ASC;  
-- �޼��� ���۵� �ð����� ��� ����

-- �Ǹ��ڰ� ������ ���� ����� �����Ұ� �Ƴ�
SELECT distinct msgsender, contentsno, msgreceiver
FROM msg_samp
ORDER BY contentsno ASC;  





DELETE FROM msg_samp
WHERE msgno = 1;

