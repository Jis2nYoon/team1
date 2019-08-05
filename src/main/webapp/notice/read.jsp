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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(document).ready(function(){ // window.onload = function() { ... }

  });

</script>
</head>

<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>   

<DIV class='title_line' >공지사항</DIV>

    <div class="col-sm-10 col-sm-offset-1">
    <div class="panel panel-default">
      <div class="panel-heading">
        <span class="col-sm-1">제 목: </span>
        <span>${mem_NoticeVO.title }</span>
        <span style='float: right;'>
          <A href='./update.do?noticeno=${mem_NoticeVO.noticeno }&word=${param.word}&nowPage=${param.nowPage}'>
          <span class="glyphicon glyphicon-pencil" title="수정"></span></A>
          <A href='./delete.do?noticeno=${mem_NoticeVO.noticeno }&word=${param.word}&nowPage=${param.nowPage}'>
          <span class="glyphicon glyphicon-trash" title="삭제"></span></A>
          <span>|</span>
          ${mem_NoticeVO.rdate.substring(0, 16)}</span>
      </div>
      <tbody>
        <tr>
          <td style='text-align: left;'>
            <div class="panel-body" style='white-space: pre-line;'>${mem_NoticeVO.content } </div>
            <div class="panel-body" style='text-align: right;'>
              작성자: 
              <c:if test="${mem_NoticeVO.thumbs.length() > 0 }">
              <IMG src='./storage/${mem_NoticeVO.thumbs }' style='margin-top: 2px;'></A>
              </c:if>
              ${mem_NoticeVO.nickname }
            </div>
          </td>
        </tr>
      </tbody>
      
  <DIV style='text-align: center; margin: 10px auto;'>
    <button class="btn btn-default" type="button" onclick="location.href='list_by_search_paging.do?word=${param.word}&nowPage=${param.nowPage}'">목록</button>
  </DIV>
  </div>
  </div>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>


   