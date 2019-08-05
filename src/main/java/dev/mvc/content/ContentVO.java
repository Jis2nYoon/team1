package dev.mvc.content;
 
import java.util.List;
 
import org.springframework.web.multipart.MultipartFile;
 
public class ContentVO {
  /*������ ��ȣ*/
  private int contentsno;
  /*ī�װ� ��ȣ*/
  private int cateno;
  /*ȸ�� ��ȣ*/
  private int memberno;
  /*������*/
  private String title;
  /*�۳���*/
  private String contents;
  /*����*/
  private String picture;
  /*����ũ��*/
  private String picsize;
  /*��ϳ�¥*/
  private String rdate;  
  /*��ȸ��*/
  private int views;  
  /*�Ǹſ��� */
  private String saleA;
  /*��ǰ �̸�*/
  private String pname;
  /*��ǰ ����*/
  private int price;

  /** 
  Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
  DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
  �������� ���� ���ε�
  */  
  private List<MultipartFile> filesMF;
 
  /** size1�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
  private String sizesLabel;

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

  public String getPicture() {
    return picture;
  }

  public void setPicture(String picture) {
    this.picture = picture;
  }

  public String getPicsize() {
    return picsize;
  }

  public void setPicsize(String picsize) {
    this.picsize = picsize;
  }
  public int getViews() {
    return views;
  }

  public void setViews(int views) {
    this.views = views;
  }

  public String getSaleA() {
    return saleA;
  }

  public void setSaleA(String saleA) {
    this.saleA = saleA;
  }

  public String getPname() {
    return pname;
  }

  public void setPname(String pname) {
    this.pname = pname;
  }

  public int getPrice() {
    return price;
  }

  public void setPrice(int price) {
    this.price = price;
  }

}