<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<!-- 자신의 평가 보기 -->

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
 
 <link rel="stylesheet" href="../js/rating.css" type="text/css" media="screen" title="Rating CSS">
<!--  <script type="text/javascript" src="../js/jquery.min.js"></script> -->
<script type="text/javascript" src="../js/rating.js"></script>
 
<script type="text/javascript">
$(function(){                   // Start when document ready
  $('#star-rating').rating(); // Call the rating plugin
}); 

/* $(function(){
  $('#star-rating').rating(function(vote, event){
      // we have vote and event variables now, lets send vote to server.
      
//       $.ajax({
//           url: "/get_votes.php",
//           type: "GET",
//           data: {rate: vote},
//       });
  });
}); */

  function update_grade(memberno) {
    var grade_memno = ${gradeVO.memberno}
    if (grade_memno == memberno) {
      alert('자신의 평점은 등록할 수 없습니다.')
    } else {
      // 문자열: ', ""
      var url = './grade_update.do?mno=' + memberno;
      var width = 500;
      var height = 400;
      var win = window.open(url, '평점 등록', 'location=no, menubar=no, resizable =no, width=' 
          + width + 'px, height='+ height + 'px');
      var x = (screen.width - width) / 2;
      var y = (screen.height - height) / 2;

      win.moveTo(x, y);
    }
  }
</script>
</head> 
 
<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >  
 
  <ASIDE style='float: left;'>
      <A href='./list.do'>내 평점 보기</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  <button type='button' onclick="update_grade('${sessionScope.memberno}');">평점 등록</button>
평가 수 : ${gradeVO.numgrade } <br>

<br/>전체 평점 : ${gradeVO.avggrade } (제일 크게)<br/>
<div class="bigstarOff"><div class="bigstarOn" style="width: 76%;"></div></div>
<br/> 
<br/><br>판매자태도 : ${gradeVO.manner }  <br />  
  <div style="CLEAR: both;  PADDING-RIGHT: 0px; PADDING-LEFT: 0px;  BACKGROUND: url(./image/star.png) 0px 0px;  FLOAT: left;  PADDING-BOTTOM: 0px;  MARGIN: 0px;  WIDTH: 300px;  PADDING-TOP: 0px; HEIGHT: 60px;">
  <p style="WIDTH: ${gradeVO.manner*20 }%; PADDING-RIGHT:0px;  PADDING-LEFT:0px; BACKGROUND: url(./image/star_on.png) 0px 0px; PADDING-BOTTOM: 0px;  MARGIN: 0px;  PADDING-TOP: 0px; HEIGHT: 60px;">
  </p>
  </div>
<br/> 
<br/><br>배송속도 : ${gradeVO.delivery } <br />  
  <div style="CLEAR: both;  PADDING-RIGHT: 0px; PADDING-LEFT: 0px;  BACKGROUND: url(./image/star.png) 0px 0px;  FLOAT: left;  PADDING-BOTTOM: 0px;  MARGIN: 0px;  WIDTH: 300px;  PADDING-TOP: 0px; HEIGHT: 60px;">
  <p style="WIDTH: ${gradeVO.delivery*20 }%; PADDING-RIGHT:0px;  PADDING-LEFT:0px; BACKGROUND: url(./image/star_on.png) 0px 0px; PADDING-BOTTOM: 0px;  MARGIN: 0px;  PADDING-TOP: 0px; HEIGHT: 60px;">
  </p>
  </div>  
<br/> 
<br/><br>상품품질 : ${gradeVO.quality } <br /> 
  <div style="CLEAR: both;  PADDING-RIGHT: 0px; PADDING-LEFT: 0px;  BACKGROUND: url(./image/star.png) 0px 0px;  FLOAT: left;  PADDING-BOTTOM: 0px;  MARGIN: 0px;  WIDTH: 300px;  PADDING-TOP: 0px; HEIGHT: 60px;">
  <p style="WIDTH: ${gradeVO.quality*20 }%; PADDING-RIGHT:0px; PADDING-LEFT:0px; BACKGROUND: url(./image/star_on.png) 0px 0px; PADDING-BOTTOM: 0px;  MARGIN: 0px;  PADDING-TOP: 0px; HEIGHT: 60px;">
  </p>
  </div>    
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>
  