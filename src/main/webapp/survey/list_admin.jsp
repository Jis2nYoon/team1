<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>설문조사 질문 목록</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript">
// 항목 리스트 보기
function surveyitem(surveyno) {
  // 문자열: ', ""
  var url = '../surveyitem/list.do?surveyno=' + surveyno;
  var width = 800;
  var height = 600;
  var win = window.open(url, '항목 변경', 'width='+width+'px, height='+height+'px');
  var x = (screen.width - width) / 2; 
  var y = (screen.height - height) / 2;
  
  win.moveTo(x, y);
}
</script>
 
<script type="text/javascript">
</script>
</head>
 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <DIV class='title_line'>설문 조사 질문 목록</DIV>
  
  <DIV class='aside_menu'>
  <ASIDE style='float: left;'>
    <%-- <A href='../categrp/list.do'>카테고리 그룹</A> >
    <A href='./list_by_categrpno.do?categrpno=${param.categrpno }'>${categrpVO.name }</A>  --%>
  </ASIDE> 
  <ASIDE style='float: right;'>
    <A href='./create.do'>설문 질문 등록</A> <span class='menu_divide'> |</span>
    <A href='./list_admin.do'>새로 고침</A> 
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 10%;"></col>
        <col style="width: 30%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 25%;"></col>
        <col style="width: 25%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>번호</th>
          <th>설문 제목</th>
          <th style='text-align: center;'>작성자</th>
          <th style='text-align: center;'>설문 기간</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="surveyVO" items="${list }" varStatus="info">
          <tr> 
            <td style='text-align: center;'>${info.count }</td>
            <td>
              <a href='./read.do?surveyno=${surveyVO.surveyno }'>${surveyVO.title}</a> 
            </td> 
            <td style='text-align: center;'>관리자</td>
            <td style='text-align: center;'>${surveyVO.startdate} ~ ${surveyVO.enddate}</td>
            <td style='text-align: center;'>
              <button class="btn btn-default btn-sm" onclick="location.href='./update.do?surveyno=${surveyVO.surveyno}'">질문 수정</button>
              <button class="btn btn-default btn-sm" onclick="location.href='./delete.do?surveyno=${surveyVO.surveyno}'">질문 삭제</button>
              <button class="btn btn-default btn-sm" onclick="javascript: surveyitem('${surveyVO.surveyno }')">항목 보기</button>
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