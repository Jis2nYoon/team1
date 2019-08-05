DROP TABLE msg;
DROP TABLE msgroom;

/**********************************/
/* Table Name: 쪽지 */
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
-- 은진=>다솜
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               2, 1, '안녕하세요.', '직거래 가능할까요?', sysdate, 0, 1);

contentsno=2
-- 은진=>다솜
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               2, 1, '안녕하세요.', '직거래 가능할까요?', sysdate, 0, 2);
            
-- 유정=>다솜
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               3, 1, '안녕하세요.', '직거래 가능할까요?', sysdate, 0, 1);
               
-- 은진=>다솜
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               2, 1, '안녕하세요.', '직거래 가능할까요?', sysdate, 0, 1);
               
               
               
               
-- 다솜=>은진
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               1, 2, '안녕하세요.', '직거래 가능할까요?', sysdate, 0, 2);
               
-- 다솜=>유정
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
               1, 3, '안녕하세요.', '직거래 가능할까요?', sysdate, 0, 1);
               
보낸쪽지 목록
2개

받은 쪽지 목록
3개
               
select *
from msg;
               
               
             
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  2, 1, '직거래 가능할까요?', sysdate, 'spring.jpg', 0, 0, 1);

COMMENT ON TABLE msg is '쪽지';
COMMENT ON COLUMN msg.msgno is '쪽지 번호';
COMMENT ON COLUMN msg.msgsender is '보내는 사람';
COMMENT ON COLUMN msg.msgreceiver is '받는 사람';
COMMENT ON COLUMN msg.msgcontent is '메세지 내용';
COMMENT ON COLUMN msg.msgtime is '메세지 보낸 날짜';
COMMENT ON COLUMN msg.fname is '파일명';
COMMENT ON COLUMN msg.fsize is '파일 사이즈';
COMMENT ON COLUMN msg.mcnt is '조회여부';
COMMENT ON COLUMN msg.contentsno is '컨텐츠 번호';


--생성--0
--양은진 -> 전다솜(contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  2, 1, '직거래 가능할까요?', sysdate, 'spring.jpg', 0, 0, 1);
  
--김유정 ->전다솜(contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  3, 1, '직거래 가능할까요?', sysdate, 'spring.jpg', 0, 0, 1);
  
--김유정 ->전다솜 (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  3, 1, '직거래 가능할까요?', sysdate, 'spring.jpg', 0, 0, 2);
  
--전다솜 -> 양은진  (contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  1, 2, '네 가능합니다.', sysdate, 'spring.jpg', 0, 0, 1);
  
--전다솜 -> 김유정  (contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  1, 3, '네 가능합니다.', sysdate, 'spring.jpg', 0, 0, 1);
  
--전다솜 -> 김유정  (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
  1, 3, '네 가능합니다.', sysdate, 'spring.jpg', 0, 0, 2);  

===================================
--TEST
contents
2개

1번 양은진 -> 다솜
      다솜 -> 양은진
--양은진 -> 전다솜(contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
2, 1, '안녕하세요.', '직거래 가능할까요?', sysdate, 0, 1);
        
--전다솜 -> 양은진  (contentsno =1)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
1, 2, '안녕하세요.', '직거래 가능합니다', sysdate, 0, 1);
      
      

2번 양은진 -> 다솜
    김유정 -> 다솜
    
    다솜->은진
    다솜->유정
--양은진 ->전다솜 (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
2, 1, '안녕하세요.', '직거래 가능할까요?', sysdate, 0, 2);
    
--김유정 ->전다솜 (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
3, 1, '안녕하세요.', '직거래 가능할까요?', sysdate, 0, 2);
  
--전다솜 -> 양은진  (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
1, 2, '안녕하세요.', '직거래 가능합니다', sysdate, 0, 2);
  
--전다솜 -> 김유정  (contentsno =2)
INSERT INTO msg(msgno, msgsender, msgreceiver, msgtitle, msgcontent, msgtime, mcnt, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg),
1, 3, '안녕하세요.', '직거래 가능합니다', sysdate, 0, 2);

양은진
구매자일경우
보낸 메시지 = 1번 1개 2번 1개
받은 메시지 = 1번 1개 2번 1개

김유정 
구매자
보낸 메시지 = 2번 1개
받은 메시지 = 2번 1개

전다솜
판매자
보낸메시지 = 1번 1개 2번 2개
받은 메시지 = 1번 1개 2번 2개

  
====================================
--목록
1) 게시글 단위로 보이게
①판매자일 경우 : 예) 전다솜
SELECT contentsno, cateno, memberno, title, contents, rdate
FROM content
ORDER BY contentsno ASC;
추가 : 메시지가 온 경우의 게시글 리스트 가져오기 == 메시지카운트가 0보다 크면 리스트 가져오기
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
          1      1        1 이어폰 팝니다.  택배비 무료 가격 2만원 2019-05-27 10:31:23.0  NULL
          2      1        1 이어폰 팝니다2. 택배비 무료 가격 2만원 2019-05-27 10:31:27.0  NULL


         
