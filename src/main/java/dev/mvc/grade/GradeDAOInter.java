package dev.mvc.grade;

import java.util.ArrayList;

import dev.mvc.grade.GradeVO;
import dev.mvc.grade.Member_GradeVO;

public interface GradeDAOInter {
  /**
   * <xmp>
   * ȸ�����Խ� ������̺� ���
   * <insert id="create" parameterType="GradeVO">
   * </xmp>
   * @param memberno
   * @return ������ ���ڵ� �� (1:����)
   */
  public int create(int memberno);
  
  /**
   * ��ü ȸ�� ��� ��� ��� (������)
   * @return ��� list
   */
  public ArrayList<Member_GradeVO> list();
  
  /**
   * ȸ���� ��� read
   * @param mno
   * @return
   */
  public GradeVO read(int memberno);
  
  /**
   * ȸ����� 1 �׸� �߰��� ����
   * @param gradeVO
   * @return ������ ���ڵ� �� (1:����)
   */
  public int update(GradeVO gradeVO);
  
  /**
   * ȸ�������� ȸ���� ȸ����� ����
   * @param memberno
   * @return ������ ���ڵ� �� (1:����)
   */
  public int delete(int memberno);
  
  /**
   * �ش� memberno�� ���� grade���̺��� ���ڵ� ��
   * @param memberno
   * @return ��ȸ�� ȸ����� ��
   */
  public int count_memno(int memberno);
  
  
  /**
   * �ų� ������ ��
   * @param gradeVO
   * @return ������ ���ڵ� �� (1:����)
   */
  public int update_manner(int manner, int mno);
  
}
