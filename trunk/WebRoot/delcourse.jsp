<%@page contentType="text/html;charset=UTF-8"%>

<%

String cid = request.getParameter("CID");
zy.util.CsvFile.delCourse(cid);

%>

<script>location = "courseadmin.jsp"; </script>