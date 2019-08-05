<%@ page contentType="text/html; charset=UTF-8" %>
 
  <!--로그인 form -->
  
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>Flea Market Login</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
 <!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript" src="../js/jquery.cookie.js"></script>

<script type="text/javascript">
 function loadDefault(){
   $('#email').val('master@mail.com');
   $('#passwd').val('123');
   
 }

 </script>
</head> 
 
<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' > 
 
<DIV class='title_line' >로그인</DIV>
 

  <FORM name='frm' method='POST' action='./login.do' class="form-horizontal" >
  
    <div class="form-group" style="margin-top:45px;">
      <label for="email" style='width: 45%;' class="col-md-6 control-label" >이메일</label>    
      <div class="col-md-6">
        <input type='text' class="form-control input-md" name='email' id='email' value='${ck_email }' required="required" style='width: 30%;' placeholder="이메일 계정" autofocus="autofocus">
       <Label>   
          <input type='checkbox' name='email_save' value='Y' 
                    ${ck_email_save == 'Y' ? "checked='checked'" : "" }> 저장
        </Label></div>
      </div>
  
 
    <div class="form-group">
      <label for="passwd" style='width: 45%;' class="col-md-6 control-label">패스워드</label>    
      <div class="col-md-6">
        <input type='password' class="form-control input-md" name='passwd' id='passwd' value='${ck_passwd }' required="required" style='width: 30%;' placeholder="패스워드">
        <Label>
          <input type='checkbox' name='passwd_save' value='Y' 
                    ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
        </Label>
      </div>
    </div>   
  <div style="text-align: center; margin-top:45px;" >            
        <button type='submit' class="btn btn-primary btn-md" style = "background:#22232D;">로그인</button>
        <button type='button' class="btn btn-primary btn-md" style = "background:#22232D;" onclick="location.href='./search_email.do'">이메일 찾기</button>
        <button type='button' class="btn btn-primary btn-md" style = "background:#22232D;" onclick="location.href='./search_passwd.do'">비밀번호 찾기</button>
        <button type='button' class="btn btn-primary btn-md" style = "background:#22232D;" onclick="location.href='./create.do'">회원가입</button>   
        <button type='button' class="btn btn-primary btn-md" style = "background:#22232D;" onclick="loadDefault()">테스트 계정</button> 
    </div>
  
    
  </FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 
 