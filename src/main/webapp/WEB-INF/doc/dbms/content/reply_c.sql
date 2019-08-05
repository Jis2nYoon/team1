DROP TABLE reply CASCADE CONSTRAINTS;

1) DDL
/**********************************/
/* Table Name: ��� */
/**********************************/
CREATE TABLE reply(
    replyno                           NUMBER(8)    NOT NULL, --����� �߰� �����Ǹ鼭 ��� ���� �ĺ�Ű��
    replycont                         VARCHAR2(512)    NOT NULL, --��� ����
    contentsno                        NUMBER(10)     NOT NULL, -- ��� ���� ������� �ĺ��� �� ��ȣ
    memberno                          NUMBER(10)     NOT NULL, -- ��� �Է��� �ĺ��� ��� ��ȣ
    rdate                             DATE     NOT NULL, -- ��� �Է� �ð�
    grpno                             NUMBER(8)    DEFAULT 0     NOT NULL, -- ����� ����
    indent                            NUMBER(8)    DEFAULT 0     NOT NULL, --����� ���� ǥ���Ҷ� indent �̿�. 0~1�� ǥ���ϵ�����.
    ansnum                            NUMBER(8)    DEFAULT 0     NOT NULL --������ ����
);

COMMENT ON TABLE reply is '���';
COMMENT ON COLUMN reply.replyno is '��� ��ȣ';
COMMENT ON COLUMN reply.replycont is '��� ����';
COMMENT ON COLUMN reply.contentsno is '������ ��ȣ';
COMMENT ON COLUMN reply.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN reply.rdate is '��۵�ϳ�¥';
COMMENT ON COLUMN reply.grpno is '��ۼ���';
COMMENT ON COLUMN reply.indent is '�鿩����';
COMMENT ON COLUMN reply.ansnum is '���ۼ���';


ALTER TABLE reply ADD CONSTRAINT IDX_reply_PK PRIMARY KEY (replyno);
ALTER TABLE reply ADD CONSTRAINT IDX_reply_FK0 FOREIGN KEY (contentsno) REFERENCES content (contentsno);
ALTER TABLE reply ADD CONSTRAINT IDX_reply_FK1 FOREIGN KEY (memberno) REFERENCES fmember (memberno);

2) SEQUENCE 

-- SEQUENCE ��ü ����
DROP SEQUENCE reply_seq;

CREATE SEQUENCE reply_seq
START WITH   1            --���۹�ȣ
INCREMENT BY 1          --������
MAXVALUE   99999999  --�ִ밪, NUMBER(7) ����
CACHE        2               --������ ����� ���� update�Ǵ� ���� �����ϱ����� ĳ�ð�
NOCYCLE;    


3) ���, C(create) & �亯ó��

-- NULL ������ ���� ���� ����� �ȵǴ� ���� ����
-- Oracle
SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply;
 GRPNO
 ---------
     1

-- 1) ���

INSERT INTO reply(replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum)
VALUES(reply_seq.nextval, '��� ����', 1, 1, sysdate, (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply), 0, 0);

INSERT INTO reply(replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum)
VALUES(reply_seq.nextval, '����� ���', 17, 1, sysdate, (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply), 0, 0);

INSERT INTO reply(replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum)
VALUES(reply_seq.nextval, 'indent����� ���', 17, 1, sysdate, (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply), 1, 0);
--2) �亯 ��Ͽ� ���� �亯 ������ ���� ó��
--UPDATE reply
--SET ansnum = ansnum + 1
--WHERE grpno = 1 AND ansnum > �θ� ansnum �÷��� ��;
UPDATE reply
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;

--3) �θ��� index �÷��� �� + 1: �鿩���� ȿ�� ���

