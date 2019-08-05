package dev.mvc.surveymember;
/*
CREATE TABLE fsurveymember(
surveymemberno                NUMBER(10) NOT NULL PRIMARY KEY,
surveyitemno                  NUMBER(10) NULL ,
memberno                         NUMBER(6) NULL ,
rdate                          DATE NOT NULL,
  FOREIGN KEY (surveyitemno) REFERENCES fsurveyitem (surveyitemno),
  FOREIGN KEY (memberno) REFERENCES fmember (memberno)
);
*/
public class SurveymemberVO {
  private int surveymemberno;
  private int surveyitemno;
  private int memberno;
  private String rdate;
  
  public int getSurveymemberno() {
    return surveymemberno;
  }
  public void setSurveymemberno(int surveymemberno) {
    this.surveymemberno = surveymemberno;
  }
  public int getSurveyitemno() {
    return surveyitemno;
  }
  public void setSurveyitemno(int surveyitemno) {
    this.surveyitemno = surveyitemno;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
}
