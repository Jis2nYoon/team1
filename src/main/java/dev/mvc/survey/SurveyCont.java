package dev.mvc.survey;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.surveyitem.SurveyitemProcInter;
import dev.mvc.surveyitem.SurveyitemVO;

@Controller
public class SurveyCont {
  @Autowired
  @Qualifier("dev.mvc.survey.SurveyProc")
  private SurveyProcInter surveyProc;
  
  @Autowired
  @Qualifier("dev.mvc.surveyitem.SurveyitemProc")
  private SurveyitemProcInter surveyitemProc;
  
    public SurveyCont() {
      System.out.println("--> SurveyCont created.");
    }

    /**
     * 설문조사 질문 등록 폼 
     * http://localhost:9090/fm/survey/create.do
     */
    @RequestMapping(value="/survey/create.do", method=RequestMethod.GET)
    public ModelAndView create() {
      ModelAndView mav = new ModelAndView();
      
      mav.setViewName("/survey/create"); // /webapp/survey/create.jsp
      
      return mav;
    }
    
    /**
     * 설문조사 질문 등록 처리
     */
    @RequestMapping(value="/survey/create.do", method=RequestMethod.POST)
    public ModelAndView create(SurveyVO surveyVO) {
      ModelAndView mav = new ModelAndView();
        
      int count = surveyProc.create(surveyVO);
      // mav.addObject("count", count);
      
      mav.setViewName("redirect:/survey/create_msg.jsp?count=" + count);
      
      return mav;
    }
    
    /**
     * 설문조사 질문 목록(사용자) - 검색 x
     */
    @RequestMapping(value = "/survey/list_user.do", method = RequestMethod.GET)
    public ModelAndView list_user() {
      ModelAndView mav = new ModelAndView();
      
      ArrayList<SurveyVO> list = surveyProc.list_user();
      mav.addObject("list", list);
   
      mav.setViewName("/survey/list_user"); // /webapp/survey/list_user.jsp
   
      return mav;
    }
    
    /**
     * 설문조사 질문 목록(관리자) - 검색 x
     */
    @RequestMapping(value = "/survey/list_admin.do", method = RequestMethod.GET)
    public ModelAndView list_admin() {
      ModelAndView mav = new ModelAndView();
      
      ArrayList<SurveyVO> list = surveyProc.list_admin();
      mav.addObject("list", list);
   
      mav.setViewName("/survey/list_admin"); // /webapp/survey/list_user.jsp
   
      return mav;
    }
    
    /**
     * 설문조사 질문 read
     * @param surveyno
     * @return
     */
    @RequestMapping(value="/survey/read.do", method=RequestMethod.GET)
    public ModelAndView read(int surveyno){
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/survey/read");
      
      SurveyVO surveyVO = surveyProc.read(surveyno);
      ArrayList<SurveyitemVO> surveyitemlist = surveyitemProc.list(surveyno);

      mav.addObject("surveyVO", surveyVO);
      mav.addObject("surveyitemlist", surveyitemlist);
      
      return mav;
    }  
    
    /**
     * 설문조사 질문 수정 폼
     */
    @RequestMapping(value="/survey/update.do", method=RequestMethod.GET)
    public ModelAndView update(int surveyno) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/survey/update");
      
      SurveyVO surveyVO = surveyProc.read(surveyno);
      mav.addObject("surveyVO", surveyVO);
      
      return mav;
    }
    
    /**
     * 설문조사 질문 수정 처리
     */
    @RequestMapping(value="/survey/update.do", method=RequestMethod.POST)
    public ModelAndView update(SurveyVO surveyVO) {
      ModelAndView mav = new ModelAndView();
     
      int count = surveyProc.update(surveyVO);
      //System.out.println(count);
      
      // Spring controller > JSP View EL
      //String title = Tool.spring_param_encoding(surveyVO.getTitle());

      mav.setViewName("redirect:/survey/update_msg.jsp?count=" + count);
      
      return mav;
    }  
    
    /**
     * 설문조사 질문 삭제
     */
    @RequestMapping(value="/survey/delete.do", method=RequestMethod.GET)
    public ModelAndView delete(int surveyno) {
      ModelAndView mav = new ModelAndView();
      
      int cnt = surveyitemProc.countByItem(surveyno);
      // 항목이 있으면 항목 삭제 안내 폼 띄우기
      if (cnt >= 1) {
        mav.addObject("cnt", cnt);
        mav.setViewName("redirect:/survey/delete.jsp?surveyno=" + surveyno);
        
        return mav;
        
      } 
      // 항목이 없으면 바로 삭제
      else {
      surveyProc.delete(surveyno);
      
      mav.setViewName("redirect:/survey/list_admin.do");
      
      return mav;
      }
    }
    
    
}
