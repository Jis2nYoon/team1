package dev.mvc.member;

import java.util.ArrayList;
import java.util.HashMap;



public interface MemberDAOInter {
  /**
   * 중복 이메일 검사
   * @param email
   * @return 중복된 이메일 레코드 수
   */
  public int checkEmail(String email);
  
  /**
   * 중복 닉네임 검사
   * @param nickname
   * @return 중복된 닉네임 레코드 수
   */
  public int checkNickname(String nickname);
  
/**
 * 프로필 이미지 찾기
 * @param memberno
 * @return 결과 내용 fileVO
 */
  public MemberVO getPhoto(int memberno);
  
  /**
   * <xmp>
   * 회원 정보 등록
   * <insert id="create" parameterType="MemberVO">
   * </xmp>
   * @param memberVO
   * @return 성공한 레코드 수 (1:성공)
   */
  public int create(MemberVO memberVO);
  
  /**
   * 회원정보 수정
   * @param memberVO
   * @return 성공한 레코드 수 (1:성공)
   */
  public int update(MemberVO memberVO);
  
  /**
   * 회원 탈퇴
   * @param memberno
   * @return 성공한 레코드 수 (1:성공)
   */
  public int cancel(int memberno);
  
  /**
   * 회원 삭제
   * @param memberno
   * @return 성공한 레코드 수 (1:성공)
   */
  public int delete(int memberno);
  
  /**
   * 검색을 하지 않는 경우, 전체 목록 출력
   * @return 목록 list
   */
  public ArrayList<MemberVO> list();
  
  /**
   * <xmp>
   * 페이징 목록
   * <select id="list_paging" resultType="MemberVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  //public ArrayList<MemberVO> list_paging(HashMap<String, Object> map);
  
  /**
   * cate별 검색된 레코드 갯수
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap<String, Object> map);
  
  /**
   * <xmp>
   * 페이징 목록
   * <select id="list_search_paging" resultType="MemberVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<MemberVO> list_search_paging(HashMap<String, Object> map);
  
  /**
   * 조회
   * @param mno
   * @return
   */
  public MemberVO read(int mno);
  
  /**
   * email 로 조회
   * @param email
   * @return
   */
  public MemberVO readByEmail(String email);
  
  /**
   * 권한변경
   * @param map
   * @return
   */
  public int act_update(HashMap<String, Object> map);

  /**
   * 권한변경
   * @param map
   * @return
   */
  public int stopdate_update(HashMap<String, Object> map);
  
  /**
   * 비밀번호 변경
   * @param map
   * @return
   */
  public int passwd_update(HashMap<String, Object> map);
  
  /**
   * 프로필 파일 변경
   * @param memberVO
   * @return
   */
  public int photo_update(MemberVO memberVO);
    
  /**
   * 로그인 
   * @param map
   * @return int
   */
  public int login(HashMap<String, Object> map);

  /**
   * email 찾기 
   * @param map
   * @return list
   */
  public ArrayList<String> search_email(HashMap<String, Object> map);
  
  /** 은진 추가
   * 회원번호로 닉네임 조회
   * <select id="nick_select" parameterType="int">
   */
  public String nick_select(int memberno);

}
