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
  $(function(){ 
  
  });
</script>
 
</head> 
<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' > 
 
<DIV class='title_line'>알림</DIV>
        <c:choose>
          <c:when test="${param.count == 0}">
            <div class="alert alert-danger alert-dismissable">
          <!-- <button id="msg_close" type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button> -->
          <a href="../index.jsp" class="close" data-dismiss="alert" aria-hidden="true">×</a>
          <strong>경고!</strong><br>패스워드 변경에 실패했습니다.
          </div>
          </c:when>
          <c:when test="${param.count == 1}">
            <div class="alert alert-success alert-dismissable">
          <!-- <button id="msg_close" type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button> -->
          <a href="../index.jsp" class="close" data-dismiss="alert" aria-hidden="true">×</a>
          <strong>성공!</strong><br>패스워드 변경에 성공했습니다.
            </div>
          </c:when>
        </c:choose>
     <br>
        
          [<A href='./passwd_update.do'>패스워드 다시 수정</A>]
          [<A href='./list.do'>목록</A>]
        
       <br>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 