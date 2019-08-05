package dev.mvc.notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import nation.web.tool.Tool;


@Controller
public class NoticeCont {

  @Autowired
  @Qualifier("dev.mvc.notice.NoticeProc")
  private NoticeProcInter noticeProc=null;
  
  public NoticeCont () {
    System.out.println("--> team1.NoticeCont created.");
  }
  
  // http://localhost:9090/fm/notice/create.do
  @RequestMapping(value="/notice/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/create"); // /webapp/notice/create.jsp
    
    return mav;
  }
  
  // http://localhost:9090/fm/notice/create.do
  @RequestMapping(value="/notice/create.do", method=RequestMethod.POST)
  public ModelAndView create(NoticeVO noticeVO) {
    ModelAndView mav = new ModelAndView();
    
    int count = noticeProc.create(noticeVO);
    mav.setViewName("redirect:/notice/create_msg.jsp?count=" + count);
    
    return mav;
  }
  
  /**
   * ��ü ���
   * 
   * @return
   */
  // http://localhost:9090/fm/notice/list.do
  @RequestMapping(value = "/notice/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
 
    ArrayList<Mem_NoticeVO> list = noticeProc.list();
    mav.addObject("list", list);
    
    mav.setViewName("/notice/list"); // /webapp/notice/list.jsp
 
    return mav;
  }
  
  /**
   * ��ȸ
   * @param noticeno
   * @return
   */
  @RequestMapping(value = "/notice/read.do", method = RequestMethod.GET)
  public ModelAndView read(int noticeno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/read"); // /webapp/notice/read.jsp

    Mem_NoticeVO mem_NoticeVO = noticeProc.read(noticeno);
    mav.addObject("mem_NoticeVO", mem_NoticeVO);
    
    return mav;
  }
  
  /**
   * ���� ��
   * @param noticeno
   * @return
   */
  // http://localhost:9090/fm/notice/update.do?noticeno=1
  @RequestMapping(value="/notice/update.do", 
                            method=RequestMethod.GET)
  public ModelAndView update(int noticeno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/update"); // /webapp/notice/update.jsp
    
    Mem_NoticeVO mem_NoticeVO = noticeProc.read(noticeno);
    mav.addObject("mem_NoticeVO", mem_NoticeVO);

    return mav;
  }
  
  /**
   * ���� ó��
   * @param noticeVO
   * @return
   */
  // http://localhost:9090/fm/notice/update.do
  @RequestMapping(value="/notice/update.do", 
                            method=RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, 
                                          NoticeVO noticeVO,
                                          @RequestParam(value="word", defaultValue="") String word,
                                          @RequestParam(value="nowPage", defaultValue="1") int nowPage)  {
    ModelAndView mav = new ModelAndView();
    
    int count = noticeProc.update(noticeVO);
    redirectAttributes.addAttribute("word", word);
    redirectAttributes.addAttribute("nowPage", nowPage);
    redirectAttributes.addAttribute("noticeno", noticeVO.getNoticeno());
    
    mav.setViewName("redirect:/notice/update_msg.jsp?count=" + count);
    
    return mav;
  }  
  
  /**
   *  ���� ��
   * @param noticeno
   * @return
   */
  // http://localhost:9090/fm/notice/delete.do?noticeno=1
  @RequestMapping(value="/notice/delete.do", 
                            method=RequestMethod.GET)
  public ModelAndView delete(int noticeno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/notice/delete"); // /webapp/notice/delete.jsp
    
    Mem_NoticeVO mem_NoticeVO = noticeProc.read(noticeno);
    mav.addObject("mem_NoticeVO", mem_NoticeVO);
    
    return mav;
  }
  
  /**
   *  ���� ó��
   * @param noticeno
   * @return
   */
  // http://localhost:9090/fm/notice/delete.do?noticeno=1
  @RequestMapping(value="/notice/delete.do", 
                            method=RequestMethod.POST)
  public ModelAndView delete_proc(RedirectAttributes redirectAttributes, 
                                              int noticeno,
                                              @RequestParam(value="word", defaultValue="") String word,
                                              @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();

    int count = noticeProc.delete(noticeno);
    if (count > 0) {
      // -------------------------------------------------------------------------------------
      // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
      HashMap<String, Object> map = new HashMap();
      map.put("word", word);
      if (noticeProc.search_count(map) % Notice.RECORD_PER_PAGE == 0) {
        nowPage = nowPage - 1;
        if (nowPage < 1) {
          nowPage = 1;
        }
      }
      // -------------------------------------------------------------------------------------
    }
    
    redirectAttributes.addAttribute("word", word);
    redirectAttributes.addAttribute("nowPage", nowPage);
    mav.setViewName("redirect:/notice/delete_msg.jsp?count=" + count);
    
    return mav;
  }
  
  /**
   * �˻� ���
   * 
   * @return
   */
  // http://localhost:9090/fm/notice/list_by_search.do
/*  @RequestMapping(value = "/notice/list_by_search.do", method = RequestMethod.GET)
  public ModelAndView list_by_search(String word) {
    ModelAndView mav = new ModelAndView();
 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);
    
    // �˻��� ���ڵ� ���
    List<NoticeVO> list = noticeProc.list_by_search(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = noticeProc.search_count(map);
    mav.addObject("search_count", search_count);
    
    mav.setViewName("/notice/list_by_search"); // /webapp/notice/list_by_search.jsp
 
    return mav;
  }*/
  
  /**
   * ��� + �˻� + ����¡ ����
   * http://localhost:9090/fm/notice/list_by_search_paging.do
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/notice/list_by_search_paging.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_search_paging(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    // �˻� ��� �߰�,  /webapp/notice/list_by_search_paging.jsp
    mav.setViewName("/notice/list_by_search_paging");   
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);       
    
    // �˻� ���
    List<Mem_NoticeVO> list = noticeProc.list_by_search_paging(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = noticeProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     * 
     * @param listFile ��� ���ϸ� 
     * @param categoryno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = noticeProc.pagingBox("list_by_search_paging.do", search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }    
}
