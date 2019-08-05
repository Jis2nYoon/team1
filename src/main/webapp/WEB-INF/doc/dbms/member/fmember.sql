--�ŷ� �Խñ� ���̺� ����
DROP TABLE content;  
--�α��� ���� ���̺� ����
DROP TABLE fgrade;
--ȸ����� ���̺� ����
DROP TABLE flogin;
--ȸ�� ���̺� ����
DROP TABLE fmember;


/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE fmember(
		memberno             		NUMBER(10)		   NOT NULL		 PRIMARY KEY,
		email                     		VARCHAR2(50)		 NOT NULL    UNIQUE,
		passwd                  		VARCHAR2(60)		 NOT NULL,
		thumbs                    VARCHAR2(100)       NULL ,
    photo                      VARCHAR2(200)       NULL ,
    sizes                        VARCHAR2(100)       NULL,
		nickname               		VARCHAR2(30)		 NOT NULL,
		mname                  		VARCHAR2(20)		 NOT NULL,
		tel                        		VARCHAR2(14)		 NOT NULL,
		zipcode                  		VARCHAR2(5)		 NULL ,
		address1                   VARCHAR2(80)   NULL, -- �ּ� 1
    address2                   VARCHAR2(50)   NULL, -- (��) �ּ� 2
		act                        		CHAR(1)		         DEFAULT 'Y'		 NOT NULL,
		stopdate                		DATE		             NULL ,
		mdate                   		DATE		             NOT NULL
);

-- stopdate = ������ �����Ǿ��� �� ��¥ ���� ����
--  act = M: ������, Y: �α��� ����, N: �α��� �Ұ�, C: Ż��

COMMENT ON TABLE fmember is 'ȸ��';
COMMENT ON COLUMN fmember.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN fmember.email is '�̸��� ����';
COMMENT ON COLUMN fmember.passwd is '�н�����';
COMMENT ON COLUMN fmember.thumbs is '�����ʻ��� �����';
COMMENT ON COLUMN fmember.photo is '�����ʻ��� ����';
COMMENT ON COLUMN fmember.sizes is '���� ���� ũ��';
COMMENT ON COLUMN fmember.nickname is '�г���';
COMMENT ON COLUMN fmember.mname is '�̸�';
COMMENT ON COLUMN fmember.tel is '��ȭ';
COMMENT ON COLUMN fmember.zipcode is '�����ȣ';
COMMENT ON COLUMN fmember.address1 is '�ּ�';
COMMENT ON COLUMN fmember.address2 is '���ּ�';
COMMENT ON COLUMN fmember.act is '���� ����';
COMMENT ON COLUMN fmember.stopdate is '���� ������';
COMMENT ON COLUMN fmember.mdate is '���Գ�¥';


----------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
1) ����*******  (���/grade ���̺� ����� �� �� ����)
-- grade �� �Բ� insert �Ǳ� ���� insert all �� ********

INSERT ALL
  INTO fmember VALUES (memberno, 
  'master@mail.com', '123','','','0', '������', '������', '010-0000-0101', '11311', 
  '��⵵ ����' , '���籸', 'M','', sysdate)  
  INTO fgrade VALUES ((SELECT NVL(MAX(gradeno), 0)+1 as gradeno FROM fgrade),
  0, 0, 0, 0, 0, memberno)
 SELECT (NVL(MAX(memberno), 0)+1) as memberno 
 FROM fmember;


--�⺻ member table ���� (����)
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode, address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'master@mail.com', '123', '�մ���', 'ȫ�浿', '010-0000-0101', '11311', '��⵵ ����' , '���籸', 'Y','', sysdate);
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode, address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user1@mail.com', '123', '�Ʒι�', 'ȫ���', '010-0000-0102', '11312', '��⵵ ����', '���籸', 'Y','', sysdate);
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user2@mail.com', '123', '�մ���', '����ȫ', '010-0000-0103', '11313', '��⵵ ����', '���籸', 'Y','', sysdate);
   
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode, address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user3@mail.com', '123', '�Ʒι�72', 'ȫ���', '010-0000-0102', '11312', '��⵵ ����', '���籸', 'Y','', sysdate);
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user4@mail.com', '123', '�մ���4', '����ȫ', '010-0000-0103', '11313', '��⵵ ����', '���籸', 'Y','', sysdate);
   
  INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode, address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user5@mail.com', '123', '�Ʒι�21', 'ȫ���', '010-0000-0102', '11312', '��⵵ ����', '���籸', 'Y','', sysdate);
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'user6@mail.com', '123', '�մ���1', '����ȫ', '010-0000-0103', '11313', '��⵵ ����', '���籸', 'Y','', sysdate);
   
  
INSERT INTO fmember(memberno, email, passwd, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate)
VALUES((SELECT NVL(MAX(memberno), 0)+1 as memberno FROM fmember),
  'lastuser@mail.com', '123', '�պ���', '�κ���', '010-0000-0103', '11313', '��⵵ ����', '���籸', 'Y','', sysdate);
  
 2) ���

