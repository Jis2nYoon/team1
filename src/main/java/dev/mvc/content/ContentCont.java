package dev.mvc.content;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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

import dev.mvc.cate.CateProcInter;
import dev.mvc.cate.CateVO;
import dev.mvc.grade.GradeProcInter;
import dev.mvc.grade.GradeVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.reply.ReplyVO;
import dev.mvc.reply.ReplyProcInter;

import nation.web.tool.Tool;
import nation.web.tool.Upload;


@Controller
public class ContentCont {
  @Autowired
  @Qualifier("dev.mvc.grade.GradeProc")
  private GradeProcInter gradeProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc")
  private ReplyProcInter replyProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.content.ContentProc")
  private ContentProcInter contentProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.cate.CateProc")
  private CateProcInter cateProc = null;
 
//http://localhost:9090/team1/content/create.do?cateno=1
  /**
   * 등록 FORM
   * @param cateno
   * @param memberno
   * @return
   */
@RequestMapping(value="/content/create.do", method=RequestMethod.GET)
public ModelAndView create(int cateno, HttpSession session) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/content/create"); 
  int memberno=0;
  if (memberProc.isMember(session)) { // 로그인 되어있는 경우
    memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
  } else { // 로그인이 되어 있지 않은 경우
    mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
    return mav;
  }
  
  mav.addObject("cateno", cateno);
  mav.addObject("memberno", memberno);

