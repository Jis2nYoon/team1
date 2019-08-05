<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
 <!-- 평점 목록 관리자 -->
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 

<title>Flea market</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
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
 
  <ASIDE style='float: left;'>
      <A href='./list.do'>회원 평점 목록</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
  
 
  <span style='float: left;'>관리자만 접근가능합니다.</span>
  <table class="table table-striped" style='width: 100%; '>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 20%;'/>
    <col style='width: 15%;'/>
    <col style='width: 5%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <TR>
    <TH class='th' style="text-align:left;">회원NO</TH>
    <TH class='th' style="text-align:left;">이메일</TH>
    <TH class='th' style="text-align:left;">닉네임</TH>
    <TH class='th' style="text-align:center;">gradeno</TH>
    <TH class='th' style="text-align:center;">전체 평점</TH>
    <TH class='th' style="text-align:center;">판매자태도</TH>
    <TH class='th' style="text-align:center;">배송속도</TH>
    <TH class='th' style="text-align:center;">상품품질</TH>
    <TH class='th' style="text-align:center;">기타</TH>
  </TR>
 
  <c:forEach var="member_gradeVO" items="${list }">
    <c:set var="gradeno" value ="${member_gradeVO.gradeno }" /> 
  <TR>
    <TD class='td' style="text-align:left;">${member_gradeVO.memberno}</TD>
    <TD class='td' style="text-align:left;"><A href ="./read.do?mno=${member_gradeVO.memberno}" >${member_gradeVO.email}</A></TD>
    <TD class='td' style="text-align:left;">${member_gradeVO.nickname}</TD>
    <TD class='td' style="text-align:center;">${member_gradeVO.gradeno}</TD>
    <TD class='td' style="text-align:center;">${member_gradeVO.avggrade}</TD>
    <TD class='td' style="text-align:center;">${member_gradeVO.manner}</TD>
    <TD class='td' style="text-align:center;">${member_gradeVO.delivery}</TD>
    <TD class='td' style="text-align:center;">${member_gradeVO.quality}</TD>
    <TD class='td'  style="text-align:center;">
     <%--  <A href="javascript:stopdate_update(' ${member_gradeVO.gradeno}');"><IMG src='./images/stopdate.png' title='기타'></A>
      <A href="./delete.do?gradeno=${member_gradeVO.gradeno}"><IMG src='./images/delete.png' title='기타' ></A> --%>
    </TD>
    
  </TR>
  </c:forEach>
  
</TABLE>
 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>
  