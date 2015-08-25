<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
request.setCharacterEncoding("UTF-8");
String nowcourseid = (String)session.getAttribute("nowcourseid");
String paperid = request.getParameter("paperid");
String stuclass = request.getParameter("stuclass");if (stuclass == null) stuclass = "";
String stuname = request.getParameter("stuname");if (stuname == null) stuname = "";
String havejudged = request.getParameter("havejudged");if (havejudged == null) havejudged = "";
zy.util.CsvFile csv_paper = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper" + java.io.File.separator+"q.csv");
String[] paperdata = new String[6];
for (int i  = 0; i < csv_paper.allRecords.length; i++) {
  if (csv_paper.allRecords[i][0].equals(paperid)) {
    paperdata = csv_paper.allRecords[i];
  }
}
int allCount = 0;
%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
<style>
  .rhinput { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; font-family:宋体;font-size:12px;}
  .cp { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; }
</style>
<title>状元考试系统1.0版>>教师中心>>阅卷</title>

<script src="css/util.js"></script>
<script src="css/css.js"></script>
<script>
function doJudge(pid, uid) {
        if (<%=paperdata[11]%> == 1)
	open("judge.jsp?paperid="+pid+"&username="+uid);
        else
	open("judge1.jsp?paperid="+pid+"&username="+uid);
}
function doDel(pid, uid) {
	location = "delexaming.jsp?pid="+pid+"&uid="+uid;
}

