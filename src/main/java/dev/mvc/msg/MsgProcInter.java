package dev.mvc.msg;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.content.FileVO;
import dev.mvc.content.ContentVO;

public interface MsgProcInter {
  
  /**
   * ���� ������ (���/����)
   * <xmp>
   * <insert id="create" parameterType="MsgVO">
   * </xmp>
   * @param MsgVO
   * @return
   */
  public int create(MsgVO msgVO);
  
  /**
   * �Ǹ����ΰ�� ��� (join)
   * <xmp>
   * <select id="list_seller" resultType="ContentVO"  parameterType="int">
   * </xmp>
   * @param msgreceiver
   * @return
   */
  public ArrayList<ContentVO> list_seller(int msgreceiver);
  
  /**
   * �������ΰ�� ��� (join)
   * <xmp>
   * <select id="list_buyer" resultType="Mem_ContentVO" parameterType="int">
   * </xmp>
   * @param memberno
   * @return
   */
  public ArrayList<Mem_ContentVO> list_buyer(int memberno);
  
  /**
   * Join 1�� ��ȸ
   * <xmp>
   * <select id="read_by_join" resultType="Mem_ContentVO" parameterType="int">
   * </xmp>
   * @param contentsno
   * @return
   */
  public Mem_ContentVO read_by_join(int contentsno);
  
  /**
   *  ���� ���� ���
   * <xmp>
   * <select id="list_send" resultType="Mem_MsgVO" parameterType="HashMap">
   * </xmp>
   * @param memberno
   * @return
   */
  public ArrayList<Mem_MsgVO> list_send(HashMap<String, Object> map);
  
  /**
   *  ���� ���� ���
   * <xmp>
   * <select id="list_receive" resultType="Mem_MsgVO" parameterType="HashMap">
   * </xmp>
   * @param memberno
   * @return
   */
  public ArrayList<Mem_MsgVO> list_receive(HashMap<String, Object> map);

  /**
   * ���� 1�� �б�
   * <xmp>
   * <select id="read_msg" resultType="MsgVO" parameterType="int">
   * </xmp>
   * @param msgno
   * @return
   */
  public MsgVO read_msg(int msgno);
  
  /**
   * ���� ������ Ȯ��
   * <xmp>
   * <update id="check_msg" parameterType="HashMap">
   * </xmp>
   */
  public int check_msg(HashMap<String, Object> map);
  
  /**
   * ���� �����ϱ�
   * <xmp>
   * <delete id = "delete_msg" parameterType = "int">
   * </xmp>
   */
  public int delete_msg(int msgno);
  
  /**
   * ���� ���� �˻��� ���ڵ� ����
   * <xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </xmp>
   * @return
   */
  public int search_count(HashMap<String, Object> map);
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   * @param listFile ��� ���ϸ�
   * @param cateno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage ���� ������, nowPage�� 1���� ����
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  public String pagingBox(String listFile, int search_count, int nowPage, String word, String col, int contentsno, int memberno);
  
  /**
   * ���� ���� ��� + �˻� + ����¡
   * <xmp>
   * <select id="send_list_search_paging" resultType="Mem_MsgVO" parameterType="HashMap">
   * </xmp> 
   */
  public ArrayList<Mem_MsgVO> send_list_search_paging(HashMap<String, Object> map);
  
  /**
   * ���� ���� �˻��� ���ڵ� ����
   * <xmp>
   * <select id="search_count2" resultType="int" parameterType="HashMap">
   * </xmp>
   * @return
   */
  public int search_count2(HashMap<String, Object> map);
  
  /**
   * ���� ���� ��� + �˻� + ����¡
   * <xmp>
   * <select id="receive_list_search_paging" resultType="Mem_MsgVO" parameterType="HashMap">
   * </xmp> 
   */
  public ArrayList<Mem_MsgVO> receive_list_search_paging(HashMap<String, Object> map);
  
  /**
   * �Խñ� �ȿ� ��� ���� �����ϱ�
   * <xmp>
   * <delete id = "delete_all_msg" parameterType = "int">
   * </xmp>
   */
  public int delete_all_msg(int contentsno);
  
  /**
  * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
  * @param contentsVO
  * @return
  */
  public ArrayList<FileVO> getThumbs(MsgVO msgVO);
}
