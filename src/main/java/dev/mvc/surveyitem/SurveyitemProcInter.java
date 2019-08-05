package dev.mvc.surveyitem;

import java.util.ArrayList;

public interface SurveyitemProcInter {
  
  /**
   * 설문 항목 등록
   * <xmp>
   * <insert id="create" parameterType="SurveyitemVO">
   * </xmp>
   * @param SurveyitemVO
   * @return
   */
  public int create(SurveyitemVO surveyitemVO);
  
  /**
   * 설문 항목 목록
   * <xmp>
   * <select id="list" resultType="SurveyitemVO"  parameterType="int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public ArrayList<SurveyitemVO> list(int surveyno);
  
  /**
   * 조회
   */
  public SurveyitemVO read(int surveyitemno);
  
  /**
   * 설문 항목 수정
   * <xmp>
   * <update id="update" parameterType="SurveyitemVO">
   * </xmp>
   * @param surveyitemVO
   * @return
   */
  public int update(SurveyitemVO surveyitemVO);
  
  /**
   * 설문 항목 삭제
   * <xmp>
   * <delete id="delete_item" parameterType = "int">
   * </xmp>
   * @param surveyitemno
   * @return
   */
  public int delete_item(int surveyitemno);
  
  /**
   * 설문 항목 갯수 구하기
   * <xmp>
   * <select id="countByItem" parameterType = "int" resultType="int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public int countByItem(int surveyno);

}
