<%
request.getSession().setAttribute("aa","Hello");
request.setAttribute("bb","Hello");
pageContext.setAttribute("cc","Hello");
application.setAttribute("dd","Hello");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="Pragma" content="no-cache"/>
</head>
<body>
<a href="t2.jsp" >mm</a>
<a href="t1.jsp" >me</a>
<%=request.getSession().getId()%>
<%=request.getContextPath()%>
<%=request.getPathInfo()%>
<%=request.getPathTranslated()%>
<%=request.getServletPath()%>
<%=(""+request.getSession().getMaxInactiveInterval())%>

<!--<form method="POST" action="t2.jsp">
<input type="submit">
</form>-->
</body>
</html>