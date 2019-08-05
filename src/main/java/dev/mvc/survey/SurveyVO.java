package dev.mvc.survey;

/*
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
*/
public class SurveyVO {
  private int surveyno;
  private String title;
  private String content;
  private String startdate;
  private String enddate;
  private int cnt;
  
  public int getSurveyno() {
    return surveyno;
  }
  public void setSurveyno(int surveyno) {
    this.surveyno = surveyno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getStartdate() {
    return startdate;
  }
  public void setStartdate(String startdate) {
    this.startdate = startdate;
  }
  public String getEnddate() {
    return enddate;
  }
  public void setEnddate(String enddate) {
    this.enddate = enddate;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
}
