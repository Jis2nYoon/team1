package dev.mvc.surveyitem;

/*
CREATE TABLE fsurveyitem(
surveyitemno                  NUMBER(10) NOT NULL PRIMARY KEY,
surveyno                      NUMBER(10) NULL ,
item                          VARCHAR2(200) NOT NULL,
itemfile                      VARCHAR2(1000) NULL ,
itemfsize                    VARCHAR2(1000) NULL ,
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
 */

public class SurveyitemVO {
  private int surveyitemno;
  private int surveyno;
  private String item;
  private String itemfile;
  private String itemfsize;
  private int itemcnt;
  
  public int getSurveyitemno() {
    return surveyitemno;
  }
  public void setSurveyitemno(int surveyitemno) {
    this.surveyitemno = surveyitemno;
  }
  public int getSurveyno() {
    return surveyno;
  }
  public void setSurveyno(int surveyno) {
    this.surveyno = surveyno;
  }
  public String getItem() {
    return item;
  }
  public void setItem(String item) {
    this.item = item;
  }
  public String getItemfile() {
    return itemfile;
  }
  public void setItemfile(String itemfile) {
    this.itemfile = itemfile;
  }
  public String getItemfsize() {
    return itemfsize;
  }
  public void setItemfsize(String itemfsize) {
    this.itemfsize = itemfsize;
  }
  public int getItemcnt() {
    return itemcnt;
  }
  public void setItemcnt(int itemcnt) {
    this.itemcnt = itemcnt;
  }
}
