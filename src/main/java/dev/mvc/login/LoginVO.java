package dev.mvc.login;

public class LoginVO {
  /*�α��γ��� ��ȣ*/
  private int loginno;
  /*������ �ּ�*/
  private String ip="";
  /*�α��� ��¥*/
  private String ldate = "";
  /*ȸ�� ��ȣ*/
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
