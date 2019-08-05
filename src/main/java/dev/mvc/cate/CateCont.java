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
  
//cateVO는 Form 태그의 값으로 자동 저장됨.
 // http://localhost:9090/team1/cate/create.do
 @RequestMapping(value="/cate/create.do", method=RequestMethod.POST)
 public ModelAndView create(CateVO cateVO, HttpSession session){
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // 로그인 되어있는 경우
     memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
     if (!memberProc.isMaster(session)) { // 마스터계정이 아닌 경우
       //mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
       //로그인 요청 페이지 보다는 관리자만 접근 할 수 있습니다. 라고 적힌 메세지 페이지로 이동
       return mav;
     } else{
       //마스터 계정인 경우
       int count = cateProc.create(cateVO);
       mav.setViewName("redirect:/cate/create_msg.jsp?count="+count); 
       
       return mav;
     }
   }
   //로그인이 안되있다면
   mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
   return mav;
 }
  //http://localhost:9090/team1/cate/list.do
  @RequestMapping(value="/cate/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cate/list"); // /webapp/cate/list.jsp
    int memberno=0;
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
      if (!memberProc.isMaster(session)) { // 마스터계정이 아닌 경우
        //관리자만 접근 할 수 있습니다. 라고 적힌 메세지 페이지로 이동
        return mav;
      }
    } else { // 로그인이 되어 있지 않은 경우
      mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
      return mav;
    }
    //if문을 모두 통과했다면 마스터계정이므로 목록을 보여줌.
    ArrayList<CateVO> list = cateProc.list_seqno_asc();
    mav.addObject("list", list);
    mav.addObject("memberno", memberno);
    return mav;
  }
  //JSON 출력할 것임. @ResponseBody를 쓰려다가 말음;
  //http://localhost:9090/team1/cate/read.do?cateno=1
  @ResponseBody
  @RequestMapping(value="/cate/read.do", method=RequestMethod.GET,
                             produces="text/plain;charset=UTF-8")//produces="text/plain;charset=UTF-8"으로 한글 깨짐 방지
  public String read(int cateno) {
    CateVO cateVO = cateProc.read(cateno);
    JSONObject json = new JSONObject(cateVO);
  
    return json.toString();
  } 
//cateVO는 Form 태그의 값으로 자동 저장됨.
 // http://localhost:9090/team1/cate/update.do
 @RequestMapping(value="/cate/update.do", method=RequestMethod.POST)
 public ModelAndView update(CateVO cateVO, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // 로그인 되어있는 경우
     memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
     if (!memberProc.isMaster(session)) { // 마스터계정이 아닌 경우
       //관리자만 접근 할 수 있습니다. 라고 적힌 메세지 페이지로 이동
       return mav;
     }
   } else { // 로그인이 되어 있지 않은 경우
     mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
     return mav;
   }
   int count = cateProc.update(cateVO);
   mav.setViewName("redirect:/cate/update_msg.jsp?count=" + count);
   
   return mav;
 }
 /**
  * 한건의 그룹 삭제
  * @param cateno
  * @return
  */
 @RequestMapping(value="/cate/delete.do", method=RequestMethod.POST)
 public ModelAndView delete(int cateno, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // 로그인 되어있는 경우
     memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
     if (!memberProc.isMaster(session)) { // 마스터계정이 아닌 경우
       //관리자만 접근 할 수 있습니다. 라고 적힌 메세지 페이지로 이동
       return mav;
     }
   } else { // 로그인이 되어 있지 않은 경우
     mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
     return mav;
   }
   CateVO cateVO = cateProc.read(cateno);
   int fk_cnt = 0;
   int count = 0;
   if(cateVO.getContentscnt() == 0){
     //등록된 글이 없으므로 카테고리를 바로 삭제
     count = cateProc.delete(cateno);
   } else {
     fk_cnt = cateProc.fk_delete(cateno); 
     //자식레코드 삭제에 성공하지못하면 0되고, 위에 default값도 0이여서 
     //자식테이블에서 레코드 삭제 못할 시 fk_cnt값은 0으로 남는다.
     if(fk_cnt != 0){
       cateProc.fk_zero(cateno); //성공적으로 자식테이블의 레코드를 삭제했으니 초기화해줌.
       count = cateProc.delete(cateno);
     } 
   }
   mav.setViewName("redirect:/cate/delete_msg.jsp?count=" + count);
   return mav;
 }
 /**
  * 출력 순서 상향
  * @param cateno
  * @return 처리된 레코드 갯수
  */
 // http://localhost:9090/team1/cate/seqno_inc.do?cateno=29
 @RequestMapping(value="/cate/seqno_inc.do", method=RequestMethod.POST)
 public ModelAndView update_seqno_up(int cateno, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // 로그인 되어있는 경우
     memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
     if (!memberProc.isMaster(session)) { // 마스터계정이 아닌 경우
       //관리자만 접근 할 수 있습니다. 라고 적힌 메세지 페이지로 이동
       return mav;
     }
   } else { // 로그인이 되어 있지 않은 경우
     mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
     return mav;
   }
   int count = cateProc.seqno_inc(cateno);
   mav.setViewName("redirect:/cate/list.do");
   
   return mav;
 }
 /**
  * 출력 순서 하향
  */
 // http://localhost:9090/team1/cate/seqno_dec.do
 @RequestMapping(value="/cate/seqno_dec.do", method=RequestMethod.POST)
 public ModelAndView update_seqno_down(int cateno, HttpSession session) {
   ModelAndView mav = new ModelAndView();
   int memberno=0;
   if (memberProc.isMember(session)) { // 로그인 되어있는 경우
     memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
     if (!memberProc.isMaster(session)) { // 마스터계정이 아닌 경우
       //관리자만 접근 할 수 있습니다. 라고 적힌 메세지 페이지로 이동
       return mav;
     }
   } else { // 로그인이 되어 있지 않은 경우
     mav.setViewName("member/login_need");  // 로그인 요청 페이지로 이동
     return mav;
   }
   int count = cateProc.seqno_dec(cateno);
   mav.setViewName("redirect:/cate/list.do");
   
   return mav;
 }
 /*
  * content테이블의 contentsCnt 증가
  * 이부분은 contents 등록 삭제 controller에서 사용할것임. category에서 구현하진 않음.
  * content테이블의 contentsCnt 감소
  */

 
 //http://localhost:9090/ojt/cate/list_categroy.do
 /**
  * TOP메뉴와 등록폼에서의 SELECT부분에서
  * 카테고리 분류칸 c import로 이용할 것.
  * @param request
  * @return
  */
  @RequestMapping(value="/cate/category_select.do", method=RequestMethod.GET)
  public ModelAndView list_index_left(HttpServletRequest request){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/cate/select_category"); // webapp/cate/select_category.jsp
   
    //카테고리 목록 전달
    ArrayList<CateVO> list = cateProc.list_seqno_asc();
    mav.addObject("list_category", list);
    
   return mav;
 } 
  /**
   * TOP메뉴와 등록폼에서의 SELECT부분에서
   * 카테고리 분류칸 c import로 이용할 것.
   * @param request
   * @return
   */
   @RequestMapping(value="/cate/category_list.do", method=RequestMethod.GET)
   public ModelAndView list_cate_menu(HttpServletRequest request){
     ModelAndView mav = new ModelAndView();
     mav.setViewName("/cate/list_category"); // webapp/cate/list_category.jsp
    
     //카테고리 목록 전달
     ArrayList<CateVO> list = cateProc.list_seqno_asc();
     mav.addObject("list_category", list);
     
    return mav;
  } 
 
}