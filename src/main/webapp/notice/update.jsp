<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea Market</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>


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
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

<DIV class='title_line' >공지사항 수정</DIV>

<FORM name='frm' method='POST' action='./update.do'>
  <input type='hidden' name='noticeno' id='noticeno' value='${mem_NoticeVO.noticeno }'>
  <input type='hidden' name='word' id='word' value='${param.word }'>
  <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
  
  <fieldset class='fieldset_basic'>
    <ul>
    
    <div class="form-group">   
      <label for="title" class="col-md-1 control-label">제목</label>
      <div class="col-md-11">
        <input type='text' class="form-control input-lg" name='title' id='title' value='${mem_NoticeVO.title }'' placeholder="공지 제목" required="required">
      </div>
    </div>  
    <div class="form-group">   
      <label for="content" class="col-md-1 control-label">내용</label>
      <div class="col-md-11">
        <textarea class="form-control input-lg" name='content' id='content'  rows='10' placeholder="공지할 내용" required="required">${mem_NoticeVO.content }</textarea>
      </div>
    </div>

      <DIV style='text-align: right;'>
        <button type="submit" class="btn btn-default" >수정</button>
        <button type="button" class="btn btn-default"  onclick="javascript:history.back();">취소</button>
      </DIV>        
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 
 
 