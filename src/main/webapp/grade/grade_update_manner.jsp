<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> --%>

 <!-- 평점 등록 form -->
 
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
 
 <!--  별점처리 -->
 <link rel="stylesheet" href="../js/rating.css" type="text/css" media="screen" title="Rating CSS">
<!--  <script type="text/javascript" src="../js/jquery.min.js"></script> -->
<script type="text/javascript" src="../js/rating.js"></script>
 
<script type="text/javascript">
// $(function(){                   // Start when document ready
//   $('#star-rating').rating(); // Call the rating plugin
// }); 

$(function(){
  $('#star-rating-manner').rating(function(vote, event){
      // we have vote and event variables now, lets send vote to server.
      
//       $.ajax({
//           url: "/get_votes.php",
//           type: "GET",
//           data: {rate: vote},
//       });
      alert('vote: '+vote+' event: '+event)
  });
  
  $('#star-rating-delivery').rating(function(vote, event){
    // we have vote and event variables now, lets send vote to server.
    
//     $.ajax({
//         url: "/get_votes.php",
//         type: "GET",
//         data: {rate: vote},
//     });
    alert('vote: '+vote+' event: '+event)
});
  $('#star-rating-quality').rating(function(vote, event){
    // we have vote and event variables now, lets send vote to server.
    
//     $.ajax({
//         url: "/get_votes.php",
//         type: "GET",
//         data: {rate: vote},
//     });
    alert('vote: '+vote+' event: '+event)
});
});
 
 
 
</script>
</head> 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

<FORM name='frm'  style = "margin:0px auto;" method='POST' action='./grade_update.do'>
  <input type='hidden' id='manner' name='manner' >
  <input type='hidden' id='delivery' name='delivery' >
  <input type='hidden' id='quality' name='quality' >
  <input type='hidden' id='mno' name='mno' value=' ${param.mno }'>

  <br><br>판매자 태도
<section class="container" id="star-rating-manner" >
    <input type="radio" name="example" class="rating" value="1" />
    <input type="radio" name="example" class="rating" value="2" />
    <input type="radio" name="example" class="rating" value="3" />
    <input type="radio" name="example" class="rating" value="4" />
    <input type="radio" name="example" class="rating" value="5" />
</section>
<br><br>배송 속도
 <section class="container" id="star-rating-delivery" >
    <input type="radio" name="example" class="rating" value="1" />
    <input type="radio" name="example" class="rating" value="2" />
    <input type="radio" name="example" class="rating" value="3" />
    <input type="radio" name="example" class="rating" value="4" />
    <input type="radio" name="example" class="rating" value="5" />
</section>
<br><br>상품 품질
<section class="container" id="star-rating-quality" >
    <input type="radio" name="example" class="rating" value="1" />
    <input type="radio" name="example" class="rating" value="2" />
    <input type="radio" name="example" class="rating" value="3" />
    <input type="radio" name="example" class="rating" value="4" />
    <input type="radio" name="example" class="rating" value="5" />
</section>
<br>
<button type = "submit" style="text-align: center;">등록</button>

</FORM>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 