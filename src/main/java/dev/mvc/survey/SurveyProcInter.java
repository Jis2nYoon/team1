package dev.mvc.survey;

import java.util.ArrayList;

public interface SurveyProcInter {
  /**
   *  설문조사 질문 등록
   * <xmp>
   * <insert id="create" parameterType="SurveyVO">
   * </xmp>
   * @param SurveyVO
   * @return
   */
  public int create(SurveyVO surveyVO);
  
  /**
   *  설문조사 질문 목록(사용자) - 검색 x
   * <xmp>
   * <select id="list_user" resultType="SurveyVO" >
   * </xmp>
   * @param SurveyVO
   * @return
   */
  public ArrayList<SurveyVO> list_user();

  /**
   *  설문조사 질문 목록(관리자) - 검색 x
   * <xmp>
   * <select id="list_admin" resultType="SurveyVO" >
   * </xmp>
   * @param SurveyVO
   * @return
   */
  public ArrayList<SurveyVO> list_admin();
  
  /**
   *  설문조사 하기 (사용자) join추후에 추가
   * <xmp>
   * <select id="read" resultType="Survey_ItemVO" parameterType="int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public Survey_ItemVO read_join(int surveyno);
  
  /**
   *  설문조사 질문 1건 조회
   * <xmp>
   * <select id="read" resultType="SurveyVO" parameterType="int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public SurveyVO read(int surveyno);
  
  /**
   *  설문조사 질문 수정(조회도 같이 됨 - 관리자)
   * <xmp>
   * <update id="update" parameterType="SurveyVO">
   * </xmp>
   * @param SurveyVO
   * @return
   */
  public int update(SurveyVO surveyVO);
  
  /**
   *  설문조사 질문 삭제(관리자)
   * <xmp>
   * <delete id="delete" parameterType = "int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public int delete(int surveyno);
}
