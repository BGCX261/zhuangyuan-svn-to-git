<%@page contentType="text/html;charset=UTF-8"%>
<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("3")) {
  response.sendRedirect("error.html?message=2");
}
zy.util.CsvFile ss = zy.util.CsvFile.getACsvFile("sessionstrategy");
String sss = "0";
if (ss != null && ss.allRecords != null && ss.allRecords.length > 0 && ss.allRecords[0].length > 0) {
    sss = ss.allRecords[0][0];
}
ss = zy.util.CsvFile.getACsvFile("compareset");
String ssss = "0";
if (ss != null && ss.allRecords != null && ss.allRecords.length > 0 && ss.allRecords[0].length > 0) {
    ssss = ss.allRecords[0][0];
}
ss = zy.util.CsvFile.getACsvFile("judgeset");
String sssss = "0";
if (ss != null && ss.allRecords != null && ss.allRecords.length > 0 && ss.allRecords[0].length > 0) {
    sssss = ss.allRecords[0][0];
}
%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>管理中心</title>

<script src="css/util.js"></script>
<script src="css/css.js"></script>
<script>
function setCourseActive(courseid) {
  document.form1.activecourseid.value = courseid;
  document.form1.submit();
}
function newPassword() {
  alert("newPassword");
  alert(document.form1.newp1.value);
  if (document.form1.newp.value == "") {
    alert("新的密码不能为空！");
    return;
  }
  if (document.form1.newp.value != document.form1.newp1.value) {
    alert("密码与密码确认不一致！");
    return;
  }
  location = "newpass.jsp?newpass="+httpAddrEncode(document.form1.newp.value);
}
function newSessionStrategy() {
	var tmp = "0";
    var tmp1 = document.getElementsByName("sessioncontrol");
    for (var i = 0; i < tmp1.length; i++) {
        if (tmp1[i].checked) {
            tmp = tmp1[i].value;
        }
    }
    location = "newsessionstrategy.jsp?newsessionstrategy="+tmp;
}
function newCompareset() {
	var tmp = "0";
    var tmp1 = document.getElementsByName("compareset");
    for (var i = 0; i < tmp1.length; i++) {
        if (tmp1[i].checked) {
            tmp = tmp1[i].value;
        }
    }
    location = "newcompareset.jsp?compareset="+tmp;
}
function newJudgeset() {
	var tmp = "0";
    var tmp1 = document.getElementsByName("judgeset");
    for (var i = 0; i < tmp1.length; i++) {
        if (tmp1[i].checked) {
            tmp = tmp1[i].value;
        }
    }
    location = "newjudgeset.jsp?judgeset="+tmp;
}
</script>
</head>
<body align=right leftmargin=10 topmargin=0>
<form name="form1" method="post" action="setactivecourse.jsp">
<input type="hidden" name="activecourseid" value="">
<table height="100%" width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr height="5"><td></td></tr>
  <tr height="30">
    <td>
      <table height="30" width="100%"  border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td class="pagetitleleft" width="340"><marquee>状元考试系统1.0版</marquee></td>
	      <td class="pagetitleleft" >&nbsp;</td>
	      <td class="pagetitleright" width="360"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr height=15><td class="pagetitleright" colspan=25 align=right valign=bottom>当前位置 管理中心&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:location='logoutcontrol.jsp';void 0;" class="tlink" accessKey='O'>&nbsp;退出登录&nbsp;</a>|<a  href='1/zyhelp.htm' class="tlink" accessKey='E' target="help">&nbsp;帮助&nbsp;</a> </td></tr>
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
	      <td width="200"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr height="100">
			  <td class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				    <tr  height="17" >
			          <td width="100%" class="contentwindowtitle">&nbsp;管理中心菜单</td>
			        </tr>
					<tr  height="25" >
					  <td ><a href="courseadmin.jsp" accessKey="K" class=clink>&nbsp;&nbsp;&#8226;&nbsp;课程管理(K)&nbsp;</a></td>
					</tr>
					<tr  height="25" >
					  <td ><a href="gradeadmin.jsp" accessKey="G" class=clink>&nbsp;&nbsp;&#8226;&nbsp;单位管理(G)&nbsp;</a></td>
					</tr>
					<tr  height="25" >
					  <td ><a href="classadmin.jsp" accessKey="S" class=clink>&nbsp;&nbsp;&#8226;&nbsp;部门管理(S)&nbsp;</a></td>
					</tr>
					<tr  height="25" >
					  <td ><a href="teacheradmin.jsp" accessKey="Q" class=clink>&nbsp;&nbsp;&#8226;&nbsp;教师管理(Q)&nbsp;</a></td>
					</tr>
					<tr  height="25" >
					  <td ><a href="studentadmin.jsp" accessKey="P" class=clink>&nbsp;&nbsp;&#8226;&nbsp;学生管理(P)&nbsp;</a></td>
					</tr>
					<tr  height="25" >
					  <td ><a href="bak.jsp" accessKey="B" class=clink>&nbsp;&nbsp;&#8226;&nbsp;备份和还原(B)&nbsp;</a></td>
					</tr>
					<tr  height="25" >
					  <td ><a href="javascript:location='logoutcontrol.jsp';void 0;" accessKey="L" class=clink>&nbsp;&nbsp;&#8226;&nbsp;退出登录(L)&nbsp;</a></td>
					</tr>
					<tr >
					  <td align="left">&nbsp;</td>
					</tr>
				</table>
		      </td>
		    </tr>
			<tr height=20><td></td></tr>
			<tr height=150>
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
			<tr height=150>
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
		    </tr>
                    <tr ><td> </td></tr>
		  </table>
	    </td>
		<td width=20></td>
		<td><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" >
				  <tr  height="17" >
				    <td class="contentwindowtitle" width="10">&nbsp;</td>
			        <td colspan="2" class="contentwindowtitle">欢迎管理员进入本系统，你可以在这里设置课程、部门，你可以在这里添加教师和学生。</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					    <tr height="20">
						  <td></td>
						</tr>
					    <tr height="10">
						  <td  width="100%" class="content" valign=top >
                            请管理员在安装好系统以后立即修改管理端的密码，以免学生和教师利用初始密码testadmin进入管理端修改数据：<br/>
                            新密码：<input type="password" name="newp" class="rhinput"/> 新密码确认：<input type="password" name="newp1"   class="rhinput"/> <input class="bt" type="button" value="更新密码" onclick="newPassword();"/> <br/> <br/> <br/>

                            登录策略，设置同一用户是否能在多处同时登录的问题，如果不能，那么是后来的用户不能登录呢还是前面的用户被踢出呢？<br/>
                            <input type="radio" name="sessioncontrol" value="0" checked/>不限制同一用户在多处同时登录<br/> <input type="radio" name="sessioncontrol"  value="1"/>已有用户登录，同样的用户不能再登录 <br/><input type="radio" name="sessioncontrol"  value="2"/>已有用户登录，同样的用户可以再登录，并且前面登录的用户被踢出
                            <br/><input class="bt" type="button" value="更新登录策略" onclick="newSessionStrategy();"/>
                              <br/> <br/> <br/>

                            对照答案策略，设置是否在试卷结束时间到达以后才能对照答案（这一设置只有针对考试开始时间与考试结束时间之间的差小于24小时的试卷才能有效，对于考试开始时间与考试结束时间之间的差大于24小时的试卷将做为作业和练习对待，不具有考试的严肃性，所以以下的设置对这样的试卷不起作用！）<br/>
                            <input type="radio" name="compareset" value="0" checked/>只要交卷以后就可以对照答案！<br/> <input type="radio" name="compareset"  value="1"/>交卷以后，只有在到达考试结束时间以后才能对照答案
                            <br/><input class="bt" type="button" value="更新对照答案策略" onclick="newCompareset();"/>
                              <br/> <br/> <br/>

                            阅卷策略，设置教师在阅卷的时候是否可以更改客观题的分数！<br/>
                            <input type="radio" name="judgeset" value="0" checked/>教师在阅卷的时候不能更改客观题的分数<br/> <input type="radio" name="judgeset"  value="1"/>教师在阅卷的时候可以更改客观题的分数
                            <br/><input class="bt" type="button" value="更新阅卷策略" onclick="newJudgeset();"/>
                              <br/> <br/> <br/>

							在<a href="courseadmin.jsp" class=clink>课程管理</a>中，可以添加和删除课程。<br/><br/>
							在<a href="gradeadmin.jsp" class=clink>单位管理</a>中，可以添加和删除单位。<br/><br/>
							在<a href="classadmin.jsp" class=clink>部门管理</a>中，可以添加和删除部门。<br/><br/>
							在<a href="teacheradmin.jsp" class=clink>教师管理</a>中，可以添加和删除教师，指定教师教授的课程。<br/><br/>
							在<a href="studentadmin.jsp" class=clink>学生管理</a>中，可以添加和删除学生，指定学生学习的课程。<br/><br/>
							本系统现有：<br/><br/>
							课程数：<%= zy.util.CsvFile.getACsvFile("course").allRecords.length %> <br/><br/>
							单位数：<%= zy.util.CsvFile.getACsvFile("grade").allRecords.length %> <br/><br/>
							部门数：<%= zy.util.CsvFile.getACsvFile("class").allRecords.length %><br/><br/>
							教师数：<%= zy.util.CsvFile.getTeachersCount() %><br/><br/>
							学生数：<%= zy.util.CsvFile.getStudentsCount() %><br/><br/>
						  </td>
						</tr>
						<tr><td></td></tr>
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
</form>
</body>
<script>
    var tmp1 = document.getElementsByName("sessioncontrol");
    for (var i = 0; i < tmp1.length; i++) {
        if (tmp1[i].value == "<%=sss%>") {
            tmp1[i].checked = true;
        }
    }
    tmp1 = document.getElementsByName("compareset");
    for (var i = 0; i < tmp1.length; i++) {
        if (tmp1[i].value == "<%=ssss%>") {
            tmp1[i].checked = true;
        }
    }
    tmp1 = document.getElementsByName("judgeset");
    for (var i = 0; i < tmp1.length; i++) {
        if (tmp1[i].value == "<%=sssss%>") {
            tmp1[i].checked = true;
        }
    }
</script>
</html>