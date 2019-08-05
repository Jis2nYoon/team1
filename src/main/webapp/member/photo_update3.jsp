<%@ page contentType = "text/html; charset=UTF-8" %>
 
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
$(function() { // 자동 실행
  var params = "memberno="+${param.memberno};
  
  $.ajax({
    url: "/fm/member/getPhoto.do",
    type: "GET",
    cache: false,    
    dataType: "json", // or html
    data: params,
    success: function(data){
        if(data.sizes != '0'){
          $('#msg-down').html('<A href="../download?dir=/member/storage&filename=t.jpg"><span class="glyphicon glyphicon-download" style="font-size : 15px; " >DOWNLOAD</span></A>');
          $('#msg-panel').html("<A href='./storage/"+data.photo+"' target='_blank'><IMG src='./temp/" +data.thumbs+ "' class='rounded-circle' style='width: 180px; height: 180px;' title='크게 보기' ></A>");
        }
      },
      error : function() {
      }
    });
});

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
      dataType: "html", // or html
      success: function(data){
        if(data == 'delete'){
          $('#file', frm).val('');
          $('#msg').html('이미지 파일만 선택해주세요.')
        }
        else if(data=='fail'){          
          $('#msg').html('프로필사진 변경에 실패하였습니다.')
        }
        else{              
          var frm = $('#frm');
          $('#file', frm).val('');
          $('#msg-panel').html(data);
          //$('#msg').html('프로필사진이 변경되었습니다.');          
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
 
  <DIV id='msg-panel' style='width: 80%; margin: 20px auto;  text-align: center;'></DIV>    
  <DIV id='msg-down'  style ='margin: 20px auto;  text-align: center;'></DIV> 
  
  <DIV id='msg'  style= 'margin: 20px auto;  text-align: center; '></DIV> 
  
  <form name="frm" id="frm" action="./photo_update.do" class="form-horizontal" style="text-align:center;"
      method="post" enctype="multipart/form-data" style='margin: 30px;'>
    <input type='hidden' name='memberno' id='memberno' value='${param.memberno }'>     
    
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