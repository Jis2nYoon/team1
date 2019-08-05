<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <!-- 이 페이지는 관리자와 회원만 접근 가능 컨트롤러 FORM에서 걸러지므로 이곳에서 작업할 필요는 없다. -->
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

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/JavaScript">
window.onload = function(){
  $('#btn_create').click(create);
  CKEDITOR.replace('contents',{
    height: 500
  });  // <TEXTAREA>태그 id 값
}
//검색
function create() {
  var frm = $('#frm');
  //alert("파일 이름: " + $('#filesMF').val())
  if($('#cateno option:selected').val() == -1){//생성 전에 카테고리 선택 확인
    alert('category를 선택하세요!');
  } else if(!$('#filesMF').val()){// 사진이 1개 이상 업로드 되었는지 체크
    alert('사진은 한개 이상 꼭 등록하셔야 합니다!');
  }  else if(!$('#pname').val()){// 상품이름 적었는지 체크
    alert('상품 이름을 입력하세요.');
  }  else if(!$('#price').val()){// 상품가격 적었는지 체크
    alert('상품 가격을 입력하세요.');
  } else{
    frm.submit();
  }
  
}
// function send(){
//   var file = document.getElementById('files');
//   var files = file.files;    // 파일 목록 배열 추출
//   var length = files.length; // 목록 길이 추출
//  // alert('length: ' + length);
//   if (length == 0) {
//     alert('파일을 1개이상 선택해야합니다.')
//     return
//   } else {
//     $('#panel').text(''); // table 태그 내용 지우기
//     $('#msg').text('이미지를 전송중입니다.'); // 메시지 출력
//     $('#msgGIF').show();  // Progressbar 출력
//     $('#frm').submit();  // 서브밋
    
//   }

// }

</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'> 
  <div class='title_line'>새로운 글 작성</div>
  <FORM name='frm' method='POST' action='./create.do' enctype="multipart/form-data" class="form-horizontal" id="frm">
      <input type='hidden' id='memberno' name='memberno' value=' ${sessionScope.memberno }'>
      <!-- Spring 출력 카테고리 목록 select form -->
      <div class="form-group">
      <label for='cateno' class="col-md-1 control-label">카테고리</label>
        <div class="col-md-11">
          <select id='cateno' name="cateno" class="form-control input-lg" >
            <c:import url="/cate/category_select.do" /> 
          </select>
        </div>
      </div>
      <div class="form-group">   
      <label for="title" class="col-md-1 control-label">상품 이름</label>
      <div class="col-md-11"> <!--  나중에 사람들이 자주 쓰는 상품이름, 유사한 상품이름이 옆에 추천이름으로 뜨도록한다. 검색기능처럼 -->
        <input type='text' class="form-control input-lg" name='pname' id='pname' value='갤럭시 버즈' required="required">
      </div>
    </div> 
    <div class="form-group">   
      <label for="title" class="col-md-1 control-label">상품가격</label>
      <div class="col-md-11">
        <input type='number' class="form-control input-lg" name='price' id='price' value='160000' required="required">
      </div>
    </div> 
    <div class="form-group">   
      <label for="title" class="col-md-1 control-label">글 제목</label>
      <div class="col-md-11">
        <input type='text' class="form-control input-lg" name='title' id='title' value='갤럭시 버즈 팝니다.' required="required">
      </div>
    </div>  
    <div class="form-group">   
      <label for="contents" class="col-md-1 control-label">내용</label>
      <div class="col-md-11">
        <textarea class="form-control input-lg" name='contents' id='contents'  rows='10' required="required">갤럭시 버즈 검은색 12만원에 팝니다.</textarea>
      </div>
    </div>
    <div class="form-group">   
        <label for="filesMF" class="col-md-1 control-label">업로드 파일</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple" required="required">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
    </div>   
    <DIV style='text-align: right;'>
      <A href="javascript:create()" class="btn btn-default" >등록</A>
      <button class="btn btn-default" type="button" onclick="location.href='#'">취소[목록]</button>
    </DIV>
  </FORM>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 