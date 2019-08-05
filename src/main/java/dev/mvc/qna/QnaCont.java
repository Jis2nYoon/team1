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
   * ��� �� http://localhost:9090/fm/qna/create.do
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
   * ��� ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/qna/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = qnaVO.getFilesMF(); 
 
    // System.out.println("--> filesMF.get(0).getSize(): " +
    // filesMF.get(0).getSize());
 
    String files = "";        // DBMS �÷��� ������ ���ϸ�
    String files_item = ""; // �ϳ��� ���ϸ�
    String filesizes = "";       // DBMS �÷��� ������ ���� ũ��
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
            filesizes = filesizes + "/" + sizes_item;
            // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
            thumbs = thumbs + "/" + thumbs_item;
            
          // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    count = qnaProc.create(qnaVO);

    mav.setViewName(
        "redirect:/qna/create_msg.jsp?count=" + count); // /webapp/qna/create_msg.jsp
 
    return mav;
  }

  /**
   * ��ü ���
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
   * ��ȸ
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
  
  // ZIP ���� �� ���� �ٿ�ε� 
  @RequestMapping(value = "/qna/download.do", method = RequestMethod.GET)
  public ModelAndView download(HttpServletRequest request, int qnano) {
    ModelAndView mav = new ModelAndView();

    Mem_QnaVO mem_QnaVO = qnaProc.read(qnano);
    
    String files = mem_QnaVO.getFiles();
    String[] files_array = files.split("/");
    
    String dir = "/qna/storage";
    String upDir = Tool.getRealPath(request, dir); // ���� ��� ����
    
    // �ٿ�ε�Ǵ� ����, ���ϸ��� �����ϰų� ��¥ ����
    String zip = Tool.getDateRand() + ".zip";  // 20190522102114933.zip
    String zip_filename = upDir + zip; // ���������� ������ ���� ����
    
    String[] zip_src = new String[files_array.length]; // ���� ������ŭ �迭 ����
    
    for (int i=0; i < files_array.length; i++) {
      zip_src[i] = upDir + "/" + files_array[i]; // ���� ��ΰ� ���յ� ���� ����      
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
        // 4 KB�� �о buffer �迭�� ������ ���� ����Ʈ���� length�� ����
        while((length = in.read(buffer)) > 0) {
          zipOutputStream.write(buffer, 0, length); // ����� ����, ���뿡���� ���� ��ġ, ����� ����
          
        }
        zipOutputStream.closeEntry();
        in.close();
      }
      zipOutputStream.close();
      
      File file = new File(zip_filename);
      
      if (file.exists() && file.length() > 0) {
        System.out.println(zip_filename + " ���� ���� ����.");
      }
      
//      if (file.delete() == true) {
//        System.out.println(zip_filename + " ������ �����߽��ϴ�.");
//      }

    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }
 
    // download ���� ����
    mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);  

    return mav;
  }
  
  /**
  * ���� �� http://localhost:9090/fm/qna/update.do
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
  * - �۸� �����ϴ� ���
  * - ���ϸ� �����ϴ� ���
  * - �۰� ������ ���ÿ� �����ϴ� ���
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
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/qna/storage");
   // Spring�� File ��ü�� �����ص�.
   List<MultipartFile> filesMF = qnaVO.getFilesMF(); 
    
   String files = ""; // �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String filesizes = "";
   long sizes_item = 0; // �ϳ��� ���� ������
   String thumbs = ""; // Thumb ���ϵ�
   String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�

   int count = filesMF.size(); // ���ε�� ���� ����

   // ������ ��� ���� ��ȸ
   Mem_QnaVO qnaVO_old = qnaProc.read(qnaVO.getQnano());
   
   if (filesMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
     if (qnaVO_old.getFiles() != null) {
     // thumbs ���� ����
     String thumbs_old = qnaVO_old.getQnathumb();
     StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
     while (thumbs_st.hasMoreTokens()) {
       String fname = upDir + thumbs_st.nextToken();
       Tool.deleteFile(fname);
     }

     // ���� ���� ����
     String files_old = qnaVO_old.getFiles();
     StringTokenizer files_st = new StringTokenizer(files_old, "/");
     while (files_st.hasMoreTokens()) {
       String fname = upDir + files_st.nextToken();
       Tool.deleteFile(fname); // ������ ��ϵ� ���� ���� ����
     }
     }
     // --------------------------------------------
     // ���ο� ������ ��� ����
     // --------------------------------------------
     // for (MultipartFile multipartFile: filesMF) {
     for (int i = 0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i); // 0 ~
       System.out.println("multipartFile.getName(): " + multipartFile.getName());

       // if (multipartFile.getName().length() > 0) { // ���������� �ִ��� üũ, filesMF
       if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
         // System.out.println("���� ������ �ֽ��ϴ�.");
         files_item = Upload.saveFileSpring(multipartFile, upDir);
         sizes_item = multipartFile.getSize();

         if (Tool.isImage(files_item)) {
           thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb �̹���
                                                                   // ����
         }

         if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
           // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
           filesizes = filesizes + "/" + sizes_item;
           // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
           thumbs = thumbs + "/" + thumbs_item;
         } else if (multipartFile.getSize() > 0) { // ������ ��� ���� ��ü�� 1�� ����������
                                                   // ũ�� üũ
           files = files_item; // file1.jpg
           filesizes = "" + sizes_item; // 123456
           thumbs = thumbs_item; // file1_t.jpg
         }

       }
     } // for END
     // --------------------------------------------
     // ���ο� ������ ��� ����
     // --------------------------------------------

   } else { // �۸� �����ϴ� ���, ������ ���� ���� ����
     if(qnaVO_old.getFiles() != null) {
       files = qnaVO_old.getFiles();
       filesizes = qnaVO_old.getFilesizes();
       thumbs = qnaVO_old.getQnathumb();
     }
   }
   qnaVO.setFiles(files);
   qnaVO.setFilesizes(filesizes);
   qnaVO.setThumbs(thumbs);

   qnaVO.setMemberno(1); // ȸ�� ������ session���� ����

   count = qnaProc.update(qnaVO); //DBMS ����
   
   //redirect:/qna/update_msg.jsp

   redirectAttributes.addAttribute("count", count); // redirect param ����?

   // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
   redirectAttributes.addAttribute("qnano", qnaVO.getQnano());

   mav.setViewName("redirect:/qna/update_msg.jsp");

   return mav;

 }


  /**
   * ���� �� 
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
   * ����
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

    // ������ ��� ���� ��ȸ
    Mem_QnaVO qnaVO_old = qnaProc.read(qnano);
    
    if(qnaVO_old.getFiles() != null) {
      String thumbs_old = qnaVO_old.getQnathumb();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
      }
 
      // ���� ���� ����
      String files_old = qnaVO_old.getFiles();
      StringTokenizer files_st = new StringTokenizer(files_old, "/");
      while (files_st.hasMoreTokens()) {
        String fname = upDir + files_st.nextToken();
        Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
      }
    }
 
    int count = qnaProc.delete(qnano);
 
    // mav.setViewName("redirect:/qna/delete_msg.jsp?count=" + count + "&...);
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
    redirectAttributes.addAttribute("qnano", qnano);
    redirectAttributes.addAttribute("title", qnaVO_old.getTitle());
    
    mav.setViewName("redirect:/qna/delete_msg.jsp");
 
    return mav;
 
  }
  
  /**
   * �亯 �� http://localhost:9090/fm/qna/reply.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/reply.do", method = RequestMethod.GET)
  public ModelAndView reply(int qnano) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("�亯 ���: " + qnano);
    Mem_QnaVO mem_QnaVO = qnaProc.read(qnano);
    mav.addObject("mem_QnaVO", mem_QnaVO);
    
    mav.setViewName("/qna/reply"); // /webapp/qna/reply.jsp
 
    return mav;
  }
  
  /**
   * �亯 ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/qna/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = qnaVO.getFilesMF(); 
 
    String files = "";        // DBMS �÷��� ������ ���ϸ�
    String files_item = ""; // �ϳ��� ���ϸ�
    String filesizes = "";       // DBMS �÷��� ������ ���� ũ��
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
            filesizes = filesizes + "/" + sizes_item;
            // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
            thumbs = thumbs + "/" + thumbs_item;
            
          // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    // ȸ�� ���� �� session ���κ���
    // int mno = (Integer)session.getAttribute("mno");
    qnaVO.setMemberno(1);
    
    // --------------------------- �亯 ���� �ڵ� ���� --------------------------
    Mem_QnaVO parentVO = qnaProc.read(qnaVO.getQnano()); // �θ�� ���� ����
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("grpno", parentVO.getGrpno());
    map.put("ansnum", parentVO.getAnsnum());
    qnaProc.increaseAnsnum(map); // ���� ��ϵ� �亯 �ڷ� +1 ó����.
 
    qnaVO.setGrpno(parentVO.getGrpno()); // �θ��� �׷��ȣ �Ҵ�
    qnaVO.setIndent(parentVO.getIndent() + 1); // �亯 ���� ����
    qnaVO.setAnsnum(parentVO.getAnsnum() + 1); // �θ� �ٷ� �Ʒ� ���
    // --------------------------- �亯 ���� �ڵ� ���� --------------------------
 
    count = qnaProc.reply(qnaVO);

    mav.setViewName("redirect:/qna/reply_msg.jsp?count=" + count); // /webapp/qna/reply_msg.jsp
 
    return mav;
  }
  
}
