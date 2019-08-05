/** ���̺� ���� **/
DROP TABLE ffaq;

/****************************/
/*    ����ã������ ���̺�    */
/****************************/
CREATE TABLE ffaq(
  faqno           NUMBER(10)       NOT NULL     PRIMARY KEY,
  question       CLOB   NOT NULL,
  answer         CLOB  NOT NULL,
  memberno     NUMBER(10)      NOT NULL,
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);

COMMENT ON TABLE ffaq is '����ã������';
COMMENT ON COLUMN ffaq.faqno is '���� ��ȣ';
COMMENT ON COLUMN ffaq.question is '����';
COMMENT ON COLUMN ffaq.answer is '�亯';
COMMENT ON COLUMN ffaq.memberno is 'ȸ�� ��ȣ';

-- ���
INSERT INTO ffaq(faqno, question, answer, memberno)
VALUES((SELECT NVL(MAX(faqno), 0)+1 as faqno FROM ffaq), 
'FAQ�� ������?', '���� ã�� ������ ���մϴ�.', 1);

INSERT INTO ffaq(faqno, question, answer, memberno)
VALUES((SELECT NVL(MAX(faqno), 0)+1 as faqno FROM ffaq), 
'FAQ�� ���� �ø�����?', '�����ڰ� �ۼ��ؼ� �ø��ϴ�.', 1);

-- ���
SELECT faqno, question, answer, memberno
FROM ffaq
ORDER BY faqno DESC;

-- ��ȸ
SELECT faqno, question, answer, memberno
FROM ffaq
WHERE faqno = 1;

-- ����
UPDATE ffaq
SET question='FAQ��?', answer='���� ã�� ������(frequently asked questions)'
WHERE faqno = 1;
        
-- ����
DELETE FROM ffaq
WHERE faqno = 1;


