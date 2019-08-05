<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html> 
<html lang="ko"> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea Market</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
</head> 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

<DIV class='title_line'>알림</DIV>

<DIV class='message'>
<br>
  <fieldset class='fieldset_basic'>
    <UL>
    <div style='text-align: center;'>
      <c:choose>
        <c:when test="${param.count == 1 }">
          <label>질문을 삭제했습니다.</label><br>
        </c:when>
        <c:otherwise>
          <label>질문 삭제에 실패했습니다.</label><br>
        </c:otherwise>
      </c:choose>
        <br>
        <c:if test="${param.count != 1 }">
          <button type="button" class="btn btn-default" onclick="javascript:history.back();">다시 시도</button>        
        </c:if>
        <button type="button" class="btn btn-default" onclick="location.href='./list.do'">목록</button>
      </div>
    </UL>
  </fieldset>

</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

   
  