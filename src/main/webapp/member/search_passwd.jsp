<%@ page contentType="text/html; charset=UTF-8" %>
 
<!--패스워드 찾기 form-->

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
function send() {
  var email = $('#email').val();  
  var params = 'email='+email; // #: id

  $.ajax({
    url: "./search_passwd.do",
    type: "POST",
    cache: false,
    dataType: "json", // or html
    data: params,
    success: function(data){
      var msg = "";

      if(data.count == 0){
        msg = "해당 이메일 계정은 가입되어있지 않습니다."
      } else if(data.count == 1){
        msg = "해당 이메일 주소로 임시 비밀번호를 발송하였습니다."
      } else{
        msg = "임시 비밀번호 전송에 실패했습니다."
      }
       alert(msg);
              
   },
     // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
     error: function (request, status, error){  
       var msg = "에러가 발생했습니다.<br>";
       msg += "다시 시도해주세요.<br>";
       msg += "request.status: " + request.status + "<br>";
       msg += "request.responseText: " + request.responseText + "<br>";
       msg += "status: " + status + "<br>";
       msg += "error: " + error;
       
       alert(msg);
     }
   });
 }




</script>
</head> 
 
<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >  
  
<!--   <ASIDE style='float: left;'>
      <A href='./member/list.do'>회원 목록</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
  -->
<div class='menu_line'></div>
  
 
<DIV class='title_line'>비밀번호 찾기</DIV>
   <form class="form-horizontal" style="text-align:center;">
가입한 이메일계정을 입력하세요.
<div class="form-group" style = "margin-top:35px; ">
<label for="email" class="col-md-6 control-label"  style='width: 45%;'>이메일</label>
<div class="col-md-6">
<input type= 'text' name='email' id='email'  required="required"  class="form-control input-md" style='width: 30%;' placeholder="email@mail.com">
</div>
</div>
 <div style="margin-top:45px;" >            
<button type="button" onclick= "send()" style = " background: #22232D;  margin-top: 20px;" class="btn btn-primary btn-md">확인</button>
<button type="button" onclick="history.go(-1);" style = "background: #22232D;margin-top: 20px;" class="btn btn-primary btn-md">취소</button>
 </div></form>
 <DIV id='panel' class='message' style='text-align: center; display:none; background-color: #FFFFFF; '></DIV>
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 