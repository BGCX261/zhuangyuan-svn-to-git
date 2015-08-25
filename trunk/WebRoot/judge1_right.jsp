<%@page contentType="text/html;charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
String nowcourseid = (String)session.getAttribute("nowcourseid");

String answer = "";
String scores = "";
String rightanswer = "";
String totalScore = null;

String newscores = request.getParameter("newscores");
String newtotalscore = request.getParameter("newtotalscore");
if (newscores != null) {
  totalScore = zy.util.CsvFile.dealJudge(nowcourseid,request.getParameter("paperid"),request.getParameter("username"),username,newscores,newtotalscore);
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心>>阅卷</title>
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
<% if (newscores != null) {
%>
alert("试卷经过判卷后最后得分是<%=totalScore%>分");
parent.close();if (parent.opener && !parent.opener.closed) parent.opener.location.reload();
<% } %>
</script>
</head>
<body leftmargin="20" rightmargin="0" >
<table align="center" height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
<tr ><td style="border:1 gray solid;padding-left:6;padding-right:6;padding-top:6;padding-bottom:6;">
<%
    zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+".2");
    zy.util.CsvFile csv2 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+".3");
    zy.util.CsvFile csv1 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+"_"+request.getParameter("username")+".ans");
    zy.util.CsvFile csv4 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+"_"+request.getParameter("username")+".score");
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
    zy.util.CsvFile ss = zy.util.CsvFile.getACsvFile("judgeset");
    String sssss = "0";
    if (ss != null && ss.allRecords != null && ss.allRecords.length > 0 && ss.allRecords[0].length > 0) {
        sssss = ss.allRecords[0][0];
    }
%>
</td></tr>
<tr height="5"><td><hr/></td></tr>
<tr height="22">
  <td colspan="4" >&nbsp;<input type="button" class="bt" value="提交并关闭(H)"  accesskey="H" onclick="judgeEnd();"> <input type="button" class="bt" value="关闭(X)"  accesskey="C" onclick="parent.close();"></td>
</tr>
</table>
<textarea id="tmpa" style="display:none"><%=answer%></textarea>
<textarea id="tmpb" style="display:none"><%=rightanswer%></textarea>
<textarea id="tmpc" style="display:none"><%=scores%></textarea>
<form name="form1" method="post" action="">
  <input type="hidden" name="newscores" value="">
  <input type="hidden" name="newtotalscore" value="">
</form>
</body>
<script src="css/util.js"></script>
<script>
var canModifyScore = (<%=sssss%> == 1);
if (tmpa.value != '') {
  var allanswer = tmpa.value;
  var ind = 0;
  while (allanswer.indexOf('\u0002') >= 0) {
    eval("s"+allquestions[ind]).value=allanswer.substring(0,allanswer.indexOf('\u0002'));
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
  var max = "";
  while (allanswer1.indexOf('\u0002') >= 0) {
    var aa = document.getElementById("r"+allquestions[ind]);
    qra = allanswer1.substring(0,allanswer1.indexOf('\u0002'));
    score = allanswer2.substring(0,allanswer2.indexOf('\u0002'));
    if (Math.abs((score * 1) - Math.round(score * 1)) < 0.001) {
      score = Math.round(score * 1);
    }
    max = qra.substring(0,qra.indexOf(','));
    qra = qra.substring(qra.indexOf(',')+1);
    if (aa.type == "N") {
      if (!canModifyScore) {
        aa.innerHTML = "<br/>本题得分<input max=\""+max+"\" name=\"j"+allquestions[ind]+"\" type=\"text\" size=\"3\" maxlength=\"4\" disabled value=\""+score+"\">分，标准答案："+qra;
      }
      else {
        aa.innerHTML = "<br/>本题得分<input max=\""+max+"\" name=\"j"+allquestions[ind]+"\" type=\"text\" size=\"3\" maxlength=\"4\" value=\""+score+"\">分，标准答案："+qra;
      }
    }
    else {
      aa.innerHTML = "<br/>本题得分<input max=\""+max+"\"  name=\"j"+allquestions[ind]+"\"  type=\"text\" size=\"3\" maxlength=\"4\" value=\""+score+"\">分，参考答案："+encode(qra);
    }
    aa.className = "answer";
    ind ++;
    allanswer1 = allanswer1.substring(allanswer1.indexOf('\u0002') + 1);
    allanswer2 = allanswer2.substring(allanswer2.indexOf('\u0002') + 1);
  }
}

function judgeEnd() {
  var ts = 0;
  for (var i = 0; i < allquestions.length - 1; i++) {
    var dd = eval("j"+allquestions[i])
    if (!dd.value.isFloat() && !dd.value.isInt()) {
      alert("输入的小题最终得分必须是数字！");
      return;
    }
    if ((dd.value*1) > (dd.max * 1)) {
      alert("输入的小题最终得分不能大于小题满分！");
      return;
    }
    document.form1.newscores.value += dd.value+String.fromCharCode(2);
    ts += (dd.value * 1);
  }
  document.form1.newtotalscore.value = ts;
  document.form1.submit();
}

if (top.leftframe.location.toString().indexOf("about:blank") >= 0)
  top.leftframe.location = paperlocation;
</script>
</html>
