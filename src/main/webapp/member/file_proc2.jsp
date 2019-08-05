<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import = "java.io.File" %>
<%@ page import = "java.io.IOException" %>
 
<%@ page import="org.apache.commons.fileupload.*" %>
 
<%@ page import = "nation.web.tool.*" %>
 
전송된 파일 목록<br><br>
<%
//-------------------------------------------------------------------
// Fileupload 콤포넌트 관련 코드, 하나의 파일을 업로드 처리
//-------------------------------------------------------------------
String upDir = application.getRealPath("/member/storage");
String tempDir = application.getRealPath("/membes/temp");
 
FileItem fileItem = null;   //업로드 파일 객체
String filename = "";       //업로드 파일명
Upload upload = new Upload(request, -1, -1, tempDir);
 
 
// 전송하려는 파일이 최종적으로 3개임으로 3번 순환합니다.

  Thread.sleep(1000);  // 1초 지연, 서비스시 주석 처리
  fileItem = upload.getFileItem("file"); // file1, file2, file3
  
  if (fileItem != null){
    long filesize = fileItem.getSize(); // 파일 사이즈
    if(filesize > 0) {
      filename =upload.saveFile(fileItem, upDir); // 서버에 저장
      out.println("<IMG src='" + request.getContextPath() + "/javascript/jquery/form/storage/" + filename + "' style='width: 250px; height: 200px;'>");
    }  
  }
%>
 