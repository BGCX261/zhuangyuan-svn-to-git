<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="zy.util.*,java.io.File"%>


<%
request.setCharacterEncoding("UTF-8");
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("3")) {
  response.sendRedirect("error.html?message=2");
}

FileUploadRequest request1 = new FileUploadRequest(request);

String aaa = request1.getParameter("ff__absolute");

if (aaa != null) {
	String path1 = zy.util.FileUtil.decodeFile(aaa,"zip");
	System.out.println(path1);
	new zy.util.Commond("jar xvf \""+path1+"\"").run();
	session.setAttribute("error","还原成功！");
}
else {
	session.setAttribute("error","还原失败！");
}
%>

<script>location = "bak.jsp"; </script>