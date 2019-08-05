<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function(){

  });
</script>
<style>
.msginput{
  width: 80%;
  display: inline-block;
  padding: .3em .3em;
  color: #999;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #fdfdfd;
  cursor: pointer;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
}
.msglabel {
  display: inline-block;
  padding: .3em .3em;
  color: #999;
  font-size: inherit;
  line-height: normal;
  vertical-align: middle;
  background-color: #fdfdfd;
  cursor: pointer;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
}

.msgfile input[type="file"] { /* 파일 필드 숨기기 */
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  border: 0;
}
</style>
</head> 

<body>

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
      <c:forEach var="mem_MsgVO" items="${list }">
        <c:if test="${mem_MsgVO.msgreceiver == sessionScope.memberno }">
          <li class="replies">
        </c:if>
        <c:if test="${mem_MsgVO.msgreceiver != sessionScope.memberno }">
          <li class="sent">
        </c:if>
          <img src="http://emilcarlsson.se/assets/mikeross.png" alt="${mem_MsgVO.nickname }" />
          <p>${mem_MsgVO.msgcontent }</p>
        </li>
        </c:forEach>
      </ul>
    </div> 
    <!-- messages_content END -->
    
    <div class="message-input">
      <FORM name='msg' method='POST' action='./create.do' enctype="multipart/form-data" class="form-horizontal" id="msg">
        <!-- 개발시 임시 값 사용 value값 수정 좀 해줘-->
        <input type='hidden' name='msgsender' id='msgsender' value="${sessionScope.memberno }"> <!-- 세션 -->
        <input type='hidden' name='msgreceiver' id='msgreceiver' value="${param.msgreceiver }"> <!-- 컨텐츠에 회원번호 = 작성자 회원번호 -->
        <input type='hidden' name='contentsno' id='contentsno' value="1"> <!-- 건텐츠 번호 -->
        
        <div class="col-md-12">
        <!--  내가 생각 하는 부분은 채팅이여서 쪽지 제목 컬럼을 아예 삭제하고 이렇게만 해도 좋을거 같아 -->
         <input type='text' class="msginput" name='msgcontent' id='msgcontent' placeholder="Write your message..."  required="required">
        <!-- 버튼 form Start -->
        <!-- 전송버튼 -->
        <label class="msglabel"><span class="glyphicon glyphicon-send"></span></label>
        <!-- 버튼 End-->
        </div>
      </FORM>
      <FORM name='msg' method='POST' action='./filesend.do' enctype="multipart/form-data" class="form-horizontal" id="msg">
      <!-- 업로드 버튼 -->
        <label class="msglabel" for="filesMF" ><span class="glyphicon glyphicon-paperclip"></span></label> 
        <div class="msgfile">
          <input type="file" class="upload-hidden" name='filesMF' id='filesMF' size='10' multiple="multiple">
        </div>
      </FORM>
    </div>
  </div><!-- messages_container END -->

</body>

</html> 
 
 
 