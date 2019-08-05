<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea Market</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
function update(faqno) {
  $('#panel_create').hide();
  $('#panel_update').show();
  
  var params = 'faqno=' + faqno;
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
      $('#faqno', frm_update).val(rdata.faqno);
      $('#question', frm_update).val(rdata.question);
      $('#answer', frm_update).val(rdata.answer);
      
      $('#main_panel').hide(); 
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
  $('#main_panel').html("<IMG src='./images/ani01.gif' style='width: 10%; text-align: center;'>");
  $('#main_panel').show();
  
}

// 하나의 그룹 삭제
function deleteFAQ(faqno) {
  $('#panel_create').hide();
  $('#panel_update').hide();
  
  var params = 'faqno=' + faqno;
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
      $('#faqno', frm_delete).val(rdata.faqno);
      
      var str = '';
      str = rdata.name + " ("+ rdata.rdate+")";

      $('#main_panel').hide();
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
  $('#main_panel').html("<IMG src='./images/ani01.gif' style='width: 10%; text-align: center;'>");
  $('#main_panel').show();
  
}

function cancel() {
  $('#panel_update').hide();
  $('#panel_delete').hide();
  $('#panel_create').show();
}
</script>

</head> 

<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >
  
<DIV class='title_line'>자주 찾는 질문들 (FAQ)</DIV>

  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <input type='hidden' name='memberno' id='memberno' value='1'>
        
      <label for='question'>질문: </label>
      <input type='text' name='question' id='question' value='' required="required" style='width: 25%;'>

      <label for='answer'>답변: </label>
      <input type='text' name='answer' id='answer' value='' required="required" style='width: 25%;'>
       
      <button type="submit" class="btn btn-default" id='submit'>등록</button>
      <button type="button" class="btn btn-default" onclick="cancel();">취소</button>
    </FORM>
  </DIV>
  
    <DIV id='panel_update' style='display: none; padding: 10px 0px 10px 0px; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='memberno' id='memberno' value='1'>
      <input type='hidden' name='faqno' id='faqno' value=''>

      <label for='question'>질문: </label>
      <input type='text' name='question' id='question' value='' required="required" style='width: 25%;'>

      <label for='answer'>답변: </label>
      <input type='text' name='answer' id='answer' value='' required="required" style='width: 25%;'>
      
      <button type="submit" class="btn btn-default" id='submit'>저장</button>
      <button type="button" class="btn btn-default" onclick="cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='panel_delete' style='display: none; padding: 10px 0px 10px 0px; width: 100%; text-align: center;'>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'> 
      <input type='hidden' name='memberno' id='memberno' value='1'>
      <input type='hidden' name='faqno' id='faqno' value=''>

      <DIV id='msg_delete' style='margin: 20px auto;'></DIV>
      <button type="submit" class="btn btn-default" id='submit'>삭제</button>
      <button type="button" class="btn btn-default" onclick="cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='main_panel' class='main_panel'></DIV>
  
<div class="panel-group" id="accordion">
  <c:forEach var="faqVO" items="${list }">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse${faqVO.faqno }">
        <span class="glyphicon glyphicon-question-sign" title="질문"></span> ${faqVO.question }</a>
        
        <A href="javascript:update(${faqVO.faqno })">
        <span class="glyphicon glyphicon-pencil" title="수정"></span></A>
        <A href="javascript:deleteFAQ(${faqVO.faqno })">
        <span class="glyphicon glyphicon-trash" title="삭제"></span></A>
      </h4>
    </div>
  <div id="collapse${faqVO.faqno }" class="panel-collapse collapse">
    <div class="panel-body">
      　<span class="glyphicon glyphicon-ok-circle" title="답변"></span> ${faqVO.answer }
    </div>
  </div>
  </div>
  </c:forEach> 
</div>

  <button style='float: right;' class="btn btn-default" type="button" onclick="location.href='./create.do'">등록</button>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

 