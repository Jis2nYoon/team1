package dev.mvc.msg;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.content.ContentVO;

public interface MsgDAOInter {

  /**
   *  쪽지 보내기 (등록/생성)
   * <xmp>
   * <insert id="create" parameterType="MsgVO">
   * </xmp>
   * @param MsgVO
   * @return
   */
  public int create(MsgVO msgVO);
  
  /**
   * 판매자인경우 목록 (join)
   * <xmp>
   * <select id="list_seller" resultType="ContentVO"  parameterType="int">
   * </xmp>
   * @param msgreceiver
   * @return
   */
  public ArrayList<ContentVO> list_seller(int msgreceiver);
  
  /**
   * 구매자인경우 목록 (join)
   * <xmp>
   * <select id="list_buyer" resultType="Mem_ContentVO" parameterType="int">
   * </xmp>
   * @param memberno
   * @return
   */
  public ArrayList<Mem_ContentVO> list_buyer(int memberno);
  
  /**
   * Join 1건 조회
   * <xmp>
   * <select id="read_by_join" resultType="Mem_ContentVO" parameterType="int">
   * </xmp>
   * @param contentsno
   * @return
   */
  public Mem_ContentVO read_by_join(int contentsno);
  
  /**
   *  보낸 쪽지 목록
   * <xmp>
   * <select id="list_send" resultType="Mem_MsgVO" parameterType="HashMap">
   * </xmp>
   * @param memberno
   * @return
   */
  public ArrayList<Mem_MsgVO> list_send(HashMap<String, Object> map);
  
  /**
   *  받은 쪽지 목록
   * <xmp>
   * <select id="list_receive" resultType="Mem_MsgVO" parameterType="HashMap">
   * </xmp>
   * @param memberno
   * @return
   */
  public ArrayList<Mem_MsgVO> list_receive(HashMap<String, Object> map);
  
  /**
   * 쪽지 1건 읽기
   * <xmp>
   * <select id="read_msg" resultType="MsgVO" parameterType="int">
   * </xmp>
   * @param msgno
   * @return
   */
  public MsgVO read_msg(int msgno);
  
  /**
   * 읽음 안읽음 확인
   * <xmp>
   * <update id="check_msg" parameterType="HashMap">
   * </xmp>
   */
  public int check_msg(HashMap<String, Object> map);

  /**
   * 쪽지 삭제하기
   * <xmp>
   * <delete id = "delete_msg" parameterType = "int">
   * </xmp>
   */
  public int delete_msg(int msgno);
  
  /**
   * 보낸 쪽지 검색된 레코드 갯수
   * <xmp>
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * </xmp>
   * @return
   */
  public int search_count(HashMap<String, Object> map);
  
  /**
   * 보낸 쪽지 목록 + 검색 + 페이징
   * <xmp>
   * <select id="send_list_search_paging" resultType="Mem_MsgVO" parameterType="HashMap">
   * </xmp> 
   */
  public ArrayList<Mem_MsgVO> send_list_search_paging(HashMap<String, Object> map);
  
  /**
   * 받은 쪽지 검색된 레코드 갯수
   * <xmp>
   * <select id="search_count2" resultType="int" parameterType="HashMap">
   * </xmp>
   * @return
   */
  public int search_count2(HashMap<String, Object> map);
  
  /**
   * 받은 쪽지 목록 + 검색 + 페이징
   * <xmp>
   * <select id="receive_list_search_paging" resultType="Mem_MsgVO" parameterType="HashMap">
   * </xmp> 
   */
  public ArrayList<Mem_MsgVO> receive_list_search_paging(HashMap<String, Object> map);
  
  /**
   * 게시글 안에 모든 쪽지 삭제하기
   * <xmp>
   * <delete id = "delete_all_msg" parameterType = "int">
   * </xmp>
   */
  public int delete_all_msg(int contentsno);
  
}
