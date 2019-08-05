<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
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
 /*  function stopdate_update(memberno) {
    // 문자열: ', ""
    var url = './stopdate_update.do?memberno=' + memberno ;
    var width = 500;
    var height = 400;
    var win = window.open(url, '계정 정지일 설정', 'width='+width+'px, height='+height+'px');
    var x = (screen.width - width) / 2; 
    var y = (screen.height - height) / 2;
    
    win.moveTo(x, y);
  
  } */
</script>
</head> 
 
<body>

<section class="container" id="star-rating" >
    <input type="radio" name="example" class="rating" value="1" />
    <input type="radio" name="example" class="rating" value="2" />
    <input type="radio" name="example" class="rating" value="3" />
    <input type="radio" name="example" class="rating" value="4" />
    <input type="radio" name="example" class="rating" value="5" />
</section>

</body>
 
</html>
  