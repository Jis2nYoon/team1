<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
  content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />
<title>Flea Market</title>


<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script
  src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
  href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
  src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function() {

  });
</script>

</head>

<body>
  <DIV class='container'>
    <DIV class='content'>

      <div class="alert alert-danger alert-dismissable">
        <!-- <button id="msg_close" type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button> -->
        <a href="../index.jsp" class="close" data-dismiss="alert" aria-hidden="true">×</a> 
        <br>로그인이 필요한 페이지입니다.
      <BR>
      <BR> [<A href='${pageContext.request.contextPath}/member/login.do'>로그인</A>]
      [<A href='${pageContext.request.contextPath}/member/create.do'>회원 가입</A>]
    </DIV>

  </DIV>
  <!-- content END -->
  </DIV>
  <!-- container END -->
</body>

</html>
