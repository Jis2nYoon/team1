package dev.mvc.content;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dev.mvc.cate.CateVO;


public interface ContentDAOInter {
  /**
   * <xmp>
   * �� ���
   * <insert id="create" parameterType="ContentVO">
   * </xmp>
   * @param contentVO
   * @return ��ϵ� ���ڵ� ����
   */
  public int create(ContentVO contentVO);
  
  /**
   * <xmp>
   * ��ü �� �������� ���� (�ֽ� �� �� ����)
   * <select id='list_cono_desc' resultType="Cate_ContentVO">
   * </xmp>
   * @param 
   * @return ArrayList<ContentVO>
   */
  //public ArrayList<Cate_ContentVO> list_cono_desc();
  
  /**
   * <xmp>
   * ī�װ� �� �� �������� ����(�ֽ� �� �� ����)
   * <select id='list_by_cate_desc' parameterType="int" resultType="ContentVO">
   * </xmp>
   * @param 
   * @return ArrayList<ContentVO>
   */
  //public ArrayList<ContentVO> list_by_cate_desc(int cateno);
  
  /**
   * <xmp>
   * ��ȸ
   * <select id='read' resultType="ContentVO" parameterType="int">
   * </xmp>
   * @return
   */
  public ContentVO read(int contentsno);
  
  /**
   * <Xmp>
   * ����
   * <update id='update' parameterType="ContentVO" >
   * </Xmp>
   * @param contentVO
   * @return
   */
  public int update(ContentVO contentVO);
  /**
   * <Xmp>
   * ���� ���������� ����� ���� �Ѱ� ����
   * <update id='deletefile' parameterType="ContentVO" >
   * </Xmp>
   * @param contentVO
   * @return
   */
  public int deletefile(ContentVO contentVO);
  /**
   * ���� ó��
   * <xmp>
   *   <delete id="delete" parameterType="int">
   * </xmp> 
   * @param contentno
   * @return ó���� ���ڵ� ����
   */
  public int delete(int contentno);
  /**
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param contentVO
   * @return
   */
  public ArrayList<FileVO> getThumbs(ContentVO contentVO);
  /**
   * ��ü ����, �������� �˻�
   * <xmp>
   * <select id="search_list_all" resultType="Cate_ContentVO" parameterType="HashMap">
   * </xmp>
   * @param word
   * @return
   */
  public ArrayList<Cate_ContentVO> search_list_all(HashMap map);
  
  /**
   * ��ü ����, �������� �˻��� ���ڵ� ����
   * <xmp>
   * <select id="search_count_all" resultType="int" parameterType="HashMap">
   * </xmp>
   * @param word
   * @return
   */
  public int search_count_all(HashMap map);
  
  /**
   * ī�װ��� ����, �������� �˻�
   * <xmp>
   * <select id="search_list_by_cateno" resultType="ContentVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<ContentVO> search_list_by_cateno(HashMap map);
  
  /**
   * ī�װ��� ����, �������� �˻��� ���ڵ� ����
   * <xmp>
   * <select id="search_count_by_cateno" resultType="int" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public int search_count_by_cateno(HashMap map);
  
  /**
   * ��ü �˻��� ���ڵ� ��� + ����¡ +����
   * <xmp>
   * <select id="search_list_all_paging" resultType="Cate_ContentVO" parameterType="HashMap">
   * </xmp>
   * @param map (String �˻���, int startNum, int endNum)
   * @return
   */
  public ArrayList<Cate_ContentVO> search_list_all_paging(HashMap<String, Object> map);
  
  /**
   * ī�װ� �� �˻��� ���ڵ� ��� + ����¡
   * <xmp>
   * <select id="search_list_by_cateno_paging" resultType="ContentVO" parameterType="HashMap">
   * </xmp>
   * @param map (int cateno, String �˻���, int startNum, int endNum)
   * @return
   */
  public ArrayList<ContentVO> search_list_by_cateno_paging(HashMap<String, Object> map);
  
  /**
   * <Xmp>
   * ��ȸ���� 1 ����
   * <update id='views' parameterType="int">
   * </Xmp>
   * @param contentVO
   * @return
   */
  public int views(int contentsno);
  /**
   * <Xmp>
   * �ǸſϷ�
   * <update id='sale' parameterType="int">
   * </Xmp>
   * @param contentVO
   * @return
   */
  public int sale(int contentsno);
}
