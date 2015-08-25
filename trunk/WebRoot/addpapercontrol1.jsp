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
String paperlocation = (String)request.getParameter("paperlocation");
zy.util.CsvFile.addPaper1(nowcourseid,paperdata,username,paperid, paperlocation);

%>
<script>parent.location = "testpapers.jsp";</script>
