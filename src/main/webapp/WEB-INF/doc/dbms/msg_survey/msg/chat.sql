DROP TABLE msg_samp;

/**********************************/
/* Table Name: 쪽지 */
/**********************************/
CREATE TABLE msg_samp(
		msgno                         		NUMBER(10)		 NOT NULL		 PRIMARY KEY, -- 메세지 번호
		msgsender                     		NUMBER(10)		 NOT NULL, -- 보내는 사람
		msgreceiver                   		NUMBER(20)		 NOT NULL, -- 받는 사람
		msgcontent                    		CLOB		 NOT NULL, -- 메세지 내용
		msgtime                       		DATE		 NOT NULL, -- 보낸 시간
		contentsno                    		NUMBER(10)		 NULL , -- 연결된 상품 번호
  FOREIGN KEY (msgsender) REFERENCES fmember (memberno),
  FOREIGN KEY (msgreceiver) REFERENCES fmember (memberno),
  FOREIGN KEY (contentsno) REFERENCES content (contentsno)
);

COMMENT ON TABLE msg_samp is '쪽지';
COMMENT ON COLUMN msg_samp.msgno is '쪽지 번호';
COMMENT ON COLUMN msg_samp.msgsender is '보내는 사람';
COMMENT ON COLUMN msg_samp.msgreceiver is '받는 사람';
COMMENT ON COLUMN msg_samp.msgcontent is '메세지 내용';
COMMENT ON COLUMN msg_samp.msgtime is '메세지 보낸 날짜';
COMMENT ON COLUMN msg_samp.contentsno is '컨텐츠 번호';


--생성--0
--양은진 -> 전다솜(contentsno =1)
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2번 회원이 1에게 보내는 메세지1', sysdate, 1); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1번 회원이 2에게 보내는 메세지1', sysdate, 1); 

INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2번 회원이 1에게 보내는 메세지2', sysdate, 1); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1번 회원이 2에게 보내는 메세지2', sysdate, 1); 

INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2번 회원이 1에게 보내는 메세지3', sysdate, 1); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1번 회원이 2에게 보내는 메세지3', sysdate, 1); 

--회원 3번이 보낸 메세지
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 3, 1, '3번 회원이 1에게 보내는 메세지1', sysdate, 1); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 3, '1번 회원이 3에게 보내는 메세지1', sysdate, 1); 

--회원 1번이 4번에게 보냈는데 읽씹된 메세지
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 4, '1번 회원이 4에게 보내는 메세지1', sysdate, 1); 

--상품 2번 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2번 회원이 1에게 보내는 메세지1', sysdate, 2); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1번 회원이 2에게 보내는 메세지1', sysdate, 2); 

INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2번 회원이 1에게 보내는 메세지2', sysdate, 2); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1번 회원이 2에게 보내는 메세지2', sysdate, 2); 

INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 2, 1, '2번 회원이 1에게 보내는 메세지3', sysdate, 2); 
INSERT INTO msg_samp(msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno)
VALUES((SELECT NVL(MAX(msgno), 0)+1 as msgno FROM msg_samp), 1, 2, '1번 회원이 2에게 보내는 메세지3', sysdate, 2); 

--목록

SELECT msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno
FROM msg_samp

-- 서로 주고 받은 목록을 부르려면 받는 사람 번호(user1)와 보내는사람 번호(user2) 두개가 있어야 하며
-- 각 상품에 대해  contentsno=1 AND 
-- (msgsender=2 OR msgsender=1) : msgsender가 user1이거나 msgsender가 user2인 경우를 모두 찾으면 된다.
SELECT msgno, msgsender, msgreceiver, msgcontent, msgtime, contentsno
FROM msg_samp
WHERE contentsno=1 AND (msgsender=상대방번호 OR msgsender=내번호)
ORDER BY msgtime ASC;  
-- 메세지 전송된 시간으로 목록 정렬

-- 판매자가 구매자 연락 목록을 봐야할거 아냐
SELECT distinct msgsender, contentsno, msgreceiver
FROM msg_samp
ORDER BY contentsno ASC;  





DELETE FROM msg_samp
WHERE msgno = 1;

