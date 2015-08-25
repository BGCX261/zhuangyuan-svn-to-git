<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String newpass = request.getParameter("newpass");
zy.util.CsvFile.newAdminPass(newpass);

%>

<script>location = "adminindex.jsp"; </script>