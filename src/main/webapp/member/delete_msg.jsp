<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!--회원 삭제 처리 메세지 -->
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea market</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
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
 
<DIV class='title_line'>회원 삭제</DIV>

        <c:choose>
          <c:when test="${param.count > 0}">
            <div class="alert alert-success alert-dismissable">
             <!-- <button id="msg_close" type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button> -->
               <a href="./list.do" class="close" data-dismiss="alert" aria-hidden="true">×</a>
               <strong>성공!</strong><br>회원 정보 삭제에 성공했습니다.
             </div>
          </c:when>
          <c:otherwise>
            <div class="alert alert-danger alert-dismissable">
          <!-- <button id="msg_close" type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button> -->
          <a href="./list.do" class="close" data-dismiss="alert" aria-hidden="true">×</a>
          <strong>경고!</strong><br>회원 정보 삭제에 실패했습니다.
          </div>
          </c:otherwise>
        </c:choose>
     <br>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 
 