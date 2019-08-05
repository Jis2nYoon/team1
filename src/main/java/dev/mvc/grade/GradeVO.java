package dev.mvc.grade;

public class GradeVO {
  /*평가등급 번호*/
  private int gradeno;
  /*매겨진 평가 수*/
  private int numgrade;
  /*전체 평균평점*/
  private double avggrade;
  /*판매자태도*/
  private double manner;
  /*배송속도*/
  private double delivery;
  /*상품품질*/
  private double quality;
  /*회원 번호*/
  private int memberno;
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
  public int getMemberno() {
    return memberno;
  }
  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }
  
  

}

