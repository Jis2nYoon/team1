<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
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
 
<body><DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >  
 
  <ASIDE style='float: left;'>
      <A href='./list.do'>회원 목록</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  
  <table class="table table-striped" style='width: 100%; '>
  <colgroup>
    <col style='width: 40%;'/>
    <col style='width: 60%;'/>
  </colgroup>
  <TR>
    <TH class='th'>ip 주소</TH>
    <TH class='th'>날짜</TH>
  </TR>
 
  <c:forEach var="loginVO" items="${list }">
    <c:set var="loginno" value ="${loginVO.loginno }" /> 
  <TR>
    <TD class='td' >${loginVO.ip}</TD>
    <TD class='td' >${loginVO.ldate}</TD>
    
  </TR>
  </c:forEach>
  
</TABLE>
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>
  