②구매자일 경우 : 예)양은진, 김유정msgsender=3
SELECT contentsno, cateno, memberno, title, contents, rdate
FROM content
WHERE contentsno IN (SELECT contentsno FROM msg WHERE msgsender = 2)
ORDER BY contentsno;
CONTENTSNO CATENO MEMBERNO TITLE    CONTENTS      RDATE                 MSGNO
 ---------- ------ -------- -------- ------------- --------------------- -----
          1      1        1 이어폰 팝니다. 택배비 무료 가격 2만원 2019-05-27 10:31:23.0  NULL


2)그 게시글에서 메시지들 보이게 

1.다솜이경우==받은 메시지
SELECT msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno
FROM msg
WHERE msgreceiver=1 and contentsno=1
ORDER BY msgtime ASC;
MSGNO MSGSENDER MSGRECEIVER MSGCONTENT MSGTIME               FNAME      FSIZE MCNT CONTENTSNO
 ----- --------- ----------- ---------- --------------------- ---------- ----- ---- ----------
     1         2           1 직거래 가능할까요? 2019-05-27 10:34:53.0 spring.jpg     0    0          1
     2         3           1 직거래 가능할까요? 2019-05-27 10:34:54.0 spring.jpg     0    0          1

     
2.다솜이 경우 == 보낸 메시지
SELECT msgno, msgsender, msgreceiver, msgcontent, msgtime, fname, fsize, mcnt, contentsno
FROM msg
WHERE msgsender=1 and contentsno=1
ORDER BY msgtime ASC;
MSGNO MSGSENDER MSGRECEIVER MSGCONTENT MSGTIME               FNAME      FSIZE MCNT CONTENTSNO
 ----- --------- ----------- ---------- --------------------- ---------- ----- ---- ----------
     3         1           2 네 가능합니다.   2019-05-27 10:34:55.0 spring.jpg     0    0          1
     4         1           3 네 가능합니다.   2019-05-27 10:34:56.0 spring.jpg     0    0          1


--업뎃 : 조회 여부
MsgCont에서()?)
받는사람인지 체크하기!
msgreceiver-받는사람 번호 == 회원번호가 같으면?

UPDATE msg
SET mcnt = mcnt + 1
WHERE msgno = 1 AND msgreceiver = 나의 번호 ;

--mcnt 가 0보다 크면
String str = "";
mcnt == 0 
str = new;
mcnt != 0
str = 읽음;
     
--삭제

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
                          <when test="col == 'receivernickname'"> <!-- 이름 검색 -->
                            WHERE receivernickname LIKE '%' || #{receivernickname} || '%'  
                          </when>
                          <when test="col == 'msgtitle'"> <!-- 제목 검색 -->
                            WHERE msgtitle LIKE '%' || #{msgtitle} || '%'  
                          </when>
                          <when test="col == 'msgcontent'"> <!-- 내용 검색 -->
                            WHERE msgcontent LIKE '%' || #{msgcontent} || '%'  
                          </when>
                          <when test="col == 'msgtitlecontent'"> <!-- 제목+내용 검색 -->
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
 WHERE m.nickname LIKE '%' || 양은진 || '%'  
 
 
 
 
DELETE FROM msg
WHERE contentsno = 1;


==================
조인코드

--거래 게시글 테이블과 회원 테이블 조인!
SELECT m.memberno, m.mname, 
          c.memberno, c.contentsno, c.title
FROM fmember m, content c
WHERE (c.contentsno = 1) AND (c.memberno = m.memberno);

<!-- 내가 구매자인경우 목록 -->
<select id="list_buyer" resultType="ContentVO" parameterType="int">
  SELECT contentsno, cateno, memberno, title, contents, rdate
  FROM content
  WHERE contentsno IN (SELECT contentsno FROM msg WHERE msgsender = 2)
  ORDER BY contentsno DESC;
</select>

<!-- Join 목록 -->
<select id="read_by_join" resultType="Mem_ContentVO" parameterType="int">
   SELECT m.memberno, m.nickname, m.mname
             c.memberno, c.contentsno, c.title, c.contents, c.rdate
   FROM fmember m, content c, msg n
   WHERE (c.memberno = m.memberno) and
   (c.contentsno IN (SELECT n.contentsno FROM n WHERE n.msgsender = 2));
</select> 

구매자일 경우
SELECT m.memberno, m.nickname, m.mname,
          c.memberno, c.contentsno, c.title, c.contents, c.rdate
FROM fmember m, content c
WHERE (c.memberno = m.memberno) AND  (c.contentsno IN (SELECT contentsno FROM msg WHERE msgsender = 2)) and ;


화요일날 조인 만들것
======================================================
-- 내가 보낸 메시지 보기 msgsender=나의 회원번호 목록
--                          받는사람? = 닉네임?
SELECT m.nickname as receivernickname, m.mname as receivermname,
          g.msgno, g.msgsender, g.msgreceiver, g.msgtitle, g.msgcontent, g.msgtime, g.mcnt
FROM fmember m, msg g
WHERE (g.msgreceiver = m.memberno) and g.msgsender = #{memberno}; -- 회원 세션에서 번호 받아서 처리

-- 내가 받은 메시지 (전다솜)
SELECT m.nickname as receivernickname, m.mname as receivermname,
          g.msgno, g.msgsender, g.msgreceiver, g.msgtitle, g.msgcontent, g.msgtime, g.mcnt
FROM fmember m, msg g
WHERE (g.msgsender = m.memberno) and g.msgreceiver = #{memberno}; -- 회원 세션에서 번호 받아서 처리



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