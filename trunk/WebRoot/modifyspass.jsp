<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String cid = request.getParameter("CID");
String value = request.getParameter("V");
zy.util.CsvFile.modifyUserPassword(cid, value);

%>

<script>location = "studentadmin.jsp"; </script>