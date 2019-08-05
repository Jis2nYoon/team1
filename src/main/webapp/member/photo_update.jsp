<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
 
<!--파일 업로드 폼 form-->

<!DOCTYPE html>
<html lang="ko"> 
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Flea market</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">   
function deleteImg() {    
  $.ajax({
    type: "POST",
    url: "./photo_delete.do",
    cache: false,
    dataType: "json", // or html
    success: function(data){
      if(data.doing=='delete'){  
        $("#msg-img").attr("src", './images/default.png')
        $('#msg-down').hide();
        $('#default').hide();
        $('#file', frm).val('');  
        alert('프로필사진이 삭제되었습니다.')
      }else if(data.doing == 'fail')
        alert('프로필사진이 삭제를 실패하였습니다.')
    },
    error : function(e) {
      alert("error" + e);
      
    }
  });
}

  function send() {
    var form = $('#frm');
    var frm = $('#frm')[0];
    
    //var file = $('#file', frm).val();
    //var formData = new FormData(form)
    var formData = new FormData(frm);
    if ($('#file', form).val() == '') { // frm 폼에서 id가 'file'인 태그 검색
      
      alert('전송할 이미지 파일을 선택해주세요')
      return; // 실행 중지

    }

    $.ajax({
      type: "POST",
      enctype : "multipart/form-data",
      url: "./photo_update.do",
      data: formData,
      processData:false,
      contentType:false,
      cache: false,
      dataType: "json", // or html
      success: function(data){
        if(data.doing == 'onlyImg'){
          $('#file', frm).val('');
          $('#msg').html('이미지 파일만 선택해주세요.')
        }
        else if(data.doing=='fail'){          
          $('#msg').html('프로필사진 변경에 실패하였습니다.')
        }       
        else if(data.doing=='success'){                
          $("#msg-img").attr("src", "./temp/"+data.thumbs)
          $("#msg-photo").attr("href", "./storage/"+data.photo)
          $("#msg-down").attr("href", "../download?dir=/member/storage&filename="+data.photo )
          $("#msg-down").show();
          $('#default').show();
          $('#file', frm).val('');        
          alert('프로필사진이 변경되었습니다.')
        }
      },
      error : function(e) {
        alert("error" + e);
        
      }
    });
  }

</script>
 
</head>

 <body>
<DIV class='container' >
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' >  
 
  <!-- 전송시 체크된 값 관련 메시지 출력 -->
    <DIV class='title_line'>프로필 사진 변경</DIV>
    
 
 <!-- 전송 결과 출력 --> 
 <c:choose>
  <c:when test = "${photo ne ''}">
    <DIV style='width: 80%; margin: 20px auto;  text-align: center;'>
      <A   id='msg-photo'  href='./storage/${photo }'  target='_blank' >
      <IMG src='./temp/${thumbs }'   id='msg-img'  class='rounded-circle' style='width: 180px; height: 180px;' title='크게 보기' ></A></DIV>      
    <DIV style ='margin: 20px auto;  text-align: center;'>
      <A href="../download?dir=/member/storage&filename=${photo }" id='msg-down'  target='_blank'  >
      <span class="glyphicon glyphicon-download" style="font-size : 15px; " >DOWNLOAD</span></A><br>
      <input type="button"  name="default" id="default" value='기본 이미지 적용'  onclick="deleteImg();" style=' margin-bottom:20px;'></DIV>
   </c:when>
   <c:otherwise>
      <DIV style='width: 80%; margin: 20px auto;  text-align: center;'>
      <IMG src='./images/default.png'   id='msg-img'  class='rounded-circle' style='width: 180px; height: 180px;'></DIV>
   </c:otherwise>
  </c:choose>
  <DIV id='msg'  style= 'margin: 20px auto;  text-align: center; '></DIV> 
  
  <form name="frm" id="frm" action="./photo_update.do" class="form-horizontal" style="text-align:center;"
      method="post" enctype="multipart/form-data" style='margin: 30px;'>
    
    
    <input type="file"  name="file" id="file" style=' width: 230px; margin: 0px auto; '>
    
    <br>※ 이미지 파일만 선택 가능합니다. ( jpg / jpeg / png / gif ) <br>
    ※ 권장 크기 : (180px * 180px) 이상<br><br>
    
    
    <input type="button" class="btn btn-primary btn-md" style = "background:#22232D;" value="전송" onclick="send();">
    <input type="reset" class="btn btn-primary btn-md" style = "background:#22232D;" value="선택취소" >
  </form><br>
 
   
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>