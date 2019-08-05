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
  var photo = '';
  $.ajax({
    url: "/fm/member/getPhoto.do",
    type: "GET",
    cache: false,    
    dataType: "json", // or html
    data: params,
    success: function(data){
      var photo = data.photo;
        if(data.sizes != '0'){
         //alert(data.sizes);
       //  "<IMG src='" +  request.getContextPath()+"/member/temp/" +data.thumbs+ "' style='width: 200px; height: 150px;'">
         $('#msg-panel').html("<IMG src='./temp/" +data.thumbs+ "' style='width: 150px; height: 150px;' onclick='panel_img(${param.memberno })' title='크게 보기' >"); 
        }
      },
      error : function() {
      }
    });
});
function panel_img(){
  var params = "memberno="+${param.memberno};
  $.ajax({
    url: "/fm/member/getPhoto.do",
    type: "GET",
    cache: false,    
    dataType: "json", // or html
    data: params,
    success: function(data){     
      var url = './storage/'+data.photo;
      var img=new Image();
      img.src=url;
       var img_width=img.width;
       var win_width=img.width;
      var height=img.height;
      var OpenWindow=window.open('','_blank', 'width='+img_width+', height='+height+', menubars=no, scrollbars=auto');
      OpenWindow.document.write("<style>body{margin:0px;}</style><img src='./storage/"+data.photo+"' width='"+win_width+"'>");
      
      
//         if(data.sizes != '0'){         
//          var panel = '';
//          panel += "<DIV id='panel' class='popup_img' style='width: 80%; margin: 0px 5%;'>";
//          panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+data.photo+"' style='width: 100%;'></A>";
//          panel += "</DIV>";
         
//          $('#main_panel').html(panel);
//          $('#main_panel').show();
         
//         }
      },
      error : function() {
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
          $('#msg').html('프로필사진이 변경되었습니다.');          
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
  
  <DIV id='msg'  style= 'margin: 20px auto;  text-align: center; color: #000055; font-size: 1.2em;' ></DIV> 
  
  <form name="frm" id="frm" action="./photo_update.do" 
      method="post" enctype="multipart/form-data" style='margin: 30px;'>
    <input type='hidden' name='memberno' id='memberno' value='${param.memberno }'>     
    
    <input type="file" name="file" id="file" style='margin-top: 30px;'>
    <br>※ 이미지 파일만 선택 가능합니다.( jpg / jpeg / png / gif )<br><br>
    
    <input type="button" value="전송" onclick="send();">
    <input type="reset" value="선택취소" >
  </form><br>
 
   
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>
 
</html>