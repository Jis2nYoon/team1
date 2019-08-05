package dev.mvc.notice;

import java.util.ArrayList;
import java.util.HashMap;

public interface NoticeProcInter {
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
   * 공지사항 목록
   * <select id="list" resultType="NoticeVO">
   * </xmp>
   * @return ArrayList<NoticeVO>
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
   * 페이지 목록 문자열 생성
   * @param listFile 목록 파일명 
   * @param cateno 커테고리번호
   * @param search_count 검색 갯수
   * @param nowPage 현재 페이지, nowPage는 1부터 시작
   * @param word 검색어
   * @return
   */
  public String pagingBox(String listFile, int search_count, int nowPage, String word);
   
  
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
