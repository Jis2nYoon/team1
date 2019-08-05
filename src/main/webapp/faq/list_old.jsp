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

  
</script>

</head> 

<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >
  
<DIV class='title_line'>공지사항</DIV>

<DIV class='aside_menu'>
  <ASIDE style='float: right;'>
    <A href='./create.do'>등록</A> <span class='menu_divide'> |</span>
    <A href='./list.do'>새로고침</A> 
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>

<!-- 임시 출력 -->
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 40%;'/>
    <col style='width: 40%;'/>
    <col style='width: 5%;'/>
    <col style='width: 5%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>질문 번호</TH>
    <TH style='text-align: center ;'>질 문</TH>
    <TH style='text-align: center ;'>답 변</TH>
    <TH style='text-align: center ;'>회원 번호</TH>
    <TH style='text-align: center ;'>관 리</TH>
    
  </TR>
  </thead>

  <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
    <c:forEach var="faqVO" items="${list }">
  <TR>
    <TD style='text-align: center ;'>${faqVO.faqno }</TD>
    <TD style='text-align: center;'>${faqVO.question }</A></TD>
    <TD style='text-align: center ;'>${faqVO.answer }</TD>
    <TD style='text-align: center ;'>${faqVO.memberno }</TD>    
    <TD style='text-align: center ;'>
      <A href='./update.do?faqno=${faqVO.faqno }'><span class="glyphicon glyphicon-pencil" title="수정"></span></A>
      <A href='./delete.do?faqno=${faqVO.faqno }'><span class="glyphicon glyphicon-trash" title="삭제"></span></A>
    </TD>
  </TR>
  </c:forEach> 
  </tbody>
  
</TABLE>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

 