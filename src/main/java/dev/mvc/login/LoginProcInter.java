package dev.mvc.login;

import java.util.ArrayList;

public interface LoginProcInter {

  /**
   * <xmp>
   * ȸ���α��ν� �α��γ��� ���
   * <insert id="create" parameterType="LoginVO">
   * </xmp>
   * @param loginVO
   * @return ������ ���ڵ� �� (1:����)
   */
  public int create(LoginVO loginVO);
  
  /**
   * ��ü ��� ���
   * @return ��� list
   */
  public ArrayList<Member_LoginVO> list();
  
  /**
   * ȸ���� ���� list ��ȸ
   * @param mno
   * @return
   */
  public ArrayList<LoginVO> list_memberno(int memberno);
  
  /**
   * ȸ�������� ȸ���� �α��γ��� ����
   * @param loginno
   * @return ������ ���ڵ� �� (1:����)
   */
  public int delete(int memberno);
  
  /**
   * �ش� memberno�� ���� login���̺��� ���ڵ� ��
   * @param memberno
   * @return ��ȸ�� �α��γ��� ���ڵ� ��
   */
  public int count_memno(int memberno);
}
