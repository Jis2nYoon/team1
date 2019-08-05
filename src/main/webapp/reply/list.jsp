<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

    <c:forEach var="ReplyVO" items="${replylist }" varStatus="status">
      <div id="indent" class="col-sm-${ReplyVO.indent } reply_indent">
      <c:if test="${ReplyVO.indent > 0}">
          <i class="glyphicon glyphicon-share-alt gly-rotate-180"></i>
      </c:if>
      </div>
      <div class="well col-sm-${12-ReplyVO.indent }">
        <DIV style="margin-left: 10px;font-size: 0.9em; color: #e89510; float: left;">${nickmap.get(ReplyVO.memberno) }</DIV>
        <DIV style='float: right;'>
        <!-- 댓글 memberno와 본인의 memberno가 일치하면 수정/삭제 버튼이 보이도록함.-->
        <c:if test="${ReplyVO.memberno == sessionScope.memberno }">
          <button class="myreply_btn" type="button" id="reply_update" onclick="location.href='javascript:update_form(${ReplyVO.replyno})'"> 수정</button>
          <span class="myreply_span">/</span>
          <button class="myreply_btn" type="button" id="reply_delete" onclick="location.href='javascript:delete_proc(${ReplyVO.replyno})'"> 삭제</button>
        </c:if>
        <!-- 관리자의 경우에는 삭제만 보이도록한다.  -->
        <c:if test="${ReplyVO.memberno != sessionScope.memberno }">
          <c:if test="${sessionScope.act == 'M' }">
            <button class="myreply_btn" type="button" id="reply_delete" onclick="location.href='javascript:delete_proc(${ReplyVO.replyno})'"> 삭제</button>
          </c:if>
        </c:if>
        </DIV>
        <DIV style=' clear: both;'></DIV>
        <div style="word-wrap: break-word; margin: 10px auto; width: 95%;">
          <c:if test="${ReplyVO.indent == 1 }">
            ${ReplyVO.replycont }
          </c:if>
          <c:if test="${ReplyVO.indent < 1 }">
            <A href="javascript:r_reply_form(${ReplyVO.replyno })">${ReplyVO.replycont }</A>
          </c:if>
        </div>
        <div style="float: right; font-size: 0.9em; color: #999999;">${ReplyVO.rdate }</div>
        <DIV style=' clear: both;'></DIV>
      </div>
      <!-- 대댓글 form  display: none으로 가리고 있다가 글 내용을 클릭하면 show하도록함.--> 
      <div id="r_reply${ReplyVO.replyno }" class="col-sm-${12-ReplyVO.indent } col-sm-offset-${ReplyVO.indent }" style="display: none;">
        <!-- 댓글 form -->
        <c:if test="${ReplyVO.indent < 1 }"><!-- indent가 1이면 form이 보이지 않도록 함. -->
        <DIV id="reply${ReplyVO.replyno }" class="col-sm-${12-ReplyVO.indent }" style="margin: 10px;">
        <FORM class='form' name='frm_reply${ReplyVO.replyno }' id='frm_reply${ReplyVO.replyno }' method='POST' action='../reply/create_reply.do'>
          <input type='hidden' name='replyno' id='replyno' value='${ReplyVO.replyno }'> <!-- 부모 댓글의 replyno를 일단은 여기에 넣어서 넘긴다. -->
          <input type='hidden' name='indent' id='indent' value='0'>
          <input type='hidden' name='grpno' id='grpno' value='0'>
          <input type='hidden' name='ansnum' id='ansnum' value='0'>
          <input type='hidden' name='contentsno' id='contentsno' value='${ReplyVO.contentsno}'>
<%--           ${ReplyVO.contentsno}/${ReplyVO.memberno }/${ReplyVO.replyno }/${ReplyVO.indent }/${ReplyVO.grpno }/${ReplyVO.ansnum } --%>
          <p class="form-control-static myreply_span" id="ids">${nickmap.get(sessionScope.memberno) }</p><!-- 이부분의 아이디는 member sql을 이용해서 닉넴이나 아이디를 쓰게 될 부분-->
          <textarea class="form-control input-lg" name='replycont' id='replycont'  rows='4'>대댓글을 입력하세요.</textarea>
          <DIV style='text-align: right; margin: 10px;'>
          <button class="btn btn-default" type="button" id="btn_reply${ReplyVO.replyno }" onclick="location.href='javascript:r_reply_proc(${ReplyVO.replyno })'"> 등록</button>
          <button class="btn btn-default" type="button" onclick="location.href='javascript:cancel(${ReplyVO.replyno })'"> 취소</button>
        </DIV>
        </FORM>
        </DIV>
        </c:if><!-- indent가 1이면 form이 보이지 않도록 함. -->
      </div>
    </c:forEach>