--4) �亯 ���
INSERT INTO reply(replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum)
VALUES(reply_seq.nextval, '����', 17, 1, sysdate, (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply), 0, 0);
UPDATE reply
SET ansnum = ansnum + 1
WHERE grpno = 1;
--�̷��� �Ǿ���. Ȩ���������� üũ�ڽ��� üũ�ѻ��·� ����� �ܴٸ� Update�κб��� �ϷḦ ���ִ� ����.
--���������� sql�� ���ϰ� java���Ͽ��� ��۴޷��� �ۿ��� �÷��� �����ͼ� update�� ���� �����ߴ�. sql�� ¥���� �����ҵ�

 REPLYNO REPLYCONT CONTENTSNO MEMBERNO RDATE                 GRPNO INDENT ANSNUM
 ------- --------- ---------- -------- --------------------- ----- ------ ------
       1 ��� ���� ����           1        1 2019-05-14 15:16:57.0     1      0      1
       2 ����                1        1 2019-05-14 15:53:48.0     2      0      0

--5) ����� ���� ����
SELECT replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum
FROM reply
ORDER BY grpno DESC, ansnum ASC;
       
-- �亯�� �ƴ� ����� ����
   ORDER BY replyno DESC
   
-- �亯�� ����� ����
   ORDER BY grpno DESC, ansnum ASC

4) ��ü ���, R(Read) ����� �� ����.
SELECT replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum
FROM reply
ORDER BY replyno ASC;

 REPLYNO REPLYCONT CONTENTSNO MEMBERNO RDATE                 GRPNO INDENT ANSNUM
 ------- --------- ---------- -------- --------------------- ----- ------ ------
       1 ��� ����              1        1 2019-05-14 15:16:57.0     1      0      0

5) ��ȸ, R(Read)
SELECT replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum
FROM reply
WHERE contentsno = 1;

 REPLYNO REPLYCONT CONTENTSNO MEMBERNO RDATE                 GRPNO INDENT ANSNUM
 ------- --------- ---------- -------- --------------------- ----- ------ ------
       1 ��� ����              1        1 2019-05-14 15:16:57.0     1      0      0


6) ����, U(Update)

    UPDATE reply
    SET replycont='����', rdate= sysdate, indent=1, ansnum=1
    WHERE replyno = 35;
    

UPDATE reply
SET replycont='��� ���� ����', rdate= sysdate
WHERE replyno = 35;
 
SELECT replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum
FROM reply
ORDER BY replyno ASC;

 REPLYNO REPLYCONT CONTENTSNO MEMBERNO RDATE                 GRPNO INDENT ANSNUM
 ------- --------- ---------- -------- --------------------- ----- ------ ------
       1 ��� ���� ����           1        1 2019-05-14 15:16:57.0     1      0      0

7) ����, D(Delete)
DELETE FROM reply
WHERE replyno = 3;
 

-----------------------------------------------------------------------------------

// ------------------------- �亯 ���� �ڵ� ���� -------------------------
    // �θ��� pds4no ����
    int pds4no = pds4VO.getPds4no();
    // �θ��(�亯�� ���ϱ�) ���� ���� ��ȸ
    Pds4VO parent_pds4VO = pds4DAO.read(pds4no);
    
    // �亯������ �θ��� grpno�� ������ ��ϵ� VO ��ü�� ����
    pds4VO.setGrpno(parent_pds4VO.getGrpno());
 
    // �亯������ �θ𺸴� �鿩���⸦ 1 ���� ��Ŵ
    pds4VO.setIndent(parent_pds4VO.getIndent() + 1);
    
    // �亯 ������ 1������Ŵ���� �θ� �ٷ� �ϴܿ� ��ġ ��Ű���� ��.
    pds4VO.setAnsnum(parent_pds4VO.getAnsnum() + 1);
    
    //�̺κ� �׳� �״�� �ϰ� sql���� ��� ������ ���������.����
    // ������ ��ϵ� ��۵��� ansnum�� 1 ����
    pds4DAO.increaseAnsnum(parent_pds4VO.getGrpno(), parent_pds4VO.getAnsnum());
    // ------------------------- �亯 ���� �ڵ� ���� -------------------------
    
    
  <!-- increaseAnsnum ������ ��ϵ� ��۵��� ansnum�� 1�� ���� -->
  <update id='update_ans' parameterType="HashMap">
    UPDATE reply
    SET ansnum=ansnum + 1
    WHERE grpno = #{grpno} AND ansnum = #{ansnum}
  </update>
  
  
  
  