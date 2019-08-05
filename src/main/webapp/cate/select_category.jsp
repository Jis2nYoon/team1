<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

          <option value='-1' style="text-align-last: center;">카테고리 선택</option>
          <c:forEach var="cateVO" items="${list_category}" varStatus="status">
          <c:if test="${param.cateno == cateVO.cateno}">
            <option value='${cateVO.cateno}' selected="selected" style="text-align-last: center;">${cateVO.catename }</option>
          </c:if>
          <c:if test="${param.cateno != cateVO.cateno}">
            <option value='${cateVO.cateno}' style="text-align-last: center;">${cateVO.catename }</option>
          </c:if>
          </c:forEach>
          
