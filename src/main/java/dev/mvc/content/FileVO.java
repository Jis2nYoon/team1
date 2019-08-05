package dev.mvc.content;

public class FileVO {
  /** preview 이미지 */
  private String thumb;
  /** 하나의 파일명 */
  private String file;
  /** 하나의 파일 사이즈 */
  private String size;

  public FileVO() {

  }

  public FileVO(String thumb, String file, String size) {
    super();
    this.thumb = thumb;
    this.file = file;
    this.size = size;
  }
  /**
   * setFile 되면서 thumb의 이름도 자동으로 저장된다.
   * @return the thumb
   */
  public void setThumb() {
    // 순수 파일명 추출, mt.jpg -> mt 만 추출
    String _dest = this.file.substring(0, this.file.indexOf("."));
    // 순수 확장자 추출, mt.jpg -> .jpg만 추출
    String _ends = this.file.substring(this.file.indexOf("."), this.file.length());
    this.thumb =_dest+"_t" +_ends;
  }
  /**
   * @return the thumb
   */
  public String getThumb() {
    return thumb;
  }

  /**
   * @return the file
   */
  public String getFile() {
    return file;
  }

  /**
   * setFile 되면서 thumb의 이름도 자동으로 저장된다.
   * @param file the file to set
   */
  public void setFile(String file) {
    this.file = file;
    this.setThumb();
  }

  /**
   * @return the size
   */
  public String getSize() {
    return size;
  }

  /**
   * @param size the size to set
   */
  public void setSize(String size) {
    this.size = size;
  }
  
}


