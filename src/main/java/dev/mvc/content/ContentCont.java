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
   * ��� FORM
   * @param cateno
   * @param memberno
   * @return
   */
@RequestMapping(value="/content/create.do", method=RequestMethod.GET)
public ModelAndView create(int cateno, HttpSession session) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/content/create"); 
  int memberno=0;
  if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
    memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
  } else { // �α����� �Ǿ� ���� ���� ���
    mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
    return mav;
  }
  
  mav.addObject("cateno", cateno);
  mav.addObject("memberno", memberno);

  return mav;
}
/**
 * ��� ó�� POST
 * 
 * ���� �±��� ����
 * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
 * ��
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
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/content/storage");
   // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
   List<MultipartFile> filesMF = contentVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String files = "";        // DBMS �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String sizes = "";       // DBMS �÷��� ������ ���� ũ��
   long sizes_item = 0;   // �ϳ��� ���� ������
   //String thumbs = "";    // DBMS �÷��� ������ Thumb ���ϵ�
   //String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�

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
           //Tool.preview(String upDir, String _src, int width, int height)
           Tool.preview(upDir, files_item, 500, 350); // Thumb �̹��� ����
          // ��� �̹��� ���� /upDir/mt_t.jpg  
         }

         // 1�� �̻��� ���� ���� ó��
         if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
           // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
           sizes = sizes + "/" + sizes_item;
           // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
           //thumbs = thumbs + "/" + thumbs_item;
           //������� �׳� �̿��Ҷ� filename+"_t" �̷������� �ڿ� �ٿ��� ���°ɷ� ��.
           
         // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
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
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   
   count = contentProc.create(contentVO);
   if (count == 1) {
     cateProc.cnt_inc(contentVO.getCateno()); // �ۼ� ����
   }
   mav.setViewName("redirect:/content/create_msg.jsp?count="+count); 
   
   return mav;
 }

 //http://localhost:9090/team1/content/list_cono_desc.do
 /**
  * ������-������ ���� List
  * contentno �������� Join ���
  * @return
  */
  @RequestMapping(value="/content/list_cono_desc.do", method=RequestMethod.GET)
  public ModelAndView list(@RequestParam(value="cateno", defaultValue="0") int cateno, 
                                      @RequestParam(value="word", defaultValue="") String word, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      if (!memberProc.isMaster(session)) { // �����Ͱ����� �ƴ� ���
        //�����ڸ� ���� �� �� �ֽ��ϴ�. ��� ���� �޼��� �������� �̵�
        return mav;
      }
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
    } else { // �α����� �Ǿ� ���� ���� ���
      mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
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
   * contentno �������� Join ���
   * @return
   */
   @RequestMapping(value="/content/list_all_desc.do", method=RequestMethod.GET)
   public ModelAndView list_all(@RequestParam(value="cateno", defaultValue="0") int cateno, @RequestParam(value="word", defaultValue="") String word, HttpSession session) {
     ModelAndView mav = new ModelAndView();
     int memberno=0;
     if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
       memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
     } else { // �α����� �Ǿ� ���� ���� ���
       //mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
       //return mav;
       //�α����� �Ǿ����� �ʾƵ� ��ǰ ��ü ����� �� �� �ִ�.
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
     
     //�ش� ���� ��� ���� ����
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
   * ī�װ� �� contentsno �������� ���� Cate_ContentVO
   * @return
   */
   @RequestMapping(value="/content/list_by_cate_desc.do", method=RequestMethod.GET)
   public ModelAndView list_by_cate(@RequestParam(value="cateno", defaultValue="1") int cateno, @RequestParam(value="word", defaultValue="") String word, HttpSession session) {
     ModelAndView mav = new ModelAndView();
     int memberno=0;
     if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
       memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
     } else { // �α����� �Ǿ� ���� ���� ���
       mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
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
    * �� ��ȸ
    * @param contentsno
    * @param memberno
    * @return
    */
 @RequestMapping(value="/content/read.do", method=RequestMethod.GET)
 public ModelAndView read(int contentsno, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
     memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
   } else { // �α����� �Ǿ� ���� ���� ���
     //mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
     //return mav;
     //��ȸ���� �� Ȯ���� �����ϵ��� �Ѵ�.
   }
   mav.setViewName("/content/read");
   //�ش� �� ��ȸ�� ����
   int viewcount = contentProc.views(contentsno);
   //System.out.println(viewcount);
   //��ȸ�� �� ���� ����
   ContentVO contentVO = contentProc.read(contentsno);
   //System.out.println(contentVO.getViews());
   mav.addObject("contentVO", contentVO);
   
   //ȸ����ȣ �г���
   String nickname = memberProc.nick_select(contentVO.getMemberno());
   mav.addObject("nickname", nickname);
   
   //ī�װ� �̸� ����
   mav.addObject("catename", cateProc.read(contentVO.getCateno()).getCatename());
   //���� �̸� ����Ʈ ����
   ArrayList<FileVO> file_list = contentProc.getThumbs(contentVO);
   mav.addObject("file_list", file_list);
   
   //�ش� ���� ��� ���� ����
   int replycnt = replyProc.count_all(contentsno);
   mav.addObject("replycnt", replycnt);
   //�ش� ���� ��� ��� ����
   ArrayList<ReplyVO> replylist  = replyProc.list(contentsno);
   mav.addObject("replylist", replylist);
   
   // �۾����� ȸ�� ���� �� ����
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
   * �� ���� FORM
   * @param contentno
   * @param memberno
   * @return
   */
@RequestMapping(value="/content/update.do", method=RequestMethod.GET)
public ModelAndView update(int contentsno, HttpSession session) {
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
    memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
  } else { // �α����� �Ǿ� ���� ���� ���
    mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
    return mav;
    //��ȸ���� �� ���� �Ұ���
  }
  mav.setViewName("/content/update");
  
  //ȸ����ȣ ����
  mav.addObject("memberno", memberno);
  
  //ī�װ� ��� ����
  ArrayList<CateVO> list = cateProc.list_seqno_asc();
  mav.addObject("list_category", list);
  
  
  ContentVO contentVO = contentProc.read(contentsno);
  mav.addObject("contentVO", contentVO);

  ArrayList<FileVO> file_list = contentProc.getThumbs(contentVO);
  mav.addObject("file_list", file_list);
  
  return mav;
}
/**
 * file �Ѱ� ���� �� SQL������Ʈ
 * @param memberno  ȸ����ȣ ����
 * @param contentVO   ��� �� ���������� �����ϰ� �ִ� ���� �״�� ����
 * @param filename   ������ ���� �̸�
 * @return
 */
@RequestMapping(value="/content/deletefile.do", method=RequestMethod.GET)
public ModelAndView deletefile(HttpServletRequest request, HttpSession session, int contentsno, String filename) { 
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
    memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
  } else { // �α����� �Ǿ� ���� ���� ���
    mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
    return mav;
    //��ȸ���� �� ���� �Ұ���
  }
  ContentVO contentVO = contentProc.read(contentsno);
  String upDir = Tool.getRealPath(request, "/content/storage");
  String files = contentVO.getPicture();          // xmas01_2.jpg/xmas02_2.jpg...
  String sizes = contentVO.getPicsize();        // 272558/404087... 
  
  String[] files_array_old = files.split("/");   // ���ϸ� ����
  String[] sizes_array_old = sizes.split("/"); // ���� ������
  String[] files_new;
  String[] sizes_new;
  //-------------------------------------------------------------------
  //���� ���� ���� �۾� ����
  //-------------------------------------------------------------------
  ArrayList<FileVO> file_list = contentProc.getThumbs(contentVO);

  //Iterator�� ���� ���ϰ����� �ӵ��� ���� �׳� size�� ����� ��.
  int i = 0;
  int index = Content.file_not_exist;
  for(; i < file_list.size(); i++){
    String file_old= file_list.get(i).getFile();
    String thumb_old = file_list.get(i).getThumb();
    if(file_old.equals(filename)){//file���� ��ġ�ϸ� ����
      Tool.deleteFile(upDir + file_old);// ������ ��ϵ� file ����
      Tool.deleteFile(upDir + thumb_old);// ������ ��ϵ� thumb ����
      index = i;
    }
  }
  if(index != Content.file_not_exist){
    //list���� ���� ����
    file_list.remove(index); 
    
    //String�迭 ���� ����
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
    //���ο� ���� ����Ʈ String ����
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
    //System.out.println("���� ����Ʈ2: " + picture_new);
    //System.out.println("ũ�� ����Ʈ2: " + picsize_new);
    
    //���ο� ���� ����Ʈ�� contentVO�� ����
    contentVO.setPicture(picture_new);
    contentVO.setPicsize(picsize_new);
    
  }  
  //-------------------------------------------------------------------
  //���� ���� ���� �۾� ��
  //-------------------------------------------------------------------
  
  //SQL ������Ʈ 
  contentProc.deletefile(contentVO);//���� delete�� updatesql��

  //ȸ����ȣ ����
  mav.addObject("memberno", memberno);
  //ȸ����ȣ ����
  mav.addObject("contentsno", contentsno);
  //update.do get ȣ��
  mav.setViewName("redirect:/content/update.do");
  return mav;
}
/**
 * - �۸� �����ϴ� ����� ���� 
 * - ���ϸ� �����ϴ� ����� ���� 
 * - �۰� ������ ���ÿ� �����ϴ� ����� ����
 * 
 * @param request
 * @param contentsVO
 * @return
 */
@RequestMapping(value = "/content/update.do", method = RequestMethod.POST)
public ModelAndView update(HttpServletRequest request, ContentVO contentVO, HttpSession session) {
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
    memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
  } else { // �α����� �Ǿ� ���� ���� ���
    mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
    return mav;
    //��ȸ���� �� ���� �Ұ���
  }
  ContentVO contentVO_old = contentProc.read(contentVO.getContentsno());
  //System.out.println("POST UPDATE " + contentVO.getContentsno());
  //System.out.println("POST UPDATE " +  memberno);
  // -------------------------------------------------------------------
  // 1. ���� ���� ���� �ڵ� 
  // -------------------------------------------------------------------
  // �� �κ��� ���� �Ѱ� ���� �� ���� deletefile ��Ʈ�ѷ��� ����Ϸ�Ǿ� �̹� ���� �Ǿ� �ִ� �����̹Ƿ� �۾��� �ʿ� ����.
  // -------------------------------------------------------------------
  // �߰��� ���� ���� �ڵ� ����
  // -------------------------------------------------------------------
  String upDir = Tool.getRealPath(request, "/content/storage");
  // Spring�� File ��ü�� �����ص�.
  List<MultipartFile> filesMF = contentVO.getFilesMF(); 

  // System.out.println("--> filesMF.get(0).getSize(): " +
  // filesMF.get(0).getSize());

  String files = contentVO_old.getPicture(); // �÷��� ������ ���ϸ� ����� ������ �̸����� �����ð�
  String files_item = ""; // �ϳ��� ���ϸ�
  String sizes = contentVO_old.getPicsize(); 
  long sizes_item = 0; // �ϳ��� ���� ������

  if (filesMF != null) {  // ���� ���ε� �Ȱ� �����Ѵٸ�
    int count = filesMF.size(); // ���ε�� ���� ����
    // --------------------------------------------
    // ���ο� ������ ��� ����
    // --------------------------------------------
    // for (MultipartFile multipartFile: filesMF) {
    for (int i = 0; i < count; i++) {
      MultipartFile multipartFile = filesMF.get(i); // 0 ~
      //System.out.println("POST UPDATE multipartFile.getName(): " + multipartFile.getName());

    //if (multipartFile.getName().length() > 0) { // ���������� �ִ��� üũ, filesMF
      if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
        //System.out.println("POST UPDATE ���� ������ �ֽ��ϴ�.");
        files_item = Upload.saveFileSpring(multipartFile, upDir);
        sizes_item = multipartFile.getSize();
        // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
        files = files + "/" + files_item;
        // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
        sizes = sizes + "/" + sizes_item;
        
        if (Tool.isImage(files_item)) { // �̹������� �˻�
          Tool.preview(upDir, files_item, 120, 80); // Thumb �̹��� ����
         // ��� �̹��� ���� /upDir/mt_t.jpg  
        }
      } //  if (multipartFile.getSize() > 0)  END
    } // for END
    // --------------------------------------------
    // ���ο� ������ ��� ����
    // --------------------------------------------
  } else { // �۸� �����ϴ� ���, ������ ���� ���� ����
    files = contentVO_old.getPicture();
    sizes = contentVO_old.getPicsize();
  }
  contentVO.setPicture(files);
  //System.out.println("POST UPDATE " + files);
  contentVO.setPicsize(sizes);
  //System.out.println("POST UPDATE " + sizes);
  
  int cnt = contentProc.update(contentVO);  // SQL �۾� DBMS ����

  // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
  
  //redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
  //redirectAttributes.addAttribute("count", count); // redirect parameter ����

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
 * ���� �� 
 * http://localhost:9090/ojt/content/delete.do?cateno=1
 * 
 * @return
 */
