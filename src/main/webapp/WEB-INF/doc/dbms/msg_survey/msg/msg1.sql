DROP TABLE msg;
DROP TABLE msgroom;

/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE msg(
		msgno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		msgsender                     		NUMBER(10)		 NOT NULL,
		msgreceiver                   		NUMBER(20)		 NOT NULL,
		msgtitle                            VARCHAR2(50)   NOT NULL,
		msgcontent                    		CLOB		 NOT NULL,
		msgtime                       		DATE		 NOT NULL,
		thumbs                        VARCHAR2(1000)      NULL,
		files                         		VARCHAR2(1000)		 NULL,
		sizes                         		  VARCHAR2(1000)		 NULL,
		mcnt                          		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		contentsno                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (msgsender) REFERENCES fmember (memberno),
  FOREIGN KEY (msgreceiver) REFERENCES fmember (memberno),
  FOREIGN KEY (contentsno) REFERENCES content (contentsno)
);

DROP TABLE msg;

DELETE FROM msg;

--test1
CREATE TABLE msg(
    msgno                               NUMBER(10)     NOT NULL    PRIMARY KEY,
    msgsender                         NUMBER(20)     NOT NULL,
    msgreceiver                       NUMBER(20)     NOT NULL,
    msgtitle                            VARCHAR2(50)   NOT NULL,
    msgcontent                       CLOB               NOT NULL,
    msgtime                           DATE               NOT NULL,
    mcnt                                NUMBER(10)     DEFAULT 0     NOT NULL,
    contentsno                        NUMBER(10)     NOT NULL ,
  FOREIGN KEY (msgsender) REFERENCES fmember (memberno),
  FOREIGN KEY (msgreceiver) REFERENCES fmember (memberno),
  FOREIGN KEY (contentsno) REFERENCES content (contentsno)
);

contentsno=1
-- ����=>�ټ�
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               2, 1, '�ȳ��ϼ���.', '���ŷ� �����ұ��?', sysdate, 0, 1);

contentsno=2
-- ����=>�ټ�
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               2, 1, '�ȳ��ϼ���.', '���ŷ� �����ұ��?', sysdate, 0, 2);
            
-- ����=>�ټ�
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               3, 1, '�ȳ��ϼ���.', '���ŷ� �����ұ��?', sysdate, 0, 1);
               
-- ����=>�ټ�
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               2, 1, '�ȳ��ϼ���.', '���ŷ� �����ұ��?', sysdate, 0, 1);
               
               
               
               
-- �ټ�=>����
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               1, 2, '�ȳ��ϼ���.', '���ŷ� �����ұ��?', sysdate, 0, 2);
               
-- �ټ�=>����
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               1, 3, '�ȳ��ϼ���.', '���ŷ� �����ұ��?', sysdate, 0, 1);
               
�������� ���
2��

���� ���� ���
3��
               
select *
from msg;
               
               
             
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  2, 1, '���ŷ� �����ұ��?', sysdate, 'spring.jpg', 0, 0, 1);

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

===================================
--TEST
contents
2��

1�� ������ -> �ټ�
      �ټ� -> ������
--������ -> ���ټ�(contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
2, 1, '�ȳ��ϼ���.', '���ŷ� �����ұ��?', sysdate, 0, 1);
        
--���ټ� -> ������  (contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
1, 2, '�ȳ��ϼ���.', '���ŷ� �����մϴ�', sysdate, 0, 1);
      
      

2�� ������ -> �ټ�
    ������ -> �ټ�
    
    �ټ�->����
    �ټ�->����
--������ ->���ټ� (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
2, 1, '�ȳ��ϼ���.', '���ŷ� �����ұ��?', sysdate, 0, 2);
    
--������ ->���ټ� (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
3, 1, '�ȳ��ϼ���.', '���ŷ� �����ұ��?', sysdate, 0, 2);
  
--���ټ� -> ������  (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
1, 2, '�ȳ��ϼ���.', '���ŷ� �����մϴ�', sysdate, 0, 2);
  
--���ټ� -> ������  (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
1, 3, '�ȳ��ϼ���.', '���ŷ� �����մϴ�', sysdate, 0, 2);

