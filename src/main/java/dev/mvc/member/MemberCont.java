package dev.mvc.member;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.grade.GradeProcInter;
import dev.mvc.login.LoginProcInter;
import dev.mvc.login.LoginVO;

import nation.web.tool.*;

@Controller
public class MemberCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;

  @Autowired
  @Qualifier("dev.mvc.login.LoginProc")
  private LoginProcInter loginProc = null;

  @Autowired
  @Qualifier("dev.mvc.grade.GradeProc")
  private GradeProcInter gradeProc = null;

  @Autowired
  private JavaMailSender mailSender;

  public MemberCont() {
    // System.out.println("--> MemberCont created.");
  }

  /**
   * �ߺ� �̸��� �˻�, JSON
   * http://localhost:9090/fm/member/checkEmail.do?email=user1@mail.com
   * 
   * @param email
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/member/checkEmail.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String checkEmail(String email) {
    /*
     * try { Thread.sleep(1000); } catch (InterruptedException e) {
     * e.printStackTrace(); }
     */

    int count = memberProc.checkEmail(email);
    JSONObject json = new JSONObject(count);
    json.put("count", count);

    return json.toString();
  }

  /**
   * �ߺ� �г��� �˻�, JSON
   * 
   * @param �г���
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/member/checkNickname.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String checkNickname(String nickname) {

    int count = memberProc.checkNickname(nickname);
    JSONObject json = new JSONObject(count);
    json.put("count", count);

    return json.toString();
  }

  /**
   * �н����� ������
   * 
   * @return
   */ 
  @RequestMapping(value = "/member/passwd_update.do", method = RequestMethod.GET)
  public ModelAndView passwd_update(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/passwd_update"); // webapp/member/passwd_update.jsp

    String email = (String) session.getAttribute("email");
    mav.addObject("email", email);

    return mav;
  }

  /**
   * �н����带 �����մϴ�.
   * 
   * @param request
   * @param passwd
   * @param new_passwd
   * @return
   */
  @RequestMapping(value = "/member/passwd_update.do", method = RequestMethod.POST)
  public ModelAndView passwd_update(HttpServletRequest request, HttpSession session, String passwd, String new_passwd) {

    ModelAndView mav = new ModelAndView();
    String email = (String) session.getAttribute("email");
    int count = 0;

    count = memberProc.login(email, passwd); // ���� �н����� �˻�

    if (count == 1) { // �α����� ȸ���� �н����� �˻�
      int count_update = memberProc.passwd_update(new_passwd, email);
      mav.setViewName("redirect:/member/passwd_update_msg.jsp?count=" + count_update);
    } else { // ���� ��й�ȣ Ʋ������
      mav.setViewName("redirect:/member/passwd_update_msg.jsp?count=" + count);
    }

    return mav;
  }

  /**
   * ���� ������ ���� form
   */
  @RequestMapping(value = "/member/stopdate_update.do", method = RequestMethod.GET)
  public ModelAndView stopdate_update() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/stopdate_update"); // /webapp/member/stopdate_update.jsp

    return mav;
  }

  /**
   * ���� ������ ���� ó��
   * 
   * @param stopdate
   * @param memberno
   */
  @RequestMapping(value = "/member/stopdate_update.do", method = RequestMethod.POST)
  public ModelAndView stopdate_update(String stopdate, int memberno) {
    ModelAndView mav = new ModelAndView();
    int count;

    if (stopdate.equals("-1")) {
      count = memberProc.stopdate_update("", memberno);
    } else {
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Calendar cal = Calendar.getInstance();

      cal.add(Calendar.DAY_OF_MONTH, Integer.parseInt(stopdate));

      count = memberProc.stopdate_update(sdf.format(cal.getTime()), memberno);
    }
    mav.setViewName("redirect:/member/act_update_proc.jsp?count=" + count);

    return mav;
  }

  /**
   * ���� ���� ���ε� form
   */
  @RequestMapping(value = "/member/photo_update.do", method = RequestMethod.GET)
  public ModelAndView photo_update(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // �α��� �Ǿ��ִ� ���
      memberno = (int) session.getAttribute("memberno"); // ���� ���� ���� �ҷ�����
    } else {
      MemberVO memberVO = memberProc.getPhoto(memberno);

      mav.setViewName("/member/photo_update"); // /webapp/member/photo_update.jsp

      mav.addObject("memberno", memberno);
      mav.addObject("thumbs", memberVO.getThumbs());
      mav.addObject("photo", memberVO.getPhoto());

    }
    return mav;
  }

  /**
   * ���� ���� ����
   */
  @ResponseBody
  @RequestMapping(value = "/member/photo_delete.do", method = RequestMethod.POST)
  public String photo_delete(HttpSession session) {

    int memberno = (int) session.getAttribute("memberno");
    JSONObject json = new JSONObject();
    int count = 0;

    MemberVO memberVO = new MemberVO();
    memberVO.setMemberno(memberno);
    memberVO.setPhoto("");
    memberVO.setThumbs("");
    memberVO.setSizes("0");
    count = memberProc.photo_update(memberVO); // db ����
    if (count == 1) {
      json.put("doing", "delete");
    } else
      json.put("doing", "fail");

    return json.toString();
  }

  /**
   * ���� ���� ���ε� ó��
   */
  @ResponseBody
  @RequestMapping(value = "/member/photo_update.do", method = RequestMethod.POST)
  public String photo_update(HttpSession session, HttpServletRequest request, MultipartFile file) {

    int memberno = (int) session.getAttribute("memberno");
    JSONObject json = new JSONObject();
    int count = 0;

    // -------------------------------------------------------------------
    // Fileupload ������Ʈ ���� �ڵ�, �ϳ��� ������ ���ε� ó��
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/member/storage");
    String tempDir = Tool.getRealPath(request, "/member/temp");

    String filename = ""; // ���ε� ���ϸ�
    String thumbs_name = ""; // ����� ���ϸ�

    long filesize = file.getSize(); // ���� ������
    if (filesize > 0) {

      filename = Upload.saveFileSpring(file, upDir); // ������ ���� ����
      if (Tool.isImage(filename)) { // �̹������� �˻�
        thumbs_name = Tool.preview(tempDir, upDir, filename, 180, 180); // Thumb
                                                                        // �̹���
                                                                        // ����

        MemberVO memberVO = new MemberVO();
        memberVO.setMemberno(memberno);
        memberVO.setPhoto(filename);
        memberVO.setThumbs(thumbs_name);
        memberVO.setSizes(Long.toString(filesize));
        count = memberProc.photo_update(memberVO); // db ����

        if (count == 1) {
          json.put("photo", memberVO.getPhoto());
          json.put("thumbs", memberVO.getThumbs());

          json.put("doing", "success");

        } else {
          json.put("doing", "fail");
        }
      } else {
        String fname = upDir + filename;
        Tool.deleteFile(fname);
        json.put("doing", "onlyImg");
      }
    }

    return json.toString();
  }

  /**
   * ���� ���� form
   */
  @RequestMapping(value = "/member/act_update.do", method = RequestMethod.GET)
  public ModelAndView act_update() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/act_update"); // /webapp/member/list.jsp

    return mav;
  }

  /**
   * ���� ���� ó��
   * 
   * @param act
   * @param memberno
   */
  @RequestMapping(value = "/member/act_update.do", method = RequestMethod.POST)
  public ModelAndView act_update(String act, int memberno) {
    ModelAndView mav = new ModelAndView();

    int count = memberProc.act_update(act, memberno);

    mav.setViewName("redirect:/member/act_update_proc.jsp?count=" + count);

    return mav;
  }

  /**
   * ȸ������ �� http://localhost:9090/fm/member/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/member/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/create"); // /webapp/member/create.jsp

    return mav;
  }

  /**
   * ȸ������ ó�� http://localhost:9090/fm/member/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/member/create.do", method = RequestMethod.POST)
  public ModelAndView create(RedirectAttributes redirectAttributes, MemberVO memberVO) {
    ModelAndView mav = new ModelAndView();

    int count = memberProc.create(memberVO);

    redirectAttributes.addAttribute("count", count); // 1 or 0
    // mav.addObject("count", count);
    mav.setViewName("redirect:/member/create_msg.jsp");

    return mav;
  }

  /**
   * �̸��� ã�� form
   * 
   * @return
   */
  @RequestMapping(value = "/member/search_email.do", method = RequestMethod.GET)
  public ModelAndView search_email() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/search_email"); // webapp/member/search_email.jsp

    return mav;
  }

  /**
   * �̸��� ã�� ó��
   * 
   * @return
   */
  @RequestMapping(value = "/member/search_email.do", method = RequestMethod.POST)
  public ModelAndView search_email(String mname, String tel) {
    ModelAndView mav = new ModelAndView();

    ArrayList<String> list = memberProc.search_email(mname, tel);
    for (int i = 0; i < list.size(); i++) {
      list.set(i, Tool.maskingEmail(list.get(i)));
    }

    mav.addObject("list", list);
    mav.setViewName("/member/search_email_msg"); // webapp/member/search_email.jsp

    return mav;
  }

  /**
   * ��й�ȣ ã�� form
   * 
   * @return
   */
  @RequestMapping(value = "/member/search_passwd.do", method = RequestMethod.GET)
  public ModelAndView search_passwd() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/search_passwd"); // webapp/member/search_passwd.jsp

    return mav;
  }

  /**
   * ��й�ȣ ã�� proc
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/member/search_passwd.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public String search_passwd(String email) {
    // String msg = "";

    int count = memberProc.checkEmail(email.trim());
    if (count == 0) {
      // msg = "�ش� �̸��� ������ ���ԵǾ����� �ʽ��ϴ�.";
    } else {
      String key = Tool.key();

      String setfrom = "fleamarket0215@gmail.com";
      String title = " Flea market �ӽ� ��й�ȣ"; // ����
      String content = "��й�ȣ �ӽ� ��й�ȣ = " + key;

      try {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

        messageHelper.setFrom(setfrom); // �����»�� �����ϰų� �ϸ� �����۵��� ����
        messageHelper.setTo(email); // �޴»�� �̸���
        messageHelper.setSubject(title); // ���������� ������ �����ϴ�
        messageHelper.setText(content); // ���� ����

        mailSender.send(message);
        count = memberProc.passwd_update(key.trim(), email);
        if (count == 1) {
        }
        // msg = "�ش� �̸��� �ּҷ� �ӽ� ��й�ȣ�� �߼��Ͽ����ϴ�."; //����
      } catch (Exception e) {
        System.out.println("����: " + e);
        count = -1;
        // msg = "�ӽ� ��й�ȣ ���ۿ� �����߽��ϴ�."; //����
      }
    }
    JSONObject json = new JSONObject(count);
    json.put("count", count);

    return json.toString();

  }

  /**
   * ȸ�� ��� http://localhost:9090/fm/member/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/member/list.do", method = RequestMethod.GET)
  public ModelAndView list(HttpSession session, @RequestParam(value = "col", defaultValue = "") String col,
      @RequestParam(value = "word", defaultValue = "") String word,
      @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    if (memberProc.isMember(session)) {
      if (memberProc.isMaster(session)) {
        mav.setViewName("/member/list"); // /webapp/member/list.jsp
        /* ArrayList<MemberVO> list = memberProc.list(); */
        ArrayList<MemberVO> list = memberProc.list_search_paging(col, word, nowPage);
        mav.addObject("list", list);

        int search_count = memberProc.search_count(col, word, nowPage);
        mav.addObject("search_count", search_count);

        /**
         * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� ���� ������: 11 / 22 [����] 11 12 13 14 15
         * 16 17 18 19 20 [����]
         *
         * @param listFile
         *          ��� ���ϸ�
         * @param cateno
         *          ī�װ���ȣ
         * @param search_count
         *          �˻�(��ü) ���ڵ��
         * @param nowPage
         *          ���� ������
         * @param word
         *          �˻���
         * @return ����¡ ���� ���ڿ�
         */

        String paging = memberProc.pagingBox("list.do", search_count, nowPage, col, word);
        mav.addObject("paging", paging);

        mav.addObject("nowPage", nowPage);

      } else {
        mav.setViewName("/member/login_need");
      }
    } else {
      mav.setViewName("/member/login_need");
    }
    return mav;
  }

  /**
   * ȸ�� ���� 1�� �б�
   * 
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/member/read.do", method = RequestMethod.GET)
  public ModelAndView read(int memberno) {
    // System.out.println("--> read(int mno) GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/read"); // webapp/member/read.jsp

    MemberVO memberVO = memberProc.read(memberno);
    mav.addObject("memberVO", memberVO);

    return mav;
  }

  /**
   * ȸ������ ���� ó��
   * 
   * @param memberVO
   * @return
   */
  @RequestMapping(value = "/member/update.do", method = RequestMethod.POST)
  public ModelAndView update(MemberVO memberVO) {
    ModelAndView mav = new ModelAndView();

    int count = memberProc.update(memberVO);

    mav.setViewName("redirect:/member/update_msg.jsp?count=" + count + "&mno=" + memberVO.getMemberno());

    return mav;
  }

  /**
   * ȸ�� Ż�� form
   * 
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/member/cancel.do", method = RequestMethod.GET)
  public ModelAndView cancel(int memberno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/cancel"); // webapp/member/read.jsp

    MemberVO memberVO = memberProc.read(memberno);
    mav.addObject("memberVO", memberVO);

    return mav;
  }

  /**
   * ȸ�� Ż�� ó��
   * 
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/member/cancel_proc.do", method = RequestMethod.POST)
  public ModelAndView cancel_proc(int memberno, String passwd, HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int count = 0;
    if (passwd.equals(session.getAttribute("passwd"))) {
      count = memberProc.cancel(memberno);
      if (count > 0) {
        session.invalidate();
      }
    } else
      count = -1;
    mav.setViewName("redirect:/member/cancel_msg.jsp?count=" + count);

    return mav;
  }

  /**
   * ȸ������ ���� form
   * 
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/member/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int memberno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/delete"); // webapp/member/delete.jsp

    MemberVO memberVO = memberProc.read(memberno);
    int cntGrade = gradeProc.count_memno(memberno);
    int cntLogin = loginProc.count_memno(memberno);
    mav.addObject("cntGrade", cntGrade);
    mav.addObject("cntLogin", cntLogin);
    mav.addObject("memberVO", memberVO);

    return mav;
  }

  /**
   * ȸ������ ���� ó��
   * 
   * @param redirectAttributes
   * @param request
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/member/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, HttpServletRequest request, int memberno) {
    ModelAndView mav = new ModelAndView();
    int count = 0;
    count = memberProc.delete(memberno);
    redirectAttributes.addAttribute("count", count); // 1 or 0
    // redirectAttributes.addAttribute("memberno", memberno); // ȸ�� ��ȣ

    mav.setViewName("redirect:/member/delete_msg.jsp");

    return mav;
  }

  /**
   * �α��� form
   * 
   * @return
   */
  // http://localhost:9090/member/member/login.do
  @RequestMapping(value = "/member/login.do", method = RequestMethod.GET)
  public ModelAndView login(HttpServletRequest request) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/login_ck_form"); // /webapp/member/login_ck_form.jsp

    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;

    String ck_email = ""; // email ���� ����
    String ck_email_save = ""; // email ���� ���θ� üũ�ϴ� ����
    String ck_passwd = ""; // passwd ���� ����
    String ck_passwd_save = ""; // passwd ���� ���θ� üũ�ϴ� ����

    if (cookies != null) {
      for (int i = 0; i < cookies.length; i++) {
        cookie = cookies[i]; // ��Ű ��ü ����

        if (cookie.getName().equals("ck_email")) {
          ck_email = cookie.getValue();
        } else if (cookie.getName().equals("ck_email_save")) {
          ck_email_save = cookie.getValue(); // Y, N
        } else if (cookie.getName().equals("ck_passwd")) {
          ck_passwd = cookie.getValue(); // 1234
        } else if (cookie.getName().equals("ck_passwd_save")) {
          ck_passwd_save = cookie.getValue(); // Y, N
        }
      }
    }

    mav.addObject("ck_email", ck_email);
    mav.addObject("ck_email_save", ck_email_save);
    mav.addObject("ck_passwd", ck_passwd);
    mav.addObject("ck_passwd_save", ck_passwd_save);

    return mav;
  }

  /**
   * �α��� ó��
   * 
   * @param request
   * @param response
   * @param session
   * @param email
   * @param email_save
   * @param passwd
   * @param passwd_save
   * @return
   */
  @RequestMapping(value = "/member/login.do", method = RequestMethod.POST)
  public ModelAndView login(HttpServletRequest request, HttpServletResponse response, HttpSession session, String email,
      @RequestParam(value = "email_save", defaultValue = "") String email_save, String passwd,
      @RequestParam(value = "passwd_save", defaultValue = "") String passwd_save) {
    // System.out.println("--> login() POST called.");
    ModelAndView mav = new ModelAndView();
    String msg = "";
    if (memberProc.checkEmail(email) != 1) { // �α��� ���н�
      mav.setViewName("redirect:/member/login_msg.jsp");
      msg = "�������� �ʴ� �̸��� �����Դϴ�.";
      mav.addObject("msg", msg);
    } else if (memberProc.login(email, passwd) != 1) { // �α��� ���н�
      mav.setViewName("redirect:/member/login_msg.jsp");
      msg = "�̸��� �Ǵ� �н����尡 ��ġ���� �ʽ��ϴ�.";
      mav.addObject("msg", msg);

    } else { // �н����� ��ġ�ϴ� ���
      MemberVO memberVO = memberProc.readByEmail(email);

      // act �˻�
      if (memberVO.getAct().equals("C")) {
        mav.setViewName("redirect:/member/login_msg.jsp");
        msg = "�̹� Ż���� ȸ���Դϴ�.";
        mav.addObject("msg", msg);
        return mav;
      } else if (memberVO.getAct().equals("N")) {
        mav.setViewName("redirect:/member/login_msg.jsp");
        msg = "�α����� ������ ȸ���Դϴ�.";
        mav.addObject("msg", msg);
        return mav;
      } // act �˻� END

      // stopdate �˻�
      if (memberVO.getStopdate() != "") { // ���������� �����Ҷ�
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date stopdate = null;
        Date nowdate = null;
        try {
          stopdate = sdf.parse(memberVO.getStopdate().substring(0, 10));
          nowdate = sdf.parse(sdf.format(new Date()).toString().substring(0, 10));
        } catch (ParseException e) {
          e.printStackTrace();
        }
        int compare = stopdate.compareTo(nowdate);
        if (compare >= 0) { // stopdate >= nowdate ���� �����Ⱓ�϶�
          mav.setViewName("redirect:/member/login_msg.jsp");
          msg = "�α����� " + sdf.format(stopdate) + " ���� ������ ȸ���Դϴ�.";
          mav.addObject("msg", msg);
          return mav;

        } else { // stopdate < nowdate ���� �ð��� �������� ��������
          memberProc.stopdate_update("", memberVO.getMemberno());
        }
      } // ���������� �����Ҷ� END
      // ������ ��� : �α��� ����
      // -------------------------------------------------------------------
      // session ���� ����
      // -------------------------------------------------------------------
      session.setAttribute("memberno", memberVO.getMemberno());
      // session ���� ��ü
      session.setAttribute("email", email);
      // session.setAttribute("passwd", passwd);
      session.setAttribute("nickname", memberVO.getNickname());
      session.setAttribute("act", memberVO.getAct());

      // -------------------------------------------------------------------
      // email ���� ��Ű ����
      // -------------------------------------------------------------------
      if (email_save.equals("Y")) { // email�� ������ ���
        Cookie ck_email = new Cookie("ck_email", email);
        ck_email.setMaxAge(60 * 60 * 72 * 10); // 30 day, �ʴ���
        response.addCookie(ck_email);
      } else { // N, email�� �������� �ʴ� ���
        Cookie ck_email = new Cookie("ck_email", "");
        ck_email.setMaxAge(0);
        response.addCookie(ck_email);
      }
      // email�� �������� �����ϴ� CheckBox üũ ����
      Cookie ck_email_save = new Cookie("ck_email_save", email_save);
      ck_email_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_email_save);
      // -------------------------------------------------------------------

      // -------------------------------------------------------------------
      // Password ���� ��Ű ����
      // -------------------------------------------------------------------
      if (passwd_save.equals("Y")) { // �н����� ������ ���
        Cookie ck_passwd = new Cookie("ck_passwd", passwd);
        ck_passwd.setMaxAge(60 * 60 * 72 * 10); // 30 day
        response.addCookie(ck_passwd);
      } else { // N, �н����带 �������� ���� ���
        Cookie ck_passwd = new Cookie("ck_passwd", "");
        ck_passwd.setMaxAge(0);
        response.addCookie(ck_passwd);
      }
      // passwd�� �������� �����ϴ� CheckBox üũ ����
      Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
      ck_passwd_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_passwd_save);
      // -------------------------------------------------------------------

      // �α��� ���� �߰�
      LoginVO loginVO = new LoginVO();

      loginVO.setIp(request.getRemoteAddr());
      loginVO.setMemberno(memberVO.getMemberno());

      loginProc.create(loginVO);

      // -------------------------------------------------------------------

      mav.setViewName("redirect:/index.jsp");

      // �α��� ���� END
    } // �н����� ��ġ�ϴ� ��� END
    return mav;

  }

  /**
   * �α׾ƿ� ó��
   * 
   * @param request
   * @param session
   * @return
   */
  @RequestMapping(value = "/member/logout.do", method = RequestMethod.GET)
  public ModelAndView logout(HttpServletRequest request, HttpSession session) {

    ModelAndView mav = new ModelAndView();

    session.invalidate(); // session ���� ��ü�� ��ϵ� ��� session ���� ����

    mav.setViewName("redirect:/member/logout_msg.jsp");

    return mav;
  }

  /**
   * �ߺ� �̸��� �˻�, JSON
   * http://localhost:9090/fm/member/checkEmail.do?email=user1@mail.com
   * 
   * @param email
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/member/getPhoto.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String getPhoto(HttpSession session, @RequestParam(value = "memberno", defaultValue = "0") int memberno) {
    JSONObject json = new JSONObject();

    if (memberno != 0) { // �α��� ���¿��� ����
      MemberVO memberVO = memberProc.getPhoto(memberno);
      if (Integer.parseInt(memberVO.getSizes()) == 0) { // ����� ������ ������
        json.put("sizes", 0);
      } else { // �������̹��� ��½�
        json.put("thumbs", memberVO.getThumbs());
        json.put("photo", memberVO.getPhoto());
        json.put("sizes", memberVO.getSizes());
      }
    }
    return json.toString();
  }

}