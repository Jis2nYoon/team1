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
   * 메시지(쪽지) 전송 폼 
   * http://localhost:9090/fm/msg/create.do?msgreceiver=1
   */
  @RequestMapping(value="/msg/create.do", method=RequestMethod.GET)
  public ModelAndView create(int msgreceiver, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0; // 로그인 되어 있는 나의 회원 번호
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
    } else { // 로그인이 되어 있지 않은 경우
      mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
      return mav;
      //비회원은 글 삭제 불가능
    }
    String nickname = memberProc.nick_select(msgreceiver); // 받는 사람
    mav.addObject("nickname", nickname);
    
    // -------------------------------------------------------------------
    // session 세션 저장
    // -------------------------------------------------------------------
    session.getAttribute("memberno"); //보내는 사람
    // session 내부 객체
      
    mav.setViewName("/msg/create"); // /webapp/msg/create.jsp
    
    return mav;
  }
  
  /**
   * 메시지(쪽지) 전송 처리
   * 
   * 파일 태그의 연결
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ↓
   * private List<MultipartFile> filesMF;
   * 
   */
  @RequestMapping(value="/msg/create.do", method=RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, MsgVO msgVO) {
    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/msg/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = msgVO.getFilesMF(); 
 
    // System.out.println("--> filesMF.get(0).getSize(): " +
    // filesMF.get(0).getSize());
 
    String files = "";        // DBMS 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String sizes = "";       // DBMS 컬럼에 저장할 파일 크기
    long sizes_item = 0;   // 하나의 파일 사이즈
    String thumbs = "";    // DBMS 컬럼에 저장할 Thumb 파일들
    String thumbs_item = ""; // 하나의 Thumb 파일명
 
    int count = filesMF.size(); // 업로드된 파일 갯수
 
    // Spring은 파일 선택을 안해도 1개의 MultipartFile 객체가 생성됨.
    // System.out.println("--> 업로드된 파일 갯수 count: " + count);
 
    if (count > 0) { // 전송 파일이 존재한다면
      // for (MultipartFile multipartFile: filesMF) {
      for (int i = 0; i < count; i++) {
        MultipartFile multipartFile = filesMF.get(i); // 0: 첫번째 파일, 1:두번째 파일 ~
        // System.out.println("multipartFile.getName(): " + multipartFile.getName());
 
        if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
          // System.out.println("전송 파일이 있습니다.");
          files_item = Upload.saveFileSpring(multipartFile, upDir); // 서버에 파일 저장
          sizes_item = multipartFile.getSize(); // 서버에 저장된 파일 크기
 
          if (Tool.isImage(files_item)) { // 이미지인지 검사
            thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지 생성
          }
 
          // 1개 이상의 다중 파일 처리
          if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
            // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
            files = files + "/" + files_item;
            // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // 미니 이미지를 조합하여 하나의 컬럼에 저장
            thumbs = thumbs + "/" + thumbs_item;
            
          // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
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
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
      
    count = msgProc.create(msgVO);
    // mav.addObject("count", count);
    
    mav.setViewName("redirect:/msg/create_msg.jsp?count=" + count);
    
    return mav;
  }
  
  /**
   * 판매자인경우 목록 (join)?
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
   * 구매자인 경우 목록 (join)
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
   * 보낸 메시지(쪽지) 목록
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
   * 받은 메시지(쪽지) 목록
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
   * 쪽지 1건 읽기
   * @param msgno
   * @return
   */
  @RequestMapping(value="/msg/read_msg.do", method=RequestMethod.GET)
  public ModelAndView read_msg(int msgno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/msg/read_msg"); // webapp/msg/read_msg.jsp
    
    MsgVO msgVO = msgProc.read_msg(msgno);
    mav.addObject("msgVO", msgVO);
      
    // 세션 값 
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
   * 쪽지 답장하기
   */
  @RequestMapping(value="/msg/answer.do", method=RequestMethod.GET)
  public ModelAndView answer() {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/msg/answer"); // /webapp/msg/create.jsp
    
    return mav;
  }
  
  /**
   * 메시지(쪽지) 답장 처리
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
   * 한건의 쪽지 삭제
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
    
    // 기존의 등록 정보 조회
    MsgVO msgVO_old = msgProc.read_msg(msgno);
    
      // thumbs 파일 삭제
      String thumbs_old = msgVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname);  // 기존에 등록된 thumbs 파일 삭제
      }
 
      // 원본 파일 삭제
      String files_old = msgVO_old.getFiles();
      StringTokenizer files_st = new StringTokenizer(files_old, "/");
      while (files_st.hasMoreTokens()) {
        String fname = upDir + files_st.nextToken();
        Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
      }
   
    int count = msgProc.delete_msg(msgno);  // int count 생략 삭제 안될시, 찍어볼것!
    
    // ====================================
    // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
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
    
    redirectAttributes.addAttribute("count", count);  // redirect parameter 적용
    
    // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
    redirectAttributes.addAttribute("msgno", msgno);
    redirectAttributes.addAttribute("title", msgVO_old.getMsgtitle());
    redirectAttributes.addAttribute("nowPage", nowPage);
    
    if(check ==1){
      mav.setViewName("redirect:/msg/receive_list_search_paging.do?memberno=" + memberno + "&contentsno=" + contentsno);  // 목록으로 바로 이동
    }
    if(check ==2) {
      mav.setViewName("redirect:/msg/send_list_search_paging.do?memberno=" + memberno + "&contentsno=" + contentsno);  // 목록으로 바로 이동
    }
   
    return mav;
  }
  
  /**
   * 보낸 쪽지 목록 + 검색 + 페이징
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
 
    // 검색된 레코드 갯수
    int search_count = msgProc.search_count(map);
    mav.addObject("search_count", search_count);
    //System.out.println("--> search_count"+ search_count);
    
    String paging = msgProc.pagingBox("send_list_search_paging.do", search_count, nowPage, word, col, contentsno, memberno);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
 
    return mav;
    }
  
  /**
   * 받은 쪽지 목록 + 검색 + 페이징
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
 
    // 검색된 레코드 갯수
    int search_count = msgProc.search_count2(map);
    mav.addObject("search_count", search_count);
    //System.out.println("--> search_count"+ search_count);
    
    String paging = msgProc.pagingBox("receive_list_search_paging.do", search_count, nowPage, word, col, contentsno, memberno);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
 
    return mav;
    }
  
  /**
   * 게시글 안에 모든 쪽지 삭제하기
   * @param contentsno
   * @return
   */
  @RequestMapping(value="/msg/delete_all_msg.do", method=RequestMethod.GET)
  public ModelAndView delete_all_msg(int check, int memberno, int contentsno, int msgsender) {
    ModelAndView mav = new ModelAndView();
   
    msgProc.delete_all_msg(contentsno);  // int count 생략 삭제 안될시, 찍어볼것!
    
    if(check ==1){
      mav.setViewName("redirect:/msg/list_seller.do?msgsender=" + msgsender);  // 목록으로 바로 이동
    }
    if(check ==2) {
      mav.setViewName("redirect:/msg/list_buyer.do?memberno=" + memberno);  // 목록으로 바로 이동
    }
   
    return mav;
  }
}
