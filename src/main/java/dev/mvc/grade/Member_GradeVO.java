package dev.mvc.grade;

public class Member_GradeVO {
  int memberno;
  String email="";
  String nickname="";
  /*�򰡵�� ��ȣ*/
  private int gradeno;
  /*�Ű��� �� ��*/
  private int numgrade;
  /*��ü �������*/
  private double avggrade;
  /*�Ǹ����µ�*/
  private double manner;
  /*��ۼӵ�*/
  private double delivery;
  /*��ǰǰ��*/
  private double quality;
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
  public int getGradeno() {
    return gradeno;
  }
  public void setGradeno(int gradeno) {
    this.gradeno = gradeno;
  }
  public int getNumgrade() {
    return numgrade;
  }
  public void setNumgrade(int numgrade) {
    this.numgrade = numgrade;
  }
  public double getAvggrade() {
    return avggrade;
  }
  public void setAvggrade(double avggrade) {
    this.avggrade = avggrade;
  }
  public double getManner() {
    return manner;
  }
  public void setManner(double manner) {
    this.manner = manner;
  }
  public double getDelivery() {
    return delivery;
  }
  public void setDelivery(double delivery) {
    this.delivery = delivery;
  }
  public double getQuality() {
    return quality;
  }
  public void setQuality(double quality) {
    this.quality = quality;
  }
  
}
