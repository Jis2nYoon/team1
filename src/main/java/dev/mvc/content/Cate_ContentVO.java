package dev.mvc.content;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Cate_ContentVO {
  /**  카테고리 이름 */
  private String catename;
  /** 카테고리 번호 */
  private int cateno;

  /*컨텐츠 번호*/
  private int contentsno;
  /*회원 번호*/
  private int memberno;
  /*글제목*/
  private String title;
  /*글내용*/
  private String contents;
  /*사진*/
  private String picture;
  /*사진크기*/
  private String picsize;
  /*등록날짜*/
  private String rdate;
  /*상품 이름*/
  private String pname;
  /*상품 가격*/
  private int price;
  /*판매여부 */
  private String saleA;
  /*조회수*/
  private int views;  
  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
  여러개의 파일 업로드
  */  
  private List<MultipartFile> filesMF;
 
  /** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
  private String sizesLabel;

  public String getCatename() {
    return catename;
  }

  public void setCatename(String catename) {
    this.catename = catename;
  }


  public int getContentsno() {
    return contentsno;
  }

  public void setContentsno(int contentsno) {
    this.contentsno = contentsno;
  }

  public int getCateno() {
    return cateno;
  }

  public void setCateno(int cateno) {
    this.cateno = cateno;
  }

  public int getMemberno() {
    return memberno;
  }

  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getContents() {
    return contents;
  }

  public void setContents(String contents) {
    this.contents = contents;
  }

  public String getPicture() {
    return picture;
  }

  public void setPicture(String picture) {
    this.picture = picture;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  public List<MultipartFile> getFilesMF() {
    return filesMF;
  }

  public void setFilesMF(List<MultipartFile> filesMF) {
    this.filesMF = filesMF;
  }

  public String getSizesLabel() {
    return sizesLabel;
  }

  public void setSizesLabel(String sizesLabel) {
    this.sizesLabel = sizesLabel;
  }

  public String getPicsize() {
    return picsize;
  }

  public void setPicsize(String picsize) {
    this.picsize = picsize;
  }
  public int getPrice() {
    return price;
  }

  public void setPrice(int price) {
    this.price = price;
  }

  public String getPname() {
    return pname;
  }

  public void setPname(String pname) {
    this.pname = pname;
  }

  public String getSaleA() {
    return saleA;
  }

  public void setSaleA(String saleA) {
    this.saleA = saleA;
  }

  public int getViews() {
    return views;
  }

  public void setViews(int views) {
    this.views = views;
  }

}

