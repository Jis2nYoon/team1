package  dev.mvc.cate;

import java.util.ArrayList;

public interface CateDAOInter {
  /**
   * <Xmp>
   * 카테고리 그룹 등록
   * <insert id="create" parameterType="CateVO">
   * </Xmp>
   * @param cateVO
   * @return 처리된 레코드 갯수
   */
    public int create(CateVO cateVO);
    /**
     * <Xmp>
     * cateno 오름차순 목록
     * <select id='list_cateno_asc' resultType="CateVO">
     * </Xmp>
     * @return 목록
     */
    public ArrayList<CateVO> list_cateno_asc();
    
    /**
     * <Xmp>
     * seqno 오름차순 목록
     * <select id='list_seqno_asc' resultType="CateVO">
     * </Xmp>
     * @return 목록
     */
    public ArrayList<CateVO> list_seqno_asc();
    /**
     * <Xmp>
     * 조회
     * <select id='read' resultType="CateVO" parameterType="int">
     * </Xmp>
     * @param cateno
     * @return
     */
    public CateVO read(int cateno);
    
    
    /**
     * <Xmp>
     * 수정
     * <update id='update' parameterType="CateVO" >
     * </Xmp>
     * @param cateVO
     * @return
     */
    public int update(CateVO cateVO);
    /**
     * 삭제 처리
     * <xmp>
     *   <delete id="delete" parameterType="int">
     * </xmp> 
     * @param cateno
     * @return 처리된 레코드 갯수
     */
    public int delete(int cateno);

    /**
     * 출력 순서 상향
     * <xmp>
     * <update id="seqno_inc" parameterType="int">
     * </xmp>
     * @param cateno
     * @return 처리된 레코드 갯수
     */
      public int seqno_inc(int cateno);
   
    /**
     * 출력 순서 하향
     * <xmp>
     *  <update id="seqno_dec" parameterType="int">
     * </xmp>
     * @param cateno
     * @return 처리된 레코드 갯수
     */
      public int seqno_dec(int cateno);
      /**
       * content테이블의 contentsCnt 증가
       * <xmp>
       *  <update id="cnt_inc" parameterType="int">
       * </xmp>
       * @param cateno
       * @return 처리된 레코드 갯수
       */
      public int cnt_inc(int cateno);
      /**
       * content테이블의 contentsCnt 감소
       * <xmp>
       *  <update id="cnt_dec" parameterType="int">
       * </xmp>
       * @param cateno
       * @return 처리된 레코드 갯수
       */
      public int cnt_dec(int cateno);
      /**
       * FK 컬럼 값이 사용된 레코드(contents) 삭제
       * <xmp>
       *  <delete id="fk_delete" parameterType="int">
       * </xmp>
       * @param cateno
       * @return 처리된 레코드 갯수
       */
      public int fk_delete(int cateno);
      /**
       * contents count를 0으로 초기화
       * <xmp>
       *  <update id="fk_zero" parameterType="int">
       * </xmp>
       * @param cateno
       * @return 처리된 레코드 갯수
       */
      public int fk_zero(int cateno);
}
