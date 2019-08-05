<%@ page contentType="text/html; charset=UTF-8"%>
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
$(function(){

});
</script>

<script type="text/javascript">
</script>
</head>

<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >

<DIV class='title_line'>질문 게시판</DIV>

  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 10%;"></col>
        <col style="width: 50%;"></col>
        <col style="width: 20%;"></col>
        <col style="width: 20%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>질문 번호</th>
          <th style='text-align: left;'>제 목</th>
          <th style='text-align: center;'>작성자</th>
          <th style='text-align: center;'>등록일</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="mem_QnaVO" items="${list }">
          <tr> 
            <td style='text-align: center;'>${mem_QnaVO.qnano}</td>
            <td>
              <c:choose>
                <c:when test="${mem_QnaVO.ansnum > 0}">    <!-- 답변글인 경우 -->
                  <img src='./images/reply.png'>
                </c:when>
              </c:choose>
              <a href="./read.do?qnano=${mem_QnaVO.qnano}">${mem_QnaVO.title}</a> 
              <c:if test="${mem_QnaVO.files.length() > 0 }">
                <span class="glyphicon glyphicon-picture" title="첨부파일"></span>
                </A>
              </c:if>
            </td>
            <td style='text-align: center;'>${mem_QnaVO.nickname}</td>
            <td style='text-align: center;'>${mem_QnaVO.rdate.substring(0, 10)}</td>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
  </div>

  <button style='float: right;' class="btn btn-default" type="button" onclick="location.href='./create.do'">등록</button>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>
    