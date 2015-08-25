<%@page contentType="text/html;charset=UTF-8"%>

<%

request.setCharacterEncoding("UTF-8");
String username = request.getParameter("username");
String passwd = request.getParameter("passwd");
String realname = request.getParameter("realname");
String stuclass = request.getParameter("stuclass");
int rst = zy.util.CsvFile.addUser(username,passwd,realname,"2", stuclass);
if (rst == 0) session.setAttribute("error","添加学生失败，用户名已经存在！");

%>

<script>location = "studentadmin.jsp"; </script>