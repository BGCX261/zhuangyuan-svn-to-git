<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="com.jspsmart.upload.*"%>

<%

String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
request.setCharacterEncoding("UTF-8");
String questionid = (String)request.getParameter("qqqqid");
String nowcourseid = (String)session.getAttribute("nowcourseid");
String submittype = (String)request.getParameter("submittype");
String qnodeid = (String)request.getParameter("qnodeid");
String qcontent = (String)request.getParameter("qcontent");
String qcontenttext = (String)request.getParameter("qcontenttext");
String subcount = (String)request.getParameter("subcount");
String qanswer = (String)request.getParameter("qanswer");
String qstructure = (String)request.getParameter("qstructure");
String qdifficulty = (String)request.getParameter("qdifficulty");
String issubjective = (String)request.getParameter("issubjective");


zy.util.CsvFile.addQuestion(nowcourseid,qnodeid,qcontent,qcontenttext,subcount,issubjective,qanswer,qstructure, qdifficulty,questionid,username);
if (submittype.equals("1")) {
  response.sendRedirect("addquestion.jsp?nodeid="+qnodeid+"&qstructure="+qstructure);
}
else {
  String allselectednodes = (String)session.getAttribute("allselect");
  /*if (allselectednodes != null && allselectednodes.length() > 0) {
    //response.sendRedirect("testquestions.jsp?allselectednodes="+allselectednodes);
  }
  else {
    response.sendRedirect("testquestions.jsp?qstructure="+qstructure);
  }*/
  response.sendRedirect("testquestions.jsp?allselectednodes=("+qnodeid+")");
}

%>
