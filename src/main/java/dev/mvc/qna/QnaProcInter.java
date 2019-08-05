package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;

public interface QnaProcInter {
  /**
   * <xmp>
   * 공지사항 등록
   * <insert id="create" parameterType="QnaVO">
   * </xmp>
   * @param qnaVO
   * @return 등록된 레코드 갯수
   */
  public int create(QnaVO qnaVO);
  
  /**
   * <xmp>
   * 목록
   * <select id="list" resultType="Mem_QnaVO">
   * </xmp>
   * @return ArrayList<Mem_QnaVO>
   */
  public ArrayList<Mem_QnaVO> list();
  
  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param contentsVO
   * @return
   */
  public ArrayList<QnaFileVO> getThumbs(Mem_QnaVO mem_QnaVO);

  /**
   * <xmp>
   * 조회
   * <select id="read" resultType="Mem_QnaVO" parameterType="int">
   * </xmp>
   * @param qnano
   * @return 한 건의 글
   */
  public Mem_QnaVO read(int qnano);
  
  /**
   * <xmp>
   * 수정
   * <update id="update" parameterType="QnaVO">
   * </xmp>
   * @param qnaVO
   * @return
   */
  public int update(QnaVO qnaVO);
  
  /**
   * <xmp>
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param qnano
   * @return
   */
  public int delete(int qnano);
  
  /**
   * <xmp>
   * 답변 순서 증가
   * <update id="increaseAnsnum" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public int increaseAnsnum(HashMap<String, Object> map);
  
  /**
   * <xmp>
   * 답변
   * <insert id="reply" parameterType="QnaVO">
   * </xmp>
   * @param qnaVO
   * @return
   */
  public int reply(QnaVO qnaVO);
  
}
