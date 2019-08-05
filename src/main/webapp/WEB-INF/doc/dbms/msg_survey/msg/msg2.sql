DROP TABLE msg;
DROP TABLE msgroom;

/**********************************/
/* Table Name: 쪽지 */
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



--목록
1) 게시글 단위로 보이게
①판매자일 경우 : 예) 전다솜
SELECT contentsno, memberno
FROM content
ORDER BY contentsno ASC;
추가 : 메시지가 온 경우의 게시글 리스트 가져오기 == 메시지카운트가 0보다 크면 리스트 가져오기
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
          1      1        1 이어폰 팝니다.  택배비 무료 가격 2만원 2019-05-27 10:31:23.0  NULL
          2      1        1 이어폰 팝니다2. 택배비 무료 가격 2만원 2019-05-27 10:31:27.0  NULL


         
②구매자일 경우 : 예)양은진
select * 
from content
where contentsno IN (select contentsno from msg where msgsender = 2)
order by contentsno;
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
WHERE msgno = 1;

--mcnt 가 0보다 크면
String str = "";
mcnt == 0 
str = new;
mcnt != 0
str = 읽음;
     
--삭제

DELETE FROM msg
WHERE msgno = 1;

