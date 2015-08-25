<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String cid = request.getParameter("CID");
zy.util.CsvFile.delUser(cid);

%>

<script>location = "teacheradmin.jsp"; </script>