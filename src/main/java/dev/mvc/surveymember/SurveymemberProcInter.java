package dev.mvc.surveymember;

public interface SurveymemberProcInter {

  /**
   * 등록 (설문조사 제출하기)
   * @param surveymemberVO
   * @return
   */
  public int create(SurveymemberVO surveymemberVO);
}
