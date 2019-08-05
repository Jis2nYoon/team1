<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> --%>

 <!-- 이 페이지는 관리자만 접근 가능-->
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>Flea market</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
 window.onload = function(){
 }
 
 
 
</script>
</head> 
 
<body>
<DIV class='container'>
<DIV class='content'>
  <DIV class='aside_menu'>
    <ASIDE style='float: left;'>관리자 > 목록 > 계정 정지일 설정</ASIDE> 
    <ASIDE style='float: right;'>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV>

<FORM name='frm' method='POST' action='./stopdate_update.do'>
  <input type='hidden' id='memberno' name='memberno' value=' ${param.memberno }'>
  <fieldset class='fieldset_no_line'>
  <ul>
<li class='li_right'>
    <select name = "stopdate" id = "stopdate">
<option value = "-1">정지 해제</option>
<option value = "7">7일 후</option>
<option value = "30">30일 후</option>
<option value = "90">90일 후</option>
</select> 
</li>
<li class='li_right'>
        <button type='submit'>적용</button>
        <button type='button'  onclick = 'window.close();'>취소</button> 
      </li>
      </ul>
  </fieldset>
</FORM>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
 
</html> 