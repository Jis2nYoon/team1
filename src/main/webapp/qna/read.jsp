<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea Market</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(document).ready(function(){ // window.onload = function() { ... }

  });
  
// 이미지 클릭시 원본 크기로 팝업 보기
function doImgPop(file){ 
 img1= new Image(); 
 img1.src=(file); 
 imgControll(file); 
} 

function imgControll(file){ 
  if((img1.width!=0)&&(img1.height!=0)){ 
     viewImage(file); 
   } 
   else{ 
      controller="imgControll('"+file+"')"; 
      intervalID=setTimeout(controller,20); 
   } 
 }

function viewImage(file){ 
  W=img1.width; 
  H=img1.height; 
  O="width="+W+",height="+H+",scrollbars=yes"; 
  imgWin=window.open("","",O);
  imgWin.document.write("<html><head><title>이미지 원본 보기</title></head>");
  imgWin.document.write("<body topmargin=0 leftmargin=0>");
  imgWin.document.write("<img src="+file+" onclick='self.close()' style='cursor:pointer;' title ='클릭시 창이 닫힙니다.'>");
  imgWin.document.close();
}
   
</script>
</head>

<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>   

  <DIV class='title_line' >질문 게시판</DIV>

  <DIV id='main_panel'></DIV>  <!-- 이미지 출력 -->
  
  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="qnano" value="${mem_QnaVO.qnano}">
      <div class="col-sm-10 col-sm-offset-1">
      <div class="panel panel-default">
      <div class="panel-heading">
        <span class="col-sm-1">제 목: </span>
        <span>${mem_QnaVO.title }</span>
        <span style='float: right;'>${mem_QnaVO.rdate.substring(0, 16)}</span>
      </div>
      <tbody>
        <tr>
          <td style='text-align: left;'>
            <div class="panel-body" style='white-space: pre-line;'>${mem_QnaVO.content }
            </div></td>
        </tr>
        <div class="panel-body" style='text-align: right;'>
          작성자: 
          <c:if test="${mem_QnaVO.memthumb.length() > 0 }">
          <IMG src='./storage/${mem_QnaVO.memthumb }' style='margin-top: 2px;'></A>
          </c:if>
          ${mem_QnaVO.nickname }
        </div>
        <DIV class="panel-body" >
        <c:if test="${mem_QnaVO.files.length() > 0 }">
          <c:forEach var ="qnaFileVO"  items="${file_list }">
            <A href="javascript: doImgPop('./storage/${qnaFileVO.file }')">
            <IMG src='./storage/${qnaFileVO.thumb }' title="${qnaFileVO.size }" style='margin-top: 2px;'>
            </A>
          </c:forEach>
          <br>
          <span> 
            첨부파일: <A href="./download.do?qnano=${mem_QnaVO.qnano}">${mem_QnaVO.files }</A>
          </span>
        </c:if>
        </DIV>
      </tbody>
      
  <DIV style='text-align: center; margin: 10px auto;'>
    <button class="btn btn-default" type="button" onclick="location.href='reply.do?qnano=${mem_QnaVO.qnano}'">답변</button>
    <button class="btn btn-default" type="button" onclick="location.href='update.do?qnano=${mem_QnaVO.qnano}'">수정</button>
    <button class="btn btn-default" type="button" onclick="location.href='delete.do?qnano=${mem_QnaVO.qnano}'">삭제</button>
    <button class="btn btn-default" type="button" onclick="location.href='list.do'">목록</button>
  </DIV>
      
      </div>
      </div>
      
  </FORM>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>


   