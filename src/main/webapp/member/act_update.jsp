<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!--  회원 접근권한 수정 form -->
 <!-- 이 페이지는 관리자만 접근 가능-->

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>Flea market</title> 
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
 
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
 
<body style="font-size:20px;">
<DIV class='container'>
<DIV class='content' >
  <!-- <DIV class='aside_menu'>
    <ASIDE style='float: left;'>관리자 > 목록 > 권한 변경</ASIDE> 
    <ASIDE style='float: right;'>
    </ASIDE> 
    <DIV class='menu_line' style='clear: both;'></DIV>
  </DIV> -->
 
<FORM name='frm' method='POST' action='./act_update.do' style='text-align:center;  height:60%; vertical-align:middle;' >
  <input type='hidden' id='memberno' name='memberno' value=' ${param.memberno }'>
  <fieldset class='fieldset_no_line'>
<ul  style='list-style: none; width:140px; text-align:left; margin:0px auto;  '>
    <li>
       <input id="act" name="act" type="radio" 
          value='M'  ${param.act.trim()== 'M' ? "checked='checked'":""}>
          M: 마스터 </li>
        <li>
       <input id="act" name="act" type="radio" 
          value='Y'  ${param.act.trim()== 'Y' ? "checked='checked'":""}>
          Y: 로그인 가능           
        </li>
        <li>
       <input id="act" name="act" type="radio" 
          value='N'  ${param.act.trim()== 'N' ? "checked='checked'":""}>
          N: 로그인 불가    
        </li>
        <li>      
       <input id="act" name="act" type="radio" 
          value=C  ${param.act.trim()== 'C' ? "checked='checked'":""}>
          C: 탈퇴 회원 </li>
        </ul>
<br>
        <button type='submit'>적용</button>
        <button type='button'  onclick = 'window.close();'>취소</button> 
      
  </fieldset>
</FORM>
 
</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>
 
</html> 