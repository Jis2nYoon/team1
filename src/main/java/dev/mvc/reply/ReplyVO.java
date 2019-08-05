package dev.mvc.reply;

public class ReplyVO {
  private int replyno; //댓글이 추가 삭제되면서 계속 붙을 식별키값
  private String replycont; //어느 글의 댓글인지 식별할 글 번호
  private int contentsno; //댓글 입력자 식별할 멤버 번호
  private int memberno; //댓글 내용
  private String rdate; //댓글 입력 시간
  private int grpno; //댓글의 순서
  private int indent; //댓글의 대댓글 표현할때 indent 이용. 0~1만 표현하도록함.
  private int ansnum; //대댓글의 순서
  public int getReplyno() {
    return replyno;
  }
  public void setReplyno(int replyno) {
    this.replyno = replyno;
  }
  public String getReplycont() {
    return replycont;
  }
  public void setReplycont(String replycont) {
    this.replycont = replycont;
  }
  public int getContentsno() {
    return contentsno;
  }
  public void setContentsno(int contentsno) {
    this.contentsno = contentsno;
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
  public int getGrpno() {
    return grpno;
  }
  public void setGrpno(int grpno) {
    this.grpno = grpno;
  }
  public int getIndent() {
    return indent;
  }
  public void setIndent(int indent) {
    this.indent = indent;
  }
  public int getAnsnum() {
    return ansnum;
  }
  public void setAnsnum(int ansnum) {
    this.ansnum = ansnum;
  }

  
}

