<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
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
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心>>新增/编辑试卷</title>

<script language="JavaScript" type="text/JavaScript">
</script>
</head>
<frameset id="frameset1" cols="420,*" frameborder="NO" border="0" framespacing="0" rows="*" onload="leftframe.doOnload();"/>
  <frame name="leftframe" src="addpaper_left.jsp<%=addrString%>" scrolling="NO" />
  <frame name="rightframe" src="addpaper_right.jsp<%=addrString%>"  scrolling="NO" />
</frameset>
<noframes>
<body >
</body>
</noframes>
</html>
