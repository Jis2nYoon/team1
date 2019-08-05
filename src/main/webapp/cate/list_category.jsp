<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
          
        <c:forEach var="cateVO" items="${list_category}" varStatus="status">
          <A href="${pageContext.request.contextPath}/content/search_list_by_cateno_paging.do?cateno=${cateVO.cateno }">${cateVO.catename }</A>
        </c:forEach>
