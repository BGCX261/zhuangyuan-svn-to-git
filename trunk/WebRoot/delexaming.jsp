<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
String nowcourseid = (String)session.getAttribute("nowcourseid");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}

request.setCharacterEncoding("UTF-8");
String pid = request.getParameter("pid");
String uid = request.getParameter("uid");
zy.util.CsvFile.delExaming(nowcourseid, pid, uid);

%>

<script>location = "judgepaper.jsp?paperid=<%=pid%>"; </script>