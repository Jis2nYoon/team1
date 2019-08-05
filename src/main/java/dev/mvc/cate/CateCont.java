package  dev.mvc.cate;
 
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;

 
@Controller
public class CateCont {
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.cate.CateProc")
  private CateProcInter cateProc;
  
  public CateCont () {
    System.out.println("--> team1.CateCont created.");
  }
  
//cateVO�� Form �±��� ������ �ڵ� �����.
 // http://localhost:9090/team1/cate/create.do
 @RequestMapping(value="/cate/create.do", method=RequestMethod.POST)
 public ModelAndView create(CateVO cateVO, HttpSession session){
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
     memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
     if (!memberProc.isMaster(session)) { // �����Ͱ����� �ƴ� ���
       //mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
       //�α��� ��û ������ ���ٴ� �����ڸ� ���� �� �� �ֽ��ϴ�. ��� ���� �޼��� �������� �̵�
       return mav;
     } else{
       //������ ������ ���
       int count = cateProc.create(cateVO);
       mav.setViewName("redirect:/cate/create_msg.jsp?count="+count); 
       
       return mav;
     }
   }
   //�α����� �ȵ��ִٸ�
   mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
   return mav;
 }
  //http://localhost:9090/team1/cate/list.do
  @RequestMapping(value="/cate/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cate/list"); // /webapp/cate/list.jsp
    int memberno=0;
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
      if (!memberProc.isMaster(session)) { // �����Ͱ����� �ƴ� ���
        //�����ڸ� ���� �� �� �ֽ��ϴ�. ��� ���� �޼��� �������� �̵�
        return mav;
      }
    } else { // �α����� �Ǿ� ���� ���� ���
      mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
      return mav;
    }
    //if���� ��� ����ߴٸ� �����Ͱ����̹Ƿ� ����� ������.
    ArrayList<CateVO> list = cateProc.list_seqno_asc();
    mav.addObject("list", list);
    mav.addObject("memberno", memberno);
    return mav;
  }
  //JSON ����� ����. @ResponseBody�� �����ٰ� ����;
  //http://localhost:9090/team1/cate/read.do?cateno=1
  @ResponseBody
  @RequestMapping(value="/cate/read.do", method=RequestMethod.GET,
                             produces="text/plain;charset=UTF-8")//produces="text/plain;charset=UTF-8"���� �ѱ� ���� ����
  public String read(int cateno) {
    CateVO cateVO = cateProc.read(cateno);
    JSONObject json = new JSONObject(cateVO);
  
    return json.toString();
  } 
