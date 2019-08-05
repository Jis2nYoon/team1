package dev.mvc.member;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;



@Component("dev.mvc.member.MemberProc")
public class MemberProc implements MemberProcInter {
  @Autowired
  private MemberDAOInter memberDAO;
  
  public MemberProc () {
    //System.out.println("--> MemberProc created.");
  }
  
  @Override
  public int checkEmail(String email) {
    int count = memberDAO.checkEmail(email);
    return count;
  }
  
  @Override
  public int checkNickname(String nickname) {
    int count = memberDAO.checkNickname(nickname);
    return count;
  }

  @Override
  public MemberVO getPhoto(int memberno) {
    MemberVO memberVO = memberDAO.getPhoto(memberno);
    return memberVO;
  }
  
  @Override
  public int create(MemberVO memberVO) {
    int count = memberDAO.create(memberVO);
    return count;
  }

  @Override
  public int update(MemberVO memberVO) {
    int count = memberDAO.update(memberVO);
    return count;
  }
  
  @Override
  public int cancel(int memberno) {
    int count = memberDAO.cancel(memberno);
    return count;
  }
   
  @Override
  public int delete(int memberno) {
    int count = memberDAO.delete(memberno);
    return count;
  }
  
  /*@Override
  public ArrayList<MemberVO> list() {
    ArrayList<MemberVO> list = memberDAO.list();
    
    return list;
  }*/
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param listFile ��� ���ϸ� 
   * @param cateno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String pagingBox(String listFile, int search_count, int nowPage, String col, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Member.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Member.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Member.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Member.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Member.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 

    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� 20
    int _nowPage = (nowGrp-1) * Member.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?col="+col+"&word="+word+"&nowPage="+_nowPage+">����</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<span class='span_box_1'><A href='./"+listFile+"?col="+col+"word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 

    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowGrp * Member.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?col="+col+"&word="+word+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
 
  @Override
  public ArrayList<MemberVO> list_search_paging(String col, String word, int nowPage) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = (nowPage - 1) * Member.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Member.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
   HashMap <String, Object> map = new HashMap<String, Object> ();
   map.put("col", col);
   map.put("word", word);
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<MemberVO> list = memberDAO.list_search_paging(map);
    
    
    return list;
  }
/*  @Override
  public ArrayList<MemberVO> list_paging(int nowPage) {
     
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    
   int beginOfPage = (nowPage - 1) * Member.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Member.RECORD_PER_PAGE;   
   
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    
   HashMap<String, Object> map = new HashMap<String, Object> ();
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<MemberVO> list = memberDAO.list_paging(map);
    
    
    return list;
  }*/
  
  @Override
  public MemberVO read(int mno) {
    MemberVO memberVO = memberDAO.read(mno);
    
    return memberVO;
  }
  
  @Override
  public MemberVO readByEmail(String email) {
    MemberVO memberVO = memberDAO.readByEmail(email);
    
    return memberVO;
  }

  @Override
  public int act_update(String act, int memberno) {
    HashMap<String, Object> map = new HashMap<String, Object> ();
    map.put("act",act);
    map.put("memberno",memberno);
    
    int count = memberDAO.act_update(map);
    
    return count;
  }

  @Override
  public int stopdate_update(String stopdate, int memberno) {
    HashMap<String, Object> map = new HashMap<String, Object> ();
    map.put("stopdate",stopdate);
    map.put("memberno",memberno);
    
    int count = memberDAO.stopdate_update(map);
    
    return count;
  }
  
  @Override
  public int passwd_update(String passwd, String email) {
    HashMap<String, Object> map = new HashMap<String, Object> ();
    map.put("passwd",passwd.trim());
    map.put("email",email.trim());
    int count = memberDAO.passwd_update(map);
    
    return count;
  }

  /**
   * ������ ���� ����
   * @param memberVO
   * @return
   */
  @Override
  public int photo_update(MemberVO memberVO) {
    int count = memberDAO.photo_update(memberVO);
    
    return count;
  }
  
  @Override
  public int login(String email, String passwd) {
    HashMap<String, Object> map = new HashMap<String, Object> ();
    map.put("email",email);
    map.put("passwd",passwd);
    int count = memberDAO.login(map);
    
    return count;
  }
  
  public ArrayList<String> search_email(String mname, String tel){
    HashMap<String, Object> map = new HashMap<String, Object> ();
    map.put("mname",mname);
    map.put("tel",tel);
    ArrayList<String> list = memberDAO.search_email(map);
    
    return list;    
  }
  
  /**
   * �α��ε� ȸ�� �������� �˻��մϴ�.
   * @param request
   * @return true: �α���
   */
  public boolean isMember(HttpSession session){
    boolean sw = false;
    
    String email = (String)session.getAttribute("email");
    
    if (email != null){
      sw = true;
    }
    return sw;
  }
  /**
   * ������(������) ȸ�� �������� �˻��մϴ�.
   * @param request
   * @return true: ������
   */
  public boolean isMaster(HttpSession session){
    boolean sw = false;
    
    String act = (String)session.getAttribute("act");
    
    if (act.equals("M")){
      sw = true;
    }
    return sw;
  }

  @Override
  public int search_count(String col, String word, int nowPage) {
    HashMap<String, Object> map = new HashMap<String, Object> ();
    map.put("col",col);
    map.put("word",word);
    map.put("nowPage",nowPage);
    
    int count = memberDAO.search_count(map);
    return count;
  }
  
  /**
   * ���� �߰�
   * ȸ����ȣ�� �г��� ��ȸ
   */
  @Override
  public String nick_select(int memberno) {
    String nickname = memberDAO.nick_select(memberno);
    return nickname;
  }
}
