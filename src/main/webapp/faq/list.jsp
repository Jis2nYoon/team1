<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea Market</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

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
  
<DIV class='title_line'>자주 찾는 질문들 (FAQ)</DIV>

<div class="panel-group" id="accordion">
  <c:forEach var="faqVO" items="${list }">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse${faqVO.faqno }">
        <span class="glyphicon glyphicon-question-sign" title="질문"></span> ${faqVO.question }</a>
        
        <!-- 관리자(회원번호:1)만 수정, 삭제 버튼 활성화 -->
        <c:if test="${faqVO.memberno == 1 }">
          <A href='./update.do?faqno=${faqVO.faqno }'>
          <span class="glyphicon glyphicon-pencil" title="수정"></span></A>
          <A href='./delete.do?faqno=${faqVO.faqno }'>
          <span class="glyphicon glyphicon-trash" title="삭제"></span></A>
        </c:if>
        
      </h4>
    </div>
  <div id="collapse${faqVO.faqno }" class="panel-collapse collapse">
    <div class="panel-body">
      　<span class="glyphicon glyphicon-ok-circle" title="답변"></span> ${faqVO.answer }
    </div>
  </div>
  </div>
  </c:forEach> 
</div>

<!-- 관리자(회원번호:1)만 등록 버튼 활성화...되게 해야함 -->
<%-- <c:if test="${faqVO.memberno == 1 }"> --%>
  <button style='float: right;' class="btn btn-default" type="button" onclick="location.href='./create.do'">등록</button>
<%-- </c:if> --%>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

 