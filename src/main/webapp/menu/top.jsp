<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.ArrayList"%>
<script type="text/JavaScript">
/* login 스크립트 START */
//------------------프로필 이미지 적용
$(function() { // 자동 실행
  //session안에 memberno가 null이 아니라면 프로필 이미지 적용 스크립트 실행
  <c:if test="${sessionScope.memberno != null}">
      var params = 'memberno='+${sessionScope.memberno}
      $.ajax({
        url: "/team1/member/getPhoto.do",
        type: "GET",
        cache: false,
        dataType: "json", // or html
        data : params,
        success: function(data){
            if(data.sizes != '0'){
             //alert(data.sizes);
             $('#profile-img').attr("src","${pageContext.request.contextPath}/member/temp/"+data.thumbs); 
            }
          },
          error : function() {
          }
        });
  </c:if>
});
//------------------프로필 이미지 적용 end
  $(document).ready(function() { $('#profile-btn').data('status', 'close');});
    
  function toggle_proc(id, id2) {
    var status = $(id).data("status");
    if (status == "open") {
      closeNav(id, id2);
    } else {
      openNav(id, id2);
    }
  }

  function openNav(id, id2) {
    $(id2).addClass('active');
    $(id).data("status", "open");
  }
  function closeNav(id, id2) {
    $(id2).removeClass('active');
    $(id).data("status", "close");
  }
  /* login 스크립트 END */
/*content 스크립트 시작*/
  $(document).ready(function() { $('#profile-btn').data('status', 'close');});
  
  function toggle_proc(id, id2) {
    var status = $(id).data("status");
    if (status == "open") {
      closeNav(id, id2);
    } else {
      openNav(id, id2);
    }
  }

  function openNav(id, id2) {
    $(id2).addClass('active');
    $(id).data("status", "open");
  }
  function closeNav(id, id2) {
    $(id2).removeClass('active');
    $(id).data("status", "close");
  }

  //검색
  function search() {
    var frm_search = $('#frm_search');
    //alert($('#search_cateno option:selected').val());
    if ($('#search_cateno option:selected').val() == -1) {
      frm_search.attr('action', '${pageContext.request.contextPath}/content/search_list_all_paging.do');
    } else {
      frm_search.attr('action', '${pageContext.request.contextPath}/content/search_list_by_cateno_paging.do');
    }
    frm_search.submit();
  }
  /*content 스크립트 종료*/
</script>

<div class="mynavbar">
  <a class="mybrand" href="${pageContext.request.contextPath}/index.jsp">
    <span class="mybrandtext">Flea Market</span>
  </a>
  <!-- 화면 상단 메뉴 -->
  <!-- 검색 부분 시작 -->
  <div class="search-container">
    <form class="search-form" role="search" method='GET' action='' id='frm_search'>
      <!-- Spring 출력 카테고리 목록 select form -->
      <select id='search_cateno' name="cateno">
        <c:import url="/cate/category_select.do" /> 
      </select>
      <input type="text" id="word" name="word" placeholder="검색어를 입력하세요.">
      <button type="button" onclick="javascript:search()">검색</button>
    </form>
  </div>
  <!-- 검색 부분 끝 -->
</div>



<DIV style='clear: both;'></DIV>
<div class="mynavbar" style="margin-bottom: 30px;">
  <!-- 드롭다운 메뉴 시작 -->
  <div class="mydropdown" style="float: left;" id="profile"><!-- 로그인 확인 --><!-- 로그인 화면으로 연결 -->
    <c:choose>
      <c:when test="${sessionScope.email == null}">
        <a href="${pageContext.request.contextPath}/member/login.do">Login </a>
      </c:when>
    <c:otherwise>
    <button type="button" class="dropbtn" id="profile-btn" onclick="javascript:toggle_proc('#profile-btn', '#profile')">

