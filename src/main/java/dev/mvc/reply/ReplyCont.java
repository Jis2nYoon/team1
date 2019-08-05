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
   * ��� ó��
   * @param replyVO
   * @return
   */
  @RequestMapping(value="/reply/create.do", method=RequestMethod.POST)
  public ModelAndView create(ReplyVO replyVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
    } else { // �α����� �Ǿ� ���� ���� ���
      mav.setViewName("/member/login_need2");  // top css ���� �α��� ��û �������� �̵�
      return mav;
    }
    mav.setViewName("/reply/create_msg"); //webapp/reply/create_msg.jsp
    replyVO.setMemberno(memberno);
    int count = replyProc.create(replyVO);
    
    mav.addObject("count", count);
    
    return mav;
  }
  /**
   * ���� ��� ó��
   * @param replyVO
   * @return
   */
  @RequestMapping(value="/reply/create_reply.do", method=RequestMethod.POST)
  public ModelAndView create_reply(ReplyVO replyVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
    } else { // �α����� �Ǿ� ���� ���� ���
      mav.setViewName("/member/login_need");  // �α��� ��û �������� �̵�
      return mav;
    }
    mav.setViewName("/reply/create_msg"); //webapp/reply/create_msg.jsp
    
    //replyVO�� replyno�� �̹� ����� ���·� �Ѿ���µ� �� replyno�� �θ����� number�̹Ƿ� ������ �����Ѵ�.
    int parent_replyno = replyVO.getReplyno();
    //System.out.println(parent_replyno);
    
    //grpno, indent, ansnum�� ���ۿ� �°� �����Ͽ� �ش�.
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
 * �������� ��� ���
 * @param replyVO   nickname�߰��� mem_replyVO�� �����ؾ��ҵ�
 * @return
 */
@RequestMapping(value="/reply/list.do", method=RequestMethod.GET)
public ModelAndView list(int contentsno) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/reply/list"); //webapp/reply/create_msg.jsp
  
  //�������� ��� ��� ����
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
 * �������� ��� ���ڵ� ����
 * @param contentsno
 * @return
 */
@ResponseBody //view���ؼ� ������� �ʰ� �Ϸ���
@RequestMapping(value="/reply/list_cnt.do", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")//produces="text/plain;charset=UTF-8"���� �ѱ� ���� ����
public String list_cnt(int contentsno) {
  int count = replyProc.count_all(contentsno);
  JSONObject json = new JSONObject();
  json.put("count", count);
  return json.toString();
}

/**
 * ���� FORM
 * @param replyno
 * @return
 */
@ResponseBody //view���ؼ� ������� �ʰ� �Ϸ���
@RequestMapping(value="/reply/update.do", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")//produces="text/plain;charset=UTF-8"���� �ѱ� ���� ����
public String update(int replyno) {
  ReplyVO replyVO = replyProc.read(replyno);
  JSONObject json = new JSONObject(replyVO);
  return json.toString();
}
/**
 * ���� ó��
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
 * ���� ó��
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