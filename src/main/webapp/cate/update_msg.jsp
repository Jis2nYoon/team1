<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

    <c:choose>
      <c:when test="${param.count == 1 }">
        <div class="alert alert-success alert-dismissable">
          <a href="./list.do" class="close" data-dismiss="alert" aria-hidden="true">×</a>
          <strong>성공!</strong><br> 카테고리를 수정했습니다.   
        </div>
      </c:when>
      <c:otherwise>
        <div class="alert alert-danger alert-dismissable">
          <a href="./list.do" class="close" data-dismiss="alert" aria-hidden="true">×</a>
          <strong>경고!</strong><br> 카테고리 수정에 실패했습니다.
        </div>
      </c:otherwise>
    </c:choose>
    <br>