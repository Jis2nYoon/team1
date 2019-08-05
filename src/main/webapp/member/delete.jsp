<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
 <!--회원 삭제 페이지-->
 <!-- 이 페이지는 관리자만 접근 가능-->
 
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

  function login_delete() {
    //var frm = $('#frm');
    //var login_span = $('#login_span', frm).val();
    var params = "memberno="+${memberVO.memberno};
    var con_test = confirm("삭제하면 복구할 수 없습니다. \n 정말로 삭제하시겠습니까?");
    if (con_test == true) {

      $.ajax({
        url : "../login/delete.do",
        type : "GET",
        cache : false,
        dataType : "json", // or html
        data : params,
        success : function(data) {
          if (data.count >= 1) {
            alert("로그인내역이 삭제되었습니다.");
            location.href="./delete.do?memberno="+${memberVO.memberno};
          } else {
            alert("로그인내역 삭제가 실패하였습니다.");
          }
        },
        // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
        error : function(request, status, error) {
          var msg = "에러가 발생했습니다. <br><br>";
          msg += "다시 시도해주세요.<br><br>";
          msg += "request.status: " + request.status + "<br>";
          msg += "request.responseText: " + request.responseText + "<br>";
          msg += "status: " + status + "<br>";
          msg += "error: " + error;
          alert(msg);
        }
      });
    } else if (con_test == false) {
      alert("로그인내역 삭제가 취소되었습니다.");
    }

  }

  function grade_delete() {
    //var frm = $('#frm');
    //var login_span = $('#login_span', frm).val();
    var params = "memberno="+${memberVO.memberno};
    var con_test = confirm("삭제하면 복구할 수 없습니다. \n 정말로 삭제하시겠습니까?");
    if (con_test == true) {

      $.ajax({
        url : "../grade/delete.do",
        type : "GET",
        cache : false,
        dataType : "json", // or html
        data : params,
        success : function(data) {
          if (data.count >= 1) {
            alert("회원 등급이 삭제되었습니다.");
            location.href="./delete.do?memberno="+${memberVO.memberno};
          } else {
            alert("회원 등급 삭제가 실패하였습니다.");
          }
        },
        // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
        error : function(request, status, error) {
          var msg = "에러가 발생했습니다. <br><br>";
          msg += "다시 시도해주세요.<br><br>";
          msg += "request.status: " + request.status + "<br>";
          msg += "request.responseText: " + request.responseText + "<br>";
          msg += "status: " + status + "<br>";
          msg += "error: " + error;
          alert(msg);
        }
      });
    } else if (con_test == false) {
      alert("회원 등급 삭제가 취소되었습니다.");
    }

  }
</script>
</head> 
<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' > 
 
  <ASIDE style='float: left;'>
      <A href='./member/list.do'>회원 목록</A> > 회원 삭제 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
<DIV class='title_line'>회원 삭제</DIV>
 
<DIV class='content' >
  <FORM name='frm' method='POST' action='./delete.do'>  
    <input type='hidden' name='memberno' value='${memberVO.memberno }'>   
  
    '${memberVO.mname }(${memberVO.email })' 
    회원을 삭제하려면 로그인내역과 회원 등급을 삭제해야 합니다.<br><br>
    
    <span >로그인 내역 삭제하기 [${cntLogin}건]</span><br><br>
    <c:if test = "${cntLogin != 0 }">
    <a href = "../login/list_memberno.do?mno=${memberVO.memberno }"><로그인 내역 확인하기></a></c:if>
    <button type="button" name="login_btn" onclick="login_delete()" 
    <c:if test = "${cntLogin == 0 }">disabled='disabled'</c:if>>삭제</button>
    
        <br><br>
    <span >회원 등급 삭제하기 [${cntGrade}건]</span><br><br>
    <c:if test = "${cntGrade != 0 }">
    <a href = "list_memberno.do"><회원 등급 확인하기></a></c:if>
    <button type="button" name="grade_btn" onclick="grade_delete()" 
    <c:if test = "${cntGrade == 0 }">disabled='disabled'</c:if>>삭제</button>
    
      <br><br>
    회원 삭제하기
    삭제하면 복구 할 수 없습니다.<br><br>
    정말로 삭제하시겠습니까?<br><br>           
        
    <button type="submit">삭제</button>
    <button type="button" onclick="location.href='./list.do'">취소(목록)</button>
 
  </FORM>
</DIV>
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html> 
 
 