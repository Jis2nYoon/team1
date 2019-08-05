package dev.mvc.member;

import java.util.ArrayList;


import javax.servlet.http.HttpSession;

public interface MemberProcInter {
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
   * @return 결과 내용 memberVO
   */
    public MemberVO getPhoto(int memberno);
    
  /**
   * <xmp>
   * 등록
   * <insert id="create" parameterType="MemberVO">
   * </xmp>
   * @param contentsVO
   * @return
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
/*  public ArrayList<MemberVO> list();*/
  
  /**
   * 페이지 목록 문자열 생성
   * @param listFile 목록 파일명 
   * @param search_count 검색 갯수
   * @param nowPage 현재 페이지, nowPage는 1부터 시작
   * @param col 검색컬럼
   * @param word 검색어
   * @return
   */
  public String pagingBox(String listFile,  int search_count, int nowPage, String col, String word);
  

  /**<xmp>
   * 페이징 목록
   * <select id="list_paging" resultType="MemberVO" parameterType="HashMap">
   * </xmp>
   * @param int
   * @return
   */
  /*public ArrayList<MemberVO> list_paging(int nowPage);*/
  
  /**
   * cate별 검색된 레코드 갯수
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(String col, String word, int nowPage);
  
  /**
   * 검색 + 페이징 목록
   * @param col
   * @param word
   * @param nowPage
   * @return
   */
  public ArrayList<MemberVO> list_search_paging(String col, String word, int nowPage);
  
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
  public int act_update(String act, int memberno);
  
  /**
   * 권한변경
   * @param map
   * @return
   */
  public int stopdate_update(String stopdate, int memberno);
  
  /**
   * 비밀번호 변경
   * @param map
   * @return
   */
  public int passwd_update(String passwd, String email);
  
  /**
   * 프로필 파일 변경
   * @param memberVO
   * @return
   */
  public int photo_update(MemberVO memberVO);
  
  /**
   * 로그인
   * @param email
   * @param passwd
   * @return
   */
  public int login(String email, String passwd);
  
  /**
   * email 찾기 
   * @param mname
   * @param tel
   * @return list
   */
  public ArrayList<String> search_email(String mname, String tel);

  /**
   * 로그인된 멤버인지 검사
   * @param session
   * @return
   */
  public boolean isMember(HttpSession session);
  /**
   * 마스터(관리자) 회원 계정인지 검사합니다.
   * @param request
   * @return true: 관리자
   */
  public boolean isMaster(HttpSession session);
  
  /** 은진 추가
   * 회원번호로 닉네임 조회
   * <select id="nick_select" parameterType="int">
   */
  public String nick_select(int memberno);
}
