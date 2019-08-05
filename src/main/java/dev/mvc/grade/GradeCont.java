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
   * ��� ��ü ��� http://localhost:9090/fm/grade/list.do
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
   * ȸ���� ��� ��ȸ read
   * 
   * @param memberno
   *          ���� ���ǰ� �޾ƿ�
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
   * ȸ�������� ȸ���� ��� ���� ó��
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
   * ȸ�� ���� ��� ��
   * �ŷ��� ���� �� ȸ�� ���� ���
   * @return
   */
  @RequestMapping(value = "/grade/grade_update.do", method = RequestMethod.GET)
  public ModelAndView grade_update(int mno, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
    } else { // �α����� �Ǿ� ���� ���� ���
      mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
      return mav;
    }
    mav.setViewName("/grade/grade_update"); // webapp/member/passwd_update.jsp

    mav.addObject("mno", mno);

    return mav;
  }
  
  /**
   * ȸ�� ���� ��� ó��
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
  /* ���� -- �߰������� �ϴ� �κ� */
  /**
   * �ŷ� �� ȸ�� ���� ��� ��
   * 
   * @return
   */
  @RequestMapping(value = "/grade/manner_update.do", method = RequestMethod.GET)
  public ModelAndView manner_update(int mno, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
    } else { // �α����� �Ǿ� ���� ���� ���
      mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
      return mav;
    }
    mav.setViewName("/grade/grade_update_manner"); // webapp/member/passwd_update.jsp
    mav.addObject("mno", mno);
    return mav;
  }
  /**
   * �ŷ� �� ȸ�� ���� ��� ó��
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
