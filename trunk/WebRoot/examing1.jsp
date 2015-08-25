<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("2")) {
  response.sendRedirect("error.html?message=2");
}

String paperid = request.getParameter("paperid");
String addrString = "";
if (paperid != null && paperid.length() != 0) {
  addrString = "?paperid="+paperid;
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>学生中心>>答题</title>
<script language="JavaScript" type="text/JavaScript">
</script>
</head>
<script>
if (screen.availHeight > 600) {
    document.write('<frameset id="frameset1" cols="600,*" frameborder="YES" rows="*" />');
}
else {
    document.write('<frameset id="frameset1" rows="250,*" frameborder="YES" cols="*" />');
}
</script>

  <frame name="leftframe" src="about:blank" scrolling="auto" />
  <frame name="rightframe" src="examing1_right.jsp<%=addrString%>&nowcourseid=<%=request.getParameter("nowcourseid")%>"  scrolling="auto" />
</frameset>
<noframes>
<body >
</body>
</noframes>
</html>
