package dev.mvc.grade;

import java.util.ArrayList;

import dev.mvc.grade.GradeVO;
import dev.mvc.grade.Member_GradeVO;

public interface GradeDAOInter {
  /**
   * <xmp>
   * 회원가입시 등급테이블 등록
   * <insert id="create" parameterType="GradeVO">
   * </xmp>
   * @param memberno
   * @return 성공한 레코드 수 (1:성공)
   */
  public int create(int memberno);
  
  /**
   * 전체 회원 등급 목록 출력 (관리자)
   * @return 목록 list
   */
  public ArrayList<Member_GradeVO> list();
  
  /**
   * 회원별 등급 read
   * @param mno
   * @return
   */
  public GradeVO read(int memberno);
  
  /**
   * 회원등급 1 항목 추가시 수정
   * @param gradeVO
   * @return 성공한 레코드 수 (1:성공)
   */
  public int update(GradeVO gradeVO);
  
  /**
   * 회원삭제시 회원별 회원등급 삭제
   * @param memberno
   * @return 성공한 레코드 수 (1:성공)
   */
  public int delete(int memberno);
  
  /**
   * 해당 memberno에 대한 grade테이블의 레코드 수
   * @param memberno
   * @return 조회한 회원등급 수
   */
  public int count_memno(int memberno);
  
  
  /**
   * 매너 점수만 평가
   * @param gradeVO
   * @return 성공한 레코드 수 (1:성공)
   */
  public int update_manner(int manner, int mno);
  
}
