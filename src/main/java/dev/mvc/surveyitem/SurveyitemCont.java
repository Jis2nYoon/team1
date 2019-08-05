package dev.mvc.surveyitem;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SurveyitemCont {
  @Autowired
  @Qualifier("dev.mvc.surveyitem.SurveyitemProc")
  private SurveyitemProcInter surveyitemProc;
  
    public SurveyitemCont() {
      System.out.println("--> SurveyitemCont created.");
    }

    /**
     * 설문조사 항목 등록 폼 
     * http://localhost:9090/fm/surveyitem/create.do
     */
    @RequestMapping(value="/surveyitem/create.do", method=RequestMethod.GET)
    public ModelAndView create(int surveyno) {
      ModelAndView mav = new ModelAndView();
      
      mav.setViewName("/surveyitem/create");
      
      return mav;
    }
    
    /**
     * 설문조사 항목 등록 처리
     */
    @RequestMapping(value="/surveyitem/create.do", method=RequestMethod.POST)
    public ModelAndView create(SurveyitemVO surveyitemVO) {
      ModelAndView mav = new ModelAndView();
        
      int count = surveyitemProc.create(surveyitemVO);
      
      mav.setViewName("redirect:/surveyitem/create_msg.jsp?count=" + count);
      
      return mav;
    }
    
    /**
     * 설문조사 항목 목록
     */
    @RequestMapping(value = "/surveyitem/list.do", method = RequestMethod.GET)
    public ModelAndView list(int surveyno) {
      ModelAndView mav = new ModelAndView();

      ArrayList<SurveyitemVO> list = surveyitemProc.list(surveyno);
      mav.addObject("list", list);
   
      mav.setViewName("/surveyitem/list"); 
      
      return mav;
    }
    
    /**
     * 설문조사 항목 수정 폼
     * @param surveyitemno
     * @return
     */
    @RequestMapping(value="/surveyitem/update.do", method=RequestMethod.GET)
    public ModelAndView update(int surveyitemno) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/surveyitem/update");
      
      SurveyitemVO surveyitemVO = surveyitemProc.read(surveyitemno);
      mav.addObject("surveyitemVO", surveyitemVO);
      
      return mav;
    }
    
    /**
     * 설문조사 항목 수정 처리
     * @param surveyitemVO
     * @return
     */
    @RequestMapping(value="/surveyitem/update.do", method=RequestMethod.POST)
    public ModelAndView update(SurveyitemVO surveyitemVO) {
      ModelAndView mav = new ModelAndView();
     
      int count = surveyitemProc.update(surveyitemVO);
      System.out.println(count);
      
      // Spring controller > JSP View EL
      //String title = Tool.spring_param_encoding(surveyVO.getTitle());

      mav.setViewName("redirect:/surveyitem/update_msg.jsp?count=" + count);
      
      return mav;
    }  
    
    /**
     * 설문조사 항목 삭제
     */
    @RequestMapping(value="/surveyitem/delete_item.do", method=RequestMethod.GET)
    public ModelAndView delete_item(int surveyitemno, int surveyno) {
      ModelAndView mav = new ModelAndView();
     
      surveyitemProc.delete_item(surveyitemno);
      
      mav.setViewName("redirect:/surveyitem/list.do?surveyno="+ surveyno);
      return mav;
    }
    
}
