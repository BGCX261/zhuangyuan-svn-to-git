<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String newsessionstrategy = request.getParameter("newsessionstrategy");
zy.util.CsvFile.newSessionStrategy(newsessionstrategy);

%>

<script>location = "adminindex.jsp"; </script>