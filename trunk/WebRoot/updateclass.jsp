<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String value = request.getParameter("V");
String grade = request.getParameter("grade");
zy.util.CsvFile.updateClass(id, value, grade);

%>

<script>location = "classadmin.jsp"; </script>