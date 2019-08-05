<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <!-- 이 페이지는 관리자만 접근 가능 -->
 <!-- 카테고리 목록 및 관리 페이지 -->
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
    
<script type="text/javascript">
window.onload = function(){
  $('#panel_update').hide();
  $('#panel_delete').hide();
  $('#panel_create').show();
  $('#loading').hide(); 
  $('#btn_create').click(create_proc);
  $('#btn_update').click(update_proc);
  $('#btn_delete').click(delete_proc);
  //검은 막을 눌렀을 때 이벤트 처리
  $('#mask').click(function () {  
      location.reload(true);
  });     
}
//등록
function create_proc() {
  var params = $("#frm_create").serialize();
  $.ajax({
    url: "./create.do",
    type: "post", // post
    cache: false,
    async: true,  // true: 비동기
    dataType: "html", // 응답 형식: json, xml, html...
    data: params,
    success: function(rdata) {
      wrapWindowByMask();
      $('#msg').html(rdata);
      $('#loading').hide(); 
    },
    // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
    error: function(request, status, error) { // callback 함수
      var msg = 'ERROR<br><br>';
      msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
      msg += '<strong>error</strong><br>'+error + '<hr>';
      console.log(msg);
    }
  });
  // 처리중 출력
  $('#loading').show();
}
  //수정 form
  function update(cateno) {
    $('#panel_delete').hide();
    $('#panel_create').hide();
    $('#panel_update').show();
    var params = 'cateno=' + cateno;
    $.ajax({
      url: "./read.do",
      type: "get", // get
      cache: false,
      async: true,  // true: 비동기
      dataType: "json", // 응답 형식: json, xml, html...
      data: params,
      success: function(rdata) {
        // alert(rdata);
        var frm_update = $('#frm_update'); // 폼이 여러개인경우
        $('#cateno', frm_update).val(rdata.cateno);
        $('#catename', frm_update).val(rdata.catename);
        $('#seqno', frm_update).val(rdata.seqno);
        $('#loading').hide(); 
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
        console.log(msg);
      }
    });
    // 처리중 출력
    $('#loading').show();
  }
  //수정 proc
  function update_proc() {
    var params = $("#frm_update").serialize();
    $.ajax({
      url: "./update.do",
      type: "post", // post
      cache: false,
      async: true,  // true: 비동기
      dataType: "html", // 응답 형식: json, xml, html...
      data: params,
      success: function(rdata) {
        wrapWindowByMask();
        $('#msg').html(rdata);
        $('#loading').hide(); 
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
        console.log(msg);
      }
    });
    // 처리중 출력
    $('#loading').show();
  }
  //삭제 form
  function deleteOne(cateno) {
    $('#panel_create').hide();
    $('#panel_update').hide();
    var params = 'cateno=' + cateno;
    $.ajax({
      url: "./read.do",
      type: "get", // get
      cache: false,
      async: true,  // true: 비동기
      dataType: "json", // 응답 형식: json, xml, html...
      data: params,
      success: function(rdata) {
        // alert(rdata);
        var frm_delete = $('#frm_delete'); // 폼이 여러개인경우
        var str
        $('#cateno', frm_delete).val(rdata.cateno);
        if(rdata.contentscnt == 0){
          str = rdata.catename + "을 삭제하시겠습니까?";
        } else if (rdata.contentscnt > 0) {
          str = rdata.catename + "카테고리에 등록 된 글이 " + rdata.contentscnt + "개 있습니다.<br>전부 삭제하시겠습니까?";
        }
        $('#loading').hide();
        $('#msg_delete').html(str);
        $('#panel_delete').show();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
        console.log(msg);
      }
    });
    // 처리중 출력
    $('#loading').show();
  }
  function delete_proc() {
    var params = $("#frm_delete").serialize();
    $.ajax({
      url: "./delete.do",
      type: "post", // post
      cache: false,
      async: true,  // true: 비동기
      dataType: "html", // 응답 형식: json, xml, html...
      data: params,
      success: function(rdata) {
        $('#panel_delete').hide();
        wrapWindowByMask();
        $('#msg').html(rdata);
        $('#loading').hide(); 
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
        console.log(msg);
      }
    });
    // 처리중 출력
    $('#loading').show();
  }
  // 우선순위 up 10 -> 1
  function seqnoInc(cateno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './seqno_inc.do');
    $('#cateno', frm_seqno).val(cateno);
    frm_seqno.submit();
  }
  
  // 우선순위 down 1 -> 10
  function seqnoDec(cateno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './seqno_dec.do');
    $('#cateno', frm_seqno).val(cateno);
    frm_seqno.submit();
  }
  
  function cancel() {
    $('#panel_update').hide();
    $('#panel_delete').hide();
    $('#panel_create').show();
  }
  
  function wrapWindowByMask(){
    //화면의 높이와 너비를 구한다.
    var maskHeight = $(document).height();  
    var maskWidth = $(window).width();  
    var msgH = maskWidth/3;
    var msgW = maskHeight/3;

    //마스크를 전체화면으로 채운다.
    $('#mask').css({'width':maskWidth,'height':maskHeight});  
    $('#mask').show();    
    $('#msg').css({'width':msgW,'height':msgH});  
    $('#msg').show();
}

