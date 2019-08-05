/**********************************/
/* Table Name: �������� ���� */
/**********************************/
CREATE TABLE fsurvey(
surveyno                      NUMBER(10) NOT NULL PRIMARY KEY,
title                          VARCHAR2(200) NOT NULL,
content                       CLOB               NOT NULL,      -- CLOB
startdate                      VARCHAR2(10) NOT NULL,
enddate                        VARCHAR2(10) NULL ,
cnt                            NUMBER(7) DEFAULT 0 NOT NULL
--visible                         CHAR(1)           DEFAULT 'Y'     NOT NULL,
);
 
COMMENT ON TABLE fsurvey is '��������';
COMMENT ON COLUMN fsurvey.surveyno is '���� ���� ��ȣ';
COMMENT ON COLUMN fsurvey.title is '����';
COMMENT ON COLUMN fsurvey.content is '����';
COMMENT ON COLUMN fsurvey.startdate is '���� ��¥';
COMMENT ON COLUMN fsurvey.enddate is '���� ��¥';
COMMENT ON COLUMN fsurvey.cnt is '���� �ο�';
--COMMENT ON COLUMN survey.visible is '��� ���';
 

--���(������)
INSERT INTO fsurvey(surveyno, title, content, startdate, enddate, cnt)
VALUES((SELECT NVL(MAX(surveyno), 0)+1 as surveyno FROM fsurvey), 
          '��ȣ ������ ��������', '���� �����ϴ� �������� �������ּ���.', sysdate, sysdate, 0);
          
--���(�����)
SELECT *
FROM fsurvey
WHERE (enddate > sysdate)
ORDER BY enddate ASC;
          
--���(������)
SELECT *
FROM fsurvey
ORDER BY enddate ASC;

--��ȸ(����� &������)
SELECT *
FROM fsurvey
WHERE surveyno = 1;

--����(������)
UPDATE fsurvey
SET title='���� ��ȭ', content='���� �����ϴ� ��ȭ�� �������ּ���.', startdate=TO_DATE('2019-05-25'), enddate=TO_DATE('2019-05-25')
WHERE surveyno = 1;

--����(������)
DELETE FROM fsurvey
WHERE surveyno = 1;

 
/**********************************/
/* Table Name: ���� ���� �׸� */
/**********************************/
DROP table fsurveyitem;

CREATE TABLE fsurveyitem(
surveyitemno                  NUMBER(10) NOT NULL PRIMARY KEY,
surveyno                      NUMBER(10) NULL ,
item                          VARCHAR2(200) NOT NULL,
itemfile                      VARCHAR2(1000) NULL ,
itemfsize                    VARCHAR2(1000) NULL ,
itemcnt                        NUMBER(7) DEFAULT 0 NOT NULL,
  FOREIGN KEY (surveyno) REFERENCES fsurvey (surveyno)
);
 
CREATE TABLE fsurveyitem(
surveyitemno                  NUMBER(10) NOT NULL PRIMARY KEY,
surveyno                      NUMBER(10) NULL ,
item                          VARCHAR2(200) NOT NULL,
itemcnt                        NUMBER(7) DEFAULT 0 NOT NULL,
  FOREIGN KEY (surveyno) REFERENCES fsurvey (surveyno)
);

COMMENT ON TABLE fsurveyitem is '���� ���� �׸�';
COMMENT ON COLUMN fsurveyitem.surveyitemno is '���� ���� �׸� ��ȣ';
COMMENT ON COLUMN fsurveyitem.surveyno is '���� ���� ��ȣ';
COMMENT ON COLUMN fsurveyitem.item is '�׸�';
COMMENT ON COLUMN fsurveyitem.itemfile is '�׸� ����';
COMMENT ON COLUMN fsurveyitem.itemfsize is '�׸� ���� ������';
COMMENT ON COLUMN fsurveyitem.itemcnt is '�׸� ���� �ο�';

