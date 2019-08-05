package dev.mvc.login;

public class Member_LoginVO {
  int memberno;
  String email="";
  String nickname="";
  int loginno;
  String ip="";
  String ldate="";
  
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  public String getEmail() {
    return email;
  }
  public void setEmail(String email) {
    this.email = email;
  }
  public String getNickname() {
    return nickname;
  }
  public void setNickname(String nickname) {
    this.nickname = nickname;
  }
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
}