  return mav;
}
/**
 * 등록 처리 POST
 * 
 * 파일 태그의 연결
 * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
 * ↓
 * private List<MultipartFile> filesMF;
 * 
 * @param request
 * @param contentsVO
 * @return
 */
 // http://localhost:9090/team1/content/create.do
 @RequestMapping(value="/content/create.do", method=RequestMethod.POST)
 public ModelAndView create(HttpServletRequest request, ContentVO contentVO) {
   ModelAndView mav = new ModelAndView();
   // -------------------------------------------------------------------
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/content/storage");
   // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
   List<MultipartFile> filesMF = contentVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String files = "";        // DBMS 컬럼에 저장할 파일명
   String files_item = ""; // 하나의 파일명
   String sizes = "";       // DBMS 컬럼에 저장할 파일 크기
   long sizes_item = 0;   // 하나의 파일 사이즈
   //String thumbs = "";    // DBMS 컬럼에 저장할 Thumb 파일들
   //String thumbs_item = ""; // 하나의 Thumb 파일명

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
           //Tool.preview(String upDir, String _src, int width, int height)
           Tool.preview(upDir, files_item, 500, 350); // Thumb 이미지 생성
          // 축소 이미지 조합 /upDir/mt_t.jpg  
         }

         // 1개 이상의 다중 파일 처리
         if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
           // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
           sizes = sizes + "/" + sizes_item;
           // 미니 이미지를 조합하여 하나의 컬럼에 저장
           //thumbs = thumbs + "/" + thumbs_item;
           //썸네일은 그냥 이용할때 filename+"_t" 이런식으로 뒤에 붙여서 쓰는걸로 함.
           
         // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
         } else if (multipartFile.getSize() > 0) { 
           files = files_item; // file1.jpg
           sizes = "" + sizes_item; // 123456
           //thumbs = thumbs_item; // file1_t.jpg
         }
       } // if (multipartFile.getSize() > 0) {  END
     } // END for
   }
   contentVO.setPicture(files);
   contentVO.setPicsize(sizes);
   //contentVO.setThumbs(thumbs);
   // -------------------------------------------------------------------
   // 파일 전송 코드 종료
   // -------------------------------------------------------------------
   
   count = contentProc.create(contentVO);
   if (count == 1) {
     cateProc.cnt_inc(contentVO.getCateno()); // 글수 증가
   }
   mav.setViewName("redirect:/content/create_msg.jsp?count="+count); 
   
   return mav;
 }

 //http://localhost:9090/team1/content/list_cono_desc.do
 /**
  * 관리자-컨텐츠 관리 List
  * contentno 내림차순 Join 목록
  * @return
  */
  @RequestMapping(value="/content/list_cono_desc.do", method=RequestMethod.GET)
  public ModelAndView list(@RequestParam(value="cateno", defaultValue="0") int cateno, 
                                      @RequestParam(value="word", defaultValue="") String word, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      if (!memberProc.isMaster(session)) { // 마스터계정이 아닌 경우
        //관리자만 접근 할 수 있습니다. 라고 적힌 메세지 페이지로 이동
        return mav;
      }
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
    } else { // 로그인이 되어 있지 않은 경우
      mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
      return mav;
    }
    mav.setViewName("/content/list_all_content"); //list_all_content.jsp 
    //HashMap 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);
    
    ArrayList<Cate_ContentVO> list = contentProc.search_list_all(map);
    mav.addObject("list", list);
    
    mav.addObject("memberno", memberno);
    return mav;
  }
  /**
   * Grid List
   * contentno 내림차순 Join 목록
   * @return
   */
   @RequestMapping(value="/content/list_all_desc.do", method=RequestMethod.GET)
   public ModelAndView list_all(@RequestParam(value="cateno", defaultValue="0") int cateno, @RequestParam(value="word", defaultValue="") String word, HttpSession session) {
     ModelAndView mav = new ModelAndView();
     int memberno=0;
     if (memberProc.isMember(session)) { // 로그인 되어있는 경우
       memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
     } else { // 로그인이 되어 있지 않은 경우
       //mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
       //return mav;
       //로그인이 되어있지 않아도 물품 전체 목록은 볼 수 있다.
     }
     mav.setViewName("/content/grid_list"); //grid_list.jsp 
     //HashMap 
     HashMap<String, Object> map = new HashMap<String, Object>();
     map.put("word", word);
     
     ArrayList<Cate_ContentVO> list = contentProc.search_list_all(map);
     mav.addObject("list", list);
   
     //mav.addObject("memberno", memberno);
     HashMap<Integer, Object> nickmap = new HashMap<>();
     
     String nickname;
     for(int i = 0; i < list.size(); i++){
       memberno = list.get(i).getMemberno();
       nickname = memberProc.nick_select(memberno);
       nickmap.put(memberno, nickname);
     }
     
     mav.addObject("nickmap", nickmap);
     
     //해당 글의 댓글 개수 전달
     HashMap<Integer, Integer> replycnt = new HashMap<>();
     int reply;
     int contentsno;
     for(int i = 0; i < list.size(); i++){
       contentsno = list.get(i).getContentsno();
       reply = replyProc.count_all(contentsno);
       replycnt.put(contentsno, reply);
     }
     mav.addObject("replycnt", replycnt);
     
     return mav;
   }
  /**
   * 카테고리 별 contentsno 내림차순 정렬 Cate_ContentVO
   * @return
   */
   @RequestMapping(value="/content/list_by_cate_desc.do", method=RequestMethod.GET)
   public ModelAndView list_by_cate(@RequestParam(value="cateno", defaultValue="1") int cateno, @RequestParam(value="word", defaultValue="") String word, HttpSession session) {
     ModelAndView mav = new ModelAndView();
     int memberno=0;
     if (memberProc.isMember(session)) { // 로그인 되어있는 경우
       memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
     } else { // 로그인이 되어 있지 않은 경우
       mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
       return mav;
     }
     mav.setViewName("/content/list_by_cate_desc"); //list_by_cate_desc.jsp 

     //HashMap 
     HashMap<String, Object> map = new HashMap<String, Object>();
     map.put("cateno", cateno);
     map.put("word", word);
     
     CateVO cateVO = cateProc.read(cateno);
     
     mav.addObject("catename", cateVO.getCatename());
     
     ArrayList<ContentVO> list = contentProc.search_list_by_cateno(map);
     mav.addObject("list", list);
     
     
     return mav;
   }
   
 //http://localhost:9090/team1/content/read.do?contentsno=1
   /**
    * 글 조회
    * @param contentsno
    * @param memberno
    * @return
    */
 @RequestMapping(value="/content/read.do", method=RequestMethod.GET)
 public ModelAndView read(int contentsno, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // 로그인 되어있는 경우
     memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
   } else { // 로그인이 되어 있지 않은 경우
     //mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
     //return mav;
     //비회원도 글 확인은 가능하도록 한다.
   }
   mav.setViewName("/content/read");
   //해당 글 조회수 증가
   int viewcount = contentProc.views(contentsno);
   //System.out.println(viewcount);
   //조회한 글 정보 전달
   ContentVO contentVO = contentProc.read(contentsno);
   //System.out.println(contentVO.getViews());
   mav.addObject("contentVO", contentVO);
   
   //회원번호 닉네임
   String nickname = memberProc.nick_select(contentVO.getMemberno());
   mav.addObject("nickname", nickname);
   
   //카테고리 이름 전달
   mav.addObject("catename", cateProc.read(contentVO.getCateno()).getCatename());
   //파일 이름 리스트 전달
   ArrayList<FileVO> file_list = contentProc.getThumbs(contentVO);
   mav.addObject("file_list", file_list);
   
   //해당 글의 댓글 개수 전달
   int replycnt = replyProc.count_all(contentsno);
   mav.addObject("replycnt", replycnt);
   //해당 글의 댓글 목록 전달
   ArrayList<ReplyVO> replylist  = replyProc.list(contentsno);
   mav.addObject("replylist", replylist);
   
   // 글쓴이의 회원 사진 및 정보
   MemberVO memberVO = memberProc.read(contentVO.getMemberno());
   //memberno, email, passwd, thumbs, photo,sizes, nickname, mname, tel, zipcode,address1, address2, act, stopdate, mdate
   
   String thumbs = memberVO.getThumbs();
   String photo = memberVO.getPhoto();
   
   mav.addObject("thumbs", thumbs);
   mav.addObject("photo", photo);
   
   GradeVO gradeVO = gradeProc.read(contentVO.getMemberno());
   
   mav.addObject("gradeVO", gradeVO);
   
   return mav;
 }
   
