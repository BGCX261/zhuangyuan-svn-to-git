<%@page contentType="text/html;charset=UTF-8"%>

<%

String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
request.setCharacterEncoding("UTF-8");
String questionid = (String)request.getParameter("delwhat");
while (questionid.length() > 0) {
  zy.util.CsvFile.delQuestion(questionid.substring(0, questionid.indexOf(zy.util.CsvFile.SAPERATE_CHAR)));
  questionid = questionid.substring(questionid.indexOf(zy.util.CsvFile.SAPERATE_CHAR) + 1);
}
String allselectednodes = (String)session.getAttribute("allselect");
if (allselectednodes != null && allselectednodes.length() > 0) {
  response.sendRedirect("testquestions.jsp?allselectednodes="+allselectednodes);
}
else {
  response.sendRedirect("testquestions.jsp?");
}

%>
