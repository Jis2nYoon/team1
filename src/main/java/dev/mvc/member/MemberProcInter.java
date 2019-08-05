package dev.mvc.member;

import java.util.ArrayList;


import javax.servlet.http.HttpSession;

public interface MemberProcInter {
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
   * @return ��� ���� memberVO
   */
    public MemberVO getPhoto(int memberno);
    
  /**
   * <xmp>
   * ���
   * <insert id="create" parameterType="MemberVO">
   * </xmp>
   * @param contentsVO
   * @return
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
/*  public ArrayList<MemberVO> list();*/
  
  /**
   * ������ ��� ���ڿ� ����
   * @param listFile ��� ���ϸ� 
   * @param search_count �˻� ����
   * @param nowPage ���� ������, nowPage�� 1���� ����
   * @param col �˻��÷�
   * @param word �˻���
   * @return
   */
  public String pagingBox(String listFile,  int search_count, int nowPage, String col, String word);
  

  /**<xmp>
   * ����¡ ���
   * <select id="list_paging" resultType="MemberVO" parameterType="HashMap">
   * </xmp>
   * @param int
   * @return
   */
  /*public ArrayList<MemberVO> list_paging(int nowPage);*/
  
  /**
   * cate�� �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(String col, String word, int nowPage);
  
  /**
   * �˻� + ����¡ ���
   * @param col
   * @param word
   * @param nowPage
   * @return
   */
  public ArrayList<MemberVO> list_search_paging(String col, String word, int nowPage);
  
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
  public int act_update(String act, int memberno);
  
  /**
   * ���Ѻ���
   * @param map
   * @return
   */
  public int stopdate_update(String stopdate, int memberno);
  
  /**
   * ��й�ȣ ����
   * @param map
   * @return
   */
  public int passwd_update(String passwd, String email);
  
  /**
   * ������ ���� ����
   * @param memberVO
   * @return
   */
  public int photo_update(MemberVO memberVO);
  
  /**
   * �α���
   * @param email
   * @param passwd
   * @return
   */
  public int login(String email, String passwd);
  
  /**
   * email ã�� 
   * @param mname
   * @param tel
   * @return list
   */
  public ArrayList<String> search_email(String mname, String tel);

  /**
   * �α��ε� ������� �˻�
   * @param session
   * @return
   */
  public boolean isMember(HttpSession session);
  /**
   * ������(������) ȸ�� �������� �˻��մϴ�.
   * @param request
   * @return true: ������
   */
  public boolean isMaster(HttpSession session);
  
  /** ���� �߰�
   * ȸ����ȣ�� �г��� ��ȸ
   * <select id="nick_select" parameterType="int">
   */
  public String nick_select(int memberno);
}
