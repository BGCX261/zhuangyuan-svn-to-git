<%@page contentType="text/html;charset=UTF-8"%>

<%

String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
request.setCharacterEncoding("UTF-8");
String paperid = (String)request.getParameter("delwhat");
while (paperid.length() > 0) {
  zy.util.CsvFile.delPaper(paperid.substring(0, paperid.indexOf(zy.util.CsvFile.SAPERATE_CHAR)));
  paperid = paperid.substring(paperid.indexOf(zy.util.CsvFile.SAPERATE_CHAR) + 1);
}
response.sendRedirect("testpapers.jsp");

%>
