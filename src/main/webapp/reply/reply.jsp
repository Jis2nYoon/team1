<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


  <!-- 댓글 시작 -->
  <div class="col-sm-10 col-sm-offset-1">
    <div class="col-sm-12" style="border-bottom: solid 1px #e89510;">
    <strong style="margin-left: 10px; font-size: 1.2em;">댓글 </strong> <span id="replyCnt"> ${replycnt } </span>
    <a href="#" ><i class='fas fa-sync-alt'></i></a>
  </div>
  <!-- 댓글 form -->
  <div id="reply" class="col-sm-12" style="margin: 10px;">
      <p class="form-control-static">아이디</p>
      <textarea class="form-control input-lg" name='contents' id='contents'  rows='4'>댓글을 입력하세요.</textarea>
      <DIV style='text-align: right; margin: 10px;'>
        <button class="btn btn-default" type="button" onclick="location.href='#'">등록</button>
      </DIV>
  </div>
  <!-- 댓글 내용 -->
  <c:forEach var="ReplyVO" items="${replylist }" varStatus="status">
  <div class="col-sm-12" style="margin: 10px;">
    <div id="indent" class="col-sm-${ReplyVO.indent }" style='text-align: right;'>
      <!-- <i class="material-icons">&#xe8e4;</i> -->
    <!-- jquery로 innerhtml수정으로 넣도록함. -->
    </div>
    <div class="well col-sm-${12-ReplyVO.indent }">
      <DIV style="margin-left: 10px;font-size: 0.9em; color: #e89510; float: left;">아이디 ${ReplyVO.memberno }</DIV>
      <DIV style='float: right;'>
      <!-- 댓글 memberno와 본인의 memberno가 일치하면 버튼이 보이도록함.
                관리자의 경우도 보이도록한다. -->
        <button class="myreply_btn" type="button" id="reply_update" onclick="location.href='#'"> 수정</button>
        <span class="myreply_span">/</span>
        <button class="myreply_btn" type="button" id="reply_delete" onclick="location.href='#'"> 삭제</button>
      </DIV>
      <DIV style=' clear: both;'></DIV>
      <div style="word-wrap: break-word; margin: 10px auto; width: 95%;">${ReplyVO.replycont }</div>
      <div style="float: right; font-size: 0.9em; color: #999999;">${ReplyVO.rdate }</div>
      <DIV style=' clear: both;'></DIV>
    </div>
    <!-- 대댓글 form  display: none으로 가리고 있다가 글 내용을 클릭하면 show하도록함.--> 
    <div class="col-sm-${ReplyVO.indent }">
    </div>
    <div id="reply_comment" class="col-sm-${12-ReplyVO.indent }" style="display: none;">
      <p class="form-control-static">아이디 ${ReplyVO.memberno }</p>
      <textarea class="form-control input-lg" name='contents' id='contents'  rows='4'>댓글을 입력하세요.</textarea>
      <DIV style='text-align: right; margin: 10px;'>
        <button class="btn btn-default" type="button" onclick="location.href='#'">등록</button>
      </DIV>
    </div>
    </div>
    </c:forEach>
  </div>
  <!-- 댓글 끝 -->