package dev.mvc.msg;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.member.MemberProcInter;


import dev.mvc.content.FileVO;
import dev.mvc.content.ContentVO;

import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class MsgCont {
  @Autowired
  @Qualifier("dev.mvc.msg.MsgProc")
  private MsgProcInter msgProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  public MsgCont () {
    System.out.println("--> MsgCont created.");
  }
  
  /**
   * �޽���(����) ���� �� 
   * http://localhost:9090/fm/msg/create.do?msgreceiver=1
   */
  @RequestMapping(value="/msg/create.do", method=RequestMethod.GET)
  public ModelAndView create(int msgreceiver, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0; // �α��� �Ǿ� �ִ� ���� ȸ�� ��ȣ
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
    } else { // �α����� �Ǿ� ���� ���� ���
      mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
      return mav;
      //��ȸ���� �� ���� �Ұ���
    }
    String nickname = memberProc.nick_select(msgreceiver); // �޴� ���
    mav.addObject("nickname", nickname);
    
    // -------------------------------------------------------------------
    // session ���� ����
    // -------------------------------------------------------------------
    session.getAttribute("memberno"); //������ ���
    // session ���� ��ü
      
    mav.setViewName("/msg/create"); // /webapp/msg/create.jsp
    
    return mav;
  }
  
  /**
   * �޽���(����) ���� ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
   * private List<MultipartFile> filesMF;
   * 
   */
  @RequestMapping(value="/msg/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, MsgVO msgVO) {
    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/msg/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = msgVO.getFilesMF(); 
 
    // System.out.println("--> filesMF.get(0).getSize(): " +
    // filesMF.get(0).getSize());
 
    String files = "";        // DBMS �÷��� ������ ���ϸ�
    String files_item = ""; // �ϳ��� ���ϸ�
    String sizes = "";       // DBMS �÷��� ������ ���� ũ��
    long sizes_item = 0;   // �ϳ��� ���� ������
    String thumbs = "";    // DBMS �÷��� ������ Thumb ���ϵ�
    String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
 
    int count = filesMF.size(); // ���ε�� ���� ����
 
    // Spring�� ���� ������ ���ص� 1���� MultipartFile ��ü�� ������.
    // System.out.println("--> ���ε�� ���� ���� count: " + count);
 
    if (count > 0) { // ���� ������ �����Ѵٸ�
      // for (MultipartFile multipartFile: filesMF) {
      for (int i = 0; i < count; i++) {
        MultipartFile multipartFile = filesMF.get(i); // 0: ù��° ����, 1:�ι�° ���� ~
        // System.out.println("multipartFile.getName(): " + multipartFile.getName());
 
        if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
          // System.out.println("���� ������ �ֽ��ϴ�.");
          files_item = Upload.saveFileSpring(multipartFile, upDir); // ������ ���� ����
          sizes_item = multipartFile.getSize(); // ������ ����� ���� ũ��
 
          if (Tool.isImage(files_item)) { // �̹������� �˻�
            thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb �̹��� ����
          }
 
          // 1�� �̻��� ���� ���� ó��
          if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
            // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
            files = files + "/" + files_item;
            // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
            thumbs = thumbs + "/" + thumbs_item;
            
          // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
          } else if (multipartFile.getSize() > 0) { 
            files = files_item; // file1.jpg
            sizes = "" + sizes_item; // 123456
            thumbs = thumbs_item; // file1_t.jpg
          }
        } // if (multipartFile.getSize() > 0) {  END
      } // END for
    }
    msgVO.setFiles(files);
    msgVO.setSizes(sizes);
    msgVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
      
    count = msgProc.create(msgVO);
    // mav.addObject("count", count);
    
    mav.setViewName("redirect:/msg/create_msg.jsp?count=" + count);
    
    return mav;
  }
  
  /**
   * �Ǹ����ΰ�� ��� (join)?
   */
  @RequestMapping(value = "/msg/list_seller.do", method = RequestMethod.GET)
  public ModelAndView list_seller(int msgreceiver) {
    ModelAndView mav = new ModelAndView();
    
 
    ArrayList<ContentVO> list = msgProc.list_seller(msgreceiver);
    mav.addObject("list", list);
    
    //ArrayList<Mem_ContentVO> mem_Content_list = msgProc.read_by_join(contentsno);
    //mav.addObject("mem_Content_list", mem_Content_list);
 
    mav.setViewName("/msg/list_seller"); // /webapp/msg/list_send.jsp
 
    return mav;
  }
  
  /**
   * �������� ��� ��� (join)
   */
  @RequestMapping(value = "/msg/list_buyer.do", method = RequestMethod.GET)
  public ModelAndView list_buyer(int memberno) {
    ModelAndView mav = new ModelAndView();
 
    ArrayList<Mem_ContentVO> list = msgProc.list_buyer(memberno);
    mav.addObject("list", list);
    
    //ArrayList<Mem_ContentVO> mem_Content_list = msgProc.read_by_join(contentsno);
    //mav.addObject("mem_Content_list", mem_Content_list);
 
    mav.setViewName("/msg/list_buyer"); // /webapp/msg/list_buyer.jsp
 
    return mav;
  }
  
  /**
   * ���� �޽���(����) ���
   * http://localhost:9090/fm/msg/list_send.do?memberno=2&contentsno=1
   */
  @RequestMapping(value = "/msg/list_send.do", method = RequestMethod.GET)
  public ModelAndView list_send(int memberno, int contentsno) {
    ModelAndView mav = new ModelAndView();
    
    /*Mem_ContentVO mem_ContentVO = msgProc.read_by_join(contentsno);
    mav.addObject("mem_ContentVO", mem_ContentVO);*/
 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("memberno", memberno);
    map.put("contentsno", contentsno);
    
    ArrayList<Mem_MsgVO> list = msgProc.list_send(map);
    mav.addObject("list", list);
 
    mav.setViewName("/msg/list_send"); // /webapp/msg/list_send.jsp
 
    return mav;
  }
  
  /**
   * ���� �޽���(����) ���
   * http://localhost:9090/fm/msg/list_receive.do?memberno=1&contentsno=1
   */
  @RequestMapping(value = "/msg/list_receive.do", method = RequestMethod.GET)
  public ModelAndView list_receive(int memberno, int contentsno) {
    ModelAndView mav = new ModelAndView();
    
    /*Mem_ContentVO mem_ContentVO = msgProc.read_by_join(contentsno);
    mav.addObject("mem_ContentVO", mem_ContentVO);*/
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("memberno", memberno);
    map.put("contentsno", contentsno);
 
    ArrayList<Mem_MsgVO> list = msgProc.list_receive(map);
    mav.addObject("list", list);
 
    mav.setViewName("/msg/list_receive"); // /webapp/msg/list_receive.jsp
 
    return mav;
  }
 
  /**
   * ���� 1�� �б�
   * @param msgno
   * @return
   */
  @RequestMapping(value="/msg/read_msg.do", method=RequestMethod.GET)
  public ModelAndView read_msg(int msgno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/msg/read_msg"); // webapp/msg/read_msg.jsp
    
    MsgVO msgVO = msgProc.read_msg(msgno);
    mav.addObject("msgVO", msgVO);
      
    // ���� �� 
    int msgreceiver = 1;
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("msgno", msgno);
    map.put("msgreceiver", msgreceiver);
    msgProc.check_msg(map);
    
    int mcnt = msgVO.getMcnt();
    
    Mem_MsgVO mem_MsvVO = new Mem_MsgVO();
    mem_MsvVO.setMcnt(mcnt);
    
    ArrayList<FileVO> file_list = msgProc.getThumbs(msgVO);
    
    mav.addObject("file_list", file_list);
    
    return mav;
  }  
  
  /**
   * ���� �����ϱ�
   */
  @RequestMapping(value="/msg/answer.do", method=RequestMethod.GET)
  public ModelAndView answer() {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/msg/answer"); // /webapp/msg/create.jsp
    
    return mav;
  }
  
  /**
   * �޽���(����) ���� ó��
   */
  @RequestMapping(value="/msg/answer.do", method=RequestMethod.POST)
  public ModelAndView answer(MsgVO msgVO) {
    ModelAndView mav = new ModelAndView();
      
    int count = msgProc.create(msgVO);
    // mav.addObject("count", count);
    
    mav.setViewName("redirect:/msg/answer_msg.jsp?count=" + count);
    
    return mav;
  }
  
  /**
   * �Ѱ��� ���� ����
   * @param msgno
   * @return
   */
  @RequestMapping(value="/msg/delete_msg.do", method=RequestMethod.GET)
  public ModelAndView delete_msg(int msgno, int check, int memberno, int contentsno,
                                              RedirectAttributes redirectAttributes, 
                                              HttpServletRequest request,
                                              @RequestParam(value="word", defaultValue="") String word,
                                              @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    
    String upDir = Tool.getRealPath(request, "/msg/storage");
    
    // ������ ��� ���� ��ȸ
    MsgVO msgVO_old = msgProc.read_msg(msgno);
    
      // thumbs ���� ����
      String thumbs_old = msgVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname);  // ������ ��ϵ� thumbs ���� ����
      }
 
      // ���� ���� ����
      String files_old = msgVO_old.getFiles();
      StringTokenizer files_st = new StringTokenizer(files_old, "/");
      while (files_st.hasMoreTokens()) {
        String fname = upDir + files_st.nextToken();
        Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
      }
   
    int count = msgProc.delete_msg(msgno);  // int count ���� ���� �ȵɽ�, ����!
    
    // ====================================
    // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
    HashMap<String, Object> map = new HashMap<String, Object>();
    
    map.put("word", word);
    map.put("nowPage", nowPage);
    map.put("memberno", memberno);
    map.put("contentsno", contentsno);
    
    if(msgProc.search_count(map) % Msg.RECORD_PER_PAGE == 0) {
      nowPage = nowPage -1;
      if(nowPage < 1) {
        nowPage = 1;
      }
    }
    // ====================================
    
    redirectAttributes.addAttribute("count", count);  // redirect parameter ����
    
    // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
    redirectAttributes.addAttribute("msgno", msgno);
    redirectAttributes.addAttribute("title", msgVO_old.getMsgtitle());
    redirectAttributes.addAttribute("nowPage", nowPage);
    
    if(check ==1){
      mav.setViewName("redirect:/msg/receive_list_search_paging.do?memberno=" + memberno + "&contentsno=" + contentsno);  // ������� �ٷ� �̵�
    }
    if(check ==2) {
      mav.setViewName("redirect:/msg/send_list_search_paging.do?memberno=" + memberno + "&contentsno=" + contentsno);  // ������� �ٷ� �̵�
    }
   
    return mav;
  }
  
  /**
   * ���� ���� ��� + �˻� + ����¡
   * @param cateno
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/msg/send_list_search_paging.do", 
                                       method = RequestMethod.GET)
  public ModelAndView send_list_search_paging(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="col", defaultValue="") String col,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      int contentsno, int memberno
      ) { 
    // System.out.println("--> list_by_cateno() GET called.");
    // System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/msg/send_list_search_paging"); // /webapp/msg/list_send.jsp
 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("memberno", memberno);
    map.put("contentsno", contentsno);
    map.put("word", word);   // #{word}
    map.put("col", col);   // #{col}
    map.put("nowPage", nowPage);  
    
    ArrayList<Mem_MsgVO> list = msgProc.send_list_search_paging(map);
    mav.addObject("list", list);
 
    // �˻��� ���ڵ� ����
    int search_count = msgProc.search_count(map);
    mav.addObject("search_count", search_count);
    //System.out.println("--> search_count"+ search_count);
    
    String paging = msgProc.pagingBox("send_list_search_paging.do", search_count, nowPage, word, col, contentsno, memberno);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
 
    return mav;
    }
  
  /**
   * ���� ���� ��� + �˻� + ����¡
   * @param cateno
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/msg/receive_list_search_paging.do", 
                                       method = RequestMethod.GET)
  public ModelAndView receive_list_search_paging(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="col", defaultValue="") String col,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      int contentsno, int memberno
      ) { 
    // System.out.println("--> list_by_cateno() GET called.");
    // System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/msg/receive_list_search_paging"); // /webapp/msg/list_send.jsp
 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("memberno", memberno);
    map.put("contentsno", contentsno);
    map.put("word", word);   // #{word}
    map.put("col", col);   // #{col}
    map.put("nowPage", nowPage);  
    
    ArrayList<Mem_MsgVO> list = msgProc.receive_list_search_paging(map);
    mav.addObject("list", list);
 
    // �˻��� ���ڵ� ����
    int search_count = msgProc.search_count2(map);
    mav.addObject("search_count", search_count);
    //System.out.println("--> search_count"+ search_count);
    
    String paging = msgProc.pagingBox("receive_list_search_paging.do", search_count, nowPage, word, col, contentsno, memberno);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
 
    return mav;
    }
  
  /**
   * �Խñ� �ȿ� ��� ���� �����ϱ�
   * @param contentsno
   * @return
   */
  @RequestMapping(value="/msg/delete_all_msg.do", method=RequestMethod.GET)
  public ModelAndView delete_all_msg(int check, int memberno, int contentsno, int msgsender) {
    ModelAndView mav = new ModelAndView();
   
    msgProc.delete_all_msg(contentsno);  // int count ���� ���� �ȵɽ�, ����!
    
    if(check ==1){
      mav.setViewName("redirect:/msg/list_seller.do?msgsender=" + msgsender);  // ������� �ٷ� �̵�
    }
    if(check ==2) {
      mav.setViewName("redirect:/msg/list_buyer.do?memberno=" + memberno);  // ������� �ٷ� �̵�
    }
   
    return mav;
  }
}