</script>
<style type="text/css">
  #mask {  
    position:absolute;  
    left:0;
    top:0;
    z-index:9000;  
    background-color:rgba(0, 0, 0, 0.3);  
    display:none;  
  }
  #msg {
      display: none;
      position:absolute;  
      z-index:10000;
      top: 50%;
      left: 50%;
      -webkit-transform: translate(-50%, -50%);
                 transform: translate(-50%, -50%);
  }
</style>
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

  <DIV class='title_line'>카테고리 관리</DIV>
  <div id="msg"></div>
  <div id="mask"></div>
  <div id='loading' class='loading'></div>
  <!-- 우선 순위 증가 감소 폼, GET -> POST 시작-->
  <FORM class='form-horizontal' name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='cateno' id='cateno' value=''>
  </FORM>
  <!-- 우선 순위 증가 감소 폼, GET -> POST 끝 -->
  
  <!-- Create Panel 시작 -->
  <DIV id='panel_create' class="panel_gray col-md-12">
    <FORM class='form-inline' name='frm_create' id='frm_create' method='POST' action='./create.do'>
    <label for='catename'>카테고리 이름</label>
    <input class='form-control'  type='text' name='catename' id='catename' value='' required="required" placeholder="카테고리 이름">
    <label for='seqno'>순서</label>
    <input class='form-control'  type='number' name='seqno' id='seqno' value='1' required="required" min='1' max='1000' step='1' >
    <button class="btn btn-default" type="button" id='btn_create'>등록</button>
    <button class="btn btn-default" type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>
  <!-- Create Panel 끝 -->

<!-- Update Panel 시작 -->
  <DIV id='panel_update' class="panel_gray col-md-12"  style="display: none;">
    <FORM class='form-inline'  name='frm_update' id='frm_update' method='POST'  action='./update.do'>
      <input class='form-control'  type='hidden' name='cateno' id='cateno' value=''>
      <label for='catename'>카테고리 이름</label>
      <input class='form-control'  type='text' name='catename' id='catename' value='' required="required">
      <label for='seqno'>순서</label>
      <input class='form-control'  type='number' name='seqno' id='seqno' value='1' required="required" min='1' max='1000' step='1' >
      <button class="btn btn-default" type="button" id='btn_update'>저장</button>
      <button class="btn btn-default" type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>
<!-- Update Panel 끝 -->
  
<!-- Delete Panel 시작 -->
  <DIV id='panel_delete' class="panel_gray col-md-12"  style="display: none;">
    <FORM class='form-inline' name='frm_delete' id='frm_delete' method='POST' action='./delete.do'> 
      <input class='form-control'  type='hidden' name='cateno' id='cateno' value=''>
      <DIV id='msg_delete'></DIV>
      <button class="btn btn-default" type="button" id='btn_delete'>삭제</button>
      <button class="btn btn-default" type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>
<!-- Delete Panel 끝 -->
  
  <!-- List 테이블 시작 -->
<TABLE class="table table-hover">
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 40%;'/>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
    <col style='width: 20%;'/>
  </colgroup>

  <thead>  
  <TR>
    <TH style='text-align: center ;'>순서</TH>
    <TH>카테고리 이름</TH>
    <TH style='text-align: center ;'>categoryno.</TH>
    <TH style='text-align: center ;'>등록된 글</TH>
    <TH style='text-align: center ;'>관리</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="cateVO" items="${list }">
  <TR>
    <TD style='text-align: center ;'>${cateVO.seqno }</TD>
    <TD><A class="texthover" href="../content/list_by_cate_desc.do?cateno=${cateVO.cateno }">${cateVO.catename }</A></TD>
    <TD style='text-align: center ;'>${cateVO.cateno }</TD>
    <TD style='text-align: center ;'>${cateVO.contentscnt } 개</TD>
    <TD style='text-align: center ;'>
      <A href="../content/create.do?cateno=${cateVO.cateno }"><span class="glyphicon glyphicon-asterisk" title="글 등록"></span></A>
      <A href="javascript:seqnoInc(${cateVO.cateno })"><span class="glyphicon glyphicon-plus" title="우선순위 높임"></span></A>
      <A href="javascript:seqnoDec(${cateVO.cateno })"><span class="glyphicon glyphicon-minus" title="우선순위 낮춤"></span></A>
      <A href="javascript:update(${cateVO.cateno })"><span class="glyphicon glyphicon-pencil" title="수정"></span></A>
      <A href="javascript:deleteOne(${cateVO.cateno })"><span class="glyphicon glyphicon-trash" title="삭제"></span></A>
    </TD>
  </TR>
  </c:forEach> 
  </tbody>
</TABLE>
<!-- List 테이블 끝 -->

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" />
</DIV> <!-- container END -->
</body>

</html> 


