<%@page contentType="text/html;charset=UTF-8"%>

<%

String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}

zy.util.CsvFile cf = (zy.util.CsvFile)zy.util.CsvFile.all.get("course_teacher");

String activecourseid = request.getParameter("activecourseid");
for (int i = 0; i < cf.allRecords.length; i++) {
  if (cf.allRecords[i][1].equals(username)) {
    if (activecourseid.equals(cf.allRecords[i][0])) {
      cf.allRecords[i][2] = "1";
    }
    else {
      cf.allRecords[i][2] = "0";
    }
  }
}

cf.toFile();

response.sendRedirect("teacherindex.jsp");

%>
