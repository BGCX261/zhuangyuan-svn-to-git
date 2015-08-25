<%@page contentType="text/html;charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
String nowcourseid = (String)session.getAttribute("nowcourseid");
zy.util.CsvFile.updateST(nowcourseid, request.getParameter("cs1"), request.getParameter("ss"));
response.sendRedirect("structure.jsp");
%>
