package  dev.mvc.reply;

import java.util.ArrayList;

public interface ReplyProcInter {
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
  * ����� ���� ���� �۾�
   * @param replyVO
   * @return
   */
  public ReplyVO update_seq(int parent_replyno);
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
   * ��� �Ѱ� ��ȸ
   * <select id="read" resultType="ReplyVO" parameterType="int">
   * </Xmp>
   * @param replyno
   * @return
   */
  public ReplyVO read(int replyno);
  
}
