package dev.mvc.qna;

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
import java.util.StringTokenizer;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class QnaCont {
  @Autowired
  @Qualifier("dev.mvc.qna.QnaProc")
  private QnaProcInter qnaProc=null;
  
  public QnaCont () {
    System.out.println("--> team1.QnaCont created.");
  }
  
  /**
   * 등록 폼 http://localhost:9090/fm/qna/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/qna/create"); // /webapp/qna/create.jsp
 
    return mav;
  }

  /**
   * 등록 처리
   * 
   * 파일 태그의 연결
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ↓
   * private List<MultipartFile> filesMF;
   * 
   * @param request
   * @param qnaVO
   * @return
   */
  @RequestMapping(value = "/qna/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, 
                                        QnaVO qnaVO) {
    // System.out.println("--> create() POST executed");
    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/qna/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = qnaVO.getFilesMF(); 
 
    // System.out.println("--> filesMF.get(0).getSize(): " +
    // filesMF.get(0).getSize());
 
    String files = "";        // DBMS 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String filesizes = "";       // DBMS 컬럼에 저장할 파일 크기
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
            filesizes = filesizes + "/" + sizes_item;
            // 미니 이미지를 조합하여 하나의 컬럼에 저장
            thumbs = thumbs + "/" + thumbs_item;
            
          // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
          } else if (multipartFile.getSize() > 0) { 
            files = files_item; // file1.jpg
            filesizes = "" + sizes_item; // 123456
            thumbs = thumbs_item; // file1_t.jpg
          }
        } // if (multipartFile.getSize() > 0) {  END 
      } // END for
    } 
    qnaVO.setFiles(files);
    qnaVO.setFilesizes(filesizes);
    qnaVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    count = qnaProc.create(qnaVO);

    mav.setViewName(
        "redirect:/qna/create_msg.jsp?count=" + count); // /webapp/qna/create_msg.jsp
 
    return mav;
  }

  /**
   * 전체 목록
   * 
   * @return
   */
  // http://localhost:9090/fm/qna/list.do
  @RequestMapping(value = "/qna/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
 
    ArrayList<Mem_QnaVO> list = qnaProc.list();
    mav.addObject("list", list);

    mav.setViewName("/qna/list"); // /webapp/qna/list.jsp
 
    return mav;
  }
  
  /**
   * 조회
   * 
   * @param qnano
   * @return
   */
  @RequestMapping(value = "/qna/read.do", method = RequestMethod.GET)
  public ModelAndView read(int qnano) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/qna/read"); // /webapp/qna/read.jsp

    Mem_QnaVO mem_QnaVO = qnaProc.read(qnano);
    mav.addObject("mem_QnaVO", mem_QnaVO);
    
    ArrayList<QnaFileVO> file_list = qnaProc.getThumbs(mem_QnaVO);

    mav.addObject("file_list", file_list);
    return mav;
  }
  
  // ZIP 압축 후 파일 다운로드 
  @RequestMapping(value = "/qna/download.do", method = RequestMethod.GET)
  public ModelAndView download(HttpServletRequest request, int qnano) {
    ModelAndView mav = new ModelAndView();

    Mem_QnaVO mem_QnaVO = qnaProc.read(qnano);
    
    String files = mem_QnaVO.getFiles();
    String[] files_array = files.split("/");
    
    String dir = "/qna/storage";
    String upDir = Tool.getRealPath(request, dir); // 절대 경로 산출
    
    // 다운로드되는 파일, 파일명을 지정하거나 날짜 조합
    String zip = Tool.getDateRand() + ".zip";  // 20190522102114933.zip
    String zip_filename = upDir + zip; // 압축파일이 생성될 폴더 지정
    
    String[] zip_src = new String[files_array.length]; // 파일 갯수만큼 배열 선언
    
    for (int i=0; i < files_array.length; i++) {
      zip_src[i] = upDir + "/" + files_array[i]; // 절대 경로가 조합된 파일 저장      
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
        System.out.println(zip_filename + " 압축 파일 생성.");
      }
      
//      if (file.delete() == true) {
//        System.out.println(zip_filename + " 파일을 삭제했습니다.");
//      }

    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }
 
    // download 서블릿 연결
    mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);  

    return mav;
  }
  
  /**
  * 수정 폼 http://localhost:9090/fm/qna/update.do
  * 
  * @return
  */
 @RequestMapping(value = "/qna/update.do", method = RequestMethod.GET)
 public ModelAndView update(int qnano) {
   ModelAndView mav = new ModelAndView();
   
   Mem_QnaVO mem_QnaVO = qnaProc.read(qnano);
   mav.addObject("mem_QnaVO", mem_QnaVO);
   
   ArrayList<QnaFileVO> file_list = qnaProc.getThumbs(mem_QnaVO);
   mav.addObject("file_list", file_list);
   
   mav.setViewName("/qna/update"); // /webapp/qna/update.jsp

   return mav;
 }

 /**
  * - 글만 수정하는 경우
  * - 파일만 수정하는 경우
  * - 글과 파일을 동시에 수정하는 경우
  * 
  * @param request
  * @param qnaVO
  * @return
  */
 @RequestMapping(value = "/qna/update.do", method = RequestMethod.POST)
 public ModelAndView update(RedirectAttributes redirectAttributes, 
                                        HttpServletRequest request, 
                                        QnaVO qnaVO) {
   ModelAndView mav = new ModelAndView();

   // -------------------------------------------------------------------
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/qna/storage");
   // Spring이 File 객체를 저장해둠.
   List<MultipartFile> filesMF = qnaVO.getFilesMF(); 
    
   String files = ""; // 컬럼에 저장할 파일명
   String files_item = ""; // 하나의 파일명
   String filesizes = "";
   long sizes_item = 0; // 하나의 파일 사이즈
   String thumbs = ""; // Thumb 파일들
   String thumbs_item = ""; // 하나의 Thumb 파일명

   int count = filesMF.size(); // 업로드된 파일 갯수

   // 기존의 등록 정보 조회
   Mem_QnaVO qnaVO_old = qnaProc.read(qnaVO.getQnano());
   
   if (filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
     if (qnaVO_old.getFiles() != null) {
     // thumbs 파일 삭제
     String thumbs_old = qnaVO_old.getQnathumb();
     StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
     while (thumbs_st.hasMoreTokens()) {
       String fname = upDir + thumbs_st.nextToken();
       Tool.deleteFile(fname);
     }

     // 원본 파일 삭제
     String files_old = qnaVO_old.getFiles();
     StringTokenizer files_st = new StringTokenizer(files_old, "/");
     while (files_st.hasMoreTokens()) {
       String fname = upDir + files_st.nextToken();
       Tool.deleteFile(fname); // 기존에 등록된 원본 파일 삭제
     }
     }
     // --------------------------------------------
     // 새로운 파일의 등록 시작
     // --------------------------------------------
     // for (MultipartFile multipartFile: filesMF) {
     for (int i = 0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i); // 0 ~
       System.out.println("multipartFile.getName(): " + multipartFile.getName());

       // if (multipartFile.getName().length() > 0) { // 전송파일이 있는지 체크, filesMF
       if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
         // System.out.println("전송 파일이 있습니다.");
         files_item = Upload.saveFileSpring(multipartFile, upDir);
         sizes_item = multipartFile.getSize();

         if (Tool.isImage(files_item)) {
           thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지
                                                                   // 생성
         }

         if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
           // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
           filesizes = filesizes + "/" + sizes_item;
           // 미니 이미지를 조합하여 하나의 컬럼에 저장
           thumbs = thumbs + "/" + thumbs_item;
         } else if (multipartFile.getSize() > 0) { // 파일이 없어도 파일 객체가 1개 생성됨으로
                                                   // 크기 체크
           files = files_item; // file1.jpg
           filesizes = "" + sizes_item; // 123456
           thumbs = thumbs_item; // file1_t.jpg
         }

       }
     } // for END
     // --------------------------------------------
     // 새로운 파일의 등록 종료
     // --------------------------------------------

   } else { // 글만 수정하는 경우, 기존의 파일 정보 재사용
     if(qnaVO_old.getFiles() != null) {
       files = qnaVO_old.getFiles();
       filesizes = qnaVO_old.getFilesizes();
       thumbs = qnaVO_old.getQnathumb();
     }
   }
   qnaVO.setFiles(files);
   qnaVO.setFilesizes(filesizes);
   qnaVO.setThumbs(thumbs);

   qnaVO.setMemberno(1); // 회원 개발후 session으로 변경

   count = qnaProc.update(qnaVO); //DBMS 수정
   
   //redirect:/qna/update_msg.jsp

   redirectAttributes.addAttribute("count", count); // redirect param 적용?

   // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
   redirectAttributes.addAttribute("qnano", qnaVO.getQnano());

   mav.setViewName("redirect:/qna/update_msg.jsp");

   return mav;

 }


  /**
   * 삭제 폼 
   * http://localhost:9090/fm/qna/delete.do?qnano=1
   * 
   * @return
   */
  @RequestMapping(value = "/qna/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int qnano) {
    ModelAndView mav = new ModelAndView();
    
/*    Categrp_CateVO categrp_CateVO = cateProc.read_by_join(cateno);
    mav.addObject("categrp_CateVO", categrp_CateVO);*/
    
    Mem_QnaVO mem_QnaVO = qnaProc.read(qnano);
    mav.addObject("mem_QnaVO", mem_QnaVO);
    
    // ArrayList<FileVO> file_list = contentsProc.getThumbs(contentsVO);
    // mav.addObject("file_list", file_list);
    
    mav.setViewName("/qna/delete"); // /webapp/qna/delete.jsp
 
    return mav;
  }
  

  /**
   * 삭제
   * @param request
   * @param qnaVO
   * @return
   */
  @RequestMapping(value = "/qna/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int qnano) {
    ModelAndView mav = new ModelAndView();
 
    String upDir = Tool.getRealPath(request, "/qna/storage");

    // 기존의 등록 정보 조회
    Mem_QnaVO qnaVO_old = qnaProc.read(qnano);
    
    if(qnaVO_old.getFiles() != null) {
      String thumbs_old = qnaVO_old.getQnathumb();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
      }
 
      // 원본 파일 삭제
      String files_old = qnaVO_old.getFiles();
      StringTokenizer files_st = new StringTokenizer(files_old, "/");
      while (files_st.hasMoreTokens()) {
        String fname = upDir + files_st.nextToken();
        Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
      }
    }
 
    int count = qnaProc.delete(qnano);
 
    // mav.setViewName("redirect:/qna/delete_msg.jsp?count=" + count + "&...);
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
    redirectAttributes.addAttribute("qnano", qnano);
    redirectAttributes.addAttribute("title", qnaVO_old.getTitle());
    
    mav.setViewName("redirect:/qna/delete_msg.jsp");
 
    return mav;
 
  }
  
  /**
   * 답변 폼 http://localhost:9090/fm/qna/reply.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/reply.do", method = RequestMethod.GET)
  public ModelAndView reply(int qnano) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("답변 대상: " + qnano);
    Mem_QnaVO mem_QnaVO = qnaProc.read(qnano);
    mav.addObject("mem_QnaVO", mem_QnaVO);
    
    mav.setViewName("/qna/reply"); // /webapp/qna/reply.jsp
 
    return mav;
  }
  
  /**
   * 답변 처리
   * 
   * 파일 태그의 연결
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ↓
   * private List<MultipartFile> filesMF;
   * 
   * @param request
   * @param qnaVO
   * @return
   */
  @RequestMapping(value = "/qna/reply.do", method = RequestMethod.POST)
  public ModelAndView reply(HttpServletRequest request, QnaVO qnaVO) {
    // System.out.println("--> reply() POST executed");
    ModelAndView mav = new ModelAndView();
 
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/qna/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = qnaVO.getFilesMF(); 
 
    String files = "";        // DBMS 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String filesizes = "";       // DBMS 컬럼에 저장할 파일 크기
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
            filesizes = filesizes + "/" + sizes_item;
            // 미니 이미지를 조합하여 하나의 컬럼에 저장
            thumbs = thumbs + "/" + thumbs_item;
            
          // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
          } else if (multipartFile.getSize() > 0) { 
            files = files_item; // file1.jpg
            filesizes = "" + sizes_item; // 123456
            thumbs = thumbs_item; // file1_t.jpg
          }
        } // if (multipartFile.getSize() > 0) {  END
      } // END for
    }
    qnaVO.setFiles(files);
    qnaVO.setFilesizes(filesizes);
    qnaVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    // 회원 개발 후 session 으로변경
    // int mno = (Integer)session.getAttribute("mno");
    qnaVO.setMemberno(1);
    
    // --------------------------- 답변 관련 코드 시작 --------------------------
    Mem_QnaVO parentVO = qnaProc.read(qnaVO.getQnano()); // 부모글 정보 추출
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("grpno", parentVO.getGrpno());
    map.put("ansnum", parentVO.getAnsnum());
    qnaProc.increaseAnsnum(map); // 현재 등록된 답변 뒤로 +1 처리함.
 
    qnaVO.setGrpno(parentVO.getGrpno()); // 부모의 그룹번호 할당
    qnaVO.setIndent(parentVO.getIndent() + 1); // 답변 차수 증가
    qnaVO.setAnsnum(parentVO.getAnsnum() + 1); // 부모 바로 아래 등록
    // --------------------------- 답변 관련 코드 종료 --------------------------
 
    count = qnaProc.reply(qnaVO);

    mav.setViewName("redirect:/qna/reply_msg.jsp?count=" + count); // /webapp/qna/reply_msg.jsp
 
    return mav;
  }
  
}
