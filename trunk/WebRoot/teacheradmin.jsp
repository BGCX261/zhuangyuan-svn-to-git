<%@page contentType="text/html;charset=UTF-8"%>
<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("3")) {
  response.sendRedirect("error.html?message=2");
}

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<title>状元考试系统1.0版>>管理中心</title>

<script src="css/css.js"></script>
<script src="css/util.js"></script>
<script>
var demoTeachers = new Array(
"fumiaoqin",
"yuzhenqing",
"yangyu"
);

function isDemoTeacher(cid) {
  var result = false;
  for (var i = 0; i < demoTeachers.length; i++) {
    if (demoTeachers[i] == cid) {
      result = true; break;
    }
  }
  return result;
}

function setCourse(courseid, nowcs) {
  if (isDemoTeacher(courseid)) {
    //alert("你要修改的是系统定义的演示教师，修改操作无效！"); return;
  }
  var aa = prompt("请输入新的关联课程，不同的课程以空格分隔！",nowcs);
  if (aa == null ) {
	  return;
  }
  location = "courseteacher.jsp?CID="+courseid+"&V="+httpAddrEncode(aa);
}
function doDel(cid) {
  if (isDemoTeacher(cid)) {
    //alert("你要删除的是系统定义的演示教师，删除操作无效！"); return;
  }
  location="delteacher.jsp?CID="+cid;
}
function doAdd() {
	document.form1.username.value = document.form1.username.value.trim();
	if (document.form1.username.value == "") {
		alert("用户名不能为空！");
		return;
	}
	document.form1.passwd.value = document.form1.passwd.value.trim();
	document.form1.passwd1.value = document.form1.passwd1.value.trim();
	if (document.form1.passwd.value != document.form1.passwd1.value) {
		alert("两次输入的密码不一致！");
		return;
	}
	document.form1.realname.value = document.form1.realname.value.trim();
	if (document.form1.realname.value == "") {
		alert("姓名不能为空！");
		return;
	}
    document.form1.submit();
}
function modifyPassword(cid) {
  if (isDemoTeacher(cid)) {
    //alert("你要修改的是系统定义的演示教师，修改操作无效！"); return;
  }
  var aa = prompt("请输入新密码！","");
  if (aa == null ) {
	  return;
  }
  var bb = prompt("请再次输入新密码！","");
  if (bb == null ) {
	  return;
  }
  if (aa != bb) {
	  alert("两次输入的密码不一致！");
	  return;
  }
  location = "modifytpass.jsp?CID="+cid+"&V="+httpAddrEncode(aa);
}
</script>
<style>
.rhinput {
	BORDER-RIGHT: #C4DEF7 1px solid;
	BORDER-TOP: #C4DEF7 1px solid;
	BORDER-LEFT: #C4DEF7 1px solid;
	BORDER-BOTTOM: #C4DEF7 1px solid;
}
</style>
</head>
<body align=right leftmargin=10 topmargin=0>
<form name="form1" method="post" action="addteacher.jsp">
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
		<td><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" >
				  <tr  height="17" >
				    <td class="contentwindowtitle" width="10">&nbsp;</td>
			        <td colspan="2" class="contentwindowtitle">欢迎管理员进入本，你可以在这里添加教师、删除教师、修改教师。</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					    <tr height="5">
						  <td></td>
						</tr>
					    <tr height="10">
						  <td  width="100%" class="content"  >&nbsp;&nbsp;&nbsp;&nbsp;以下是本系统的所有教师&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						   <input type="button" class="bt" value="返回管理中心"  onclick="location='adminindex.jsp';">
						  </td>
						</tr>
					    <tr height="5">
						  <td class="content" ><hr/></td>
						</tr>
						<tr height="18">
						  <td colspan="5" >
						    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
								<tr height="22" class="trow">
								  <td width="80">&nbsp;用户名</td>
								  <td width="80">姓名</td>
								  <!--<td width="80">身份</td>-->
								  <!--<td width="80">部门</td>-->
								  <td width="350">相关联的课程</td>
								  <td >操作</td>
								</tr>
							  </table>
						  </td>
					    </tr>
						<tr>
						  <td><div class="contentdiv">
						    <table  id="datatable"  height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<%
zy.util.CsvFile csv_user = (zy.util.CsvFile)zy.util.CsvFile.all.get("user");
System.out.println("111111111111111111111111:"+csv_user.allRecords.length);
zy.util.CsvFile csv_course_user = (zy.util.CsvFile)zy.util.CsvFile.all.get("course_teacher");
String cls = "";
String sf   = "";
String rcourse = "";
for (int i = 0; i < csv_user.allRecords.length; i++) {
	if (csv_user.allRecords[i][4].equals("2")) continue;
  if (i % 2 == 0) cls = "orow";
  else cls = "erow";
  if (csv_user.allRecords[i][4].equals("1")) sf = "教师";
  else sf = "学生";
  rcourse = "";
  for (int j = 0; j < csv_course_user.allRecords.length; j++) {
    if (csv_course_user.allRecords[j][1].equals(csv_user.allRecords[i][0])) {
      rcourse += zy.util.CsvFile.getCourseNameById(csv_course_user.allRecords[j][0])+" ";
    }
  }
%>
                                                       <tr  height="22" class="<%=cls%>">
								  <td width="80"><%=csv_user.allRecords[i][0]%>&nbsp;</td>
								  <td width="80"><%=csv_user.allRecords[i][2]%>&nbsp;</td>
								  <!-- <td width="80"><%=sf%></td>-->
								  <!--<td width="80"><%=csv_user.allRecords[i][5]%>&nbsp;</td>-->
								  <td width="350"><%=rcourse%>&nbsp;</td>
								  <td >
								    <input type="button" class="bt" value="删除" onclick="doDel('<%=csv_user.allRecords[i][0]%>');"/>
								    <input type="button" class="bt" value="修改密码" onclick="modifyPassword('<%=csv_user.allRecords[i][0]%>');"/>
								    <input type="button" class="bt" value="设置关联课程" onclick="setCourse('<%=csv_user.allRecords[i][0]%>','<%=rcourse%>');"/>
								  </td>
								</tr>
<% } %>
								<tr>
								  <td class="content" colspan="6"></td>
								</tr>
							  </table></div>
						  </td>
					    </tr>
					    <tr height="5">
						  <td class="content" ><hr/></td>
					   </tr>
					   <tr height="20">
					      <td class="content" >
						  用户名<input class="rhinput" type="text" border="0" size="15" name="username" id="username" accessKey="N" onkeypress="if (event.keyCode == 13) passwd.focus();">
						  密码<input class="rhinput" type="password" border="0" size="15" name="passwd" id="passwd" accessKey="N" onkeypress="if (event.keyCode == 13) passwd1.focus();">
						  密码确认<input class="rhinput" type="password" border="0" size="15" name="passwd1" id="passwd1" accessKey="N" onkeypress="if (event.keyCode == 13) realname.focus();">
						  姓名<input class="rhinput" type="text" border="0" size="15" name="realname" id="realname" accessKey="N" onkeypress="if (event.keyCode == 13) doAdd();">
							 <input type="button" class="bt" value="添加教师"  onclick="doAdd();">
                          </td>
					   </tr>
					    <tr height="15">
						  <td class="content" ></td>
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
</form>
</body>
</html>

<script>
<% if (session.getAttribute("error") != null) { %>
alert('<%=session.getAttribute("error")%>');
<% session.removeAttribute("error");} %>
</script>