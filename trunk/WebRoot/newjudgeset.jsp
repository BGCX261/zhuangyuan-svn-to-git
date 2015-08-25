<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String newjudgeset = request.getParameter("judgeset");
zy.util.CsvFile.newJudgeset(newjudgeset);

%>

<script>location = "adminindex.jsp"; </script>