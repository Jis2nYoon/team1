package dev.mvc.surveymember;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.surveyitem.SurveyitemVO;

@Controller
public class SurveymemberCont {
  @Autowired
  @Qualifier("dev.mvc.surveymember.SurveymemberProc")
  private SurveymemberProcInter surveymemberProc;
  
    public SurveymemberCont() {
      System.out.println("--> SurveymemberCont created.");
    }
    
    /**
     * 설문조사 제출 등록 폼 
     * http://localhost:9090/fm/surveymember/create.do
     */
    @RequestMapping(value="/surveymember/create.do", method=RequestMethod.GET)
    public ModelAndView create(int surveyitemno, int memberno) {
      ModelAndView mav = new ModelAndView();
      
      mav.setViewName("/surveymember/create");
      
      return mav;
    }
    
    /**
     * 설문조사 제출 등록 처리
     */
    @RequestMapping(value="/surveymember/create.do", method=RequestMethod.POST)
    public ModelAndView create(SurveymemberVO surveymemberVO) {
      ModelAndView mav = new ModelAndView();
        
      int count = surveymemberProc.create(surveymemberVO);
      
      mav.setViewName("redirect:/surveymember/create_msg.jsp?count=" + count);
      
      return mav;
    }
    
    
}
