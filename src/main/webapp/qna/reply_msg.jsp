<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea Market</title>
 
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
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
<DIV class='title_line'>알림</DIV>
 <br>
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
    <div style='text-align: center;'>
      <c:choose>
        <c:when test="${param.count == 0}">
          <label>답변에 실패했습니다.</label><br>
          <label>다시 시도해주세요.</label><br>
          <li class='li_none'>
            <br>
            <button type='button' onclick='history.back()'>다시 시도</button>
            <button type='button' class="btn btn-default" onclick="location.href='./list.do'">목록</button>
          </li>
                     
        </c:when>
        <c:when test="${param.count == 1}">
          <label>답변에 성공했습니다.</label><br>
            <br>
            <%-- <button type='button' onclick="location.href='./read.do?cateno=${param.cateno}&contentsno=${param.contentsno}'">변경 확인</button> --%>
            <button type='button' class="btn btn-default" onclick="location.href='./list.do'">목록</button>        
        </c:when>
      </c:choose>    
      </div>
    </UL>
  </fieldset>
 
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 