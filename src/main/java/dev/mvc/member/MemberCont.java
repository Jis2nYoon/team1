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
   * 중복 이메일 검사, JSON
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
   * 중복 닉네임 검사, JSON
   * 
   * @param 닉네임
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
   * 패스워드 변경폼
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
   * 패스워드를 변경합니다.
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

    count = memberProc.login(email, passwd); // 현재 패스워드 검사

    if (count == 1) { // 로그인한 회원의 패스워드 검사
      int count_update = memberProc.passwd_update(new_passwd, email);
      mav.setViewName("redirect:/member/passwd_update_msg.jsp?count=" + count_update);
    } else { // 기존 비밀번호 틀렸을때
      mav.setViewName("redirect:/member/passwd_update_msg.jsp?count=" + count);
    }

    return mav;
  }

  /**
   * 계정 정지일 변경 form
   */
  @RequestMapping(value = "/member/stopdate_update.do", method = RequestMethod.GET)
  public ModelAndView stopdate_update() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/stopdate_update"); // /webapp/member/stopdate_update.jsp

    return mav;
  }

  /**
   * 계정 정지일 변경 처리
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
   * 사진 파일 업로드 form
   */
  @RequestMapping(value = "/member/photo_update.do", method = RequestMethod.GET)
  public ModelAndView photo_update(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    int memberno=0;
    if (memberProc.isMember(session)) { // 로그인 되어있는 경우
      memberno = (int) session.getAttribute("memberno"); // 현재 세션 내용 불러오기
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
   * 사진 파일 삭제
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
    count = memberProc.photo_update(memberVO); // db 저장
    if (count == 1) {
      json.put("doing", "delete");
    } else
      json.put("doing", "fail");

    return json.toString();
  }

  /**
   * 사진 파일 업로드 처리
   */
  @ResponseBody
  @RequestMapping(value = "/member/photo_update.do", method = RequestMethod.POST)
  public String photo_update(HttpSession session, HttpServletRequest request, MultipartFile file) {

    int memberno = (int) session.getAttribute("memberno");
    JSONObject json = new JSONObject();
    int count = 0;

    // -------------------------------------------------------------------
    // Fileupload 콤포넌트 관련 코드, 하나의 파일을 업로드 처리
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/member/storage");
    String tempDir = Tool.getRealPath(request, "/member/temp");

    String filename = ""; // 업로드 파일명
    String thumbs_name = ""; // 썸네일 파일명

    long filesize = file.getSize(); // 파일 사이즈
    if (filesize > 0) {

      filename = Upload.saveFileSpring(file, upDir); // 서버에 파일 저장
      if (Tool.isImage(filename)) { // 이미지인지 검사
        thumbs_name = Tool.preview(tempDir, upDir, filename, 180, 180); // Thumb
                                                                        // 이미지
                                                                        // 생성

        MemberVO memberVO = new MemberVO();
        memberVO.setMemberno(memberno);
        memberVO.setPhoto(filename);
        memberVO.setThumbs(thumbs_name);
        memberVO.setSizes(Long.toString(filesize));
        count = memberProc.photo_update(memberVO); // db 저장

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
   * 권한 변경 form
   */
  @RequestMapping(value = "/member/act_update.do", method = RequestMethod.GET)
  public ModelAndView act_update() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/act_update"); // /webapp/member/list.jsp

    return mav;
  }

  /**
   * 권한 변경 처리
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
   * 회원가입 폼 http://localhost:9090/fm/member/create.do
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
   * 회원가입 처리 http://localhost:9090/fm/member/create.do
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
   * 이메일 찾기 form
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
   * 이메일 찾기 처리
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
   * 비밀번호 찾기 form
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
   * 비밀번호 찾기 proc
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/member/search_passwd.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
  public String search_passwd(String email) {
    // String msg = "";

    int count = memberProc.checkEmail(email.trim());
    if (count == 0) {
      // msg = "해당 이메일 계정은 가입되어있지 않습니다.";
    } else {
      String key = Tool.key();

      String setfrom = "fleamarket0215@gmail.com";
      String title = " Flea market 임시 비밀번호"; // 제목
      String content = "비밀번호 임시 비밀번호 = " + key;

      try {
        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

        messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
        messageHelper.setTo(email); // 받는사람 이메일
        messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
        messageHelper.setText(content); // 메일 내용

        mailSender.send(message);
        count = memberProc.passwd_update(key.trim(), email);
        if (count == 1) {
        }
        // msg = "해당 이메일 주소로 임시 비밀번호를 발송하였습니다."; //성공
      } catch (Exception e) {
        System.out.println("실패: " + e);
        count = -1;
        // msg = "임시 비밀번호 전송에 실패했습니다."; //실패
      }
    }
    JSONObject json = new JSONObject(count);
    json.put("count", count);

    return json.toString();

  }

  /**
   * 회원 목록 http://localhost:9090/fm/member/list.do
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
         * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15
         * 16 17 18 19 20 [다음]
         *
         * @param listFile
         *          목록 파일명
         * @param cateno
         *          카테고리번호
         * @param search_count
         *          검색(전체) 레코드수
         * @param nowPage
         *          현재 페이지
         * @param word
         *          검색어
         * @return 페이징 생성 문자열
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
   * 회원 정보 1건 읽기
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
   * 회원정보 수정 처리
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
   * 회원 탈퇴 form
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
   * 회원 탈퇴 처리
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
   * 회원정보 삭제 form
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
   * 회원정보 삭제 처리
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
    // redirectAttributes.addAttribute("memberno", memberno); // 회원 번호

    mav.setViewName("redirect:/member/delete_msg.jsp");

    return mav;
  }

  /**
   * 로그인 form
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

    String ck_email = ""; // email 저장 변수
    String ck_email_save = ""; // email 저장 여부를 체크하는 변수
    String ck_passwd = ""; // passwd 저장 변수
    String ck_passwd_save = ""; // passwd 저장 여부를 체크하는 변수

    if (cookies != null) {
      for (int i = 0; i < cookies.length; i++) {
        cookie = cookies[i]; // 쿠키 객체 추출

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
   * 로그인 처리
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
    if (memberProc.checkEmail(email) != 1) { // 로그인 실패시
      mav.setViewName("redirect:/member/login_msg.jsp");
      msg = "존재하지 않는 이메일 계정입니다.";
      mav.addObject("msg", msg);
    } else if (memberProc.login(email, passwd) != 1) { // 로그인 실패시
      mav.setViewName("redirect:/member/login_msg.jsp");
      msg = "이메일 또는 패스워드가 일치하지 않습니다.";
      mav.addObject("msg", msg);

    } else { // 패스워드 일치하는 경우
      MemberVO memberVO = memberProc.readByEmail(email);

      // act 검사
      if (memberVO.getAct().equals("C")) {
        mav.setViewName("redirect:/member/login_msg.jsp");
        msg = "이미 탈퇴한 회원입니다.";
        mav.addObject("msg", msg);
        return mav;
      } else if (memberVO.getAct().equals("N")) {
        mav.setViewName("redirect:/member/login_msg.jsp");
        msg = "로그인이 정지된 회원입니다.";
        mav.addObject("msg", msg);
        return mav;
      } // act 검사 END

      // stopdate 검사
      if (memberVO.getStopdate() != "") { // 정지기한이 존재할때
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
        if (compare >= 0) { // stopdate >= nowdate 아직 정지기간일때
          mav.setViewName("redirect:/member/login_msg.jsp");
          msg = "로그인이 " + sdf.format(stopdate) + " 까지 정지된 회원입니다.";
          mav.addObject("msg", msg);
          return mav;

        } else { // stopdate < nowdate 현재 시간이 정지일을 지났을때
          memberProc.stopdate_update("", memberVO.getMemberno());
        }
      } // 정지기한이 존재할때 END
      // 나머지 경우 : 로그인 진행
      // -------------------------------------------------------------------
      // session 세션 저장
      // -------------------------------------------------------------------
      session.setAttribute("memberno", memberVO.getMemberno());
      // session 내부 객체
      session.setAttribute("email", email);
      // session.setAttribute("passwd", passwd);
      session.setAttribute("nickname", memberVO.getNickname());
      session.setAttribute("act", memberVO.getAct());

      // -------------------------------------------------------------------
      // email 관련 쿠키 저장
      // -------------------------------------------------------------------
      if (email_save.equals("Y")) { // email를 저장할 경우
        Cookie ck_email = new Cookie("ck_email", email);
        ck_email.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
        response.addCookie(ck_email);
      } else { // N, email를 저장하지 않는 경우
        Cookie ck_email = new Cookie("ck_email", "");
        ck_email.setMaxAge(0);
        response.addCookie(ck_email);
      }
      // email를 저장할지 선택하는 CheckBox 체크 여부
      Cookie ck_email_save = new Cookie("ck_email_save", email_save);
      ck_email_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_email_save);
      // -------------------------------------------------------------------

      // -------------------------------------------------------------------
      // Password 관련 쿠키 저장
      // -------------------------------------------------------------------
      if (passwd_save.equals("Y")) { // 패스워드 저장할 경우
        Cookie ck_passwd = new Cookie("ck_passwd", passwd);
        ck_passwd.setMaxAge(60 * 60 * 72 * 10); // 30 day
        response.addCookie(ck_passwd);
      } else { // N, 패스워드를 저장하지 않을 경우
        Cookie ck_passwd = new Cookie("ck_passwd", "");
        ck_passwd.setMaxAge(0);
        response.addCookie(ck_passwd);
      }
      // passwd를 저장할지 선택하는 CheckBox 체크 여부
      Cookie ck_passwd_save = new Cookie("ck_passwd_save", passwd_save);
      ck_passwd_save.setMaxAge(60 * 60 * 72 * 10); // 30 day
      response.addCookie(ck_passwd_save);
      // -------------------------------------------------------------------

      // 로그인 내역 추가
      LoginVO loginVO = new LoginVO();

      loginVO.setIp(request.getRemoteAddr());
      loginVO.setMemberno(memberVO.getMemberno());

      loginProc.create(loginVO);

      // -------------------------------------------------------------------

      mav.setViewName("redirect:/index.jsp");

      // 로그인 진행 END
    } // 패스워드 일치하는 경우 END
    return mav;

  }

  /**
   * 로그아웃 처리
   * 
   * @param request
   * @param session
   * @return
   */
  @RequestMapping(value = "/member/logout.do", method = RequestMethod.GET)
  public ModelAndView logout(HttpServletRequest request, HttpSession session) {

    ModelAndView mav = new ModelAndView();

    session.invalidate(); // session 내부 객체의 등록된 모든 session 변수 삭제

    mav.setViewName("redirect:/member/logout_msg.jsp");

    return mav;
  }

  /**
   * 중복 이메일 검사, JSON
   * http://localhost:9090/fm/member/checkEmail.do?email=user1@mail.com
   * 
   * @param email
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/member/getPhoto.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String getPhoto(HttpSession session, @RequestParam(value = "memberno", defaultValue = "0") int memberno) {
    JSONObject json = new JSONObject();

    if (memberno != 0) { // 로그인 상태에만 실행
      MemberVO memberVO = memberProc.getPhoto(memberno);
      if (Integer.parseInt(memberVO.getSizes()) == 0) { // 저장된 사진이 없을때
        json.put("sizes", 0);
      } else { // 프로필이미지 출력시
        json.put("thumbs", memberVO.getThumbs());
        json.put("photo", memberVO.getPhoto());
        json.put("sizes", memberVO.getSizes());
      }
    }
    return json.toString();
  }

}