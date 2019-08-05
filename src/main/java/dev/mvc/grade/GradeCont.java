package dev.mvc.grade;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.grade.GradeProcInter;
import dev.mvc.grade.GradeVO;
import dev.mvc.grade.Member_GradeVO;
import dev.mvc.member.MemberProcInter;

@Controller
public class GradeCont {
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.grade.GradeProc")
  private GradeProcInter gradeProc = null;

  public GradeCont() {
  }

  /**
   * 등급 전체 목록 http://localhost:9090/fm/grade/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/grade/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/grade/list"); // /webapp/grade/list.jsp

    ArrayList<Member_GradeVO> list = gradeProc.list();
    mav.addObject("list", list);

    return mav;
  }

  /**
   * 회원별 등급 조회 read
   * 
   * @param memberno
   *          현재 세션값 받아옴
   * @return
   */
  @RequestMapping(value = "/grade/read.do", method = RequestMethod.GET)
  public ModelAndView read(int mno) {

    ModelAndView mav = new ModelAndView();
    mav.setViewName("/grade/read");

    GradeVO gradeVO = gradeProc.read(mno);
    mav.addObject("gradeVO", gradeVO);

    return mav;
  }

  /**
   * 회원삭제시 회원별 등급 삭제 처리
   * 
   * @param redirectAttributes
   * @param request
   * @param memberno
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/grade/delete.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String delete(int memberno) {
    int count = gradeProc.delete(memberno);
    JSONObject json = new JSONObject(count);
    json.put("count", count);

    return json.toString();

  }

  /**
   * 회원 평점 등록 폼
   * 거래가 끝난 후 회원 평점 등록
   * @return
   */
  @RequestMapping(value = "/grade/grade_update.do", method = RequestMethod.GET)
  public ModelAndView grade_update(int mno, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
    } else { // 로그인이 되어 있지 않은 경우
      mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
      return mav;
    }
    mav.setViewName("/grade/grade_update"); // webapp/member/passwd_update.jsp

    mav.addObject("mno", mno);

    return mav;
  }
  
  /**
   * 회원 평점 등록 처리
   * 
   * @return
   */
  @RequestMapping(value = "/grade/grade_update.do", method = RequestMethod.POST)
  public ModelAndView grade_update(int manner, int delivery, int quality,int mno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/grade/grade_update"); // webapp/member/passwd_update.jsp

    // mav.addObject("email", email);

    return mav;
  }
  /* 지선 -- 추가했으면 하는 부분 */
  /**
   * 거래 전 회원 평점 등록 폼
   * 
   * @return
   */
  @RequestMapping(value = "/grade/manner_update.do", method = RequestMethod.GET)
  public ModelAndView manner_update(int mno, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
    } else { // 로그인이 되어 있지 않은 경우
      mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
      return mav;
    }
    mav.setViewName("/grade/grade_update_manner"); // webapp/member/passwd_update.jsp
    mav.addObject("mno", mno);
    return mav;
  }
  /**
   * 거래 전 회원 평점 등록 처리
   * 
   * @return
   */
  @RequestMapping(value = "/grade/manner_update.do", method = RequestMethod.POST)
  public ModelAndView manner_update(int manner, int mno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/grade/grade_update_manner"); // webapp/member/passwd_update_manner.jsp

    int count = gradeProc.update_manner(manner, mno);
    mav.addObject("count", count);

    return mav;
  }
  
}
