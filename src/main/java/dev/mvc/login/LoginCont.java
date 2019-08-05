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
     * �α��γ��� ��ü ��� http://localhost:9090/fm/login/list.do
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
     * ȸ���� �α��� ���� list ��ȸ
     * 
     * @param memberno  ���� ���ǰ� �޾ƿ�
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
     * ȸ�������� ȸ���� �α��γ��� ���� ó��
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
