package dev.mvc.survey;
/*  
 * SELECT s.surveyno, s.title, s.content, s.startdate, s.enddate, s.cnt,
             i.surveyitemno, i.surveyno, i.item, i.itemcnt
 */
public class Survey_ItemVO {
  private int surveyno;
  private String title;
  private String content;
  private String startdate;
  private String enddate;
  private int cnt;
  private int surveyitemno;
  private String item;
  private int itemcnt;
  
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
  public int getSurveyitemno() {
    return surveyitemno;
  }
  public void setSurveyitemno(int surveyitemno) {
    this.surveyitemno = surveyitemno;
  }
  public String getItem() {
    return item;
  }
  public void setItem(String item) {
    this.item = item;
  }
  public int getItemcnt() {
    return itemcnt;
  }
  public void setItemcnt(int itemcnt) {
    this.itemcnt = itemcnt;
  }
  
}
