DROP TABLE reply CASCADE CONSTRAINTS;

1) DDL
/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE reply(
    replyno                           NUMBER(8)    NOT NULL, --댓글이 추가 삭제되면서 계속 붙을 식별키값
    replycont                         VARCHAR2(512)    NOT NULL, --댓글 내용
    contentsno                        NUMBER(10)     NOT NULL, -- 어느 글의 댓글인지 식별할 글 번호
    memberno                          NUMBER(10)     NOT NULL, -- 댓글 입력자 식별할 멤버 번호
    rdate                             DATE     NOT NULL, -- 댓글 입력 시간
    grpno                             NUMBER(8)    DEFAULT 0     NOT NULL, -- 댓글의 순서
    indent                            NUMBER(8)    DEFAULT 0     NOT NULL, --댓글의 대댓글 표현할때 indent 이용. 0~1만 표현하도록함.
    ansnum                            NUMBER(8)    DEFAULT 0     NOT NULL --대댓글의 순서
);

COMMENT ON TABLE reply is '댓글';
COMMENT ON COLUMN reply.replyno is '댓글 번호';
COMMENT ON COLUMN reply.replycont is '댓글 내용';
COMMENT ON COLUMN reply.contentsno is '컨텐츠 번호';
COMMENT ON COLUMN reply.memberno is '회원 번호';
COMMENT ON COLUMN reply.rdate is '댓글등록날짜';
COMMENT ON COLUMN reply.grpno is '댓글순서';
COMMENT ON COLUMN reply.indent is '들여쓰기';
COMMENT ON COLUMN reply.ansnum is '대댓글순서';


ALTER TABLE reply ADD CONSTRAINT IDX_reply_PK PRIMARY KEY (replyno);
ALTER TABLE reply ADD CONSTRAINT IDX_reply_FK0 FOREIGN KEY (contentsno) REFERENCES content (contentsno);
ALTER TABLE reply ADD CONSTRAINT IDX_reply_FK1 FOREIGN KEY (memberno) REFERENCES fmember (memberno);

2) SEQUENCE 

-- SEQUENCE 객체 생성
DROP SEQUENCE reply_seq;

CREATE SEQUENCE reply_seq
START WITH   1            --시작번호
INCREMENT BY 1          --증가값
MAXVALUE   99999999  --최대값, NUMBER(7) 대응
CACHE        2               --시쿼스 변경시 자주 update되는 것을 방지하기위한 캐시값
NOCYCLE;    


3) 등록, C(create) & 답변처리

-- NULL 값으로 인해 숫자 계산이 안되는 것을 방지
-- Oracle
SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply;
 GRPNO
 ---------
     1

-- 1) 등록

INSERT INTO reply(replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum)
VALUES(reply_seq.nextval, '댓글 내용', 1, 1, sysdate, (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply), 0, 0);

INSERT INTO reply(replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum)
VALUES(reply_seq.nextval, '실험용 댓글', 17, 1, sysdate, (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply), 0, 0);

INSERT INTO reply(replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum)
VALUES(reply_seq.nextval, 'indent실험용 댓글', 17, 1, sysdate, (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply), 1, 0);
--2) 답변 등록에 따른 답변 순서의 증가 처리
--UPDATE reply
--SET ansnum = ansnum + 1
--WHERE grpno = 1 AND ansnum > 부모 ansnum 컬럼의 값;
UPDATE reply
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;

--3) 부모의 index 컬럼의 값 + 1: 들여쓰기 효과 출력

--4) 답변 등록
INSERT INTO reply(replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum)
VALUES(reply_seq.nextval, '대댓글', 17, 1, sysdate, (SELECT NVL(MAX(grpno), 0) + 1 as grpno FROM reply), 0, 0);
UPDATE reply
SET ansnum = ansnum + 1
WHERE grpno = 1;
--이렇게 되야함. 홈페이지에서 체크박스를 체크한상태로 댓글을 단다면 Update부분까지 완료를 해주는 것임.
--수업에서는 sql로 안하고 java파일에서 답글달려는 글에서 컬럼값 가져와서 update를 통해 수정했다. sql로 짜려면 복잡할듯

 REPLYNO REPLYCONT CONTENTSNO MEMBERNO RDATE                 GRPNO INDENT ANSNUM
 ------- --------- ---------- -------- --------------------- ----- ------ ------
       1 댓글 내용 수정           1        1 2019-05-14 15:16:57.0     1      0      1
       2 대댓글                1        1 2019-05-14 15:53:48.0     2      0      0

