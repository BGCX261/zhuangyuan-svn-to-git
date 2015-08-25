<%@page contentType="text/html;charset=UTF-8"%>
<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
String nowcourseid = (String)session.getAttribute("nowcourseid");
%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
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
</head>
<body leftmargin="20" rightmargin="0" >
<table align="center" height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
<tr ><td style="border:1 gray solid;padding-left:6;padding-right:6;padding-top:6;padding-bottom:6;" >
<%
    zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+".2");
    out.println(csv.allRecords[0][0]);

%>
</td></tr>
</table>
</body>
</html>

<script language="JavaScript" type="text/JavaScript">
<%
String ifShowCard = request.getParameter("showCard");
if (ifShowCard == null || ifShowCard.equals("NO")) { %>
   top.location=paperlocation;
<% } else { %>
   parent.leftframe.location=paperlocation;
<% } %>
</script>
