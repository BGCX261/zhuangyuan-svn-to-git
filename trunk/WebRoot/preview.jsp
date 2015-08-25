<%@page contentType="text/html;charset=UTF-8"%>

<%

String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
request.setCharacterEncoding("UTF-8");
String nowcourseid = (String)session.getAttribute("nowcourseid");
String paperdata = (String)request.getParameter("paperdata");
String paperid = (String)request.getParameter("paperid");
String[] ca = zy.util.CsvFile.getPaperContentAndAnswer(nowcourseid,paperdata);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心>>新增试卷</title>
<style>
body {
  font-family: 宋体;
  font-size:14px;
}
p {
  font-family: 宋体;
  font-size:14px;
}
td {
  font-family: 宋体;
  font-size:14px;
}
.papertitle {
  font-family: 黑体;
  font-size:28px;
  font-decoration:bold;
}
.papertitle1 {
  font-family: 宋体;
  font-size:12px;
  font-decoration:bold;
}
.mttitle {
  font-family: 黑体;
  font-size:16px;
  font-decoration:bold;
}
</style>
<script language="JavaScript" type="text/JavaScript">
</script>
</head>
<body leftmargin="0" >
<table align="center" height="100%" width="700" border="0" cellpadding="0" cellspacing="0">
<tr ><td>
<%
    out.println(ca[0]);
%>
</td></tr>
</table>
</body>
</html>
