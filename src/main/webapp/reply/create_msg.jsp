<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <c:choose>
      <c:when test="${count == 1 }">
        <div class="alert alert-success alert-dismissable">
          <button id="msg_close" onclick="location.href='javascript:init()'" type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
          <strong>성공!</strong><br> 새로운 댓글을 등록했습니다.   
        </div>
      </c:when>
      <c:otherwise>
        <div class="alert alert-danger alert-dismissable">
          <button id="msg_close" onclick="location.href='javascript:init()'" type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
          <strong>경고!</strong><br> 새로운 댓글 등록에 실패했습니다.
        </div>
      </c:otherwise>
    </c:choose>
    <br>