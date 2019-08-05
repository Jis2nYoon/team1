package dev.mvc.faq;

import java.util.ArrayList;

public interface FaqDAOInter {
  /**
   * <xmp>
   * 공지사항 등록
   * <insert id="create" parameterType="FaqVO">
   * </xmp>
   * @param faqVO
   * @return 등록된 레코드 갯수
   */
  public int create(FaqVO faqVO);
  
  /**
   * <xmp>
   * 목록
   * <select id="list" resultType="FaqVO">
   * </xmp>
   * @return ArrayList<FaqVO>
   */
  public ArrayList<FaqVO> list();
  
  /**
   * <xmp>
   * 조회
   * <select id="read" resultType="FaqVO" parameterType="int">
   * </xmp>
   * @param faqno
   * @return 한 건의 글
   */
  public FaqVO read(int faqno);
  
  /**
   * <xmp>
   * 수정
   * <update id="update" parameterType="FaqVO">
   * </xmp>
   * @param faqVO
   * @return
   */
  public int update(FaqVO faqVO);
  
  /**
   * 삭제 처리
   * <xmp>
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param faqno
   * @return 처리된 레코드 갯수
   */
  public int delete(int faqno);
  
}
