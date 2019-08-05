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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/locale/ko.js"></script>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/> -->

<script src="../js/bootstrap-datetimepicker.js"></script>
<link rel="stylesheet" type="text/css" href="../css/datetimepickerstyle.css" />

<script type="text/javascript">
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >

<DIV class='title_line' style='width: 50%;'>설문조사 항목 수정</DIV>

<DIV style="magin: 0px auto;">
<FORM name='frm' method='POST' action='./update.do' class="form-horizontal" >
<%--   <input type='hidden' name='surveyno' value='${param.surveyno }'> --%>
  <input type='hidden' name='surveyitemno' value='${param.surveyitemno }'>

     <div class="form-group">
        <label for="item" class="col-md-4 control-label">항목 내용</label>
        <div class="col-md-5">
          <input type='text' class="form-control input-lg" name='item' id='item' value='${surveyitemVO.item }' required="required" style='width: 80%;'>
        </div>
      </div>  

     <div class="form-group">   
        <label for='content' class="col-md-4 control-label">참고 파일</label>
        <div class="col-md-5">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40'>
        </div>
      </div>  
     
      <div class="col-md-7 control-label">   
     <button type="submit">등록</button>
     </div>
</FORM>
</DIV>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 