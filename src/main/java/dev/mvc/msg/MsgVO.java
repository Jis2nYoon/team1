package dev.mvc.msg;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MsgVO {
  
/*  CREATE TABLE msg(
    msgno                               NUMBER(10)     NOT NULL    PRIMARY KEY,
    msgsender                         NUMBER(20)     NOT NULL,
    msgreceiver                       NUMBER(20)     NOT NULL,
    msgtitle                            VARCHAR2(50)   NOT NULL,
    msgcontent                       CLOB               NOT NULL,
    msgtime                           DATE               NOT NULL,
    mcnt                                NUMBER(10)     DEFAULT 0     NOT NULL,
    contentsno                        NUMBER(10)     NOT NULL ,
  FOREIGN KEY (msgsender) REFERENCES fmember (memberno),
  FOREIGN KEY (msgreceiver) REFERENCES fmember (memberno),
  FOREIGN KEY (contentsno) REFERENCES content (contentsno)
);*/

  private int msgno;
  private int msgsender;
  private int msgreceiver;
  private String msgtitle;
  private String msgcontent;
  private String msgtime;
  private int mcnt;
  private int contentsno;
  
  /** Preview ���� �̹��� 200 X 150, �ڵ� ������ */
  private String thumbs = "";
  /** ���� �̹����߿� ù��° Preview �̹��� ����, 200 X 150 */
  private String thumb = "";
  /** ���ε� ���� */
  private String files = "";
  /** ���ε�� ���� ũ�� */
  private String sizes = "";
  
  /** 
  Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
  DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
  �������� ���� ���ε�
  */  
  private List<MultipartFile> filesMF;

  /** size1�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
  private String sizesLabel;
  
  
  /**
   * @return the thumbs
   */
  public String getThumbs() {
    return thumbs;
  }

  /**
   * @param thumbs the thumbs to set
   */
  public void setThumbs(String thumbs) {
    this.thumbs = thumbs;
  }

  /**
   * @return the files
   */
  public String getFiles() {
    if (this.files == null) {
      return "";
    } else{
      return files;
    }
  }

  /**
   * @param files the files to set
   */
  public void setFiles(String files) {
    this.files = files;
  }

  /**
   * @return the sizes
   */
  public String getSizes() {
    return sizes;
  }

  /**
   * @param sizes the sizes to set
   */
  public void setSizes(String sizes) {
    this.sizes = sizes;
  }
  
  /**
   * @return the sizesLabel
   */
  public String getSizesLabel() {
    return sizesLabel;
  }

  /**
   * @param sizesLabel the sizesLabel to set
   */
  public void setSizesLabel(String sizesLabel) {
    this.sizesLabel = sizesLabel;
  }

  /**
   * @return the filesMF
   */
  public List<MultipartFile> getFilesMF() {
    return filesMF;
  }

  /**
   * @param filesMF the filesMF to set
   */
  public void setFilesMF(List<MultipartFile> filesMF) {
    this.filesMF = filesMF;
  }
  
  /**
   * @return the thumb
   */
  public String getThumb() {
    return thumb;
  }

  /**
   * @param thumb the thumb to set
   */
  public void setThumb(String thumb) {
    this.thumb = thumb;
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
  public int getMcnt() {
    return mcnt;
  }
  public void setMcnt(int mcnt) {
    this.mcnt = mcnt;
  }
  public int getContentsno() {
    return contentsno;
  }
  public void setContentsno(int contentsno) {
    this.contentsno = contentsno;
  }

}
