package dev.mvc.login;

import java.util.ArrayList;

public interface LoginProcInter {

  /**
   * <xmp>
   * 회원로그인시 로그인내역 등록
   * <insert id="create" parameterType="LoginVO">
   * </xmp>
   * @param loginVO
   * @return 성공한 레코드 수 (1:성공)
   */
  public int create(LoginVO loginVO);
  
  /**
   * 전체 목록 출력
   * @return 목록 list
   */
  public ArrayList<Member_LoginVO> list();
  
  /**
   * 회원별 내역 list 조회
   * @param mno
   * @return
   */
  public ArrayList<LoginVO> list_memberno(int memberno);
  
  /**
   * 회원삭제시 회원별 로그인내역 삭제
   * @param loginno
   * @return 성공한 레코드 수 (1:성공)
   */
  public int delete(int memberno);
  
  /**
   * 해당 memberno에 대한 login테이블의 레코드 수
   * @param memberno
   * @return 조회한 로그인내역 레코드 수
   */
  public int count_memno(int memberno);
}
