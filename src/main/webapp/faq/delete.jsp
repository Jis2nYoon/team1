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

<DIV class='title_line' >FAQ 삭제</DIV>

<FORM name='frm' method='POST' action='./delete.do'>
  <input type='hidden' name='faqno' id='faqno' value='${faqVO.faqno }'>
  <br>
  <fieldset class='fieldset_basic'>
    <ul>
      <div style='text-align: center;'>
        <label>다음 FAQ를 삭제하시겠습니까?</label><br>
        <br>
        <label for='question'>질문: </label>${faqVO.question } <br>
        <label for='answer'>답변: </label>${faqVO.answer } <br>
        <br>
        <button type="submit" class="btn btn-default" >삭제</button>
        <button type="button" class="btn btn-default" onclick="javascript:history.back();">취소</button>   
      </div>
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 
 
 