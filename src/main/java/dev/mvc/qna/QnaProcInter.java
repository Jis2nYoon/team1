package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;

public interface QnaProcInter {
  /**
   * <xmp>
   * �������� ���
   * <insert id="create" parameterType="QnaVO">
   * </xmp>
   * @param qnaVO
   * @return ��ϵ� ���ڵ� ����
   */
  public int create(QnaVO qnaVO);
  
  /**
   * <xmp>
   * ���
   * <select id="list" resultType="Mem_QnaVO">
   * </xmp>
   * @return ArrayList<Mem_QnaVO>
   */
  public ArrayList<Mem_QnaVO> list();
  
  /**
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param contentsVO
   * @return
   */
  public ArrayList<QnaFileVO> getThumbs(Mem_QnaVO mem_QnaVO);

  /**
   * <xmp>
   * ��ȸ
   * <select id="read" resultType="Mem_QnaVO" parameterType="int">
   * </xmp>
   * @param qnano
   * @return �� ���� ��
   */
  public Mem_QnaVO read(int qnano);
  
  /**
   * <xmp>
   * ����
   * <update id="update" parameterType="QnaVO">
   * </xmp>
   * @param qnaVO
   * @return
   */
  public int update(QnaVO qnaVO);
  
  /**
   * <xmp>
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param qnano
   * @return
   */
  public int delete(int qnano);
  
  /**
   * <xmp>
   * �亯 ���� ����
   * <update id="increaseAnsnum" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public int increaseAnsnum(HashMap<String, Object> map);
  
  /**
   * <xmp>
   * �亯
   * <insert id="reply" parameterType="QnaVO">
   * </xmp>
   * @param qnaVO
   * @return
   */
  public int reply(QnaVO qnaVO);
  
}
