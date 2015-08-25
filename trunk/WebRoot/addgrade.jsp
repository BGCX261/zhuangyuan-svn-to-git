<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");

String value = request.getParameter("V");
zy.util.CsvFile.addGrade(value);

%>

<script>location = "gradeadmin.jsp"; </script>