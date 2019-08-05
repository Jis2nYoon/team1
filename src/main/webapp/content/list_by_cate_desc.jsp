<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <!-- 이 페이지는 관리자만 접근 가능 -->
 <!-- 카테고리 별 글 목록 및 관리 페이지 -->
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
  $('#loading').hide(); 
  //검은 막을 눌렀을 때 이벤트 처리
  $('#mask').click(function () {  
      location.reload(true);
  });     
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

  <DIV class='title_line'>${catename } Contents 관리</DIV>
  <div id="msg"></div>
  <div id="mask"></div>

  <div id='loading' class='loading'></div>
  <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
  </c:if>
  <!-- List 테이블 시작 -->
<TABLE class="table table-hover">
  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 13%;'/>
    <col style='width: 10%;'/>
    <col style='width: 25%;'/>
    <col style='width: 7%;'/>
    <col style='width: 20%;'/>
    <col style='width: 10%;'/>
  </colgroup>

  <thead>  
  <TR>
    <TH style='text-align: center ;'>번호</TH>
    <TH style='text-align: center ;'>contentsno.</TH>
    <TH>글 제목</TH>
    <TH style='text-align: center ;'>계정번호</TH>
    <TH style='text-align: center ;'>글 등록일</TH>
    <TH style='text-align: center ;'>관리</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="cateVO" items="${list }" varStatus="status"> 
  <TR>
    <TD style='text-align: center ;'>${status.count }</TD>
    <TD style='text-align: center ;'>${cateVO.contentsno }</TD>
    <TD><A class="texthover" href="./read.do?contentsno=${cateVO.contentsno }">${cateVO.title }</A></TD>
    <TD style='text-align: center ;'>${cateVO.memberno } </TD>
    <TD style='text-align: center ;'>${cateVO.rdate } </TD>
    <TD style='text-align: center ;'>
      <A href="./update.do?contentsno=${cateVO.contentsno }"><span class="glyphicon glyphicon-pencil" title="수정"></span></A>
      <A href="#"><span class="glyphicon glyphicon-trash" title="삭제"></span></A>
    </TD>
  </TR>
  </c:forEach> 
  </tbody>
</TABLE>
<!-- List 테이블 끝 -->

<!-- paging -->
<DIV style="text-align: center;">${paging }</DIV>

<DIV style='text-align: right; margin: 10px;'>
  <A class="btn btn-default" href="./create.do?cateno=${param.cateno }&memberno=${param.memberno}">글 등록</A>
</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" />
</DIV> <!-- container END -->
</body>

</html> 


