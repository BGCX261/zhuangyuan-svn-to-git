<%@page contentType="text/html;charset=UTF-8"%>

<%

String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
request.setCharacterEncoding("UTF-8");
String reportwhat = (String)request.getParameter("reportwhat");
String reporttype = (String)request.getParameter("reporttype");
String reportorcg = (String)request.getParameter("reportorcg");
String reportcg = (String)request.getParameter("reportcg");
String reporttitle = (String)request.getParameter("reporttitle");
if (reporttype.equals("xls")) {

  response.sendRedirect(zy.util.CsvFile.dealReport(reporttype,reportorcg,reportcg,reporttitle,reportwhat));
}
else {
  out.println(zy.util.CsvFile.dealReport(reporttype,reportorcg,reportcg,reporttitle,reportwhat));
}
%>
