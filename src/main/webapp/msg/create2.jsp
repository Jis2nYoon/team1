<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

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

</head> 

<body>
<DIV class='container'>
<DIV class='content' >

<DIV class='title_line' style='width: 50%;'>쪽지 보내기</DIV>

<DIV style="magin: 0px auto;">
<FORM name='frm' method='POST' action='./create.do' enctype="multipart/form-data" class="form-horizontal">

  <!-- 개발시 임시 값 사용 -->
  <input type='hidden' name='msgsender' id='msgsender' value="${sessionScope.memberno }"> <!-- 세션 -->
  <input type='hidden' name='msgreceiver' id='msgreceiver' value="${param.msgreceiver }"> <!-- 컨텐츠에 회원번호 = 작성자 회원번호 -->
    
  <input type='hidden' name='contentsno' id='contentsno' value="1"> <!-- 건텐츠 번호 -->
  
     <div class="form-group">
        <label for="msgtitle" class="col-md-4 control-label">쪽지 제목</label>
        <div class="col-md-5">
          <input type='text' class="form-control input-lg" name='msgtitle' id='msgtitle' value='' required="required" style='width: 80%;'>
        </div>
      </div>  

     <div class="form-group">   
        <label for='msgcontent' class="col-md-4 control-label">쪽지 내용</label>
        <div class="col-md-5">
          <textarea name='msgcontent' class="form-control input-lg"  id='msgcontent' rows='10' required="required" >직거래 가능한가요?</textarea>
        </div>
      </div>  
      
      <div class="form-group">   
        <label for="filesMF" class="col-md-4 control-label">업로드 파일</label>
        <div class="col-md-5">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='10' multiple="multiple">
        </div>
      </div>
      
     <div class="form-group">   
      <label for='nickname' class="col-md-4 control-label">받는 사람 </label>
        <div class="col-md-5" style="text-align: left; padding-top: 7px;">
           ${nickname}
        </div>
     </div>  
     
      <div class="col-md-6 control-label">   
     <button type="submit">보내기</button>
     </div>
</FORM>
</DIV>


</DIV> <!-- content END -->
</DIV> <!-- container END -->
</body>

</html> 
 
 
 