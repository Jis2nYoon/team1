package dev.mvc.qna;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

/*  
qnano           NUMBER(10)      NOT NULL     PRIMARY KEY,
memberno     NUMBER(10)      NOT NULL,
title              VARCHAR2(200)  NOT NULL,
content         CLOB                NOT NULL,
files               CLOB                NULL ,
filesizes          CLOB                NULL ,
grpno          NUMBER(10)                           NOT NULL,
indent          NUMBER(10)      DEFAULT 0      NOT NULL,
rdate            DATE                NOT NULL,
*/
public class QnaVO {
  private int qnano;
  private int memberno;
  private String title;
  private String content;
  private String files;
  private String filesizes;
  private int grpno;
  private int indent;
  private int ansnum;
  private String rdate;
  
  private String thumbs;
  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
  여러개의 파일 업로드
  */  
  private List<MultipartFile> filesMF;

  public String getThumbs() {
    return thumbs;
  }
  public void setThumbs(String thumbs) {
    this.thumbs = thumbs;
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
  /** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
  private String sizesLabel;
  
  public int getQnano() {
    return qnano;
  }
  public void setQnano(int qnano) {
    this.qnano = qnano;
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
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getFiles() {
    return files;
  }
  public void setFiles(String files) {
    this.files = files;
  }
  public String getFilesizes() {
    return filesizes;
  }
  public void setFilesizes(String filesizes) {
    this.filesizes = filesizes;
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
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
}
