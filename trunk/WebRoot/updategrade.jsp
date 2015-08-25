<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String value = request.getParameter("V");
zy.util.CsvFile.updateGrade(id, value);

%>

<script>location = "gradeadmin.jsp"; </script>