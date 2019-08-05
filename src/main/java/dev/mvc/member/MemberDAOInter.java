package dev.mvc.member;

import java.util.ArrayList;
import java.util.HashMap;



public interface MemberDAOInter {
  /**
   * �ߺ� �̸��� �˻�
   * @param email
   * @return �ߺ��� �̸��� ���ڵ� ��
   */
  public int checkEmail(String email);
  
  /**
   * �ߺ� �г��� �˻�
   * @param nickname
   * @return �ߺ��� �г��� ���ڵ� ��
   */
  public int checkNickname(String nickname);
  
/**
 * ������ �̹��� ã��
 * @param memberno
 * @return ��� ���� fileVO
 */
  public MemberVO getPhoto(int memberno);
  
  /**
   * <xmp>
   * ȸ�� ���� ���
   * <insert id="create" parameterType="MemberVO">
   * </xmp>
   * @param memberVO
   * @return ������ ���ڵ� �� (1:����)
   */
  public int create(MemberVO memberVO);
  
  /**
   * ȸ������ ����
   * @param memberVO
   * @return ������ ���ڵ� �� (1:����)
   */
  public int update(MemberVO memberVO);
  
  /**
   * ȸ�� Ż��
   * @param memberno
   * @return ������ ���ڵ� �� (1:����)
   */
  public int cancel(int memberno);
  
  /**
   * ȸ�� ����
   * @param memberno
   * @return ������ ���ڵ� �� (1:����)
   */
  public int delete(int memberno);
  
  /**
   * �˻��� ���� �ʴ� ���, ��ü ��� ���
   * @return ��� list
   */
  public ArrayList<MemberVO> list();
  
  /**
   * <xmp>
   * ����¡ ���
   * <select id="list_paging" resultType="MemberVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  //public ArrayList<MemberVO> list_paging(HashMap<String, Object> map);
  
  /**
   * cate�� �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap<String, Object> map);
  
  /**
   * <xmp>
   * ����¡ ���
   * <select id="list_search_paging" resultType="MemberVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<MemberVO> list_search_paging(HashMap<String, Object> map);
  
  /**
   * ��ȸ
   * @param mno
   * @return
   */
  public MemberVO read(int mno);
  
  /**
   * email �� ��ȸ
   * @param email
   * @return
   */
  public MemberVO readByEmail(String email);
  
  /**
   * ���Ѻ���
   * @param map
   * @return
   */
  public int act_update(HashMap<String, Object> map);

  /**
   * ���Ѻ���
   * @param map
   * @return
   */
  public int stopdate_update(HashMap<String, Object> map);
  
  /**
   * ��й�ȣ ����
   * @param map
   * @return
   */
  public int passwd_update(HashMap<String, Object> map);
  
  /**
   * ������ ���� ����
   * @param memberVO
   * @return
   */
  public int photo_update(MemberVO memberVO);
    
  /**
   * �α��� 
   * @param map
   * @return int
   */
  public int login(HashMap<String, Object> map);

  /**
   * email ã�� 
   * @param map
   * @return list
   */
  public ArrayList<String> search_email(HashMap<String, Object> map);
  
  /** ���� �߰�
   * ȸ����ȣ�� �г��� ��ȸ
   * <select id="nick_select" parameterType="int">
   */
  public String nick_select(int memberno);

}
