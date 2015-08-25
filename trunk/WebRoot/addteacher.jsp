<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String username = request.getParameter("username");
String passwd = request.getParameter("passwd");
String realname = request.getParameter("realname");
int rst = zy.util.CsvFile.addUser(username,passwd,realname,"1", "");
if (rst == 0) session.setAttribute("error","添加教师失败，用户名已经存在！");

%>

<script>location = "teacheradmin.jsp"; </script>