<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>받은 쪽지함</title>
 
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
  
  <form name='frm' id='frm' method="get" action="./receive_list_search_paging.do">
  <input type='hidden' name='contentsno' id='contentsno' value='${param.contentsno }'>
  <input type='hidden' name='memberno' id='memberno' value='${param.memberno }'>
  
  <ASIDE style='float: right;'>
    <!--  <A href="javascript:location.reload();">새로고침</A>-->
      <SELECT name='col' onchange="total_list(this.form);">
        <OPTION value='nickname' <c:if test="${param.col.trim()  == 'nickname' }">selected="selected"</c:if>>성명</OPTION>
        <OPTION value='msgtitle' <c:if test="${param.col.trim()  == 'msgtitle' }">selected="selected"</c:if>>제목</OPTION>
        <OPTION value='msgcontent' <c:if test="${param.col.trim()  == 'msgcontent' }">selected="selected"</c:if>>내용</OPTION>
        <OPTION value='msgtitle_content' <c:if test="${param.col.trim()  == 'msgtitle_content' }">selected="selected"</c:if>>제목+내용</OPTION>
      </SELECT>
      <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
      <BUTTON type='submit'>검색</BUTTON>
  </ASIDE>
  </form>  
 <DIV class='menu_line' style='clear: both;'>
 <div class="btn-group">
  <button type="button" class="btn btn-info" onclick="location.href='#'">받은 쪽지</button>
  <button type="button" class="btn btn-info" onclick="location.href='send_list_search_paging.do?memberno=${param.memberno}&contentsno=${param.contentsno }'">보낸 쪽지</button>
  </div>
</DIV>
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 15%;"></col>
        <col style="width: 60%;"></col>
        <col style="width: 10%;"></col>
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
              <a href="./delete_msg.do?msgno=${mem_MsgVO.msgno }&check=1&memberno=${param.memberno}&contentsno=${param.contentsno }"><span class="glyphicon glyphicon-trash" title="삭제하기"></span></A>
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
      <DIV class='bottom_menu'>${paging }</DIV>
    <br><br>
  </div>
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>