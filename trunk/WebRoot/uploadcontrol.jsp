<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="zy.util.*,java.io.File"%>
<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  	response.sendRedirect("error.html?message=2");
}
%>
<%
request.setCharacterEncoding("UTF-8");
FileUploadRequest request1 = new FileUploadRequest(request);
zy.util.CsvFile csvFile = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator + "files.csv");
csvFile.addARecordToFile(new String[]{request1.getParameter("rpath__filename"), request1.getParameter("rpath__ext"), request1.getParameter("rpath__size")+"字节", username, ""+System.currentTimeMillis(), request1.getParameter("rpath")});
response.sendRedirect("resourcelib.jsp");
%>

