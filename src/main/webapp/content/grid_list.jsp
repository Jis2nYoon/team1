<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 <!-- 대부분의 고객, 사이트 이용자가 보게 될 화면 -->
 <!-- 로그인하지 않아도 볼 수 있다. -->
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
    
</head>
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

<div>
  <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
  </c:if>
  <c:if test="${param.word.length() == 0}"> 
  </c:if>
</div>
<div class="row" style="min-height: 500px;">
 <c:forEach var="cate_ContentVO" items="${list }" varStatus="status"> 
  <div class="col-sm-3">
    <div class="thumbnail">
      <a href="./read.do?contentsno=${cate_ContentVO.contentsno }">
      <c:set var="image" value="${fn:split(cate_ContentVO.picture,'/')[0]}"/>
      <c:set var="len" value="${fn:length(image) }"/>
      <c:set var="ind" value="${fn:indexOf(image, '.')}"/>
        <IMG src="./storage/${fn:substring(image,0,ind) }_t${fn:substring(image,ind,len) }" alt="${image }" style="width:100%">
        
        <c:if test="${cate_ContentVO.saleA == 'Y' }">
          <hr>
          ${cate_ContentVO.pname } · ${cate_ContentVO.price }원
          <div class="caption" style="padding:0px;margin:0px;">
          <br>
          <span class="title_span">${fn:substring(cate_ContentVO.title, 0, 15)}</span><span class='reply_span'>[${replycnt.get(cate_ContentVO.contentsno) }]</span>
          </div>
        </c:if>
        <c:if test="${cate_ContentVO.saleA == 'N' }">
          <hr>
          [판매완료]
          <div class="caption" style="padding:0px;margin:0px;">
          <br>
          <del class="title_span">제목: ${fn:substring(cate_ContentVO.title, 0, 15)}</del><span class='reply_span'>[${replycnt.get(cate_ContentVO.contentsno) }]</span>
          </div>
        </c:if>
        <br>
        <span class="ndc_span">
        ${nickmap.get(cate_ContentVO.memberno) } · ${fn:substring(cate_ContentVO.rdate,0,11) } · 조회 ${cate_ContentVO.views }</span>
      </a>
    </div>
  </div>
 </c:forEach> 
</div>
<DIV style='text-align: right; margin: 10px;'>
  <A class="btn btn-default" href="./create.do?cateno=0">글 등록</A>
</DIV>
<!-- paging -->
<DIV style="text-align: center;">${paging }</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