������
�������ϰ��
���� �޽��� = 1�� 1�� 2�� 1��
���� �޽��� = 1�� 1�� 2�� 1��

������ 
������
���� �޽��� = 2�� 1��
���� �޽��� = 2�� 1��

���ټ�
�Ǹ���
�����޽��� = 1�� 1�� 2�� 2��
���� �޽��� = 1�� 1�� 2�� 2��

  
====================================
--���
1) �Խñ� ������ ���̰�
���Ǹ����� ��� : ��) ���ټ�
SELECT contentsno, cateno, memberno, title, contents, rdate
FROM content
ORDER BY contentsno ASC;
�߰� : �޽����� �� ����� �Խñ� ����Ʈ �������� == �޽���ī��Ʈ�� 0���� ũ�� ����Ʈ ��������
contentsno
==========
1
2

SELECT contentsno, cateno, memberno, title, contents, rdate
FROM content
WHERE contentsno IN (SELECT contentsno FROM msg WHERE msgreceiver = 1)
ORDER BY contentsno;
CONTENTSNO CATENO MEMBERNO TITLE     CONTENTS      RDATE                 MSGNO
 ---------- ------ -------- --------- ------------- --------------------- -----
          1      1        1 �̾��� �˴ϴ�.  �ù�� ���� ���� 2���� 2019-05-27 10:31:23.0  NULL
          2      1        1 �̾��� �˴ϴ�2. �ù�� ���� ���� 2���� 2019-05-27 10:31:27.0  NULL


         
�豸������ ��� : ��)������, ������msgsender=3
SELECT contentsno, cateno, memberno, title, contents, rdate
FROM content
WHERE contentsno IN (SELECT contentsno FROM msg WHERE msgsender = 2)
ORDER BY contentsno;
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
WHERE msgno = 1 AND msgreceiver = ���� ��ȣ ;

--mcnt �� 0���� ũ��
String str = "";
mcnt == 0 
str = new;
mcnt != 0
str = ����;
     
--����

DELETE FROM msg
WHERE msgno = 1;

--read
  SELECT msgno, msgsender, msgreceiver, msgcontent, msgtime, mcnt, contentsno
  FROM msg
  WHERE msgno = 1;
  
  
  =============================================================
  msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
  
SELECT m.nickname as receivernickname, m.mname as receivermname,
            g.msgno, g.msgsender, g.msgreceiver, g.msgtitle, g.msgcontent, g.msgtime, g.mcnt
FROM fmember m, msg g
WHERE (g.msgreceiver = m.memberno) and g.msgsender = #{memberno} and contentsno=#{contentsno}

--  
SELECT receivernickname, receivermname,
          msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, r
