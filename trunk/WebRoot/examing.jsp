<%@page contentType="text/html;charset=UTF-8"%>
<%
session.setMaxInactiveInterval(4 * 60 * 60);

request.setCharacterEncoding("UTF-8");
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("2")) {
  response.sendRedirect("error.html?message=2");
}
String nowcourseid = request.getParameter("nowcourseid");
String issubjective = request.getParameter("issubjective");
String actionname = request.getParameter("actionname");
String answer = "";
String totalScore = null;
if (actionname != null) {
  answer = request.getParameter("answer");
  totalScore = zy.util.CsvFile.dealExaming(actionname,answer,nowcourseid,request.getParameter("paperid"),username,issubjective);
}
long serverTimeMilliSeconds = System.currentTimeMillis();
java.text.SimpleDateFormat sd = new java.text.SimpleDateFormat("yyyy年MM月dd日 hh点mm分");
String serverTimeString = sd.format(new java.util.Date());
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>学生中心>>答题</title>
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
.bt{
	border-top: 1px solid #000000;
	border-right: 1px solid #003333;
	border-bottom: 1px solid #6633CC;
	border-left: 1px solid #003333;
	text-align: center;
	font-size: 12px;
	height: 22px;
}
.cm {
  display:none;
}

</style>
<script src="files/login.js"></script>
<script language="JavaScript" type="text/JavaScript">
var serverTimeMilliSeconds = <%=serverTimeMilliSeconds%>;
var serverTimeString = "<%=serverTimeString%>";
var clientTimeMilliSeconds = new Date().getTime();
var TimeGap = 3;
if (clientServerTimeGap) {TimeGap = clientServerTimeGap;
}
if ((serverTimeMilliSeconds - clientTimeMilliSeconds) > (TimeGap * 60 * 1000) ||
    (clientTimeMilliSeconds - serverTimeMilliSeconds) > (TimeGap * 60 * 1000)) {
	alert("服务器端现在的时间是"+serverTimeString+"，你机器的时间与服务器端的时间相差超过三分钟，请调整你机器上的时间与服务器端的时间同步，否则你将无法进入做题！");
    window.close();
}

<% if (totalScore != null) {
%>
alert("你所有的客观题的得分是<%=totalScore%>分");
close();if (opener && !opener.closed) opener.location.reload();
<% } %>
</script>
</head>
<body leftmargin="0" >
<table align="center" height="100%" width="700" border="0" cellpadding="0" cellspacing="0">
<tr height="22">
  <td colspan="4" >&nbsp;<input type="button" class="bt" value="交卷(H)"  accesskey="H" onclick="handIn();"> <input type="button" class="bt" value="保存答案(S)"  accesskey="S" onclick="saveAnswer();"> 距离试卷关闭时间还有<span id="lefttime" style="color:red"/></span> </td>
</tr>
<tr height="5"><td><hr/></td></tr>
<tr ><td>
<%
    zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+".2");
    zy.util.CsvFile csv1 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper"+java.io.File.separator + request.getParameter("paperid")+"_"+username+".ans");
    answer = "";
    if (csv1.allRecords != null && csv1.allRecords.length > 0 && csv1.allRecords[0].length > 0) {
      answer = csv1.allRecords[0][0];
    }
    out.print(csv.allRecords[0][0]);
%>
</td></tr>
<tr height="5"><td><hr/></td></tr>
<tr height="22">
  <td colspan="4" >&nbsp;<input type="button" class="bt" value="交卷(H)"  accesskey="H" onclick="handIn();"> <input type="button" class="bt" value="保存答案(S)"  accesskey="S" onclick="saveAnswer();">   距离试卷关闭时间还有<span id="lefttime1" style="color:red"/></span> </td>
</tr>
</table>
<textarea id="tmpa" style="display:none"><%=answer%></textarea>
<form name="form1" method="post" action="">
  <input type="hidden" name="answer" value="">
  <input type="hidden" name="issubjective" value="">
  <input type="hidden" name="actionname" value="">
</form>
</body>
<script src="css/util.js"></script>
<script>
if (tmpa.value != '') {
  var allanswer = tmpa.value;
  var ind = 0;
  while (allanswer.indexOf('\u0002') >= 0) {
    setInputValue("s"+allquestions[ind],allanswer.substring(0,allanswer.indexOf('\u0002')));
    ind ++;
    allanswer = allanswer.substring(allanswer.indexOf('\u0002') + 1);
  }
}
var leaveMilliSeconds = paperclosetime.value*1 - (new Date().getTime());
setTimeout("checkTime();",1000);
function handIn() {
  for (var i = 0; i < allquestions.length - 1; i++) {
    document.form1.answer.value += getInputValue("s"+allquestions[i])+String.fromCharCode(2);
    document.form1.issubjective.value += getInputValue("a"+allquestions[i])+String.fromCharCode(2);
  }
  document.form1.actionname.value = 'handin';
  document.form1.submit();
}
function saveAnswer() {
  for (var i = 0; i < allquestions.length - 1; i++) {
    document.form1.answer.value += getInputValue("s"+allquestions[i])+String.fromCharCode(2);
  }
  document.form1.actionname.value = 'saveanswer';
  document.form1.submit();
}
function checkTime() {
  leaveMilliSeconds -= 1000;
  if (leaveMilliSeconds < 0) {
    alert("时间到了，系统将会执行自动交卷！");
    handIn();
    return;
  }
  lt = new Date(leaveMilliSeconds);
  var ds = "";
  if (Math.floor(lt/3600000) > 0) ds += Math.floor(lt/3600000)+"小时";
  lt = lt % 3600000;
  if (Math.floor(lt/60000) > 0) ds += Math.floor(lt/60000)+"分";
  lt = lt % 60000;
  ds += Math.floor(lt/1000)+"秒";
  lefttime.innerHTML = ds;
  lefttime1.innerHTML = ds;
  setTimeout("checkTime();",1000);
}
</script>
</html>
