<%@ page contentType="text/html; charset=UTF-8" %>
 
<!--회원 탈퇴 form-->

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea market</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
</script>
</head> 
 
<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >  
  
  <ASIDE style='float: left;'>
      <A href='./member/list.do'>회원 목록</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  
 
  <DIV class='title_line'>회원 탈퇴</DIV>
   
   <FORM name='frm' method='POST' action='./cancel_proc.do' style='text-align:center;'>
    <input type='hidden' name='memberno' id='memberno' value=' ${memberVO.memberno }'>   
     <span class='span_alert'>회원 탈퇴시 복구 할 수 없습니다.</span>
      <br><br>
     <span class='span_alert'>회원 탈퇴를 계속 하시려면 비밀번호 입력 후 [탈퇴] 버튼을 눌러주세요.</span>
      <br>
     <DIV style= "background-color:#dddddd; width:40%; margin:20px auto; text-align:center;">
      <br><label class="col-md-6 control-label">이메일</label> ${memberVO.email }  <br><br><label class="col-md-6 control-label">닉네임</label>${memberVO.nickname } <br><br><label class="col-md-6 control-label">이름</label> ${memberVO.mname }<br><br>
     <label for="passwd" class="col-md-6 control-label">비밀번호 입력</label>    
     <input type='password' class="form-control input-md" name='passwd' id='passwd'  required="required" style='width: 45%;' placeholder="password"><br>
     
   </DIV>
      <button type="submit" class="btn btn-primary btn-md" >탈퇴</button>
      <button type="button" onclick="history.go(-1);" class="btn btn-primary btn-md" >취소</button>
      
</FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 