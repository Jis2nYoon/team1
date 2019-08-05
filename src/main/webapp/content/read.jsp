<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <!-- 이 페이지는 관리자와 회원만 접근 가능 -->
 <!-- 글 작성 페이지 -->
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

<!-- icon css -->
<link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>

<!--  별점처리 -->
 <link rel="stylesheet" href="../js/rating.css" type="text/css" media="screen" title="Rating CSS">
<!--  <script type="text/javascript" src="../js/jquery.min.js"></script> -->
<script type="text/javascript" src="../js/rating.js"></script>

<script type="text/JavaScript">
window.onload = function(){
  $('.carousel').carousel();
  $('#btn_reply').click(reply_proc);
  $('#btn_r_reply').click(r_reply_proc);
}
//댓글 list 갱신
function reply_list() {
  $('#replylist').removeClass('col-sm-12');
  $("#replylist").css("margin","0px"); 
  $('#replylist').load(document.URL +  ' #replylist');
  reply_cnt();
}
//댓글 전체 개수 갱신
function reply_cnt(){
  var param = "contentsno="+${contentVO.contentsno};
  $.ajax({
    url: "../reply/list_cnt.do",
    type: "get",
    cache: false,
    async: true,  // true: 비동기
    dataType: "json", // 응답 형식: json, xml, html...
    data: param,
    success: function(rdata) {
      $('#replyCnt').html(rdata.count);
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
}
function init(){
  reply_list();
  $('#reply').show();
  $('#reply_msg').hide();
}
function r_reply_form(replyno){
  var id = '#r_reply'+replyno
  $(id).show();
}
function cancel(replyno){
  var id = '#r_reply'+replyno
  $(id).hide();
}
function r_reply_proc(replyno){
  //대댓글에 grpno, ansnum, indent변경 할수 잇게 컨트롤러 추가하고url도 변경
  var id = '#frm_reply'+replyno
  var params = $(id).serialize();
  //alert(params);
  $.ajax({
    url: "../reply/create_reply.do",
    type: "post", // post
    cache: false,
    async: true,  // true: 비동기
    dataType: "html", // 응답 형식: json, xml, html...
    data: params,
    success: function(rdata) {
      $('#reply').hide();
      cancel(replyno);
      $('#reply_msg').html(rdata);
      $('#reply_msg').show();
      reply_list();
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
}
function reply_proc(){
  var frm = $("#frm_reply").attr("action");
  if(frm == "../reply/create.do"){
    create_proc();
  } else if(frm == "../reply/update.do"){
    update_proc();
  }
}
//등록
function create_proc() {
  var params = $("#frm_reply").serialize();
  $.ajax({
    url: "../reply/create.do",
    type: "post", // post
    cache: false,
    async: true,  // true: 비동기
    dataType: "html", // 응답 형식: json, xml, html...
    data: params,
    success: function(rdata) {
      $('#reply').hide();
      $('#reply_msg').html(rdata);
      $('#reply_msg').show();
      reply_list();
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
}

//수정 form
function update_form(replyno) {
  $("#frm_reply").attr("action", "../reply/update.do");
  var param =  "replyno="+replyno;
  $.ajax({
    url: "../reply/update.do",
    type: "get", // post
    cache: false,
    async: true,  // true: 비동기
    dataType: "json", // 응답 형식: json, xml, html...
    data: param,
    success: function(rdata) {
      var ids = "아이디"+rdata.memberno;
      $('#ids').val(ids);
      $('#replycont').val(rdata.replycont);
      $('#indent').val(rdata.indent);
      $('#grpno').val(rdata.grpno);
      $('#ansnum').val(rdata.ansnum);
      $('#replyno').val(rdata.replyno);
      $("#frm_reply").get(0).scrollIntoView(true);
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
}

//수정 처리
function update_proc() {
  var params = $("#frm_reply").serialize();
  $.ajax({
    url: "../reply/update.do",
    type: "post", // post
    cache: false,
    async: true,  // true: 비동기
    dataType: "html", // 응답 형식: json, xml, html...
    data: params,
    success: function(rdata) {
      $('#reply').hide();
      $('#reply_msg').html(rdata);
      $('#reply_msg').show();
      reply_list();
      
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
}

//삭제
function delete_proc(replyno) {
  var params = "replyno="+replyno;
  $.ajax({
    url: "../reply/delete.do",
    type: "post", // post
    cache: false,
    async: true,  // true: 비동기
    dataType: "html", // 응답 형식: json, xml, html...
    data: params,
    success: function(rdata) {
      $('#reply').hide();
      $('#reply_msg').html(rdata);
      $('#reply_msg').show();
      reply_list();
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
}
/*프로필 별점*/
// $(function(){                   // Start when document ready
//   $('#star-rating').rating(); // Call the rating plugin
// }); 

 $(function(){
  $('#star-rating-manner').rating(function(vote, event){
    $('#manner').val(vote);
  });  
  $('#star-rating-delivery').rating(function(vote, event){
    $('#delivery').val(vote);
  });
  $('#star-rating-quality').rating(function(vote, event){
    $('#quality').val(vote);
  });
 });

 function send(){ 
   if(($('#manner').val()=='') || ($('#delivery').val()=='') || ($('#quality').val()=='')){
     alert('모든 항목에 체크해주세요.');
     return false;
   }
  return true;
 }
 
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'> 
  <!-- 사진 시작 -->
  <div class="col-sm-10 col-sm-offset-1" style="margin-bottom: 10px;">
  <div id="carousel-picture" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
      <ol class="carousel-indicators">
        <c:forEach var="fileVO" items="${file_list}" varStatus="status">
          <c:if test="${status.index == 0 }">
            <li data-target="#carousel-picture" data-slide-to="0" class="active"></li>
          </c:if>
          <c:if test="${status.index != 0 }">
            <li data-target="#carousel-picture" data-slide-to="${status.index }"></li>
          </c:if>
        </c:forEach>
      </ol>
  <!-- Carousel items -->
  <div class="carousel-inner">
    <c:forEach var="fileVO" items="${file_list}" varStatus="status">
      <c:if test="${status.index == 0 }">
        <div class="item active">
          <IMG src='./storage/${fileVO.file}' alt="picture number${status.count }">
          <div class="carousel-caption">
            <p>${fileVO.file }[${fileVO.size }]</p>
          </div>
        </div>
      </c:if>
      <c:if test="${status.index != 0 }">
        <div class="item">
          <IMG src='./storage/${fileVO.file}' alt="picture number${status.count }" >
          <div class="carousel-caption">
            <p>${fileVO.file }[${fileVO.size }]</p>
          </div>
        </div>
      </c:if>
    </c:forEach>
      </div>
    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-picture" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#carousel-picture" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  </div>
  <!-- 사진 끝 -->
  <!-- 글 내용 시작-->
  <div class="col-sm-10 col-sm-offset-1">
    <div class="panel panel-default">
      <div class="panel-heading">
        <div >
          제 목: 
          <c:if test="${contentVO.saleA == 'N' }">
            [판매완료]<del>${contentVO.title }</del>
          </c:if>
          <c:if test="${contentVO.saleA != 'N' }">
            ${contentVO.title }
          </c:if>
        </div>
        <!-- 조회수 -->
        <div style="text-align: right;"><span class="ndc_span">${nickname } · ${fn:substring(contentVO.rdate,0,11) } · 조회 ${contentVO.views }</span></div>
      </div>
      <div class="panel-body">
        <div style="min-height: 500px;">
        <c:if test="${contentVO.saleA == 'N' }">
          <span style="word-wrap: break-word;">[판매완료]<del>${contentVO.contents }</del></span>
        </c:if>
        <c:if test="${contentVO.saleA != 'N' }">
          <span style="word-wrap: break-word;">${contentVO.contents }</span>
        </c:if>
      </div>
      </div>
      <div class="panel-footer" style="text-align: center;">
        <!-- 판매자 본인일 경우 판매 완료 버튼 -->
        <c:if test="${contentVO.memberno == sessionScope.memberno }">
          <c:if test="${contentVO.saleA == 'N' }">
              <button class="btn btn-default" type="button" disabled="disabled" style="display: inline-block;" >판매완료</button>
          </c:if>
          <c:if test="${contentVO.saleA != 'N' }">
              <button class="btn btn-default" type="button" style="display: inline-block;"
              onclick="location.href='sale.do?contentsno=${contentVO.contentsno}&contmemno=${contentVO.memberno }'" >판매완료</button>
          </c:if>
        </c:if>
        <!-- 구매자 일 경우 판매자에게 1:1 메세지 보내는 버튼 -->
        <c:if test="${contentVO.memberno != sessionScope.memberno }">
          <c:if test="${contentVO.saleA == 'N' }">
              <button class="btn btn-default" type="button" disabled="disabled" style="display: inline-block;">판매자에게 연락하기</button>
          </c:if>
          <c:if test="${contentVO.saleA != 'N' }">
              <button class="btn btn-default" type="button" style="display: inline-block;"
              onclick="window.open('${pageContext.request.contextPath}/msg/create.do?msgreceiver=${contentVO.memberno}','쪽지 보내기','width=430,height=730,location=no,status=no,scrollbars=yes')" >
              판매자에게 연락하기</button>
          </c:if>
        </c:if>
        <!-- 광고 신고하기 버튼, 신고하기 버튼(사기꾼 신고 -> log로 운영자에게 보고 되는 식으로?)  -->
        <!-- 판매자의 매너 점수 메기기 -->
        <c:if test="${contentVO.memberno != sessionScope.memberno }" >
            <button class="btn btn-default" type="button" onclick="location.href=' '" style="display: inline-block;">신고하기</button>
            <!-- <button class="btn btn-default" type="button" onclick="location.href='${pageContext.request.contextPath}/grade/manner_update.do?mno=${contentVO.memberno}'">판매자 평가</button> -->
        </c:if>
        <A href='./download.do?contentsno=${contentVO.contentsno}'>PictureDownload</A>
        </div>
      </div>
    </div>
      <!-- 판매자 프로필 -->
      <div class="gradepanel col-sm-10 col-sm-offset-1">
          <div class="col-sm-2" style="display: inline-block; padding-bottom: 10px; padding-top: 10px;">
            <c:if test="${thumbs != ''}">
              <IMG src='${pageContext.request.contextPath}/member/temp/${thumbs }' style='width: 100px; height: 100px; border-radius: 20px;' onclick='panel_img(${photo })' title='크게 보기' >
            </c:if>
            <c:if test="${thumbs == ''}">
              <IMG src='${pageContext.request.contextPath}/member/images/default.png' style='width: 100px; height: 100px; border-radius: 20px;'>
            </c:if>
          </div>
          <div class="col-sm-4" style="display: inline-block;  padding-bottom: 50px; padding-top: 50px;">
            ${nickname }
          </div>
          <div class="col-sm-6" style="display: inline-block; padding-left: 50px; padding-bottom: 15px; padding-top: 15px;">
            전체 평점 : ${gradeVO.avggrade } 점 
            <div class="starOff"><div class="starOn" style="width: ${gradeVO.avggrade * 20}%;"></div></div><br>
            매너 점수 : ${gradeVO.manner } 점 
            <div class="starOff"><div class="starOn" style="width: ${gradeVO.manner * 20}%;"></div></div><br>
            배송 속도 : ${gradeVO.delivery } 점 
            <div class="starOff"><div class="starOn" style="width: ${gradeVO.delivery * 20}%;"></div></div><br>
            상품 품질 : ${gradeVO.quality } 점 
            <div class="starOff"><div class="starOn" style="width: ${gradeVO.quality * 20}%;"></div></div>
          </div>
    </div>
  <!-- 글 내용 끝 -->
  <DIV class="col-sm-10 col-sm-offset-1" style='text-align: right; margin-top: 10px;'>
      <button class="btn btn-default" type="button" onclick="location.href='update.do?contentsno=${contentVO.contentsno}'">수정</button>
      <button class="btn btn-default" type="button" onclick="location.href='delete.do?contentsno=${contentVO.contentsno}">삭제</button>
      <button class="btn btn-default" type="button" onclick="javascript:history.back()">취소[목록]</button>
  </DIV>
  <!-- 버튼 끝 -->
    <!-- 댓글 시작 -->
  <div class="col-sm-10 col-sm-offset-1">
    <div class="col-sm-12" style="border-bottom: solid 1px #e89510;">
      <strong style="margin-left: 10px; font-size: 1.2em;color: #8f5c0a;">댓글 </strong> <span id="replyCnt" style="color: #8f5c0a;"> ${replycnt } </span>
    <a href="javascript:reply_list()"><i class='fas fa-sync-alt' style="color: #8f5c0a;"></i></a>
    </div>
    <DIV id="reply_msg" class="col-sm-12" style="margin: 10px; display:none;"></DIV>
    <!-- 댓글 form -->
    <DIV id="reply" class="col-sm-12" style="margin: 10px;">
      <FORM name='frm_reply' id='frm_reply' method='POST' action='../reply/create.do'>
        <input type='hidden' name='replyno' id='replyno' value='0'>
        <input type='hidden' name='indent' id='indent' value='0'>
        <input type='hidden' name='grpno' id='grpno' value='0'>
        <input type='hidden' name='ansnum' id='ansnum' value='0'>
        <input type='hidden' name='contentsno' id='contentsno' value='${contentVO.contentsno}'>
        <p class="form-control-static myreply_span" >${sessionScope.nickname }</p>
        <textarea class="form-control input-lg" name='replycont' id='replycont'  rows='4' placeholder="댓글을 입력하세요."></textarea>
        <DIV style='text-align: right; margin: 10px;'>
        <button class="btn btn-default" type="button" id='btn_reply'>등록</button>
        <button class="btn btn-default" type="button" onclick="cancel();">취소</button>
        </DIV>
      </FORM>
    </DIV>
    <!-- 댓글 내용 -->
    <div class="col-sm-12" style="margin: 10px;" id="replylist">
        <c:import url="/reply/list.do" />
    </div>
  </div>
  <!-- 댓글 끝 -->

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 


   