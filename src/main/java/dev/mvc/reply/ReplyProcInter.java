package  dev.mvc.reply;

import java.util.ArrayList;

public interface ReplyProcInter {
  /**
   * <Xmp>
   * 댓글 등록
   * <insert id="create" parameterType="ReplyVO">
   * </Xmp>
   * @param replyVO
   * @return 처리된 레코드 갯수
   */
  public int create(ReplyVO replyVO);
  /**
   * <Xmp>
   * 대댓글 등록
   * <insert id="create_reply" parameterType="ReplyVO">
   * </Xmp>
   * @param replyVO
   * @return 처리된 레코드 갯수
   */
  public int create_reply(ReplyVO replyVO);
  /**
   * <Xmp>
   * 컨텐츠 별 오름차순 정렬 ReplyVO
   * <select id='list' parameterType="int" resultType="ReplyVO">
   * </Xmp>
   * @param contentsno
   * @return
   */
  public ArrayList<ReplyVO> list(int contentsno);
  /**
  * <Xmp>
  * 수정
  * <update id='update' parameterType="ReplyVO" >
  * </Xmp>
   * @param replyVO
   * @return
   */
  public int update(ReplyVO replyVO);
  /**
  * 댓글의 순서 갱신 작업
   * @param replyVO
   * @return
   */
  public ReplyVO update_seq(int parent_replyno);
  /**
  * <Xmp>
  * 삭제
  * <delete id="delete" parameterType="int">
  * </Xmp>
   * @param replyno
   * @return
   */
  public int delete(int replyno);
  /**
  * <Xmp>
  * 컨텐츠별 댓글 레코드 갯수
  * <select id="count_all" resultType="int" parameterType="int">
  * </Xmp>
   * @param contentsno
   * @return
   */
  public int count_all(int contentsno);

  /**
   * <Xmp>
   * 댓글 한개 조회
   * <select id="read" resultType="ReplyVO" parameterType="int">
   * </Xmp>
   * @param replyno
   * @return
   */
  public ReplyVO read(int replyno);
  
}
