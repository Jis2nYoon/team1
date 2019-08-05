package dev.mvc.member;

public class MemberVO {
  
  /** 회원 번호 */
  private int memberno;
  /** 이메일 계정 */
  private String email = "";
  /** 패스워드 */
  private String passwd = "";
  /** 프로필사진 썸네일 */
  private String thumbs = "";
  /** 프로필사진 원본 */
  private String photo = "";
  /** 프로필사진 크기 */
  private String sizes = "";
  /** 닉네임 */
  private String nickname = "";
  /** 이름 */
  private String mname = "";
  /** 전화 */
  private String tel = "";
  /** 우편번호 */
  private String zipcode = "";
  /** 주소 */
  private String address1 = "";
  /** 상세 주소 */
  private String address2 = "";
  /** 계정 상태 */
  private String act = "";
  /** 계정 정지일 */
  private String stopdate = "";
  /** 가입날짜 */
  private String mdate = "";
  
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
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public String getThumbs() {
    return thumbs;
  }
  public void setThumbs(String thumbs) {
    this.thumbs = thumbs;
  }
  public String getPhoto() {
    return photo;
  }
  public void setPhoto(String photo) {
    this.photo = photo;
  }
  public String getSizes() {
    return sizes;
  }
  public void setSizes(String sizes) {
    this.sizes = sizes;
  }
  public String getNickname() {
    return nickname;
  }
  public void setNickname(String nickname) {
    this.nickname = nickname;
  }
  public String getMname() {
    return mname;
  }
  public void setMname(String mname) {
    this.mname = mname;
  }
  public String getTel() {
    return tel;
  }
  public void setTel(String tel) {
    this.tel = tel;
  }
  public String getZipcode() {
    return zipcode;
  }
  public void setZipcode(String zipcode) {
    this.zipcode = zipcode;
  }
  public String getAddress1() {
    return address1;
  }
  public void setAddress1(String address1) {
    this.address1 = address1;
  }
  public String getAddress2() {
    return address2;
  }
  public void setAddress2(String address2) {
    this.address2 = address2;
  }
  public String getAct() {
    return act;
  }
  public void setAct(String act) {
    this.act = act;
  }
  public String getStopdate() {
    return stopdate;
  }
  public void setStopdate(String stopdate) {
    this.stopdate = stopdate;
  }
  public String getMdate() {
    return mdate;
  }
  public void setMdate(String mdate) {
    this.mdate = mdate;
  }
  
 
}