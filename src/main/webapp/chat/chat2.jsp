<%@ page contentType="text/html; charset=UTF-8" %>
 <!-- 채팅 기본 화면 -->
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
    
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
 <!--  여기서 부터가 1대1 채팅 부분 --> 
 
<!-- 채팅방 컨테이너 시작 -->
  <div class="messages_container">
  <!-- 본인 프로필 시작 -->
    <div class="contact-profile"> 
      <img class="contact-profile_img" src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />
      <p>Harvey Specter</p>
    </div>
  <!-- 본인 프로필  끝 -->
  <!-- 채팅 메세지 시작 -->
  <!-- ul과 li를 사용함. -->
    <div class="messages_content">
      <ul>
        <li class="sent">
          <img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />
          <p>How the hell am I supposed to get a jury to believe you when I am not even sure that I do?!</p>
        </li>
        <li class="replies">
          <img src="https://mdbootstrap.com/img/Photos/Avatars/img%20(10).jpg" alt="" />
          <p>When you're backed against the wall, break the god damn thing down.</p>
        </li>
        <li class="replies">
          <img src="https://mdbootstrap.com/img/Photos/Avatars/img%20(10).jpg" alt="" />
          <p>Excuses don't win championships.</p>
        </li>
        <li class="sent">
          <img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />
          <p>Oh yeah, did Michael Jordan tell you that?</p>
        </li>
        <li class="replies">
          <img src="https://mdbootstrap.com/img/Photos/Avatars/img%20(10).jpg" alt="" />
          <p>No, I told him that.</p>
        </li>
        <li class="replies">
          <img src="https://mdbootstrap.com/img/Photos/Avatars/img%20(10).jpg" alt="" />
          <p>What are your choices when someone puts a gun to your head?</p>
        </li>
        <li class="sent">
          <img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />
          <p>What are you talking about? You do what they say or they shoot you.</p>
        </li>
        <li class="replies">
          <img src="https://mdbootstrap.com/img/Photos/Avatars/img%20(10).jpg" alt="" />
          <p>Wrong. You take the gun, or you pull out a bigger one. Or, you call their bluff. Or, you do any one of a hundred and forty six other things.</p>
        </li>
      </ul>
    </div> <!-- messages_content END -->
    <div class="message-input">
      <FORM name='frm' method='POST' action='./create.do' enctype="multipart/form-data" class="form-horizontal" id="frm">
        <input type='hidden' name='memberno' id='memberno' value='${param.memberno }'>
        <div class="col-md-11">
            <input type='text' class="form-control" name='' id='' placeholder="Write your message..."  required="required">
          </div><!-- input부분이랑 messages_container 크기 조절을 해야할듯 -->
        <span class="glyphicon glyphicon-send" style="color: white;"></span><!-- 여기에 하이퍼링크 걸어서 누르도록 하면 될듯 -->
      </FORM>
    </div>
  </div><!-- messages_container END -->
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->

 
</body>
</html>