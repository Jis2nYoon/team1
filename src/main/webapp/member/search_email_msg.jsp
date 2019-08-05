<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
<!--이메일 찾기 결과 email list 메세지-->

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
 
  <DIV class='title_line'>이메일 찾기 결과</DIV>
   
   <c:if test = "${fn:length(list) != 0}">
   <table class="table table-striped" style='width: 50%; margin: 45px auto;"> '>
 
  <c:forEach var="list" items="${list }">
  <TR>
    
    <TD class='td'  >${list}</TD> <!-- 년월일 -->
    
  </TR>
  </c:forEach>  
   </TABLE>
  </c:if>
   <c:if test = "${fn:length(list) == 0}">
   해당되는 조건의 이메일이 없습니다.
   </c:if>
   
      <div style="text-align: center; margin-top:45px;" >
        <button type='submit' class="btn btn-primary btn-md" style="background: #22232D;" onclick="location.href='./login.do'">로그인</button>
        <button type='button' class="btn btn-primary btn-md" style="background: #22232D;" onclick="location.href='./search_passwd.do'">비밀번호 찾기</button>
        <button type='button' class="btn btn-primary btn-md" style="background: #22232D;" onclick="location.href='./create.do'">회원가입</button>   
   
    </div>  
    
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 