package dev.mvc.login;

import java.util.ArrayList;



import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import dev.mvc.login.LoginVO;


@Controller
public class LoginCont {
  @Autowired
  @Qualifier("dev.mvc.login.LoginProc")
  private LoginProcInter loginProc = null;
       
    public LoginCont() {
    }

    /**
     * 로그인내역 전체 목록 http://localhost:9090/fm/login/list.do
     * 
     * @return
     */
    @RequestMapping(value = "/login/list.do", method = RequestMethod.GET)
    public ModelAndView list() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/login/list"); // /webapp/login/list.jsp

      ArrayList<Member_LoginVO> list = loginProc.list();
      mav.addObject("list", list);

      return mav;
    }

    /**
     * 회원별 로그인 내역 list 조회
     * 
     * @param memberno  현재 세션값 받아옴
     * @return 
     */
    @RequestMapping(value = "/login/list_memberno.do", method = RequestMethod.GET)
    public ModelAndView list_memberno(int mno) {

      ModelAndView mav = new ModelAndView();
      mav.setViewName("/login/list_memberno");

      ArrayList<LoginVO> list= loginProc.list_memberno(mno);
      mav.addObject("list", list);

      return mav;
    }
    
    /**
     * 회원삭제시 회원별 로그인내역 삭제 처리
     * 
     * @param redirectAttributes
     * @param request
     * @param memberno 
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/login/delete.do", method = RequestMethod.GET , produces = "text/plain;charset=UTF-8")
    public String delete( int memberno) {
      int count = loginProc.delete(memberno);
      JSONObject json = new JSONObject(count);
      json.put("count", count);

      return json.toString();

    }


}
