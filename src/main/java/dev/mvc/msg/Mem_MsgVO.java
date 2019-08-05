package dev.mvc.msg;

public class Mem_MsgVO {
  // member table
  // m.memberno, m.nickname, m.mname
  private int memberno;
  private String receivernickname;
  private String receivermname;
  
  // msg table
  // g.msgno, g.msgsender, g.msgreceiver, g.msgtitle, g.msgcontent, g.msgtime
  private int msgno;
  private int msgsender;
  private int msgreceiver;
  private String msgtitle;
  private String msgcontent;
  private String msgtime;
  private int mcnt;
  
  
  public int getMcnt() {
    return mcnt;
  }
  public void setMcnt(int mcnt) {
    this.mcnt = mcnt;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getReceivernickname() {
    return receivernickname;
  }
  public void setReceivernickname(String receivernickname) {
    this.receivernickname = receivernickname;
  }
  public String getReceivermname() {
    return receivermname;
  }
  public void setReceivermname(String receivermname) {
    this.receivermname = receivermname;
  }
  public int getMsgno() {
    return msgno;
  }
  public void setMsgno(int msgno) {
    this.msgno = msgno;
  }
  public int getMsgsender() {
    return msgsender;
  }
  public void setMsgsender(int msgsender) {
    this.msgsender = msgsender;
  }
  public int getMsgreceiver() {
    return msgreceiver;
  }
  public void setMsgreceiver(int msgreceiver) {
    this.msgreceiver = msgreceiver;
  }
  public String getMsgtitle() {
    return msgtitle;
  }
  public void setMsgtitle(String msgtitle) {
    this.msgtitle = msgtitle;
  }
  public String getMsgcontent() {
    return msgcontent;
  }
  public void setMsgcontent(String msgcontent) {
    this.msgcontent = msgcontent;
  }
  public String getMsgtime() {
    return msgtime;
  }
  public void setMsgtime(String msgtime) {
    this.msgtime = msgtime;
  }
}

