package dev.mvc.surveyitem;

import java.util.ArrayList;

public interface SurveyitemProcInter {
  
  /**
   * ���� �׸� ���
   * <xmp>
   * <insert id="create" parameterType="SurveyitemVO">
   * </xmp>
   * @param SurveyitemVO
   * @return
   */
  public int create(SurveyitemVO surveyitemVO);
  
  /**
   * ���� �׸� ���
   * <xmp>
   * <select id="list" resultType="SurveyitemVO"  parameterType="int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public ArrayList<SurveyitemVO> list(int surveyno);
  
  /**
   * ��ȸ
   */
  public SurveyitemVO read(int surveyitemno);
  
  /**
   * ���� �׸� ����
   * <xmp>
   * <update id="update" parameterType="SurveyitemVO">
   * </xmp>
   * @param surveyitemVO
   * @return
   */
  public int update(SurveyitemVO surveyitemVO);
  
  /**
   * ���� �׸� ����
   * <xmp>
   * <delete id="delete_item" parameterType = "int">
   * </xmp>
   * @param surveyitemno
   * @return
   */
  public int delete_item(int surveyitemno);
  
  /**
   * ���� �׸� ���� ���ϱ�
   * <xmp>
   * <select id="countByItem" parameterType = "int" resultType="int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public int countByItem(int surveyno);

}