//http://localhost:9090/team1/content/update.do?contentsno=1
  /**
   * 글 수정 FORM
   * @param contentno
   * @param memberno
   * @return
   */
@RequestMapping(value="/content/update.do", method=RequestMethod.GET)
public ModelAndView update(int contentsno, HttpSession session) {
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // 로그인 되어있는 경우
    memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
  } else { // 로그인이 되어 있지 않은 경우
    mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
    return mav;
    //비회원은 글 수정 불가능
  }
  mav.setViewName("/content/update");
  
  //회원번호 전달
  mav.addObject("memberno", memberno);
  
  //카테고리 목록 전달
  ArrayList<CateVO> list = cateProc.list_seqno_asc();
  mav.addObject("list_category", list);
  
  
  ContentVO contentVO = contentProc.read(contentsno);
  mav.addObject("contentVO", contentVO);

  ArrayList<FileVO> file_list = contentProc.getThumbs(contentVO);
  mav.addObject("file_list", file_list);
  
  return mav;
}
/**
 * file 한개 삭제 후 SQL업데이트
 * @param memberno  회원번호 유지
 * @param contentVO   방금 전 페이지에서 수정하고 있던 내용 그대로 복사
 * @param filename   삭제할 파일 이름
 * @return
 */
@RequestMapping(value="/content/deletefile.do", method=RequestMethod.GET)
public ModelAndView deletefile(HttpServletRequest request, HttpSession session, int contentsno, String filename) { 
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // 로그인 되어있는 경우
    memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
  } else { // 로그인이 되어 있지 않은 경우
    mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
    return mav;
    //비회원은 글 수정 불가능
  }
  ContentVO contentVO = contentProc.read(contentsno);
  String upDir = Tool.getRealPath(request, "/content/storage");
  String files = contentVO.getPicture();          // xmas01_2.jpg/xmas02_2.jpg...
  String sizes = contentVO.getPicsize();        // 272558/404087... 
  
  String[] files_array_old = files.split("/");   // 파일명 추출
  String[] sizes_array_old = sizes.split("/"); // 파일 사이즈
  String[] files_new;
  String[] sizes_new;
  //-------------------------------------------------------------------
  //실제 파일 삭제 작업 시작
  //-------------------------------------------------------------------
  ArrayList<FileVO> file_list = contentProc.getThumbs(contentVO);

  //Iterator를 쓰면 편하겠지만 속도를 위해 그냥 size를 쓰기로 함.
  int i = 0;
  int index = Content.file_not_exist;
  for(; i < file_list.size(); i++){
    String file_old= file_list.get(i).getFile();
    String thumb_old = file_list.get(i).getThumb();
    if(file_old.equals(filename)){//file명이 일치하면 삭제
      Tool.deleteFile(upDir + file_old);// 기존에 등록된 file 삭제
      Tool.deleteFile(upDir + thumb_old);// 기존에 등록된 thumb 삭제
      index = i;
    }
  }
  if(index != Content.file_not_exist){
    //list에서 파일 삭제
    file_list.remove(index); 
    
    //String배열 새로 생성
    files_new = new String[file_list.size()];
    sizes_new = new String[file_list.size()];
    for(int k = 0; k <= file_list.size(); k++){
      //System.out.println(files_array_old[k]);
      //System.out.println(sizes_array_old[k]);
      if(k < index){
        files_new[k] = files_array_old[k];
        sizes_new[k] = sizes_array_old[k];
      } else if(k > index){
        files_new[k-1] = files_array_old[k];
        sizes_new[k-1] = sizes_array_old[k];
      }
    }
    //새로운 파일 리스트 String 생성
    String picture_new = "";
    String picsize_new = "";
    
    for(int j = 0; j< file_list.size(); j++){
      if(j == file_list.size()-1){
        picture_new = picture_new + files_new[j];
        picsize_new = picsize_new + sizes_new[j];
      } else { 
        picture_new = picture_new + files_new[j] + "/";
        picsize_new = picsize_new + sizes_new[j] + "/";
      }
    }
    //System.out.println("파일 리스트2: " + picture_new);
    //System.out.println("크기 리스트2: " + picsize_new);
    
    //새로운 파일 리스트로 contentVO에 갱신
    contentVO.setPicture(picture_new);
    contentVO.setPicsize(picsize_new);
    
  }  
  //-------------------------------------------------------------------
  //실제 파일 삭제 작업 끝
  //-------------------------------------------------------------------
  
  //SQL 업데이트 
  contentProc.deletefile(contentVO);//말이 delete지 updatesql임

  //회원번호 전달
  mav.addObject("memberno", memberno);
  //회원번호 전달
  mav.addObject("contentsno", contentsno);
  //update.do get 호출
  mav.setViewName("redirect:/content/update.do");
  return mav;
}
/**
 * - 글만 수정하는 경우의 구현 
 * - 파일만 수정하는 경우의 구현 
 * - 글과 파일을 동시에 수정하는 경우의 구현
 * 
 * @param request
 * @param contentsVO
 * @return
 */
