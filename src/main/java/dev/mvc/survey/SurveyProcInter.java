package dev.mvc.survey;

import java.util.ArrayList;

public interface SurveyProcInter {
  /**
   *  �������� ���� ���
   * <xmp>
   * <insert id="create" parameterType="SurveyVO">
   * </xmp>
   * @param SurveyVO
   * @return
   */
  public int create(SurveyVO surveyVO);
  
  /**
   *  �������� ���� ���(�����) - �˻� x
   * <xmp>
   * <select id="list_user" resultType="SurveyVO" >
   * </xmp>
   * @param SurveyVO
   * @return
   */
  public ArrayList<SurveyVO> list_user();

  /**
   *  �������� ���� ���(������) - �˻� x
   * <xmp>
   * <select id="list_admin" resultType="SurveyVO" >
   * </xmp>
   * @param SurveyVO
   * @return
   */
  public ArrayList<SurveyVO> list_admin();
  
  /**
   *  �������� �ϱ� (�����) join���Ŀ� �߰�
   * <xmp>
   * <select id="read" resultType="Survey_ItemVO" parameterType="int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public Survey_ItemVO read_join(int surveyno);
  
  /**
   *  �������� ���� 1�� ��ȸ
   * <xmp>
   * <select id="read" resultType="SurveyVO" parameterType="int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public SurveyVO read(int surveyno);
  
  /**
   *  �������� ���� ����(��ȸ�� ���� �� - ������)
   * <xmp>
   * <update id="update" parameterType="SurveyVO">
   * </xmp>
   * @param SurveyVO
   * @return
   */
  public int update(SurveyVO surveyVO);
  
  /**
   *  �������� ���� ����(������)
   * <xmp>
   * <delete id="delete" parameterType = "int">
   * </xmp>
   * @param surveyno
   * @return
   */
  public int delete(int surveyno);
}
