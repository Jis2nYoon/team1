package  dev.mvc.reply;
 
import java.util.ArrayList;
import java.util.HashMap;

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
public class ReplyCont {
  
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc")
  private ReplyProcInter replyProc;
  
  public ReplyCont () {
    System.out.println("--> team1.ReplyCont created.");
  }
  
//http://localhost:9090/fm/reply/create.do
  /**
   * 등록 처리
   * @param replyVO
   * @return
   */
  @RequestMapping(value="/reply/create.do", method=RequestMethod.POST)
  public ModelAndView create(ReplyVO replyVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
    } else { // 로그인이 되어 있지 않은 경우
      mav.setViewName("/member/login_need2");  // top css 없는 로그인 요청 페이지로 이동
      return mav;
    }
    mav.setViewName("/reply/create_msg"); //webapp/reply/create_msg.jsp
    replyVO.setMemberno(memberno);
    int count = replyProc.create(replyVO);
    
    mav.addObject("count", count);
    
    return mav;
  }
  /**
   * 대댓글 등록 처리
   * @param replyVO
   * @return
   */
  @RequestMapping(value="/reply/create_reply.do", method=RequestMethod.POST)
  public ModelAndView create_reply(ReplyVO replyVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
    } else { // 로그인이 되어 있지 않은 경우
      mav.setViewName("/member/login_need");  // 로그인 요청 페이지로 이동
      return mav;
    }
    mav.setViewName("/reply/create_msg"); //webapp/reply/create_msg.jsp
    
    //replyVO에 replyno가 이미 담겨진 상태로 넘어오는데 이 replyno가 부모댓글의 number이므로 변수에 저장한다.
    int parent_replyno = replyVO.getReplyno();
    //System.out.println(parent_replyno);
    
    //grpno, indent, ansnum을 대댓글에 맞게 갱신하여 준다.
    ReplyVO newVO = replyProc.update_seq(parent_replyno);
    replyVO.setGrpno(newVO.getGrpno());
    replyVO.setIndent(newVO.getIndent());
    replyVO.setAnsnum(newVO.getAnsnum());
    
    replyVO.setMemberno(memberno);
    
    int count = replyProc.create_reply(replyVO);
    
    mav.addObject("count", count);
    
    return mav;
  }
/**
 * 컨텐츠별 댓글 목록
 * @param replyVO   nickname추가한 mem_replyVO를 생성해야할듯
 * @return
 */
@RequestMapping(value="/reply/list.do", method=RequestMethod.GET)
public ModelAndView list(int contentsno) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/reply/list"); //webapp/reply/create_msg.jsp
  
  //컨텐츠별 댓글 목록 전달
  ArrayList<ReplyVO> replylist = replyProc.list(contentsno);
  mav.addObject("replylist", replylist);
  
  int memberno;
  HashMap<Integer, Object> nickmap = new HashMap<>();
  
  String nickname;
  for(int i = 0; i < replylist.size(); i++){
    memberno = replylist.get(i).getMemberno();
    nickname = memberProc.nick_select(memberno);
    nickmap.put(memberno, nickname);
  }
  
  mav.addObject("nickmap", nickmap);
  
  
 return mav;
}

/**
 * 컨텐츠별 댓글 레코드 갯수
 * @param contentsno
 * @return
 */
@ResponseBody //view통해서 출력하지 않게 하려면
@RequestMapping(value="/reply/list_cnt.do", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")//produces="text/plain;charset=UTF-8"으로 한글 깨짐 방지
public String list_cnt(int contentsno) {
  int count = replyProc.count_all(contentsno);
  JSONObject json = new JSONObject();
  json.put("count", count);
  return json.toString();
}

/**
 * 수정 FORM
 * @param replyno
 * @return
 */
@ResponseBody //view통해서 출력하지 않게 하려면
@RequestMapping(value="/reply/update.do", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")//produces="text/plain;charset=UTF-8"으로 한글 깨짐 방지
public String update(int replyno) {
  ReplyVO replyVO = replyProc.read(replyno);
  JSONObject json = new JSONObject(replyVO);
  return json.toString();
}
/**
 * 수정 처리
 * @param replyno
 * @return
 */
@RequestMapping(value="/reply/update.do", method=RequestMethod.POST)
public ModelAndView update(ReplyVO replyVO) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/reply/update_msg"); //webapp/reply/update_msg.jsp
  System.out.println(replyVO.getReplyno());
  int count = replyProc.update(replyVO);
  System.out.println(count);
  mav.addObject("count", count);
  
  return mav;
}
/**
 * 삭제 처리
 * @param replyno
 * @return
 */
@RequestMapping(value="/reply/delete.do", method=RequestMethod.POST)
public ModelAndView delete(int replyno) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/reply/delete_msg"); //webapp/reply/delete_msg.jsp
  
  int count = replyProc.delete(replyno);
  
  mav.addObject("count", count);
  
  return mav;
}



}