@RequestMapping(value = "/content/update.do", method = RequestMethod.POST)
public ModelAndView update(HttpServletRequest request, ContentVO contentVO, HttpSession session) {
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // 로그인 되어있는 경우
    memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
  } else { // 로그인이 되어 있지 않은 경우
    mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
    return mav;
    //비회원은 글 수정 불가능
  }
  ContentVO contentVO_old = contentProc.read(contentVO.getContentsno());
  //System.out.println("POST UPDATE " + contentVO.getContentsno());
  //System.out.println("POST UPDATE " +  memberno);
  // -------------------------------------------------------------------
  // 1. 기존 파일 삭제 코드 
  // -------------------------------------------------------------------
  // 이 부분은 파일 한개 삭제 시 마다 deletefile 컨트롤러가 실행완료되어 이미 삭제 되어 있는 상태이므로 작업할 필요 없음.
  // -------------------------------------------------------------------
  // 추가된 파일 전송 코드 시작
  // -------------------------------------------------------------------
  String upDir = Tool.getRealPath(request, "/content/storage");
  // Spring이 File 객체를 저장해둠.
  List<MultipartFile> filesMF = contentVO.getFilesMF(); 

  // System.out.println("--> filesMF.get(0).getSize(): " +
  // filesMF.get(0).getSize());

  String files = contentVO_old.getPicture(); // 컬럼에 저장할 파일명 목록을 기존의 이름으로 가져올것
  String files_item = ""; // 하나의 파일명
  String sizes = contentVO_old.getPicsize(); 
  long sizes_item = 0; // 하나의 파일 사이즈

  if (filesMF != null) {  // 파일 업로드 된게 존재한다면
    int count = filesMF.size(); // 업로드된 파일 갯수
    // --------------------------------------------
    // 새로운 파일의 등록 시작
    // --------------------------------------------
    // for (MultipartFile multipartFile: filesMF) {
    for (int i = 0; i < count; i++) {
      MultipartFile multipartFile = filesMF.get(i); // 0 ~
      //System.out.println("POST UPDATE multipartFile.getName(): " + multipartFile.getName());

    //if (multipartFile.getName().length() > 0) { // 전송파일이 있는지 체크, filesMF
      if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
        //System.out.println("POST UPDATE 전송 파일이 있습니다.");
        files_item = Upload.saveFileSpring(multipartFile, upDir);
        sizes_item = multipartFile.getSize();
        // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
        files = files + "/" + files_item;
        // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
        sizes = sizes + "/" + sizes_item;
        
        if (Tool.isImage(files_item)) { // 이미지인지 검사
          Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지 생성
         // 축소 이미지 조합 /upDir/mt_t.jpg  
        }
      } //  if (multipartFile.getSize() > 0)  END
    } // for END
    // --------------------------------------------
    // 새로운 파일의 등록 종료
    // --------------------------------------------
  } else { // 글만 수정하는 경우, 기존의 파일 정보 재사용
    files = contentVO_old.getPicture();
    sizes = contentVO_old.getPicsize();
  }
  contentVO.setPicture(files);
  //System.out.println("POST UPDATE " + files);
  contentVO.setPicsize(sizes);
  //System.out.println("POST UPDATE " + sizes);
  
  int cnt = contentProc.update(contentVO);  // SQL 작업 DBMS 수정

  // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
  
  //redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
  //redirectAttributes.addAttribute("count", count); // redirect parameter 적용

  //redirectAttributes.addAttribute("contentsno", contentVO.getContentsno());
  //redirectAttributes.addAttribute("cateno", contentVO.getCateno());
  //redirectAttributes.addAttribute("title", contentVO.getTitle());

  //mav.setViewName("redirect:/contents/update_msg.jsp");
  //System.out.println(cnt);
  mav.addObject("count", cnt);
  mav.addObject("memberno", memberno);
  mav.addObject("contentsno", contentVO.getContentsno());
  
  mav.setViewName("redirect:/content/read.do");//read.do -get 

  return mav;
}

