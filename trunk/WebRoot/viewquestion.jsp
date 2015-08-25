<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}

String nowcourseid = (String)session.getAttribute("nowcourseid");
String questionid = request.getParameter("questionid");
int a1, a2;
a1 = questionid.indexOf('_');
a2 = questionid.indexOf('_', a1 + 1);
String qnodeid = questionid.substring(a1 + 1, a2);
String qcontent = "";
String qanswer = "";
String qdifficulty = "";
String qsubcount = "";
String issubjective = "";
String qstructure = "";
if (questionid != null) {
  zy.util.CsvFile csv1 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                 qnodeid + java.io.File.separator+""+questionid+".1");
  qcontent =  csv1.allRecords[0][0].substring(0, csv1.allRecords[0][0].indexOf("<yzq/>答"));

  csv1 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                 qnodeid + java.io.File.separator+""+questionid+".3");
  qanswer =  csv1.allRecords[0][0];
  zy.util.CsvFile csvq = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                 qnodeid + java.io.File.separator+"q.csv");
  for (int i = 0; i < csvq.allRecords.length; i++) {
    if (csvq.allRecords[i][0].equals(questionid)) {
      qstructure = csvq.allRecords[i][2];
      qdifficulty = csvq.allRecords[i][3];
      qsubcount = csvq.allRecords[i][6];
      issubjective = csvq.allRecords[i][7];
      break;
    }
  }
}
%>

<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心</title>
<style>
body{
  font-family:宋体;
  font-size:14px;
}
td{
  font-family:宋体;
  font-size:14px;
}
</style>

</head>
<body align=right leftmargin="50" topmargin="50">
<%=qcontent%>
</body>
</html>