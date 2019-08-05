package dev.mvc.reply;

import java.util.ArrayList;
import java.util.HashMap;

public interface ReplyDAOInter {

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
  * <Xmp>
  * increaseAnsnum 기존에 등록된 댓글들의 ansnum을 1씩 증가
  * <update id='update_ans' parameterType="HashMap">
  * </Xmp>
   * @param map
   * @return
   */
  public int update_ans(HashMap<String, Integer> map);
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
  * 컨텐츠안에 그룹별 댓글 중 같은 들여쓰기인 레코드 갯수
  * <select id="count_grp_ind" resultType="int" parameterType="HashMap"">
  * </Xmp>
   * @param map
   * @return
   */
  public int count_grp_ind(HashMap<String, Integer> map);
  
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
