package dev.mvc.content;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dev.mvc.cate.CateVO;


public interface ContentDAOInter {
  /**
   * <xmp>
   * 글 등록
   * <insert id="create" parameterType="ContentVO">
   * </xmp>
   * @param contentVO
   * @return 등록된 레코드 갯수
   */
  public int create(ContentVO contentVO);
  
  /**
   * <xmp>
   * 전체 글 내림차순 정렬 (최신 글 맨 위에)
   * <select id='list_cono_desc' resultType="Cate_ContentVO">
   * </xmp>
   * @param 
   * @return ArrayList<ContentVO>
   */
  //public ArrayList<Cate_ContentVO> list_cono_desc();
  
  /**
   * <xmp>
   * 카테고리 별 글 내림차순 정렬(최신 글 맨 위에)
   * <select id='list_by_cate_desc' parameterType="int" resultType="ContentVO">
   * </xmp>
   * @param 
   * @return ArrayList<ContentVO>
   */
  //public ArrayList<ContentVO> list_by_cate_desc(int cateno);
  
  /**
   * <xmp>
   * 조회
   * <select id='read' resultType="ContentVO" parameterType="int">
   * </xmp>
   * @return
   */
  public ContentVO read(int contentsno);
  
  /**
   * <Xmp>
   * 수정
   * <update id='update' parameterType="ContentVO" >
   * </Xmp>
   * @param contentVO
   * @return
   */
  public int update(ContentVO contentVO);
  /**
   * <Xmp>
   * 수정 페이지에서 썸네일 사진 한개 삭제
   * <update id='deletefile' parameterType="ContentVO" >
   * </Xmp>
   * @param contentVO
   * @return
   */
  public int deletefile(ContentVO contentVO);
  /**
   * 삭제 처리
   * <xmp>
   *   <delete id="delete" parameterType="int">
   * </xmp> 
   * @param contentno
   * @return 처리된 레코드 갯수
   */
  public int delete(int contentno);
  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param contentVO
   * @return
   */
  public ArrayList<FileVO> getThumbs(ContentVO contentVO);
  /**
   * 전체 제목, 내용으로 검색
   * <xmp>
   * <select id="search_list_all" resultType="Cate_ContentVO" parameterType="HashMap">
   * </xmp>
   * @param word
   * @return
   */
  public ArrayList<Cate_ContentVO> search_list_all(HashMap map);
  
  /**
   * 전체 제목, 내용으로 검색된 레코드 갯수
   * <xmp>
   * <select id="search_count_all" resultType="int" parameterType="HashMap">
   * </xmp>
   * @param word
   * @return
   */
  public int search_count_all(HashMap map);
  
  /**
   * 카테고리별 제목, 내용으로 검색
   * <xmp>
   * <select id="search_list_by_cateno" resultType="ContentVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<ContentVO> search_list_by_cateno(HashMap map);
  
  /**
   * 카테고리별 제목, 내용으로 검색된 레코드 갯수
   * <xmp>
   * <select id="search_count_by_cateno" resultType="int" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public int search_count_by_cateno(HashMap map);
  
  /**
   * 전체 검색된 레코드 목록 + 페이징 +조인
   * <xmp>
   * <select id="search_list_all_paging" resultType="Cate_ContentVO" parameterType="HashMap">
   * </xmp>
   * @param map (String 검색어, int startNum, int endNum)
   * @return
   */
  public ArrayList<Cate_ContentVO> search_list_all_paging(HashMap<String, Object> map);
  
  /**
   * 카테고리 별 검색된 레코드 목록 + 페이징
   * <xmp>
   * <select id="search_list_by_cateno_paging" resultType="ContentVO" parameterType="HashMap">
   * </xmp>
   * @param map (int cateno, String 검색어, int startNum, int endNum)
   * @return
   */
  public ArrayList<ContentVO> search_list_by_cateno_paging(HashMap<String, Object> map);
  
  /**
   * <Xmp>
   * 조회수를 1 증가
   * <update id='views' parameterType="int">
   * </Xmp>
   * @param contentVO
   * @return
   */
  public int views(int contentsno);
  /**
   * <Xmp>
   * 판매완료
   * <update id='sale' parameterType="int">
   * </Xmp>
   * @param contentVO
   * @return
   */
  public int sale(int contentsno);
}
