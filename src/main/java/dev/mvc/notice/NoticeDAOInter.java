package dev.mvc.notice;

import java.util.ArrayList;
import java.util.HashMap;

public interface NoticeDAOInter {
  /**
   * <xmp>
   * �������� ���
   * <insert id="create" parameterType="NoticeVO">
   * </xmp>
   * @param noticeVO
   * @return ��ϵ� ���ڵ� ����
   */
  public int create(NoticeVO noticeVO);
  
  /**
   * <xmp>
   * ���
   * <select id="list" resultType="Mem_NoticeVO">
   * </xmp>
   * @return ArrayList<Mem_NoticeVO>
   */
  public ArrayList<Mem_NoticeVO> list();
  
  /**
   * <xmp>
   * ��ȸ
   * <select id="read" resultType="Mem_NoticeVO" parameterType="int">
   * </xmp>
   * @param noticeno
   * @return �� ���� ��
   */
  public Mem_NoticeVO read(int noticeno);
  
  /**
   * <xmp>
   * ����
   * <update id="update" parameterType="NoticeVO">
   * </xmp>
   * @param noticeVO
   * @return ������ ���ڵ� ����
   */
  public int update(NoticeVO noticeVO);
  
  /**
   * <xmp>
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param noticeno
   * @return ������ ���ڵ� ����
   */
  public int delete(int noticeno);
  
  /**
   * �˻� ���
   * <select id="list_by_search" resultType="NoticeVO" parameterType="HashMap">
   * @param cateno
   * @return
   */
  // public ArrayList<NoticeVO> list_by_search(HashMap map);
  
  /**
   * �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * <xmp>
   * �˻� + ����¡ ���
   * <select id="list_by_search_paging" resultType="Mem_NoticeVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<Mem_NoticeVO> list_by_search_paging(HashMap<String, Object> map);
}
