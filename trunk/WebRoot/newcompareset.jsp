<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String newcompareset = request.getParameter("compareset");
zy.util.CsvFile.newCompareset(newcompareset);

%>

<script>location = "adminindex.jsp"; </script>