--���(������)
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemfile, itemfsize, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, '�����', 'yej.jpg', 0, 0);
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemfile, itemfsize, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, '�ư���', 'yej.jpg', 0, 0);
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemfile, itemfsize, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          2, '�ư���', 'yej.jpg', 0, 0);    
          
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, '�����', 0);
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, '�ư���', 0);
          
--���(�����&������)
SELECT *
FROM fsurveyitem;

--�����ڸ�
SELECT *
FROM fsurveyitem
WHERE surveyno=1;

--��ȸ(����� &������)
SELECT *
FROM fsurveyitem
WHERE surveyitemno = 1;

--����(������)
UPDATE fsurveyitem
SET item='��������', itemfile='ejy.jpg', itemfsize=0
WHERE surveyno = 1;

--����(������)
DELETE FROM fsurveyitem
WHERE surveyitemno = 1;
 
 
/**********************************/
/* Table Name: ���� ���� ȸ�� */ 
/**********************************/
CREATE TABLE fsurveymember(
surveymemberno                NUMBER(10) NOT NULL PRIMARY KEY,
surveyitemno                  NUMBER(10) NULL ,
memberno                         NUMBER(6) NULL ,
rdate                          DATE NOT NULL,
  FOREIGN KEY (surveyitemno) REFERENCES fsurveyitem (surveyitemno),
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);
 
COMMENT ON TABLE fsurveymember is '���� ���� ȸ��';
COMMENT ON COLUMN fsurveymember.surveymemberno is '���� ���� ȸ�� ��ȣ';
COMMENT ON COLUMN fsurveymember.surveyitemno is '���� ���� �׸� ��ȣ';
COMMENT ON COLUMN fsurveymember.memberno is 'ȸ�� ��ȣ';
COMMENT ON COLUMN fsurveymember.rdate is '���� ���� ��¥';

--���(����� : �����ϱ�)
INSERT INTO fsurveymember(surveymemberno, surveyitemno, memberno, rdate)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, 1, sysdate);
INSERT INTO fsurveymember(surveymemberno, surveyitemno, memberno, rdate)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, 2, sysdate);
INSERT INTO fsurveymember(surveymemberno, surveyitemno, memberno, rdate)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, 3, sysdate);
          

--���(������)
SELECT *
FROM fsurveymember;

--��ȸ(����� &������)
SELECT *
FROM fsurveyitem
WHERE surveymemberno = 1;

--����(������)

--����(������)
DELETE FROM fsurveymember
WHERE surveymemberno = 1;

DELETE FROM fsurveymember
WHERE surveyitemno = 1;


SELECT COUNT(surveyitemno) as cnt
FROM fsurveyitem
WHERE surveyno = 1;

-------------------
--join(����)
--survey �� surveyitem ���̺� �����ڵ�
CREATE TABLE fsurvey(
surveyno                      NUMBER(10) NOT NULL PRIMARY KEY,
title                          VARCHAR2(200) NOT NULL,
content                       CLOB               NOT NULL,      -- CLOB
startdate                      VARCHAR2(10) NOT NULL,
enddate                        VARCHAR2(10) NULL ,
cnt                            NUMBER(7) DEFAULT 0 NOT NULL
--visible                         CHAR(1)           DEFAULT 'Y'     NOT NULL,
);
CREATE TABLE fsurveyitem(
surveyitemno                  NUMBER(10) NOT NULL PRIMARY KEY,
surveyno                      NUMBER(10) NULL ,
item                          VARCHAR2(200) NOT NULL,
itemcnt                        NUMBER(7) DEFAULT 0 NOT NULL,
  FOREIGN KEY (surveyno) REFERENCES fsurvey (surveyno)
);

  SELECT s.surveyno, s.title, s.content, s.startdate, s.enddate, s.cnt,
            i.surveyitemno, i.surveyno, i.item, i.itemcnt
  FROM fsurvey s, fsurveyitem i
  WHERE s.surveyno = i.surveyno
  ORDER BY surveyitemno ASC;
  
  
  
  
  