@RequestMapping(value = "/content/delete.do", method = RequestMethod.GET)
public ModelAndView delete(HttpSession session, int contentsno) {
  //delete get ���������� ȸ����ȣ�� ����Ȯ��
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
    memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
  } else { // �α����� �Ǿ� ���� ���� ���
    mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
    return mav;
    //��ȸ���� �� ���� �Ұ���
  }
  ContentVO contentVO = contentProc.read(contentsno);
  mav.addObject("contentVO", contentVO);
  mav.addObject("memberno", memberno);
  mav.setViewName("/content/delete"); // /webapp/contents/delete.jsp

  return mav;
}

/**
 * ����
 * @param request
 * @param contentsVO
 * @return
 */
@RequestMapping(value = "/content/delete.do", method = RequestMethod.POST)
public ModelAndView delete(RedirectAttributes redirectAttributes, HttpServletRequest request, int contentsno, HttpSession session) {
  ModelAndView mav = new ModelAndView();
  int memberno=0;
  if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
    memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
  } else { // �α����� �Ǿ� ���� ���� ���
    mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
    return mav;
    //��ȸ���� �� ���� �Ұ���
  }
  String upDir = Tool.getRealPath(request, "/content/storage");

  // ������ ��� ���� ��ȸ
  ContentVO contentVO_old = contentProc.read(contentsno);
  
  // ������ ���� ���� ��ȸ
  ArrayList<FileVO> file_list = contentProc.getThumbs(contentVO_old);

  // ������ִ� ���ϵ� ����
  for(int index = 0; index < file_list.size(); index++){
    Tool.deleteFile(upDir + file_list.get(index).getFile());  // ������ ��ϵ� ���� ���� ����
    Tool.deleteFile(upDir + file_list.get(index).getThumb()); // ������ ��ϵ� thumbs ���� ����
  }

  int count = contentProc.delete(contentsno);
  if (count > 0) {
    cateProc.cnt_dec(contentVO_old.getCateno());  // �۰��� ����
  }

  // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
  redirectAttributes.addAttribute("count", count); // redirect parameter ����
  redirectAttributes.addAttribute("contentsno", contentsno);
  redirectAttributes.addAttribute("memberno", memberno);
  redirectAttributes.addAttribute("title", contentVO_old.getTitle());
  //redirectAttributes.addAttribute("nowPage", nowPage);
  
  mav.setViewName("redirect:/content/delete_msg.jsp");

  return mav;

}
  /**
  * ��ü ����, �������� �˻�
  * @param word �˻���
  * @return
  */
  @RequestMapping(value = "/content/search_list_all.do", method = RequestMethod.GET)
  public ModelAndView search_list_all(@RequestParam(value="word", defaultValue="") String word, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
    } else { // �α����� �Ǿ� ���� ���� ���
      //mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
      //return mav;
      //��ȸ���� �� �˻��� ����
    }
  //HashMap 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);
    
    // �˻��� ���ڵ� ���
    ArrayList<Cate_ContentVO> list = contentProc.search_list_all(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count_all = contentProc.search_count_all(map);
    mav.addObject("search_count", search_count_all);

    mav.addObject("memberno", memberno);

    mav.setViewName("/content/list_all_content"); //list_all_content.jsp 
 
    return mav;
  }
  /**
  * ī�װ��� ����, �������� �˻�
  * @param cateno ī�װ� ��ȣ
  * @param word �˻���
  * @return
  */
  @RequestMapping(value = "/content/search_list_by_cateno.do", method = RequestMethod.GET)
  public ModelAndView search_list_by_cateno(int cateno,@RequestParam(value="word", defaultValue="") String word) {
    ModelAndView mav = new ModelAndView();
    //HashMap 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("cateno", cateno);
    map.put("word", word);
    
    // �˻��� ���ڵ� ���
    ArrayList<ContentVO> list = contentProc.search_list_by_cateno(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count_by_cateno = contentProc.search_count_by_cateno(map);
    mav.addObject("search_count", search_count_by_cateno);

    mav.setViewName("/content/list_by_cate_desc"); //list_by_cate_desc.jsp 
 
    return mav;
  }
  /**
   * ��ü �˻� + ����¡ +����
   * @param word
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/content/search_list_all_paging.do", method = RequestMethod.GET)
  public ModelAndView search_list_all_paging(@RequestParam(value="word", defaultValue="") String word,
                                                              @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    //HashMap ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);
    map.put("nowPage", nowPage);       
    
    // �˻��� ���ڵ� ���
    ArrayList<Cate_ContentVO> list = contentProc.search_list_all_paging(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count_all = contentProc.search_count_all(map);
    mav.addObject("search_count", search_count_all);
    //mav.setViewName("/content/list_all_content"); //list_all_content.jsp 
    mav.setViewName("/content/grid_list"); //grid_list.jsp 
    /*
     * Bootstrap Paging
     * 
     * @param listFile ��� ���ϸ� 
     * @param categoryno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = contentProc.pagingBox("search_list_all_paging.do", 0, search_count_all, nowPage, word);
    mav.addObject("paging", paging);
    //System.out.println("paging: " + paging);
    mav.addObject("nowPage", nowPage);
 
    return mav;
  }
  /**
   * ī�װ� �� �˻��� ���ڵ� ��� + ����¡
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
    //HashMap ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("cateno", cateno);
    map.put("word", word);
    map.put("nowPage", nowPage);       
    
    
    // �˻��� ���ڵ� ���
    ArrayList<ContentVO> list = contentProc.search_list_by_cateno_paging(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count_by_cateno = contentProc.search_count_by_cateno(map);
    mav.addObject("search_count", search_count_by_cateno);

    //mav.setViewName("/content/list_by_cate_desc"); //list_by_cate_desc.jsp 
    mav.setViewName("/content/grid_list"); //grid_list.jsp 
    
    /*
     * Bootstrap Paging
     * 
     * @param listFile ��� ���ϸ� 
     * @param categoryno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = contentProc.pagingBox("search_list_by_cateno_paging.do", cateno, search_count_by_cateno, nowPage, word);
    mav.addObject("paging", paging);
    mav.addObject("nowPage", nowPage);
 
    return mav;
  }
  /**
   * �ǸſϷ� proc
   * http://localhost:9090/team1/content/sale.do?cateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/content/sale.do", method = RequestMethod.GET)
  public ModelAndView sale(HttpSession session, int contentsno, int contmemno) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    int count=0;
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
      if(memberno == contmemno){ // �������� ��ϵ� ȸ����ȣ�� ������ ȸ����ȣ�� ��ġ�Ѵٸ� �ǸſϷ� �۾��� ����
        count = contentProc.sale(contentsno);
      }
    } else { // ������ Ǯ���� �α����� �Ǿ� ���� ���� ���
      //�۾����� ����.
      //mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
      //return mav;
      //���θ� �ǸſϷ� ����
    }
    mav.setViewName("redirect:/content/read.do?contentsno="+contentsno);

    return mav;
  }
  
//ZIP ���� �� ���� �ٿ�ε� 
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
   
   String[] zip_src = new String[files_array.length]; // ���� ������ŭ �迭 ����
   
   for (int i=0; i < files_array.length; i++) {
     zip_src[i] = upDir + "/" + files_array[i]; // ���� ��� ����      
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
       System.out.println(zip_filename + "�� ����Ǿ� �����ƽ��ϴ�.");
     }
     
//     if (file.delete() == true) {
//       System.out.println(zip_filename + " ������ �����߽��ϴ�.");
//     }

   } catch (FileNotFoundException e) {
     e.printStackTrace();
   } catch (IOException e) {
     e.printStackTrace();
   }

   // download ���� ����
   mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);    
   
   return mav;
 }
  
}
