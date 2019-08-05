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
$(document).ready(function(){
  $('.dateTimePicker').datetimepicker({format:"YYYY-MM-DD"});
         $('#startdate').datetimepicker({
             useCurrent: false
         });
         $('#enddate').datetimepicker({
             useCurrent: false
         });
         $('#datepicker3').datetimepicker({
             useCurrent: false
         });
         $('#datepicker4').datetimepicker({
             useCurrent: false
         });
        
        // 함수 호출 순서가 4,3,2 순서이다.
        // 4가 바뀌어야 3이 바뀌고 3이 바뀌어야 2가 바뀐다.
         $("#startdate").on("dp.change", function (e) {
             $('#enddate').data("DateTimePicker").minDate(e.date);
         });
        
         $("#enddate").on("dp.change", function (e) {
             $('#startdate').data("DateTimePicker").maxDate(e.date);
         });
 }); 
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >

<DIV class='title_line' style='width: 50%;'>설문조사 질문 수정</DIV>

<DIV style="magin: 0px auto;">
<FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
<input type='hidden' name='surveyno' id='surveyno' value="${surveyVO.surveyno }"> <!-- 컨텐츠에 회원번호 = 작성자 회원번호 -->

     <div class="form-group">
        <label for="title" class="col-md-4 control-label">설문조사 제목</label>
        <div class="col-md-5">
          <input type='text' class="form-control input-lg" name='title' id='title' value='${surveyVO.title }' required="required" style='width: 80%;'>
        </div>
      </div>  

     <div class="form-group">   
        <label for='content' class="col-md-4 control-label">설문조사 내용</label>
        <div class="col-md-5">
          <textarea name='content' class="form-control input-lg"  id='content' rows='10' required="required" >${surveyVO.content }</textarea>
        </div>
      </div>  
      
     <div class="form-group">   
       <label for='msgcontent' class="col-md-4 control-label">시작 날짜</label>
             <div class='input-group date dateTimePicker col-sm-3' id="startdate">
              <input type='text' class="form-control" name="startdate" id="startdate" value='${surveyVO.startdate}' required="required"/>
              <span class="input-group-addon">
                <span class="glyphicon glyphicon-calendar"></span>
             </span>
         </div>
     </div>  
     
     <div class="form-group">   
       <label for='msgcontent' class="col-md-4 control-label">종료 날짜</label>
             <div class='input-group date dateTimePicker col-sm-3' id="enddate">
              <input type='text' class="form-control" name="enddate" id="enddate" value='${surveyVO.enddate}' required="required"/>
              <span class="input-group-addon">
                <span class="glyphicon glyphicon-calendar"></span>
             </span>
         </div>
     </div>    
     
      <div class="col-md-7 control-label">   
     <button type="submit" class="btn btn-default">수정</button>
     </div>
</FORM>
</DIV>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 