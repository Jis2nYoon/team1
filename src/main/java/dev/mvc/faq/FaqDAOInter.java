package dev.mvc.faq;

import java.util.ArrayList;

public interface FaqDAOInter {
  /**
   * <xmp>
   * �������� ���
   * <insert id="create" parameterType="FaqVO">
   * </xmp>
   * @param faqVO
   * @return ��ϵ� ���ڵ� ����
   */
  public int create(FaqVO faqVO);
  
  /**
   * <xmp>
   * ���
   * <select id="list" resultType="FaqVO">
   * </xmp>
   * @return ArrayList<FaqVO>
   */
  public ArrayList<FaqVO> list();
  
  /**
   * <xmp>
   * ��ȸ
   * <select id="read" resultType="FaqVO" parameterType="int">
   * </xmp>
   * @param faqno
   * @return �� ���� ��
   */
  public FaqVO read(int faqno);
  
  /**
   * <xmp>
   * ����
   * <update id="update" parameterType="FaqVO">
   * </xmp>
   * @param faqVO
   * @return
   */
  public int update(FaqVO faqVO);
  
  /**
   * ���� ó��
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param faqno
   * @return ó���� ���ڵ� ����
   */
  public int delete(int faqno);
  
}
