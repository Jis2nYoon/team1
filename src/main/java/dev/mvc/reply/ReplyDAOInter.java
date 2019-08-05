package dev.mvc.reply;

import java.util.ArrayList;
import java.util.HashMap;

public interface ReplyDAOInter {

  /**
   * <Xmp>
   * ��� ���
   * <insert id="create" parameterType="ReplyVO">
   * </Xmp>
   * @param replyVO
   * @return ó���� ���ڵ� ����
   */
  public int create(ReplyVO replyVO);
  /**
   * <Xmp>
   * ���� ���
   * <insert id="create_reply" parameterType="ReplyVO">
   * </Xmp>
   * @param replyVO
   * @return ó���� ���ڵ� ����
   */
  public int create_reply(ReplyVO replyVO);
  /**
   * <Xmp>
   * ������ �� �������� ���� ReplyVO
   * <select id='list' parameterType="int" resultType="ReplyVO">
   * </Xmp>
   * @param contentsno
   * @return
   */
  public ArrayList<ReplyVO> list(int contentsno);
  /**
  * <Xmp>
  * ����
  * <update id='update' parameterType="ReplyVO" >
  * </Xmp>
   * @param replyVO
   * @return
   */
  public int update(ReplyVO replyVO);
  /**
  * <Xmp>
  * increaseAnsnum ������ ��ϵ� ��۵��� ansnum�� 1�� ����
  * <update id='update_ans' parameterType="HashMap">
  * </Xmp>
   * @param map
   * @return
   */
  public int update_ans(HashMap<String, Integer> map);
  /**
  * <Xmp>
  * ����
  * <delete id="delete" parameterType="int">
  * </Xmp>
   * @param replyno
   * @return
   */
  public int delete(int replyno);
  /**
  * <Xmp>
  * �������� ��� ���ڵ� ����
  * <select id="count_all" resultType="int" parameterType="int">
  * </Xmp>
   * @param contentsno
   * @return
   */
  public int count_all(int contentsno);
  
  /**
  * <Xmp>
  * �������ȿ� �׷캰 ��� �� ���� �鿩������ ���ڵ� ����
  * <select id="count_grp_ind" resultType="int" parameterType="HashMap"">
  * </Xmp>
   * @param map
   * @return
   */
  public int count_grp_ind(HashMap<String, Integer> map);
  
  /**
   * <Xmp>
   * ��� �Ѱ� ��ȸ
   * <select id="read" resultType="ReplyVO" parameterType="int">
   * </Xmp>
   * @param replyno
   * @return
   */
  public ReplyVO read(int replyno);

}
