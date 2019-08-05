package dev.mvc.content;

public class FileVO {
  /** preview �̹��� */
  private String thumb;
  /** �ϳ��� ���ϸ� */
  private String file;
  /** �ϳ��� ���� ������ */
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
   * setFile �Ǹ鼭 thumb�� �̸��� �ڵ����� ����ȴ�.
   * @return the thumb
   */
  public void setThumb() {
    // ���� ���ϸ� ����, mt.jpg -> mt �� ����
    String _dest = this.file.substring(0, this.file.indexOf("."));
    // ���� Ȯ���� ����, mt.jpg -> .jpg�� ����
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
   * setFile �Ǹ鼭 thumb�� �̸��� �ڵ����� ����ȴ�.
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


