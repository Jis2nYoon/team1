<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!--  회원 접근권한 수정 처리 -->

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />

<title>Flea market</title> 



</head> 
 
<body>
<DIV class='container'>
<DIV class='content'>
 <script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
<script type="text/javascript">

  opener.location.reload(); // window.open() 호출한 부모 윈도우 새로 고침
  window.close(); // 현재 창 닫기
  <c:choose>
  <c:when test="${param.count == 1}">
    alert('성공')
  </c:when>
  <c:when test="${param.count == 0}">
  alert('실패')
  </c:when>
</c:choose>
  /* ${param.count ==1 }){
    alert('권한변경 성공')
  } */
  /* ${param.count ==1 }){
    alert('권한변경 성공')
  } */
</script>
 <%--  <c:choose>
          <c:when test="${param.count == 1}">
            alert('성공');
          </c:when>
          <c:when test="${param.count == 0}">
          alert('실패');
          </c:when>
        </c:choose>  --%>
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
</html> 