function doQuery() {
  stuclass.value = stuclass.value.replace(/(^[\s,\t]*)|([\s,\t]*$)/g, "")
  stuname.value = stuname.value.replace(/(^[\s,\t]*)|([\s,\t]*$)/g, "")
  var tmp = "";
  if (stuclass.value != "") tmp += "&stuclass="+httpAddrEncode(stuclass.value);
  if (stuname.value != "") tmp += "&stuname="+httpAddrEncode(stuname.value);
  if (havejudged.checked) tmp += "&havejudged=Y";
  location = "judgepaper.jsp?paperid=<%=paperid%>"+tmp;
}
</script>
</head>
<body align=right leftmargin=10 topmargin=0>
<table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0">
  <tr height="5"><td></td></tr>
  <tr height="30">
    <td>
      <table height="30" width="100%"  border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td class="pagetitleleft" width="340"><marquee>状元考试系统1.0版</marquee></td>
	      <td class="pagetitleleft" >&nbsp;</td>
	      <td class="pagetitleright" width="360"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr height=15><td class="pagetitleright" colspan=25 align=right valign=bottom>当前位置 教师中心>>阅卷&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:location='logoutcontrol.jsp';void 0;" class="tlink" accessKey='O'>&nbsp;退出登录&nbsp;</a>|<a  href='1/zyhelp.htm' class="tlink" accessKey='E' target="help">&nbsp;帮助&nbsp;</a> </td></tr>
			<tr height=5><td></td></tr>
		    <script>createAPicture();</script>
		  </table> </td>
	    </tr>
      </table>
	</td>
  </tr>
  <tr height=15><td></td></tr>
  <tr>
    <td>
      <table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0" >
	    <tr>
		<td><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" >
				  <tr  height="17" >
				    <td class="contentwindowtitle" width="10">&nbsp;</td>
			        <td id="detailtitle" colspan="2" class="contentwindowtitle">以下是已经完成<%=paperdata[1]%>的所有学生</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					    <tr height="5">
						  <td class="content"><hr/></td>
						</tr>
					<tr height="22">
					  <td class="content" >&nbsp;部门：<input type="text"  class="rhinput" id="stuclass" name="stuclass" maxlength="30">
                                            &nbsp;姓名：<input type="text"  class="rhinput" id="stuname" name="stuname" maxlength="30">
                                            &nbsp;<input type="checkbox"  id="havejudged" name="havejudged" >只显示待阅卷学生 &nbsp;<input type="button" class="bt" value="查询" onclick="doQuery();"/>
                                          </td>
                                        <script>stuclass.value = "<%=stuclass%>";stuname.value = "<%=stuname%>";if ("<%=havejudged%>" == "Y") havejudged.checked = true;</script>
					</tr>
						<tr height="18">
						  <td colspan="5" >
						    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
								<tr height="18" class="trow">
								  <!--<td  width="280">&nbsp;试卷名称</td>-->
								  <td  width="100">用户名</td>
								  <td  width="120">姓名</td>
								  <td  width="120">部门</td>

								  <td  width="70">得分</td>
                                                                  <td  width="70">总分</td>
								  <td  width="150">交卷时间</td>
								  <td  width="150">关闭时间</td>
                                                                  <td  >操作</td>
								</tr>
							  </table>
						  </td>
					    </tr>
						<tr >
						  <td><div class="contentdiv">
						    <table id="datatable" height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<%
    zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper" + java.io.File.separator+""+paperid+".csv");
    zy.util.CsvFile csv_user = (zy.util.CsvFile) zy.util.CsvFile.all.get("user");
    String cls = "orow";
    String typeStr;
    String realname = "";
    String classname = "";
    String myscore = "";
    for (int i = 0; i < csv.allRecords.length; i++) {
      if (allCount % 2 == 0) cls = "orow";
      else cls = "erow";
      realname = "";
      for (int j  = 0; j < csv_user.allRecords.length; j++) {
        if (csv_user.allRecords[j][0].equals(csv.allRecords[i][0])) {
          realname = csv_user.allRecords[j][2];
          classname = csv_user.allRecords[j][5];
        }
      }
      if (stuclass.length() != 0) {
        if (classname.indexOf(stuclass) < 0) continue;
      }
      if (stuname.length() != 0) {
        if (realname.indexOf(stuname) < 0) continue;
      }
      myscore = zy.util.CsvFile.getMyScore(nowcourseid,paperdata[0],csv.allRecords[i][0]);
      if (havejudged.length() != 0) {
        if (myscore.indexOf("待阅卷") < 0) continue;
      }
%>
								<tr  name="datarow" height="22" class="<%=cls%>">
                                                                  <!--<td  width="280">&nbsp;<%=paperdata[1]%></td>-->
								  <td width="100"><%=csv.allRecords[i][0]%></td>
								  <td  width="120"><%=realname%></td>
                                                                  <td  width="120"><%=classname%></td>

								  <td  width="70"><%=myscore%></td>
                                                                  <td  width="70"><%=paperdata[2]%>分</td>
								  <td  width="150"><script>document.write(getDateTimeString(<%=csv.allRecords[i][1]%>));</script></td>
								  <td  width="150"><script>document.write(getDateTimeString(<%=paperdata[4]%>));</script></td>
                                                                  <% if (csv.allRecords[i][3].equals("0")) { %>
                                                                  <td  ><input type="button" class="bt" value="进入阅卷" onclick="doJudge('<%=paperdata[0]%>','<%=csv.allRecords[i][0]%>');">
									<input type="button" class="bt" value="删除做题记录" onclick="doDel('<%=paperdata[0]%>','<%=csv.allRecords[i][0]%>');">
                                                                  </td>
                                                                  <% } else { %>
                                                                  <td  ><input type="button" class="bt" value="进入阅卷" onclick="doJudge('<%=paperdata[0]%>','<%=csv.allRecords[i][0]%>');"> <input type="button" class="bt" value="删除做题记录" onclick="doDel('<%=paperdata[0]%>','<%=csv.allRecords[i][0]%>');"></td>
                                                                  <% } %>
								</tr>
<%    allCount++;
    }
%>
								<tr >
								  <td  colspan="7" class="content" ></td>
								</tr>
							  </table></div>
							</td>
					    </tr>
					    <tr height="5">
						  <td class="content" ><hr/></td>
						</tr>
						<tr height="22" >
						  <td align="center"><input type="button" class="bt"  accesskey="X" value="返回试卷管理页面(X)" onclick="location='testpapers.jsp';"></td>
						</tr>
					  </table>
					</td>
					<td width="10">&nbsp;</td>
				  </tr>
				</table>
		      </td>
		    </tr>
		    <tr height=10><td></td></tr>
		  </table></td>
	  </tr>
    </table>
  </td>
  </tr>
  <tr height="10">
    <td align="center" class="copyright" bgcolor=#101045> <a href="about.jsp" target="about">关于我们</a> <a href="copyright.jsp"  target="copyright">版权申明</a> <a href="noguilty.jsp"  target="noguilty">免责声明</a></td>
  </tr>
</table>

</body>
<script>
for (var i = 0; i < (datatable.rows.length - 1); i++) {
  datatable.rows[i].title="第"+(i+1)+"条记录，共"+(datatable.rows.length - 1)+"条记录";
}
</script>
</html>