//cateVO�� Form �±��� ������ �ڵ� �����.
 // http://localhost:9090/team1/cate/update.do
 @RequestMapping(value="/cate/update.do", method=RequestMethod.POST)
 public ModelAndView update(CateVO cateVO, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
     memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
     if (!memberProc.isMaster(session)) { // �����Ͱ����� �ƴ� ���
       //�����ڸ� ���� �� �� �ֽ��ϴ�. ��� ���� �޼��� �������� �̵�
       return mav;
     }
   } else { // �α����� �Ǿ� ���� ���� ���
     mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
     return mav;
   }
   int count = cateProc.update(cateVO);
   mav.setViewName("redirect:/cate/update_msg.jsp?count=" + count);
   
   return mav;
 }
 /**
  * �Ѱ��� �׷� ����
  * @param cateno
  * @return
  */
 @RequestMapping(value="/cate/delete.do", method=RequestMethod.POST)
 public ModelAndView delete(int cateno, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
     memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
     if (!memberProc.isMaster(session)) { // �����Ͱ����� �ƴ� ���
       //�����ڸ� ���� �� �� �ֽ��ϴ�. ��� ���� �޼��� �������� �̵�
       return mav;
     }
   } else { // �α����� �Ǿ� ���� ���� ���
     mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
     return mav;
   }
   CateVO cateVO = cateProc.read(cateno);
   int fk_cnt = 0;
   int count = 0;
   if(cateVO.getContentscnt() == 0){
     //��ϵ� ���� �����Ƿ� ī�װ��� �ٷ� ����
     count = cateProc.delete(cateno);
   } else {
     fk_cnt = cateProc.fk_delete(cateno); 
     //�ڽķ��ڵ� ������ �����������ϸ� 0�ǰ�, ���� default���� 0�̿��� 
     //�ڽ����̺��� ���ڵ� ���� ���� �� fk_cnt���� 0���� ���´�.
     if(fk_cnt != 0){
       cateProc.fk_zero(cateno); //���������� �ڽ����̺��� ���ڵ带 ���������� �ʱ�ȭ����.
       count = cateProc.delete(cateno);
     } 
   }
   mav.setViewName("redirect:/cate/delete_msg.jsp?count=" + count);
   return mav;
 }
 /**
  * ��� ���� ����
  * @param cateno
  * @return ó���� ���ڵ� ����
  */
 // http://localhost:9090/team1/cate/seqno_inc.do?cateno=29
 @RequestMapping(value="/cate/seqno_inc.do", method=RequestMethod.POST)
 public ModelAndView update_seqno_up(int cateno, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
     memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
     if (!memberProc.isMaster(session)) { // �����Ͱ����� �ƴ� ���
       //�����ڸ� ���� �� �� �ֽ��ϴ�. ��� ���� �޼��� �������� �̵�
       return mav;
     }
   } else { // �α����� �Ǿ� ���� ���� ���
     mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
     return mav;
   }
   int count = cateProc.seqno_inc(cateno);
   mav.setViewName("redirect:/cate/list.do");
   
   return mav;
 }
 /**
  * ��� ���� ����
  */
 // http://localhost:9090/team1/cate/seqno_dec.do
 @RequestMapping(value="/cate/seqno_dec.do", method=RequestMethod.POST)
 public ModelAndView update_seqno_down(int cateno, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
     memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
     if (!memberProc.isMaster(session)) { // �����Ͱ����� �ƴ� ���
       //�����ڸ� ���� �� �� �ֽ��ϴ�. ��� ���� �޼��� �������� �̵�
       return mav;
     }
   } else { // �α����� �Ǿ� ���� ���� ���
     mav.setViewName("member/login_need");  // �α��� ��û �������� �̵�
     return mav;
   }
   int count = cateProc.seqno_dec(cateno);
   mav.setViewName("redirect:/cate/list.do");
   
   return mav;
 }
 /*
  * content���̺��� contentsCnt ����
  * �̺κ��� contents ��� ���� controller���� ����Ұ���. category���� �������� ����.
  * content���̺��� contentsCnt ����
  */

 
 //http://localhost:9090/ojt/cate/list_categroy.do
 /**
  * TOP�޴��� ����������� SELECT�κп���
  * ī�װ� �з�ĭ c import�� �̿��� ��.
  * @param request
  * @return
  */
  @RequestMapping(value="/cate/category_select.do", method=RequestMethod.GET)
  public ModelAndView list_index_left(HttpServletRequest request){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cate/select_category"); // webapp/cate/select_category.jsp
   
    //ī�װ� ��� ����
    ArrayList<CateVO> list = cateProc.list_seqno_asc();
    mav.addObject("list_category", list);
    
   return mav;
 } 
  /**
   * TOP�޴��� ����������� SELECT�κп���
   * ī�װ� �з�ĭ c import�� �̿��� ��.
   * @param request
   * @return
   */
   @RequestMapping(value="/cate/category_list.do", method=RequestMethod.GET)
   public ModelAndView list_cate_menu(HttpServletRequest request){
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/cate/list_category"); // webapp/cate/list_category.jsp
    
     //ī�װ� ��� ����
     ArrayList<CateVO> list = cateProc.list_seqno_asc();
     mav.addObject("list_category", list);
     
    return mav;
  } 
 
}