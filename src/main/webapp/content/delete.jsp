<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <!-- 이 페이지는 관리자와 해당 글을 쓴 회원만 접근 가능 -->
 <!-- 글 삭제 페이지 -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea Market</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/JavaScript">

</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'> 
  <div class='title_line'>${contentVO.title } 글 삭제</div>
  
  <FORM name='frm' method='POST' action='./delete.do'>
    <input type='hidden' name='contentsno' value='${contentVO.contentsno}'>
    <div class="form-group">   
      <div class="col-md-12" style='text-align: center; margin: 30px;'>
        삭제 되는글: ${contentVO.title }<br><br>
        삭제하시겠습니까? 삭제하시면 복구 할 수 없습니다.<br>
        <br>
        <button class="btn btn-default" type = "submit">삭제 진행</button>
        <button class="btn btn-default" type = "button" onclick = "history.back()">취소</button>
      </div>
    </div>   
  </FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
