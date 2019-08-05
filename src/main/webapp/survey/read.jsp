<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>설문조사하기</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript">

</script>
</head>
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
  
  <div class='menu_line'><a href ="">보낸 쪽지</A> > 쪽지 읽기</div>
 
  <DIV id='main_panel'></DIV>  <!-- 이미지 출력 -->
  <div class="well well-lg">
  <FORM name='frm' method="get" action='./read_join.do'>
      <input type="hidden" name="surveyno" value="${survey_ItemVO.surveyno }">
      
      <fieldset class="fieldset">
        <ul>
        
          <li class="li_none">
            <span>설문 조사 제목 : ${surveyVO.title}</span> 
          </li>
          <li class="li_none">
            <DIV>설문 조사 설명 :${surveyVO.content}</DIV>
          </li>
          <c:forEach var="surveyitemVO" items="${surveyitemlist }" varStatus="info">

              <input type="radio" >${surveyitemVO.item}<br><br>

        </c:forEach>
        
        </ul>
      </fieldset>
      <button type='button' 
                 onclick="location.href='./create.do?memberno=${msgVO.msgsender}&contentsno=${msgVO.contentsno }'">제출하기</button>
  </FORM>
 </div>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>