SELECT memberno, email, passwd,  thumbs, photo, sizes, nickname, mname, tel, zipcode,  address1, address2 , act, stopdate, mdate
FROM fmember
ORDER BY memberno ASC;

2-1) �˻�
SELECT memberno, email, passwd, thumbs, photo, sizes, nickname, mname, tel, zipcode,  address1, address2 , act, stopdate, mdate
FROM fmember
WHERE email like '%mas%'
ORDER BY memberno ASC;

2-2) ��ü��� ����¡
SELECT memberno, email, passwd,  thumbs,  sizes, nickname, mname, tel, zipcode,  
          address1, address2 , act, stopdate, mdate, r
FROM(
         SELECT memberno, email, passwd, thumbs,  sizes, nickname, mname, tel, zipcode,  
                   address1, address2 , act, stopdate, mdate, rownum as r
         FROM(
                  SELECT memberno, email, passwd, thumbs,  sizes, nickname, mname, tel, zipcode,  
                            address1, address2 , act, stopdate, mdate
                  FROM fmember
                  ORDER BY memberno ASC
         )
)
WHERE r >=7 AND r <= 9;

2-3) ��ü��� ����¡ + �˻�
 SELECT memberno, email, passwd, thumbs,  sizes, nickname, mname, tel, zipcode,  
              address1, address2 , act, stopdate, mdate, r
    FROM(
             SELECT memberno, email, passwd, thumbs, sizes, nickname, mname, tel, zipcode,  
                      address1, address2 , act, stopdate, mdate, rownum as r
             FROM(
                      SELECT memberno, email, passwd, thumbs, sizes, nickname, mname, tel, zipcode,  
                                address1, address2 , act, stopdate, mdate
                      FROM fmember
                      <choose>                        
                        <when test="col == 'email'"> <!-- email �˻� -->
                          WHERE email LIKE '%' || #{word} || '%'
                        </when>
                        <when test="col == 'nickname'"> <!-- nickname �˻� -->
                          WHERE nickname LIKE '%' || #{word} || '%'
                        </when>
                        <when test="col == 'mname'"> <!-- mname �˻� -->
                          WHERE mname LIKE '%' || #{word} || '%'
                        </when>                          
                        <when test="col == 'act'"> <!-- act ���� -->
                          WHERE act = #{word}
                        </when>       
                        <when test="col == 'stopdate'"><!--  stopdate ���� -->
                          ORDER BY stopdate ASC
                        </when>    
                        <otherwise>            
                          ORDER BY memberno ASC
                        </otherwise>         
                      </choose>
             )
    )
    WHERE <![CDATA[r >= #{startNum} AND r <= #{endNum}]]>
    
3) ��ȸ

SELECT memberno, email, passwd, thumbs, photo, sizes, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate
FROM fmember
WHERE memberno =2;

3-1) ������ �̹��� ��ȸ
SELECT thumbs, photo, sizes
FROM fmember
WHERE memberno =1;
  
4) ����
UPDATE fmember
SET passwd='123', nickname = '�Ʒҽ�', mname='ȫ����', act = 'M' 
WHERE memberno =1;

UPDATE fmember
SET act = 'M'
WHERE memberno =1;

UPDATE fmember
SET thumbs='thumbs.jpg', photo = 'photo.jpg'
WHERE memberno =1;

4-1) Ż�� ����
UPDATE fmember
SET nickname = '.', zipcode='',  address1='', address2='', act = 'C', stopdate='' ,thumbs='', photo='', sizes=''
WHERE memberno =2;

4-2)��й�ȣ ����
UPDATE fmember
SET passwd='123'
WHERE email ='jjhre@naver.com';
 

SELECT memberno, email, passwd, thumbs, photo, sizes, nickname, mname, tel, zipcode,  address1, address2, act, stopdate, mdate
FROM fmember
ORDER BY memberno ASC; 
 
5) ����
DELETE FROM fmember
COMMIT;

DELETE FROM flogin
WHERE memberno = 10;

DELETE FROM fgrade
WHERE memberno = 10;

DELETE FROM fmember
WHERE memberno = 10;

6)��¥ ó��
update fmember
set stopdate = TO_DATE('2019-05-25 06:00:00', 'YYYY-MM-DD HH:MI:SS')
where memberno = 5;

7) �̸��� �ߺ� üũ
SELECT COUNT(email) as cnt
FROM fmember
WHERE email=#{email};

8) �г��� �ߺ� üũ
SELECT COUNT(nickname) as cnt
FROM fmember
WHERE nickname=#{nickname};
 
9) �̸��� ã��
SELECT email
FROM fmember
WHERE mname='������'
AND tel = '010-0000-0000'
