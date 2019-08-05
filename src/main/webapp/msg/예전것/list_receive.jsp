<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>보낸 쪽지함</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
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
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <DIV class='title_line'>받은 쪽지 보기</DIV>
 
  <DIV class='menu_line' style='clear: both;'>>>받은 쪽지  /  
  <a href="./list_send.do?memberno=1&contentsno=${param.contentsno }">보낸 쪽지</a></DIV>
  
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 15%;"></col>
        <col style="width: 50%;"></col>
        <col style="width: 20%;"></col>
        <col style="width: 15%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>보낸 사람</th>
          <th>제목</th>
          <th style='text-align: center;'>보낸 날짜</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="mem_MsgVO" items="${list }">
          <tr> 
            <td style='text-align: center;'>${mem_MsgVO.receivernickname }</td>
            <td>
              <a href="./read_msg.do?msgno=${mem_MsgVO.msgno }">${mem_MsgVO.msgtitle}</a> 
            </td> 
            <td style='text-align: center;'>${mem_MsgVO.msgtime}</td>
            <td style='text-align: center;'>
              <a href="./create.do?memberno=${mem_MsgVO.msgsender}&contentsno=${param.contentsno }'"><span class="glyphicon glyphicon-edit" title="답장하기"></span></A>
              <a href="./delete_msg.do?msgno=${mem_MsgVO.msgno }&check=2&memberno=${mem_MsgVO.memberno}&contentsno=${param.contentsno }"><span class="glyphicon glyphicon-trash" title="삭제하기"></span></A>
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
    <br><br>
  </div>
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>