/**********************************/
/* Table Name: 설문조사 질문 */
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
 
COMMENT ON TABLE fsurvey is '설문조사';
COMMENT ON COLUMN fsurvey.surveyno is '설문 조사 번호';
COMMENT ON COLUMN fsurvey.title is '제목';
COMMENT ON COLUMN fsurvey.content is '내용';
COMMENT ON COLUMN fsurvey.startdate is '시작 날짜';
COMMENT ON COLUMN fsurvey.enddate is '종료 날짜';
COMMENT ON COLUMN fsurvey.cnt is '참여 인원';
--COMMENT ON COLUMN survey.visible is '출력 모드';
 

--등록(관리자)
INSERT INTO fsurvey(surveyno, title, content, startdate, enddate, cnt)
VALUES((SELECT NVL(MAX(surveyno), 0)+1 as surveyno FROM fsurvey), 
          '선호 여행지 설문조사', '가장 좋아하는 여행지를 선택해주세요.', sysdate, sysdate, 0);
          
--목록(사용자)
SELECT *
FROM fsurvey
WHERE (enddate > sysdate)
ORDER BY enddate ASC;
          
--목록(관리자)
SELECT *
FROM fsurvey
ORDER BY enddate ASC;

--조회(사용자 &관리자)
SELECT *
FROM fsurvey
WHERE surveyno = 1;

--수정(관리자)
UPDATE fsurvey
SET title='국내 영화', content='가장 좋아하는 영화를 선택해주세요.', startdate=TO_DATE('2019-05-25'), enddate=TO_DATE('2019-05-25')
WHERE surveyno = 1;

--삭제(관리자)
DELETE FROM fsurvey
WHERE surveyno = 1;

 
/**********************************/
/* Table Name: 설문 조사 항목 */
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

COMMENT ON TABLE fsurveyitem is '설문 조사 항목';
COMMENT ON COLUMN fsurveyitem.surveyitemno is '설문 조사 항목 번호';
COMMENT ON COLUMN fsurveyitem.surveyno is '설문 조사 번호';
COMMENT ON COLUMN fsurveyitem.item is '항목';
COMMENT ON COLUMN fsurveyitem.itemfile is '항목 파일';
COMMENT ON COLUMN fsurveyitem.itemfsize is '항목 파일 사이즈';
COMMENT ON COLUMN fsurveyitem.itemcnt is '항목 선택 인원';

--등록(관리자)
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemfile, itemfsize, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, '기생충', 'yej.jpg', 0, 0);
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemfile, itemfsize, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, '아가씨', 'yej.jpg', 0, 0);
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemfile, itemfsize, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          2, '아가씨', 'yej.jpg', 0, 0);    
          
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, '기생충', 0);
INSERT INTO fsurveyitem(surveyitemno, surveyno, item, itemcnt)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, '아가씨', 0);
          
--목록(사용자&관리자)
SELECT *
FROM fsurveyitem;

--관리자만
SELECT *
FROM fsurveyitem
WHERE surveyno=1;

--조회(사용자 &관리자)
SELECT *
FROM fsurveyitem
WHERE surveyitemno = 1;

--수정(관리자)
UPDATE fsurveyitem
SET item='국제시장', itemfile='ejy.jpg', itemfsize=0
WHERE surveyno = 1;

--삭제(관리자)
DELETE FROM fsurveyitem
WHERE surveyitemno = 1;
 
 
/**********************************/
/* Table Name: 설문 참여 회원 */ 
/**********************************/
CREATE TABLE fsurveymember(
surveymemberno                NUMBER(10) NOT NULL PRIMARY KEY,
surveyitemno                  NUMBER(10) NULL ,
memberno                         NUMBER(6) NULL ,
rdate                          DATE NOT NULL,
  FOREIGN KEY (surveyitemno) REFERENCES fsurveyitem (surveyitemno),
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);
 
COMMENT ON TABLE fsurveymember is '설문 참여 회원';
COMMENT ON COLUMN fsurveymember.surveymemberno is '설문 참여 회원 번호';
COMMENT ON COLUMN fsurveymember.surveyitemno is '설문 조사 항목 번호';
COMMENT ON COLUMN fsurveymember.memberno is '회원 번호';
COMMENT ON COLUMN fsurveymember.rdate is '설문 참여 날짜';

--등록(사용자 : 제출하기)
INSERT INTO fsurveymember(surveymemberno, surveyitemno, memberno, rdate)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, 1, sysdate);
INSERT INTO fsurveymember(surveymemberno, surveyitemno, memberno, rdate)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, 2, sysdate);
INSERT INTO fsurveymember(surveymemberno, surveyitemno, memberno, rdate)
VALUES((SELECT NVL(MAX(surveyitemno), 0)+1 as surveyitemno FROM fsurveyitem), 
          1, 3, sysdate);
          

--목록(관리자)
SELECT *
FROM fsurveymember;

--조회(사용자 &관리자)
SELECT *
FROM fsurveyitem
WHERE surveymemberno = 1;

--수정(관리자)

--삭제(관리자)
DELETE FROM fsurveymember
WHERE surveymemberno = 1;

DELETE FROM fsurveymember
WHERE surveyitemno = 1;


SELECT COUNT(surveyitemno) as cnt
FROM fsurveyitem
WHERE surveyno = 1;

-------------------
--join(조인)
--survey 와 surveyitem 데이블 조인코드
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
  
  
  
  
  