--5) 목록의 정렬 변경
SELECT replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum
FROM reply
ORDER BY grpno DESC, ansnum ASC;
       
-- 답변이 아닌 경우의 정렬
   ORDER BY replyno DESC
   
-- 답변인 경우의 정렬
   ORDER BY grpno DESC, ansnum ASC

4) 전체 목록, R(Read) 사용할 일 없다.
SELECT replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum
FROM reply
ORDER BY replyno ASC;

 REPLYNO REPLYCONT CONTENTSNO MEMBERNO RDATE                 GRPNO INDENT ANSNUM
 ------- --------- ---------- -------- --------------------- ----- ------ ------
       1 댓글 내용              1        1 2019-05-14 15:16:57.0     1      0      0

5) 조회, R(Read)
SELECT replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum
FROM reply
WHERE contentsno = 1;

 REPLYNO REPLYCONT CONTENTSNO MEMBERNO RDATE                 GRPNO INDENT ANSNUM
 ------- --------- ---------- -------- --------------------- ----- ------ ------
       1 댓글 내용              1        1 2019-05-14 15:16:57.0     1      0      0


6) 수정, U(Update)

    UPDATE reply
    SET replycont='수정', rdate= sysdate, indent=1, ansnum=1
    WHERE replyno = 35;
    

UPDATE reply
SET replycont='댓글 내용 수정', rdate= sysdate
WHERE replyno = 35;
 
SELECT replyno, replycont, contentsno, memberno, rdate, grpno, indent, ansnum
FROM reply
ORDER BY replyno ASC;

 REPLYNO REPLYCONT CONTENTSNO MEMBERNO RDATE                 GRPNO INDENT ANSNUM
 ------- --------- ---------- -------- --------------------- ----- ------ ------
       1 댓글 내용 수정           1        1 2019-05-14 15:16:57.0     1      0      0

7) 삭제, D(Delete)
DELETE FROM reply
WHERE replyno = 3;
 

-----------------------------------------------------------------------------------

// ------------------------- 답변 관련 코드 시작 -------------------------
    // 부모의 pds4no 산출
    int pds4no = pds4VO.getPds4no();
    // 부모글(답변을 붙일글) 관련 정보 조회
    Pds4VO parent_pds4VO = pds4DAO.read(pds4no);
    
    // 답변임으로 부모의 grpno를 가져와 등록될 VO 객체에 저장
    pds4VO.setGrpno(parent_pds4VO.getGrpno());
 
    // 답변임으로 부모보다 들여쓰기를 1 증가 시킴
    pds4VO.setIndent(parent_pds4VO.getIndent() + 1);
    
    // 답변 순서를 1증가시킴으로 부모 바로 하단에 위치 시키도록 함.
    pds4VO.setAnsnum(parent_pds4VO.getAnsnum() + 1);
    
    //이부분 그냥 그대로 하고 sql에서 출력 순서를 뒤집으면됨.ㅇㅇ
    // 기존에 등록된 댓글들의 ansnum을 1 증가
    pds4DAO.increaseAnsnum(parent_pds4VO.getGrpno(), parent_pds4VO.getAnsnum());
    // ------------------------- 답변 관련 코드 종료 -------------------------
    
    
  <!-- increaseAnsnum 기존에 등록된 댓글들의 ansnum을 1씩 증가 -->
  <update id='update_ans' parameterType="HashMap">
    UPDATE reply
    SET ansnum=ansnum + 1
    WHERE grpno = #{grpno} AND ansnum = #{ansnum}
  </update>
  
  
  
  