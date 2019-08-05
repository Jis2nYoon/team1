package dev.mvc.faq;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class FaqCont {

  @Autowired
  @Qualifier("dev.mvc.faq.FaqProc")
  private FaqProcInter faqProc=null;
  
  public FaqCont () {
    System.out.println("--> FaqCont created.");
  }
  
  // http://localhost:9090/fm/faq/create.do
  @RequestMapping(value="/faq/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/faq/create"); // /webapp/faq/create.jsp
    
    return mav;
  }
  
  // http://localhost:9090/fm/faq/create.do
  @RequestMapping(value="/faq/create.do", method=RequestMethod.POST)
  public ModelAndView create(FaqVO faqVO) {
    ModelAndView mav = new ModelAndView();
    
    int count = faqProc.create(faqVO);
    mav.setViewName("redirect:/faq/create_msg.jsp?count=" + count);
    
    return mav;
  }
  
  /**
   * 전체 목록
   * 
   * @return
   */
  // http://localhost:9090/fm/faq/list.do
  @RequestMapping(value = "/faq/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
 
    ArrayList<FaqVO> list = faqProc.list();
    mav.addObject("list", list);
    
    mav.setViewName("/faq/list"); // /webapp/faq/list.jsp
 
    return mav;
  }
  
  /**
   * 조회
   * @param faqno
   * @return
   */
  @RequestMapping(value = "/faq/read.do", method = RequestMethod.GET)
  public ModelAndView read(int faqno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/faq/read"); // /webapp/notice/read.jsp

    FaqVO faqVO = faqProc.read(faqno);
    mav.addObject("faqVO", faqVO);
    
    return mav;
  }
  
  /**
   * 수정
   * @param faqno
   * @return
   */
  // http://localhost:9090/fm/faq/update.do?faqno=1
  @RequestMapping(value="/faq/update.do", 
                            method=RequestMethod.GET)
  public ModelAndView update(int faqno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/faq/update"); // /webapp/faq/update.jsp
    
    FaqVO faqVO = faqProc.read(faqno);
    mav.addObject("faqVO", faqVO);

    return mav;
  }
  
  /**
   * 수정 처리
   * @param faqVO
   * @return
   */
  // http://localhost:9090/fm/faq/update.do
  @RequestMapping(value="/faq/update.do", 
                            method=RequestMethod.POST)
  public ModelAndView update(FaqVO faqVO) {
    ModelAndView mav = new ModelAndView();

    int count = faqProc.update(faqVO);
    mav.setViewName("redirect:/faq/update_msg.jsp?count=" + count);
    
    return mav;
  }  
  
  /**
   * 삭제
   * @param faqno
   * @return
   */
  // http://localhost:9090/fm/faq/delete.do?faqno=1
  @RequestMapping(value="/faq/delete.do", 
                            method=RequestMethod.GET)
  public ModelAndView delete(int faqno) {
    ModelAndView mav = new ModelAndView();
    
    FaqVO faqVO = faqProc.read(faqno);
    mav.addObject("faqVO", faqVO);
    
    return mav;
  }
  
  /**
   *  삭제 처리
   * @param noticeno
   * @return
   */
  // http://localhost:9090/fm/faq/delete.do?faqno=1
  @RequestMapping(value="/faq/delete.do", 
                            method=RequestMethod.POST)
  public ModelAndView delete_proc(int faqno) {
    ModelAndView mav = new ModelAndView();
    
    int count = faqProc.delete(faqno);
    mav.setViewName("redirect:/faq/delete_msg.jsp?count=" + count);
    
    return mav;
  }
}
