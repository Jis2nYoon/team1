<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <!-- 이 페이지는 관리자와 해당 회원만 접근 가능 -->
 <!-- 글 수정 페이지 -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea Market</title>
<link href="../css/style.css" rel='Stylesheet' type='text/css'>
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
<script type="text/JavaScript">
window.onload = function(){
  CKEDITOR.replace('contents',{
    height: 500
  });  // <TEXTAREA>태그 id 값
}
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'> 
  <div class='title_line'>게시글 수정</div>

  <FORM name='frm' method='POST' action='./update.do' enctype="multipart/form-data" class="form-horizontal">
    <input type='hidden' name='contentsno' id='contentsno' value='${contentVO.contentsno }'>
    <div class="form-group">
      <label for='cateno' class="col-md-1 control-label">카테고리</label>
        <div class="col-md-11">
          <select id='cateno' name="cateno" class="form-control input-lg" >
          <c:forEach var="cateVO" items="${list_category}" varStatus="status">
          <c:if test="${contentVO.cateno == cateVO.cateno}">
            <option value='${cateVO.cateno}' selected="selected">${cateVO.catename }</option>
          </c:if>
          <c:if test="${contentVO.cateno != cateVO.cateno}">
            <option value='${cateVO.cateno}'>${cateVO.catename }</option>
          </c:if>
          </c:forEach>
          </select>
        </div>
    </div>
    <div class="form-group">   
      <label for="title" class="col-md-1 control-label">글 제목</label>
      <div class="col-md-11">
        <input type='text' class="form-control input-lg" name='title' id='title' value='${contentVO.title}' required="required">
      </div>
    </div>  
    <div class="form-group">   
      <label for="contents" class="col-md-1 control-label">내용</label>
      <div class="col-md-11"  style="min-height: 500px;">
        <textarea class="form-control input-lg" name='contents' id='contents'  rows='10'>${contentVO.contents }</textarea>
      </div>
    </div>
    <div class="form-group">   
        <label for="filesMF" class="col-md-1 control-label">파일 추가</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
        </div>
    </div>
    <div class="col-sm-11 col-sm-offset-1">
    <c:forEach var="fileVO" items="${file_list}" varStatus="status">
    <c:choose>
    <c:when test="${fn:length(file_list)  == 1 }">
      <c:set var="url" value="#"/>
    </c:when>
    <c:otherwise>
      <c:set var="url" value="./deletefile.do?contentsno=${contentVO.contentsno}&filename=${fileVO.file }"/>
    </c:otherwise>
    </c:choose>
        <c:choose>
          <c:when test="${fn:endsWith(fileVO.thumb, '.jpg')}">
          <div class="img-wrap img-thumbnail float-left ">
            <IMG id='file${status.count }'  src='./storage/${fileVO.thumb}' alt="${fileVO.file }" class="img-rounded">
            <A type="button" class="btn btn-danger btn-sm" href='${url }'>
              <span class="glyphicon glyphicon-trash" style="color: #cccccc;"></span>
            </A>
          </div>
          </c:when>
          <c:when test="${fn:endsWith(fileVO.thumb, '.gif')}">
          <div class="img-wrap img-thumbnail float-left ">
            <IMG id='file${status.count }' src='./storage/${fileVO.thumb}' alt="${fileVO.file }" class="img-rounded">
            <A type="button" class="btn btn-danger btn-sm" href='${url }'>
              <span class="glyphicon glyphicon-trash" style="color: #cccccc;"></span>
            </A>
          </div>
          </c:when>
          <c:when test="${fn:endsWith(fileVO.thumb, '.png')}">
          <div class="img-wrap img-thumbnail float-left ">
            <IMG id='file${status.count }' src='./storage/${fileVO.thumb}' alt="${fileVO.file }" class="img-rounded">
            <A type="button" class="btn btn-danger btn-sm" href='${url }'>
              <span class="glyphicon glyphicon-trash" style="color: #cccccc;"></span>
            </A>
          </div>
          </c:when>
        </c:choose>
    </c:forEach>
    </div>
    <DIV class="col-sm-offset-9">
      <button class="btn btn-default" type="submit">등록</button>
      <button class="btn btn-default" type="button" onclick="location.href='./list_cono_desc.do'">취소[목록]</button>
    </DIV>
  </FORM>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 