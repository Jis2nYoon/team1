package dev.mvc.cate;

public class CateVO {
  /**  카테고리 이름 */
  private String catename;
  /** 카테고리 번호 */
  private int cateno;
  /** 출력 순서 */
  private int seqno;
  /** 컨텐츠개수 */
  private int contentscnt;
  
  public String getCatename() {
    return catename;
  }
  public void setCatename(String catename) {
    this.catename = catename;
  }
  public int getCateno() {
    return cateno;
  }
  public void setCateno(int cateno) {
    this.cateno = cateno;
  }
  public int getSeqno() {
    return seqno;
  }
  public void setSeqno(int seqno) {
    this.seqno = seqno;
  }
  public int getContentscnt() {
    return contentscnt;
  }
  public void setContentscnt(int contentscnt) {
    this.contentscnt = contentscnt;
  }
  
  

}

