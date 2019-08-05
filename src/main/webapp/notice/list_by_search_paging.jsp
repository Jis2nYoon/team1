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

<form name='frm' id='frm' method="get" action="./list_by_search_paging.do">

    
<DIV class="panel_gray col-md-12">
  <ASIDE style='float: right;'>
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' placeholder="검색"  style='width:50%'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' placeholder="검색" style='width:50%'>
      </c:otherwise>
    </c:choose>
    <button class="btn btn-default" type='submit'>검색</button>
    <button class="btn btn-default" type="button" onclick="location.href='./list_by_search_paging.do'">목록</button>
  </ASIDE> 
  
</DIV>

</form>

<!-- 임시 출력 -->
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 50%;'/>
    <col style='width: 20%;'/>
    <col style='width: 20%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>공지 번호</TH>
    <TH style='text-align: left ;'>제 목</TH>
    <TH style='text-align: center ;'>작성자</TH>
    <TH style='text-align: center ;'>등록일</TH>
    
  </TR>
  </thead>

  <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
    <c:forEach var="mem_NoticeVO" items="${list }">
  <TR>
    <TD style='text-align: center ;'>${mem_NoticeVO.noticeno }</TD>
    <TD style='text-align: left;'>
      <A href='./read.do?noticeno=${mem_NoticeVO.noticeno }&word=${param.word}&nowPage=${param.nowPage}'>
      ${mem_NoticeVO.title }</A></TD>   
    <TD style='text-align: center ;'>${mem_NoticeVO.nickname }</TD> 
    <TD style='text-align: center ;'>${mem_NoticeVO.rdate.substring(0, 10) }</TD>
  </TR>
  </c:forEach> 
  </tbody>
</TABLE>

  <button style='float: right;' class="btn btn-default" type="button" onclick="location.href='./create.do'">등록</button>

  <DIV class='bottom_menu'>${paging }</DIV>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

 