<!--   //------------------프로필 기본이미지 적용 -->
     <img  id='profile-img'  src="${pageContext.request.contextPath}/member/images/default.png"  class="rounded-circle">  
     ${sessionScope.nickname }&nbsp;(${sessionScope.email })
        
    </button>
    <div class="mydropdown-content">
      <ul class="collapsible collapsible-accordion">
        <li><a href="${pageContext.request.contextPath}/member/logout.do"> Logout </a></li>
        <li>
        <a data-toggle="collapse" data-target="#submitblog">
            <span class="glyphicon glyphicon-star" style="color: #e89510;"></span> 
            <span class="mytextcolor">마이페이지<b class="caret mytextcolor"></b></span>
        </a>
          <div id="submitblog" class="collapse">
            <ul> 
              <li>
                <a href="${pageContext.request.contextPath}/member/photo_update.do?memberno=${sessionScope.memberno}" class="mycollapsecontent">
                  <span class="myindent mytextcolor">프로필 사진 변경</span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/member/read.do?memberno=${sessionScope.memberno}" class="mycollapsecontent">
                  <span class="myindent mytextcolor">내정보 수정</span>
                </a><!-- 본인 비밀번호 변경 등등 -->
              </li>
              <li> 
                <a href="${pageContext.request.contextPath}/grade/read.do?mno=${sessionScope.memberno}" class="mycollapsecontent">
                  <span class="myindent mytextcolor">내 등급</span>
                </a><!-- 본인 비밀번호 변경 등등 -->
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/login/list_memberno.do?mno=${sessionScope.memberno}" class="mycollapsecontent"> 
                  <span class="myindent mytextcolor">내 로그인내역</span>
                </a>
              </li>
              <li>
                <a href="#" class="mycollapsecontent"> 
                  <span class="myindent mytextcolor">내가 올린 글 모아보기</span>
                </a>
              </li>
            </ul>
          </div>
        </li>
        <li>
        <a data-toggle="collapse" data-target="#chat">
          <span class="glyphicon glyphicon-envelope" style="color: #e89510;"></span> 
          <span class="mytextcolor">쪽지함<b class="caret mytextcolor"></b></span>
        </a>
          <div id="chat" class="collapse">
            <ul>
              <li><a href="${pageContext.request.contextPath}/msg/list_seller.do?msgreceiver=${sessionScope.memberno}" class="mycollapsecontent">
                <span class="myindent mytextcolor">판매 관리</span></a></li>  
              <li><a href="${pageContext.request.contextPath}/msg/list_buyer.do?memberno=${sessionScope.memberno}" class="mycollapsecontent">
                <span class="myindent mytextcolor">구매 관리</span></a></li>
            </ul>
          </div></li>
        <li>
        <a data-toggle="collapse" data-target="#contact_me">
            <span class="glyphicon glyphicon-eye-open" style="color: #e89510;"></span>
            <span class="mytextcolor">고객센터<b class="caret mytextcolor"></b></span>
        </a>
          <div id="contact_me" class="collapse">
            <ul>
              <li>
                <a href="${pageContext.request.contextPath}/faq/list.do" class="mycollapsecontent">
                  <span class="myindent mytextcolor">FAQ</span>
                </a>
              </li>
              <li>
              <a href="${pageContext.request.contextPath}/qna/list.do" class="mycollapsecontent">
                <span class="myindent mytextcolor">1:1 문의하기</span>
              </a>
              <!-- 1:1 문의하기는 이메일로 받는걸로 구현 --></li>
            </ul>
          </div>
        </li>
        <c:if test = "${sessionScope.act == 'M'}"><!-- 관리자 일때만 메뉴가 보이도록 함. --> 
        <li>
        <a data-toggle="collapse" data-target="#about"> 
          <span class="glyphicon glyphicon-cog" style="color: #e89510;"></span>
          <span class="mytextcolor">관리자<b class="caret mytextcolor" ></b></span>
          <!-- 관리자 페이지 모음 -->
        </a>
          <div id="about" class="collapse">
            <ul>
              <li>
                <a href="${pageContext.request.contextPath}/cate/list.do" class="mycollapsecontent">
                  <span class="myindent mytextcolor">카테고리 관리</span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/content/list_cono_desc.do" class="mycollapsecontent">
                  <span class="myindent mytextcolor">컨텐츠 관리</span>
                </a>
              </li>
              <li class="divider"></li> <!-- 회원 관리 페이지랑 분리 -->
              <li>
                <a href="${pageContext.request.contextPath}/member/list.do" class="mycollapsecontent">
                 <span class="myindent mytextcolor">회원 전체목록</span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/login/list.do" class="mycollapsecontent">
                 <span class="myindent mytextcolor">로그인내역 전체목록</span>
                </a>
              </li>
              <li>
                <a href="${pageContext.request.contextPath}/grade/list.do" class="mycollapsecontent">
                 <span class="myindent mytextcolor">등급 전체목록</span>
                </a>
              </li>
            </ul>
          </div>
          </li>
        </c:if><!-- 관리자 섹션 끝 --> 
      </ul>
    </div>
      </c:otherwise>
    </c:choose>
  </div>
  <div class="mydropdown" id="menu3">
  <!-- 메뉴2 -->
  <div class="mydropdown" id="menu2">
    <button type="button" class="dropbtn" id="menu2-btn"
    onclick="javascript:toggle_proc('#menu2-btn', '#menu2')"> 카테고리 <b class="caret mytextcolor"></b></button>
    <div class="mydropdown-content">
      <div style="margin-bottom: 10px;">
        <c:import url="/cate/category_list.do" />
      </div>
    </div>
  </div>
  <!-- 메뉴1 -->
  <a href="${pageContext.request.contextPath}/content/list_all_desc.do">전체 물품</a>
  </div>
</div>
<!-- mynavbar 끝 -->