FROM(
         SELECT receivernickname, receivermname,
                   msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, rownum as r
         FROM(
                  SELECT m.nickname as receivernickname, m.mname as receivermname,
                            g.msgno, g.msgsender, g.msgreceiver, g.msgtitle, g.msgcontent, g.msgtime, g.mcnt
                  FROM fmember m, msg g
                  WHERE (g.msgreceiver = m.memberno) and g.msgsender = 3 and contentsno=1 AND 
                  m.nickname LIKE '%alps%'
                  ORDER BY g.msgno DESC
         )
)
WHERE r >=1 AND r <= 3;
 
 <select id="msg_list_search_paging" resultType="Mem_MsgVO" parameterType="HashMap">
    SELECT receivernickname, receivermname,
          msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, r
    FROM(
              SELECT receivernickname, receivermname,
                   msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, rownum as r
              FROM(
                        SELECT m.nickname as receivernickname, m.mname as receivermname,
                                  g.msgno, g.msgsender, g.msgreceiver, g.msgtitle, g.msgcontent, g.msgtime, g.mcnt
                        FROM fmember m, msg g
                        WHERE (g.msgreceiver = m.memberno) and g.msgsender = 3 and contentsno=1 and
                        <choose>
                          <when test="col == 'receivernickname'"> <!-- �̸� �˻� -->
                            WHERE receivernickname LIKE '%' || #{receivernickname} || '%'  
                          </when>
                          <when test="col == 'msgtitle'"> <!-- ���� �˻� -->
                            WHERE msgtitle LIKE '%' || #{msgtitle} || '%'  
                          </when>
                          <when test="col == 'msgcontent'"> <!-- ���� �˻� -->
                            WHERE msgcontent LIKE '%' || #{msgcontent} || '%'  
                          </when>
                          <when test="col == 'msgtitlecontent'"> <!-- ����+���� �˻� -->
                            WHERE msgtitle LIKE '%' || ? || '%' OR msgcontent LIKE '%' || ? || '%'
                          </when>
                        </choose>
                        ORDER BY grpno DESC
              )
    )
    WHERE <![CDATA[r >=#{startNum} AND r <=#{endNum}]]>
    <!-- WHERE r >=1 AND r <= 3 -->
  </select>
  
  
  
  
  
  
  
  
 SELECT COUNT(*) as cnt
 FROM fmember m, msg g
 WHERE m.nickname LIKE '%' || ������ || '%'  
 
 
 
 
DELETE FROM msg
WHERE contentsno = 1;


==================
�����ڵ�

--�ŷ� �Խñ� ���̺�� ȸ�� ���̺� ����!
SELECT m.memberno, m.mname, 
          c.memberno, c.contentsno, c.title
FROM fmember m, content c
WHERE (c.contentsno = 1) AND (c.memberno = m.memberno);

<!-- ���� �������ΰ�� ��� -->
<select id="list_buyer" resultType="ContentVO" parameterType="int">
  SELECT contentsno, cateno, memberno, title, contents, rdate
  FROM content
  WHERE contentsno IN (SELECT contentsno FROM msg WHERE msgsender = 2)
  ORDER BY contentsno DESC;
</select>

<!-- Join ��� -->
<select id="read_by_join" resultType="Mem_ContentVO" parameterType="int">
   SELECT m.memberno, m.nickname, m.mname
             c.memberno, c.contentsno, c.title, c.contents, c.rdate
   FROM fmember m, content c, msg n
   WHERE (c.memberno = m.memberno) and
   (c.contentsno IN (SELECT n.contentsno FROM n WHERE n.msgsender = 2));
</select> 

�������� ���
SELECT m.memberno, m.nickname, m.mname,
          c.memberno, c.contentsno, c.title, c.contents, c.rdate
FROM fmember m, content c
WHERE (c.memberno = m.memberno) AND  (c.contentsno IN (SELECT contentsno FROM msg WHERE msgsender = 2)) and ;


ȭ���ϳ� ���� �����
======================================================
-- ���� ���� �޽��� ���� msgsender=���� ȸ����ȣ ���
--                          �޴»��? = �г���?
SELECT m.nickname as receivernickname, m.mname as receivermname,
          g.msgno, g.msgsender, g.msgreceiver, g.msgtitle, g.msgcontent, g.msgtime, g.mcnt
FROM fmember m, msg g
WHERE (g.msgreceiver = m.memberno) and g.msgsender = #{memberno}; -- ȸ�� ���ǿ��� ��ȣ �޾Ƽ� ó��

-- ���� ���� �޽��� (���ټ�)
SELECT m.nickname as receivernickname, m.mname as receivermname,
          g.msgno, g.msgsender, g.msgreceiver, g.msgtitle, g.msgcontent, g.msgtime, g.mcnt
FROM fmember m, msg g
WHERE (g.msgsender = m.memberno) and g.msgreceiver = #{memberno}; -- ȸ�� ���ǿ��� ��ȣ �޾Ƽ� ó��



CREATE TABLE msg(
    msgno                               NUMBER(10)     NOT NULL    PRIMARY KEY,
    msgsender                         NUMBER(20)     NOT NULL,
    msgreceiver                       NUMBER(20)     NOT NULL,
    msgtitle                            VARCHAR2(50)   NOT NULL,
    msgcontent                       CLOB               NOT NULL,
    msgtime                           DATE               NOT NULL,
    mcnt                                NUMBER(10)     DEFAULT 0     NOT NULL,
    contentsno                        NUMBER(10)     NOT NULL ,
  FOREIGN KEY (msgsender) REFERENCES fmember (memberno),
  FOREIGN KEY (msgreceiver) REFERENCES fmember (memberno),
  FOREIGN KEY (contentsno) REFERENCES content (contentsno)
);