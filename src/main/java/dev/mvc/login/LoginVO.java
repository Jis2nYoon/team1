package dev.mvc.login;

public class LoginVO {
  /*로그인내역 번호*/
  private int loginno;
  /*아이피 주소*/
  private String ip="";
  /*로그인 날짜*/
  private String ldate = "";
  /*회원 번호*/
  private int memberno;
  
  public int getLoginno() {
    return loginno;
  }
  public void setLoginno(int loginno) {
    this.loginno = loginno;
  }
  public String getIp() {
    return ip;
  }
  public void setIp(String ip) {
    this.ip = ip;
  }
  public String getLdate() {
    return ldate;
  }
  public void setLdate(String ldate) {
    this.ldate = ldate;
  }
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
}
