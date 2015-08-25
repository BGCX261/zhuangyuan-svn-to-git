<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String gid = request.getParameter("GID");
zy.util.CsvFile.delGrade(gid);

%>

<script>location = "gradeadmin.jsp"; </script>