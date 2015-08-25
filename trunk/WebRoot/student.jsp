<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("2")) {
  response.sendRedirect("error.html?message=2");
}
request.setCharacterEncoding("UTF-8");
String thecourse = request.getParameter("thecourse");
String thestatus = request.getParameter("thestatus");
if (thestatus == null) thestatus = "0";
String theopt = request.getParameter("theopt");
if (theopt == null) theopt = "0";
String[][] allSelectCourse = zy.util.CsvFile.getAllSelectCourse(username);

String allSelectCourseOption = "";
for (int i = 0; i < allSelectCourse.length; i++) {
  if (thecourse != null && allSelectCourse[i][0].equals(thecourse)) {
    allSelectCourseOption += "<option value=\""+allSelectCourse[i][0]+"\" selected>"+allSelectCourse[i][1]+"</option>";
  }
  else {
    allSelectCourseOption += "<option value=\""+allSelectCourse[i][0]+"\">"+allSelectCourse[i][1]+"</option>";
  }
}

int allCount = 0;

zy.util.CsvFile ss = zy.util.CsvFile.getACsvFile("compareset");
String ssss = "0";
if (ss != null && ss.allRecords != null && ss.allRecords.length > 0 && ss.allRecords[0].length > 0) {
    ssss = ss.allRecords[0][0];
}

String sss = "" + System.currentTimeMillis();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<style>
  .rhinput { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; font-family:宋体;font-size:12px;}
  .cp { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; }
</style>
<title>状元考试系统1.0版>>学生中心</title>

<script src="css/util.js"></script>
<script src="css/css.js"></script>
<script>
var allpapersID = new Array();
var allpapersST = new Array();
var showPaperLeaveTimes = new Array(-1,0,60000,300000,600000,1800000);

function selectUnselectAll(theCheckBox) {
  var gg = document.getElementsByName('hhc');
  for (var j = 0; j < gg.length; j++)gg[j].checked=theCheckBox.checked;
}

function doQuery() {
  location = "student.jsp?&thecourse="+thecourse.value+"&thestatus="+thestatus.value+"&theopt="+theopt.value;
}

function doExam(qid, cid, opentime,type) {
  if (new Date().getTime() < opentime) {
    alert("试卷到开放时间还没有到，不能进入试卷答题！");
    return;
  }
  if (type == 1)
  open("examing.jsp?paperid="+qid+"&nowcourseid="+cid,'examing');
  else
  open("examing1.jsp?paperid="+qid+"&nowcourseid="+cid,'examing');
}

var nowtime = <%=sss%>;
function dddd() {
    nowtime+=1000;setTimeout("dddd();",1000);
    var tmp1 = new Date(nowtime);
	document.getElementById("myssss").innerHTML = tmp1.getYear()+"-"+(tmp1.getMonth() + 1)+"-"+tmp1.getDate()+" "+tmp1.getHours()+":"+tmp1.getMinutes()+":"+tmp1.getSeconds();
    reshowPaper();
}

function reshowPaper() {
    var tmp2 = <%=theopt%>;
    if (tmp2 > 0) {
        for (var i = 0; i < allpapersID.length; i++) {
    		if ((nowtime + showPaperLeaveTimes[tmp2]) < allpapersST[i]) {
                document.getElementById("tr_"+allpapersID[i]).style.display = "none";
    		}
            else {
                document.getElementById("tr_"+allpapersID[i]).style.display = "";
            }
        }
    }
}

