<%@page contentType="text/html;charset=UTF-8"%>
<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
String nowcourseid = (String)session.getAttribute("nowcourseid");

String ifShowCard = request.getParameter("showCard");
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
.cm {
  display:none;
}
</style>
<script language="JavaScript" type="text/JavaScript">
</script>
</head>
<body leftmargin="0" >
<table align="center" height="100%" width="650" border="0" cellpadding="0" cellspacing="0">
<tr ><td>
<%
    zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+".2");
    String tmp = csv.allRecords[0][0];
    if (ifShowCard == null || ifShowCard.equals("NO")) {
        int idx1 = 0, idx2 = 0;
        while ((idx1 = tmp.indexOf("<yzq/>")) > 0 && (idx2 = tmp.indexOf("></span>")) > 0) {
            tmp = tmp.subSequence(0, idx1) + tmp.substring(idx2 + 8);
        }
    }
	out.println(tmp);

  %>
</td></tr>
</table>
</body>
</html>
