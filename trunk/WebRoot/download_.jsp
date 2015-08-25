<%@ page import="java.io.*"%><%
String realPath = application.getRealPath(request.getParameter("realPath"));
realPath = realPath.replace('/',File.separatorChar);
System.out.println(realPath);
File f = new File(realPath);
response.setHeader("Content-Type",   "application/force-download;");
response.setHeader("Content-disposition","attachment;filename="   +   f.getName()   +   "");
java.io.InputStream in = new java.io.FileInputStream (f);
int len = in.available();
byte[] bb = new byte[len];
in.read(bb);
in.close();
response.getOutputStream().write(bb);
response.getOutputStream().flush();

%>