setTimeout("dddd();",1000);
function doCompare(qid, cid, type, starttime, endtime) {
  var needcompare = <%=ssss%> != 0;
  if ((endtime - starttime) > (24 * 60 * 60 * 1000)) {
    needcompare = false;
  }
  if (needcompare) {
    if (nowtime < endtime) {
        alert("还没有到达试卷结束时间，请等到试卷结束时间到底以后才进行对照答案！");
    }
    else {
      if (type == 1)
          open("compare.jsp?paperid="+qid+"&nowcourseid="+cid,'examing');
      else
          open("compare1.jsp?paperid="+qid+"&nowcourseid="+cid,'examing');
    }
  }
  else {
      if (type == 1)
          open("compare.jsp?paperid="+qid+"&nowcourseid="+cid,'examing');
      else
          open("compare1.jsp?paperid="+qid+"&nowcourseid="+cid,'examing');
  }
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
		    <tr height=15><td class="pagetitleright" colspan=25 align=right valign=bottom>当前位置 学生中心&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:location='logoutcontrol.jsp';void 0;" class="tlink" accessKey='O'>&nbsp;退出登录&nbsp;</a>|<a  href='1/zyhelp.htm' class="tlink" accessKey='E' target="help">&nbsp;帮助&nbsp;</a> </td></tr>
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
	      <td width="180"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr  height=200>
			  <td class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				    <tr  height="17" >
			          <td width="100%" class="contentwindowtitle">&nbsp;欢迎<%=session.getAttribute("realname")%>同学</td>
			        </tr >
					<tr height="5">
					  <td class="content" align="left" valign="center"></td>
					</tr>
					<tr height="5">
					  <td class="content" align="left" valign="center">提示：<br/>&nbsp;&nbsp;&nbsp;&nbsp;试卷只有在开放时间到达以后学生才能进入答题，学生必须在关闭时间达到前完成试卷，如果是在试卷关闭时间到达时，学生正在做题，系统将会自动交卷。</td>
					</tr>
					<tr height="5">
					  <td class="content" ><hr/></td>
					</tr>
					<tr  height="25">
					  <td class="content">&nbsp;课程&nbsp;&nbsp;<select id="thecourse" name="thecourse"  class="content"><option value="">本人在学的所有课程<%= allSelectCourseOption %></select></td>
					</tr >
					<tr  height="25">
					  <td class="content">&nbsp;状态&nbsp;&nbsp;<select id="thestatus" class="thestatus" class="content"><option value="0">不限定状态</option><option value="1">已经完成的试卷</option><option value="2">尚未完成的试卷</option></select></td>
					</tr>
                                        <script>thestatus.options[<%= thestatus %>].selected = true;</script>
					<tr  height="25">
					  <td class="content">&nbsp;选项&nbsp;&nbsp;<select id="theopt" class="theopt" class="content"><option value="0">不限制</option><option value="1">已经开考</option><option value="2">1分钟内开考</option><option value="3">5分钟内开考</option><option value="4">10分钟内开考</option><option value="5">30分钟内开考</option></select></td>
					</tr>
                                        <script>theopt.options[<%= theopt %>].selected = true;</script>
					<tr height="25">
					  <td>&nbsp;<input type="button" class="bt" value="查询试卷(Q)"  accesskey="Q"  title="按照所选择的条件查询试卷。" onclick="doQuery();"> </td>
					</tr>

					<tr height="5">
					  <td class="content" ><hr/></td>
					</tr>
					<!--<tr height="25">
					  <td>&nbsp;<input type="button" class="bt" value="进入短消息(D)"  accesskey="D"  title="进入短消息页面。" onclick="doQuery();"> </td>
					</tr>-->
					<tr height="25">
					  <td>&nbsp;<input type="button" class="bt" value="退出登录(T)"  accesskey="T"  title="退出登录。" onclick="location='logoutcontrol.jsp';"> </td>
					</tr>
					<tr><td></td></tr>
				</table>
		      </td>
		    </tr>
<tr height=20><td></td></tr>
			<tr height=100>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr  height="17" >
			        <td width="100%" colspan="2" class="contentwindowtitle">&nbsp;新闻和公告</td>
			      </tr>
				  <tr  height="5" >
			        <td width="100%" colspan="2"></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="about.jsp" class="clink"  target="about" >&nbsp;&#8226;&nbsp;我们能为你做什么&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="aboutthis.jsp" class="clink"  target="aboutthis" >&nbsp;&#8226;&nbsp;关于本系统&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="pic.html" target="pic"  class="clink">&nbsp;&#8226;&nbsp;本系统精彩截图&nbsp;</a></td>
			      </tr>
				<tr >
				<td colspan="2" width="100%"></td>
				</tr>
				</table>
		      </td>
		    </tr>
<tr height=20><td></td></tr>
			<tr height=100>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr  height="17" >
			        <td width="100%" colspan="2" class="contentwindowtitle">&nbsp;友情链接</td>
			      </tr>
				  <tr  height="5" >
			        <td width="100%" colspan="2"></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="http://blog.sina.com.cn/yuzhenqing" class="clink">&nbsp;&#8226;&nbsp;作者博客&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="http://www.sina.com.cn/" class="clink">&nbsp;&#8226;&nbsp;新浪网首页&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="http://www.google.com/" class="clink">&nbsp;&#8226;&nbsp;google首页&nbsp;</a></td>
			      </tr>
				  <tr >
					<td colspan="2" width="100%"></td>
				  </tr>
				</table>
		      </td>
		    </tr>                    <tr height=10><td></td></tr>
		  </table>
	    </td>
		<td width=20></td>
		<td><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" >
				  <tr  height="17" >
				    <td class="contentwindowtitle" width="10">&nbsp;</td>
			        <td id="detailtitle" colspan="2" class="contentwindowtitle">查询结果 【服务器当前时间是：<span id="myssss"></span>】</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					    <tr height="5">
						  <td class="content"><hr/></td>
						</tr>
						<tr height="18">
						  <td colspan="5" >
						    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
								<tr align="left" height="18" class="trow">
<script>
if (screen.availHeight > 600) {
								  document.write('<td width="180">试卷名称</td>');
								  document.write('<td width="110">课程名称</td>');
								  document.write('<td  width="80">试题类型</td>');
								  document.write('<td  width="50">总分</td>');
								  document.write('<td  width="70">得分</td>');
								  document.write('<td  width="110">开始时间</td>');
								  document.write('<td  width="100">结束时间</td>');
}
else {
								  document.write('<td width="80">试卷名称</td>');
								  document.write('<td width="70">课程名称</td>');
								  document.write('<td  width="70">试题类型</td>');
								  document.write('<td  width="50">总分</td>');
								  document.write('<td  width="50">得分</td>');
								  document.write('<td  width="70">开始时间</td>');
								  document.write('<td  width="70">结束时间</td>');
}
</script>
                                                                  <td  >操作</td>
								</tr>
							  </table>
						  </td>
					    </tr>
						<tr >
						  <td><div class="contentdiv">
						    <table  id="datatable" height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<%
    for (int h = 0; h < allSelectCourse.length; h++) {
      if (thecourse != null && thecourse.length() != 0 && !allSelectCourse[h][0].equals(thecourse)) continue;
      zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + allSelectCourse[h][0] + java.io.File.separator + "" +
                                  "paper" + java.io.File.separator+"q.csv");
      String cls = "orow";
      boolean isValid ;
      String typeStr ;
      String myscore = null;
      for (int i = 0; i < csv.allRecords.length; i++) {
        if (allCount % 2 == 0) cls = "orow";
        else cls = "erow";
        isValid = true;
        if (csv.allRecords[i][11].equals("1")) {
          typeStr = "题库选题";
        }
        else {
          typeStr = "上传文档";
        }
        myscore = zy.util.CsvFile.getMyScore(allSelectCourse[h][0],csv.allRecords[i][0],username);
        if (thestatus.equals("2") && myscore != null) isValid = false;
        if (thestatus.equals("1") && myscore == null) isValid = false;
        if (isValid) {
%>
								<tr  height="22" class="<%=cls%>" id="tr_<%=csv.allRecords[i][0]%>" >
<script>
allpapersID[allpapersID.length] = "<%=csv.allRecords[i][0]%>";
allpapersST[allpapersST.length] = <%=csv.allRecords[i][3]%>;
if (screen.availHeight > 600) {
								  document.write('<td width="180"><%=csv.allRecords[i][1]%></td>');
								  document.write('<td width="110"><%=allSelectCourse[h][1]%></td>');
								  document.write('<td  width="80"><%=typeStr%></td>');
								  document.write('<td  width="50"><%=csv.allRecords[i][2]%></td>');

                                                                  <% if (myscore == null) { %>
                                                                  document.write('<td  width="70">未完成</td>');
                                                                  <% } else { %>
                                                                  document.write('<td  width="70"><%=myscore%></td>');
                                                                  <% } %>
								  document.write('<td  width="110">');document.write(getDateTimeString(<%=csv.allRecords[i][3]%>));document.write('</td>');
								  document.write('<td  width="100">');document.write(getDateTimeString(<%=csv.allRecords[i][4]%>));document.write('</td>');
}
else {
								  document.write('<td width="80"><%=csv.allRecords[i][1]%></td>');
								  document.write('<td width="70"><%=allSelectCourse[h][1]%></td>');
								  document.write('<td  width="70"><%=typeStr%></td>');
								  document.write('<td  width="50"><%=csv.allRecords[i][2]%></td>');

                                                                  <% if (myscore == null) { %>
                                                                  document.write('<td  width="50">未完成</td>');
                                                                  <% } else { %>
                                                                  document.write('<td  width="50"><%=myscore%></td>');
                                                                  <% } %>
								  document.write('<td  width="70">');document.write(getDateTimeString(<%=csv.allRecords[i][3]%>));document.write('</td>');
								  document.write('<td  width="70">');document.write(getDateTimeString(<%=csv.allRecords[i][4]%>));document.write('</td>');
}
</script>
                                                                  <% if (myscore == null) { %>
                                                                  <td  >
                                                                    <input type="button" class="bt" value="进入做题" onclick="doExam('<%=csv.allRecords[i][0]%>','<%=allSelectCourse[h][0]%>',<%=csv.allRecords[i][3]%>,<%=csv.allRecords[i][11]%>);"/>
                                                                  </td  >
                                                                  <% } else { %>
                                                                  <td><input type="button" class="bt" value="对照答案" onclick="doCompare('<%=csv.allRecords[i][0]%>','<%=allSelectCourse[h][0]%>',<%=csv.allRecords[i][11]%>, <%=csv.allRecords[i][3]%>, <%=csv.allRecords[i][4]%>);"/></td>
                                                                  <% } %>
								</tr>
<%
          allCount++;
        }
      }
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
reshowPaper();
</script>
</html>