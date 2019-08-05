<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
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
  $(function(){
 
  });
  function search_list(col, word){
    var col = $('#col').val();
    var word = $('#word').val();
    
    
  }
  function act_update(act, memberno) {
    // 문자열: ', ""
    var url = './act_update.do?memberno=' + memberno + '&act=' + act;
    var width = 500;
    var height = 400;
    var win = window.open(url, '권한 변경', 'width='+width+'px, height='+height+'px');
    var x = (screen.width - width) / 2; 
    var y = (screen.height - height) / 2;
    
    win.moveTo(x, y);
  
  }
  function stopdate_update(memberno) {
    // 문자열: ', ""
    var url = './stopdate_update.do?memberno=' + memberno ;
    var width = 500;
    var height = 400;
    var win = window.open(url, '계정 정지일 설정', 'width='+width+'px, height='+height+'px');
    var x = (screen.width - width) / 2; 
    var y = (screen.height - height) / 2;
    
    win.moveTo(x, y);
  
  }
  
  
</script>
</head> 
 
<body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' > 
  
  <ASIDE style='float: left;'>
  <form name='frm' id='frm' method="get" action="./list.do">
    <select name = "col" id="col">
      <option value = "email" ${param.col.trim()== 'email' ? "selected='selected'":""}>이메일</option>
      <option value = "nickname" ${param.col.trim()== 'nickname' ? "selected='selected'":""}>닉네임</option>
      <option value = "mname" ${param.col.trim()== 'mname' ? "selected='selected'":""}>성명</option>
    </select>
    <c:choose>
      <c:when test="${(param.col=='email' || param.col=='mname' || param.col=='nickname') && param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' >
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' >
      </c:otherwise>
    </c:choose>   
    <button type='submit' >검색</button>
    </form>
    
      <A href='./list.do'>회원 목록</A>  
      <c:if test="${param.word.length() > 0}"> 
      &nbsp;>
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
          
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록초기화</A>
    
  </ASIDE> 
 
  <div class='menu_line'></div>
  
 
  <span style='float: left;'>관리자만 접근가능합니다.</span>
  <span style='float: right;'>M: 마스터, Y: 로그인 가능, N: 로그인 불가, C: 탈퇴</span>
  <table class="table table-striped" style='width: 100%; '>
  <colgroup>
    <col style='width: 8%;'/>
    <col style='width: 15%;'/>
    <col style='width: 9%;'/>
    <col style='width: 7%;'/>
    <col style='width: 10%;'/>
    <col style='width: 12%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 7%;'/>
    <col style='width: 12%;'/>
  </colgroup>
  <TR>
    <TH class='th' style="text-align:center; ">사진</TH>
    <TH class='th' style="text-align:center;">이메일</TH>
    <TH class='th' style="text-align:center;">닉네임</TH>
    <TH class='th' style="text-align:center;">성명</TH>
    <TH class='th' style="text-align:center;">전화번호</TH>
    <TH class='th' style="text-align:center;">주소</TH>
    <TH class='th'  style="text-align:center;">등록일</TH>
    <TH class='th'  style="text-align:center;"><A href="./list.do?col=stopdate">정지기한</A></TH>
    <TH class="dropdown" style="text-align:center;">
            <a href=# class="dropdown-toggle" data-toggle="dropdown">상태 <b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><A href="./list.do?col=act&word=M">M</a></li>
              <li><A href="./list.do?col=act&word=Y">Y</a></li>
              <li><A href="./list.do?col=act&word=N">N</a></li>
              <li><A href="./list.do?col=act&word=C">C</a></li>
            </ul></TH>
    <TH class='th' style="text-align:center;">기타</TH>
  </TR>
 
  <c:forEach var="memberVO" items="${list }">
    <c:set var="memberno" value ="${memberVO.memberno }" /> 
  <TR>
<%--     <TD class='td' style="text-align:center;">${memberno}</TD> --%>
    <td class='td' >
            <c:choose>
              <c:when test="${memberVO.thumbs != ''}">
                <A href="./photo_update.do?memberno=${memberVO.memberno }"><IMG id='thumb' src='./temp/${memberVO.thumbs}' style='width: 90px; height: 90px;' ></A> 
              </c:when>
              <c:otherwise>
                <IMG id='thumb' src='./images/default.png' style='width: 80px; height: 80px;'> <!-- 파일이 존재하지 않는 경우 -->
              </c:otherwise>
            </c:choose>
    </td>        
    <TD class='td' ><A href="./read.do?memberno=${memberno}&col=${param.col}&word=${param.word}&nowPage=${nowPage}">${memberVO.email}</A></TD>
    <TD class='td' ><A href="./read.do?memberno=${memberno}">${memberVO.nickname}</A></TD>
    <TD class='td' ><A href="./read.do?memberno=${memberno}">${memberVO.mname}</A></TD>
    <TD class='td' >${memberVO.tel}</TD>
    <TD class='td' >
      <c:choose>
        <c:when test="${memberVO.address1.length() > 10 }">
          ${memberVO.address1.substring(0, 10) }
        </c:when>
        <c:otherwise>
          ${memberVO.address1}
        </c:otherwise>
      </c:choose>
    </TD>
    <TD class='td'  style="text-align:center;">${memberVO.mdate.substring(0, 10)}</TD> <!-- 년월일 -->      
    <TD class='td'  style="text-align:center;">
    <c:if test="${memberVO.stopdate ne ''}">
    ${memberVO.stopdate.substring(0, 10)}</c:if></TD>
    <TD class='td'  style="text-align:center;">
    <A href="javascript:act_update(' ${memberVO.act} ' ,' ${memberVO.memberno}');">${memberVO.act}</A>
    
    <TD class='td'  style="text-align:center;">
      <A href="javascript:stopdate_update(' ${memberVO.memberno}');"><span class="glyphicon glyphicon-time"  title='계정정지일 설정'></span></A>
      <%-- <A href="./passwd_update.do?email=${memberVO.email}"><span class="glyphicon glyphicon-lock"  title='패스워드 변경'></span></A> --%>
      <A href="./read.do?memberno=${memberVO.memberno}"><span class="glyphicon glyphicon-pencil" title='수정'></span></A>
      <A href="./cancel.do?memberno=${memberVO.memberno}"><span class="glyphicon glyphicon-ban-circle"  title='탈퇴' ></span></A>
      <A href="./delete.do?memberno=${memberVO.memberno}"><span class="glyphicon glyphicon-trash"  title='삭제' ></span></A>
    
          
    </TD>
    
  </TR>
  </c:forEach>
  
</TABLE>
 <DIV style="text-align: center;
    margin-top: 20px;">${paging }</DIV>
  <br><br>
  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>
  