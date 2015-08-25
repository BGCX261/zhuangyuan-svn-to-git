<%@page contentType="text/html;charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null) {
  response.sendRedirect("error.html?message=2");
}
String nowcourseid = request.getParameter("nowcourseid");
String answer = "";
String scores = "";
String rightanswer = "";
String totalScore = null;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>学生中心>>对照答案</title>
<style>
body {
  font-family: 宋体;
  font-size:14px;
}
p {
  font-family: 宋体;
  font-size:14px;
}
td {
  font-family: 宋体;
  font-size:14px;
}
.papertitle {
  font-family: 黑体;
  font-size:28px;
  font-decoration:bold;
}
.papertitle1 {
  font-family: 宋体;
  font-size:12px;
  font-decoration:bold;
}
.mttitle {
  font-family: 黑体;
  font-size:16px;
  font-decoration:bold;
}
.answer {
  font-family: 宋体;
  font-size:14px;
  color:red;
}
.bt{
	border-top: 1px solid #000000;
	border-right: 1px solid #003333;
	border-bottom: 1px solid #6633CC;
	border-left: 1px solid #003333;
	text-align: center;
	font-size: 12px;
	height: 22px;
}

</style>
<script language="JavaScript" type="text/JavaScript">
</script>
</head>
<body leftmargin="0" >
<table align="center" height="100%" width="700" border="0" cellpadding="0" cellspacing="0">
<tr ><td>
<%
    zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+".2");
    zy.util.CsvFile csv2 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+".3");
    zy.util.CsvFile csv1 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+"_"+username+".ans");
    zy.util.CsvFile csv4 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+"_"+username+".score");
    answer = "";
    if (csv1.allRecords != null && csv1.allRecords.length > 0 && csv1.allRecords[0].length > 0) {
      answer = csv1.allRecords[0][0];
    }
    if (csv4.allRecords != null && csv4.allRecords.length > 0 && csv4.allRecords[0].length > 0) {
      scores = csv4.allRecords[0][0];
    }
    if (csv2.allRecords != null && csv2.allRecords.length > 0 && csv2.allRecords[0].length > 0) {
      for (int j = 0; j < csv2.allRecords[0].length - 1; j++) {
        rightanswer += csv2.allRecords[0][j] + "\u0002";
      }
    }
    out.print(csv.allRecords[0][0]);

	String sss = "" + System.currentTimeMillis();
    zy.util.CsvFile ss = zy.util.CsvFile.getACsvFile("compareset");
    String ssss = "0";
    if (ss != null && ss.allRecords != null && ss.allRecords.length > 0 && ss.allRecords[0].length > 0) {
        ssss = ss.allRecords[0][0];
    }

%>
</td></tr>
</table>
<textarea id="tmpa" style="display:none"><%=answer%></textarea>
<textarea id="tmpb" style="display:none"><%=rightanswer%></textarea>
<textarea id="tmpc" style="display:none"><%=scores%></textarea>
</body>
<script src="css/util.js"></script>

<script>
var theEndTime  = document.getElementById('paperclosetime').value * 1;
var theStartTime = document.getElementById('paperopentime').value * 1;
var needcompare = <%=ssss%> != 0;
if ((theEndTime - theStartTime) > (24 * 60 * 60 * 1000)) {
    needcompare = false;
}
if (needcompare) {
  if (<%=sss%> < theEndTime) {
    alert("还没有到达试卷结束时间，请等到试卷结束时间到底以后才进行对照答案！");window.close();
  }
  else {
  }
}

if (tmpa.value != '') {
  var allanswer = tmpa.value;
  var ind = 0;
  while (allanswer.indexOf('\u0002') >= 0) {
    setInputValue("s"+allquestions[ind],allanswer.substring(0,allanswer.indexOf('\u0002')));
    ind ++;
    allanswer = allanswer.substring(allanswer.indexOf('\u0002') + 1);
  }
}
if (tmpb.value != '') {
  var allanswer1 = tmpb.value;
  var allanswer2 = tmpc.value;
  var ind = 0;
  var qra = ""
  var score = "";
  while (allanswer1.indexOf('\u0002') >= 0) {
    var aa = document.getElementById("r"+allquestions[ind]);
    qra = allanswer1.substring(0,allanswer1.indexOf('\u0002'));
    score = allanswer2.substring(0,allanswer2.indexOf('\u0002'));
    if (Math.abs((score * 1) - Math.round(score * 1)) < 0.001) {
      score = Math.round(score * 1);
    }
    qra = qra.substring(qra.indexOf(',')+1);
    if (aa.type == "1" || aa.type == "2") {
      aa.innerHTML = "<br/>本题得分"+score+"分，标准答案："+qra;
    }
    else if (aa.type == "3") {
      if (getInputValue("a"+allquestions[ind]) == "N") {
        aa.innerHTML = "<br/>本题得分"+score+"分，标准答案：";
      }
      else {
        aa.innerHTML = "<br/>本题得分"+score+"分，参考答案：";
      }
      var dd = 0;
      while (qra.indexOf(SAPERATE_CHAR) >= 0) {
        aa.innerHTML += "<br/>"+(++dd)+"、"+encode(qra.substring(0, qra.indexOf(SAPERATE_CHAR)));
        qra = qra.substring(qra.indexOf(SAPERATE_CHAR)+1);
      }
    }
    else if (aa.type == "4") {
      aa.innerHTML = "<br/>本题得分"+score+"分，标准答案：";
      var dd = 0;
      while (qra.indexOf(SAPERATE_CHAR) >= 0) {
        aa.innerHTML += String.fromCharCode(65+(dd++)) + "-"+qra.substring(0, qra.indexOf(SAPERATE_CHAR)) +"; ";
        qra = qra.substring(qra.indexOf(SAPERATE_CHAR)+1);
      }
    }
    else if (aa.type == "5") {
      aa.innerHTML = "<br/>本题得分"+score+"分，标准答案："+(qra == "Y" ? "正确" : "错误");
    }
    else if (aa.type == "6") {
      aa.innerHTML = "<br/>本题得分"+score+"分，参考答案："+encode(qra);
    }
    aa.className = "answer";
    ind ++;
    allanswer1 = allanswer1.substring(allanswer1.indexOf('\u0002') + 1);
    allanswer2 = allanswer2.substring(allanswer2.indexOf('\u0002') + 1);
  }
}
</script>
</html>
