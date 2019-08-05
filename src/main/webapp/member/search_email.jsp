<%@ page contentType="text/html; charset=UTF-8" %>
 
<!--이메일 찾기 form-->

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
  
 
  <DIV class='title_line'>이메일 찾기</DIV>
   
   <FORM name='frm' method='POST' action='./search_email.do' class="form-horizontal" style="text-align:center;">
    <%-- <input type='hidden' name='memberno' id='memberno' value=' ${memberVO.memberno }'>    --%>
        <br>계정에 등록된 이름과 전화번호를 입력하세요.
        <div class="form-group" style = "margin-top:35px;">
          <label for="name" class="col-md-6 control-label">이름</label>
           <div class="col-md-6">
            <input type='text' name='mname' id='mname'  required="required" class="form-control input-md" style='width: 30%;' placeholder="이름">
           </div>
        </div>
        
        <div class="form-group">
          <label for="tel" class="col-md-6 control-label">전화번호 ('-' 포함 입력)</label>
            <div class="col-md-6">
             <input type='text' name='tel' id='tel'  required="required" class="form-control input-md" style='width: 30%;' placeholder="010-0000-0000">
            </div>
        </div>
        
        <button type="submit" style = "margin-top: 20px; background: #22232D;" class="btn btn-primary btn-md" >확인</button>
        <button type="button" onclick="history.go(-1);" style = "margin-top: 20px; background: #22232D;" class="btn btn-primary btn-md" >취소</button>
     
</FORM>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 