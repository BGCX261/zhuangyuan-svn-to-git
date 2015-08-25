<%@page contentType="text/html;charset=UTF-8"%>

<%

String password = request.getParameter("P");
zy.util.CsvFile admin = zy.util.CsvFile.getACsvFile("admin");
String adminPassword = "testadmin";
if (admin != null && admin.allRecords != null && admin.allRecords.length > 0 && admin.allRecords[0].length > 0) {
    adminPassword = admin.allRecords[0][0];
}
if (password == null) password = "";
if (password.equals(adminPassword)) {
  session.setAttribute("username", "admin");
  session.setAttribute("password", password);
  session.setAttribute("realname", "管理员");
  session.setAttribute("email", "");
  session.setAttribute("usertype", "3");

%>

  <script>location = "adminindex.jsp"; </script>
<%
}
else {
%>

  <script>location = "error.html?message=1"; </script>
<%
}


%>
