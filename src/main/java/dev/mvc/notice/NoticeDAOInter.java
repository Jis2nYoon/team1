package dev.mvc.notice;

import java.util.ArrayList;
import java.util.HashMap;

public interface NoticeDAOInter {
  /**
   * <xmp>
   * 공지사항 등록
   * <insert id="create" parameterType="NoticeVO">
   * </xmp>
   * @param noticeVO
   * @return 등록된 레코드 갯수
   */
  public int create(NoticeVO noticeVO);
  
  /**
   * <xmp>
   * 목록
   * <select id="list" resultType="Mem_NoticeVO">
   * </xmp>
   * @return ArrayList<Mem_NoticeVO>
   */
  public ArrayList<Mem_NoticeVO> list();
  
  /**
   * <xmp>
   * 조회
   * <select id="read" resultType="Mem_NoticeVO" parameterType="int">
   * </xmp>
   * @param noticeno
   * @return 한 건의 글
   */
  public Mem_NoticeVO read(int noticeno);
  
  /**
   * <xmp>
   * 수정
   * <update id="update" parameterType="NoticeVO">
   * </xmp>
   * @param noticeVO
   * @return 수정된 레코드 갯수
   */
  public int update(NoticeVO noticeVO);
  
  /**
   * <xmp>
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param noticeno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int noticeno);
  
  /**
   * 검색 목록
   * <select id="list_by_search" resultType="NoticeVO" parameterType="HashMap">
   * @param cateno
   * @return
   */
  // public ArrayList<NoticeVO> list_by_search(HashMap map);
  
  /**
   * 검색된 레코드 갯수
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * <xmp>
   * 검색 + 페이징 목록
   * <select id="list_by_search_paging" resultType="Mem_NoticeVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<Mem_NoticeVO> list_by_search_paging(HashMap<String, Object> map);
}
