package dev.mvc.notice;

/*
noticeno        NUMBER(8)       NOT NULL     PRIMARY KEY,
memberno     NUMBER(10)      NOT NULL,
title              VARCHAR2(30)   NOT NULL,
content         VARCHAR(1000)  NOT NULL,
rdate            DATE                NOT NULL,
FOREIGN KEY (memberno) REFERENCES fmember (memberno)
*/
public class NoticeVO {
  private int noticeno;
  private int memberno;
  private String title;
  private String content;
  private String rdate;
  
  public int getNoticeno() {
    return noticeno;
  }
  public void setNoticeno(int noticeno) {
    this.noticeno = noticeno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
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
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
}