/**
 * 삭제 폼 
 * http://localhost:9090/ojt/content/delete.do?cateno=1
 * 
 * @return
 */
@RequestMapping(value = "/content/delete.do", method = RequestMethod.GET)
public ModelAndView delete(HttpSession session, int contentsno) {
  //delete get 페이지에서 회원번호로 본인확인
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // 로그인 되어있는 경우
    memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
  } else { // 로그인이 되어 있지 않은 경우
    mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
    return mav;
    //비회원은 글 삭제 불가능
  }
  ContentVO contentVO = contentProc.read(contentsno);
  mav.addObject("contentVO", contentVO);
  mav.addObject("memberno", memberno);
  mav.setViewName("/content/delete"); // /webapp/contents/delete.jsp

  return mav;
}

/**
 * 삭제
 * @param request
 * @param contentsVO
 * @return
 */
@RequestMapping(value = "/content/delete.do", method = RequestMethod.POST)
public ModelAndView delete(RedirectAttributes redirectAttributes, HttpServletRequest request, int contentsno, HttpSession session) {
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // 로그인 되어있는 경우
    memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
  } else { // 로그인이 되어 있지 않은 경우
    mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
    return mav;
    //비회원은 글 삭제 불가능
  }
  String upDir = Tool.getRealPath(request, "/content/storage");

  // 기존의 등록 정보 조회
  ContentVO contentVO_old = contentProc.read(contentsno);
  
  // 기존의 파일 정보 조회
  ArrayList<FileVO> file_list = contentProc.getThumbs(contentVO_old);

  // 저장되있던 파일들 삭제
  for(int index = 0; index < file_list.size(); index++){
    Tool.deleteFile(upDir + file_list.get(index).getFile());  // 기존에 등록된 원본 파일 삭제
    Tool.deleteFile(upDir + file_list.get(index).getThumb()); // 기존에 등록된 thumbs 파일 삭제
  }

  int count = contentProc.delete(contentsno);
  if (count > 0) {
    cateProc.cnt_dec(contentVO_old.getCateno());  // 글갯수 감소
  }

  // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
  redirectAttributes.addAttribute("count", count); // redirect parameter 적용
  redirectAttributes.addAttribute("contentsno", contentsno);
  redirectAttributes.addAttribute("memberno", memberno);
  redirectAttributes.addAttribute("title", contentVO_old.getTitle());
  //redirectAttributes.addAttribute("nowPage", nowPage);
  
  mav.setViewName("redirect:/content/delete_msg.jsp");

  return mav;

}
  /**
  * 전체 제목, 내용으로 검색
  * @param word 검색어
  * @return
  */
  @RequestMapping(value = "/content/search_list_all.do", method = RequestMethod.GET)
  public ModelAndView search_list_all(@RequestParam(value="word", defaultValue="") String word, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
    } else { // 로그인이 되어 있지 않은 경우
      //mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
      //return mav;
      //비회원도 글 검색은 가능
    }
  //HashMap 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);
    
    // 검색된 레코드 목록
    ArrayList<Cate_ContentVO> list = contentProc.search_list_all(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 개수
    int search_count_all = contentProc.search_count_all(map);
    mav.addObject("search_count", search_count_all);

    mav.addObject("memberno", memberno);

    mav.setViewName("/content/list_all_content"); //list_all_content.jsp 
 
    return mav;
  }
  /**
  * 카테고리별 제목, 내용으로 검색
  * @param cateno 카테고리 번호
  * @param word 검색어
  * @return
  */
  @RequestMapping(value = "/content/search_list_by_cateno.do", method = RequestMethod.GET)
  public ModelAndView search_list_by_cateno(int cateno,@RequestParam(value="word", defaultValue="") String word) {
    ModelAndView mav = new ModelAndView();
    //HashMap 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("cateno", cateno);
    map.put("word", word);
    
    // 검색된 레코드 목록
    ArrayList<ContentVO> list = contentProc.search_list_by_cateno(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 개수
    int search_count_by_cateno = contentProc.search_count_by_cateno(map);
    mav.addObject("search_count", search_count_by_cateno);

    mav.setViewName("/content/list_by_cate_desc"); //list_by_cate_desc.jsp 
 
    return mav;
  }
  /**
   * 전체 검색 + 페이징 +조인
   * @param word
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/content/search_list_all_paging.do", method = RequestMethod.GET)
  public ModelAndView search_list_all_paging(@RequestParam(value="word", defaultValue="") String word,
                                                              @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    //HashMap 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);
    map.put("nowPage", nowPage);       
    
    // 검색된 레코드 목록
    ArrayList<Cate_ContentVO> list = contentProc.search_list_all_paging(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 개수
    int search_count_all = contentProc.search_count_all(map);
    mav.addObject("search_count", search_count_all);
    //mav.setViewName("/content/list_all_content"); //list_all_content.jsp 
    mav.setViewName("/content/grid_list"); //grid_list.jsp 
    /*
     * Bootstrap Paging
     * 
     * @param listFile 목록 파일명 
     * @param categoryno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = contentProc.pagingBox("search_list_all_paging.do", 0, search_count_all, nowPage, word);
    mav.addObject("paging", paging);
    //System.out.println("paging: " + paging);
    mav.addObject("nowPage", nowPage);
 
    return mav;
  }
  /**
   * 카테고리 별 검색된 레코드 목록 + 페이징
   * @param cateno
   * @param word
   * @return
   */
  @RequestMapping(value = "/content/search_list_by_cateno_paging.do", method = RequestMethod.GET)
  public ModelAndView search_list_by_cateno_paging(
                                     @RequestParam(value="cateno", defaultValue="1") int cateno,
                                     @RequestParam(value="word", defaultValue="") String word,
                                     @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    //HashMap 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("cateno", cateno);
    map.put("word", word);
    map.put("nowPage", nowPage);       
    
    
    // 검색된 레코드 목록
    ArrayList<ContentVO> list = contentProc.search_list_by_cateno_paging(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 개수
    int search_count_by_cateno = contentProc.search_count_by_cateno(map);
    mav.addObject("search_count", search_count_by_cateno);

    //mav.setViewName("/content/list_by_cate_desc"); //list_by_cate_desc.jsp 
    mav.setViewName("/content/grid_list"); //grid_list.jsp 
    
    /*
     * Bootstrap Paging
     * 
     * @param listFile 목록 파일명 
     * @param categoryno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = contentProc.pagingBox("search_list_by_cateno_paging.do", cateno, search_count_by_cateno, nowPage, word);
    mav.addObject("paging", paging);
    mav.addObject("nowPage", nowPage);
 
    return mav;
  }
  /**
   * 판매완료 proc
   * http://localhost:9090/team1/content/sale.do?cateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/content/sale.do", method = RequestMethod.GET)
  public ModelAndView sale(HttpSession session, int contentsno, int contmemno) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    int count=0;
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
      if(memberno == contmemno){ // 컨텐츠에 등록된 회원번호와 세션의 회원번호가 일치한다면 판매완료 작업을 수행
        count = contentProc.sale(contentsno);
      }
    } else { // 세션이 풀려서 로그인이 되어 있지 않은 경우
      //작업하지 않음.
      //mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
      //return mav;
      //본인만 판매완료 가능
    }
    mav.setViewName("redirect:/content/read.do?contentsno="+contentsno);

    return mav;
  }
  
//ZIP 압축 후 파일 다운로드 
 @RequestMapping(value = "/content/download.do", method = RequestMethod.GET)
 public ModelAndView download(HttpServletRequest request, int contentsno) {
   ModelAndView mav = new ModelAndView();

   ContentVO contentVO = contentProc.read(contentsno);
   
   String files = contentVO.getPicture(); //micro01.jpg/micro02.jpg/micro03.jpg/micro04.jpg
   String[] files_array = files.split("/");
   
   String dir = "/content/storage";
   String upDir = Tool.getRealPath(request, dir);
   
   String zip = "download_" + contentsno + "_files.zip";
   String zip_filename = upDir + zip;
   
   String[] zip_src = new String[files_array.length]; // 파일 갯수만큼 배열 선언
   
   for (int i=0; i < files_array.length; i++) {
     zip_src[i] = upDir + "/" + files_array[i]; // 절대 경로 조합      
   }

   byte[] buffer = new byte[4096]; // 4 KB
   
   try {
     ZipOutputStream zipOutputStream = new ZipOutputStream(new FileOutputStream(zip_filename));
     
     for(int index=0; index < zip_src.length; index++) {
       FileInputStream in = new FileInputStream(zip_src[index]);
       
       Path path = Paths.get(zip_src[index]);
       String zip_src_file = path.getFileName().toString();
       // System.out.println("zip_src_file: " + zip_src_file);
       
       ZipEntry zipEntry = new ZipEntry(zip_src_file);
       zipOutputStream.putNextEntry(zipEntry);
       
       int length = 0;
       // 4 KB씩 읽어서 buffer 배열에 저장후 읽은 바이트수를 length에 저장
       while((length = in.read(buffer)) > 0) {
         zipOutputStream.write(buffer, 0, length); // 기록할 내용, 내용에서의 시작 위치, 기록할 길이
         
       }
       zipOutputStream.closeEntry();
       in.close();
     }
     zipOutputStream.close();
     
     File file = new File(zip_filename);
     
     if (file.exists() && file.length() > 0) {
       System.out.println(zip_filename + "이 압축되어 생성됐습니다.");
     }
     
//     if (file.delete() == true) {
//       System.out.println(zip_filename + " 파일을 삭제했습니다.");
//     }

   } catch (FileNotFoundException e) {
     e.printStackTrace();
   } catch (IOException e) {
     e.printStackTrace();
   }

   // download 서블릿 연결
   mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);    
   
   return mav;
 }
  
}
