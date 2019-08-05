<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    <c:choose>
      <c:when test="${param.count == 1 }">
        <div class="alert alert-success alert-dismissable">
          <!-- <button id="msg_close" type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button> -->
          <a href="./list.do" class="close" data-dismiss="alert" aria-hidden="true">×</a>
          <strong>성공!</strong><br> 새로운 카테고리를 등록했습니다.   
        </div>
      </c:when>
      <c:otherwise>
        <div class="alert alert-danger alert-dismissable">
          <!-- <button id="msg_close" type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button> -->
          <a href="./list.do" class="close" data-dismiss="alert" aria-hidden="true">×</a>
          <strong>경고!</strong><br> 새로운 카테고리 등록에 실패했습니다.
        </div>
      </c:otherwise>
    </c:choose>
    <br>