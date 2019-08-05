package  dev.mvc.cate;

import java.util.ArrayList;

public interface CateDAOInter {
  /**
   * <Xmp>
   * ī�װ� �׷� ���
   * <insert id="create" parameterType="CateVO">
   * </Xmp>
   * @param cateVO
   * @return ó���� ���ڵ� ����
   */
    public int create(CateVO cateVO);
    /**
     * <Xmp>
     * cateno �������� ���
     * <select id='list_cateno_asc' resultType="CateVO">
     * </Xmp>
     * @return ���
     */
    public ArrayList<CateVO> list_cateno_asc();
    
    /**
     * <Xmp>
     * seqno �������� ���
     * <select id='list_seqno_asc' resultType="CateVO">
     * </Xmp>
     * @return ���
     */
    public ArrayList<CateVO> list_seqno_asc();
    /**
     * <Xmp>
     * ��ȸ
     * <select id='read' resultType="CateVO" parameterType="int">
     * </Xmp>
     * @param cateno
     * @return
     */
    public CateVO read(int cateno);
    
    
    /**
     * <Xmp>
     * ����
     * <update id='update' parameterType="CateVO" >
     * </Xmp>
     * @param cateVO
     * @return
     */
    public int update(CateVO cateVO);
    /**
     * ���� ó��
     * <xmp>
     *   <delete id="delete" parameterType="int">
     * </xmp> 
     * @param cateno
     * @return ó���� ���ڵ� ����
     */
    public int delete(int cateno);

    /**
     * ��� ���� ����
     * <xmp>
     * <update id="seqno_inc" parameterType="int">
     * </xmp>
     * @param cateno
     * @return ó���� ���ڵ� ����
     */
      public int seqno_inc(int cateno);
   
    /**
     * ��� ���� ����
     * <xmp>
     *  <update id="seqno_dec" parameterType="int">
     * </xmp>
     * @param cateno
     * @return ó���� ���ڵ� ����
     */
      public int seqno_dec(int cateno);
      /**
       * content���̺��� contentsCnt ����
       * <xmp>
       *  <update id="cnt_inc" parameterType="int">
       * </xmp>
       * @param cateno
       * @return ó���� ���ڵ� ����
       */
      public int cnt_inc(int cateno);
      /**
       * content���̺��� contentsCnt ����
       * <xmp>
       *  <update id="cnt_dec" parameterType="int">
       * </xmp>
       * @param cateno
       * @return ó���� ���ڵ� ����
       */
      public int cnt_dec(int cateno);
      /**
       * FK �÷� ���� ���� ���ڵ�(contents) ����
       * <xmp>
       *  <delete id="fk_delete" parameterType="int">
       * </xmp>
       * @param cateno
       * @return ó���� ���ڵ� ����
       */
      public int fk_delete(int cateno);
      /**
       * contents count�� 0���� �ʱ�ȭ
       * <xmp>
       *  <update id="fk_zero" parameterType="int">
       * </xmp>
       * @param cateno
       * @return ó���� ���ڵ� ����
       */
      public int fk_zero(int cateno);
}
