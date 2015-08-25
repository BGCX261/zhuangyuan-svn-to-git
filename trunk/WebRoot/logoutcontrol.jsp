<%@page contentType="text/html;charset=UTF-8"%>

<%

session.removeAttribute("username");
session.removeAttribute("password");
session.removeAttribute("realname");
session.removeAttribute("email");
session.removeAttribute("usertype");
response.sendRedirect("login.jsp");

%>
