<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String value = request.getParameter("V");
zy.util.CsvFile.addCourse(value);

%>

<script>location = "courseadmin.jsp"; </script>