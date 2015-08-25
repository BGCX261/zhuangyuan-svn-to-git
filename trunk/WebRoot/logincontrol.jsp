<%@page contentType="text/html;charset=UTF-8"%>

<%

zy.util.CsvFile cf = (zy.util.CsvFile)zy.util.CsvFile.all.get("user");
String username = request.getParameter("username");
String password = request.getParameter("passwd");
if (password == null) password = "";
boolean userExists = false;
for (int i = 0; i < cf.allRecords.length; i++) {
  if (username.equals(cf.allRecords[i][0])) {
    userExists = true;
    if (password.equals(cf.allRecords[i][1])) {
	  int result = zy.util.YzqSessionListener.whenUserLogin(session, username);
	  
	  if (result == 1) {
          session.setAttribute("username", cf.allRecords[i][0]);
          session.setAttribute("password", cf.allRecords[i][1]);
          session.setAttribute("realname", cf.allRecords[i][2]);
          session.setAttribute("email", cf.allRecords[i][3]);
          session.setAttribute("usertype", cf.allRecords[i][4]);
          //session.setMaxInactiveInterval(300 * 60);

          if (cf.allRecords[i][4].equals("1")) {
            response.sendRedirect("teacherindex.jsp");
          }
          else {
            response.sendRedirect("student.jsp");
          }
	  }
      else {
        response.sendRedirect("error.html?message=3");
      }
    }

    else {
      response.sendRedirect("error.html?message=0");
    }
    break;
  }
}

if (!userExists) {
  response.sendRedirect("error.html?message=1");
}


%>
