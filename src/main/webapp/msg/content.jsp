<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8"> 
<title>Insert title here</title>
</head>
<body>

  <fieldset class='fieldset_basic'>
    <!-- memberno = 거래 게시글을 올린사람 -->
    <!-- 상품 페이지에서 쪽지보내기 버튼  -->
    <A href='./create.do?memberno=1&contentsno=1'>거래 신청하기</A> <span class='menu_divide'> |</span>
    
    <!-- top menu에 링크되어야 할 주소들 -->
    <A href='./list_seller.do?msgreceiver=1'>판매자일 경우 쪽지보기</A> <span class='menu_divide'> |</span>
    <A href='./list_buyer.do?memberno=2'>구매자일 경우 쪽지보기</A> <span class='menu_divide'> |</span>
    <A href='./list_send.do?memberno=1&contentsno=1'>보낸 쪽지보기</A> <span class='menu_divide'> |</span>
    <A href='./list_receive.do?memberno=1&contentsno=1'>받은 쪽지보기</A> <span class='menu_divide'> |</span>
  </fieldset>


</body>
</html>