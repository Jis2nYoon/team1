package dev.mvc.content;

public class Content {
  /** 페이지당 출력할 레코드 갯수 */
  public static int RECORD_PER_PAGE = 4;
  /** 블럭당 페이지 수, 하나의 블럭은 1개 이상의 페이지로 구성됨 */
  public static int PAGE_PER_BLOCK = 3;
  /** 파일이 존재하지 않음을 나타내는 상수 */
  public static final int file_not_exist = 9999; 
  //파일 업로드는 한꺼번에 9999개를 받지 않으므로 9999는 파일이 존재하지 않음을 나타내는 상수로 이용하도록 한다.
}
