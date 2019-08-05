<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>쪽지 1건 읽기</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
$(document).ready(function(){ // window.onload = function() { ... }
  
});

function panel_img(file){
  var panel = '';
  panel += "<DIV id='panel' class='popup_img' style='width: 80%; margin: 0px 5%;'>";
  panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+file+"' style='width: 100%;'></A>";
  panel += "</DIV>";
  
  $('#main_panel').html(panel);
  $('#main_panel').show();
  
}

</script>
</head>
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  
  <div class='menu_line'><a href ="">보낸 쪽지</A> > 쪽지 읽기</div>
 
  <DIV id='main_panel'></DIV>  <!-- 이미지 출력 -->
  <div class="well well-lg">
  <FORM name='frm' method="get" action='./read_msg.do'>
      <input type="hidden" name="msgno" value="${msgVO.msgno }">
      
      <fieldset class="fieldset">
        <ul>
        
          <li class="li_none">
            <span>${msgVO.msgtitle}</span> 
            <span>${msgVO.msgtime.substring(0, 16)}</span>
          </li>
          <li class="li_none">
            <DIV>${msgVO.msgcontent }</DIV>
          </li>
        </ul>
      </fieldset>
            <DIV>
              <c:forEach var ="fileVO"  items="${file_list }">
                <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.thumb }' style='margin-top: 2px;'></A>
              </c:forEach>
            </DIV>
      
      <DIV id='main_panel'></DIV>
      
      <button type='button' 
                 onclick="location.href='./create.do?memberno=${msgVO.msgsender}&contentsno=${msgVO.contentsno }'">쪽지 보내기</button>
  </FORM>
 </div>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>