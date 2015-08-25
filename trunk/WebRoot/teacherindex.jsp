<%@page contentType="text/html;charset=UTF-8"%>
<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}

zy.util.CsvFile cf = (zy.util.CsvFile)zy.util.CsvFile.all.get("course");
zy.util.CsvFile cf1 = (zy.util.CsvFile)zy.util.CsvFile.all.get("course_teacher");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心</title>

<script src="css/css.js"></script>
<script>
function setCourseActive(courseid) {
  document.form1.activecourseid.value = courseid;
  document.form1.submit();
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
		    <tr height=15><td class="pagetitleright" colspan=25 align=right valign=bottom>当前位置 教师中心&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:location='logoutcontrol.jsp';void 0;" class="tlink" accessKey='O'>&nbsp;退出登录&nbsp;</a>|<a  href='1/zyhelp.htm' class="tlink" accessKey='E' target="help">&nbsp;帮助&nbsp;</a> </td></tr>
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
			          <td width="100%" class="contentwindowtitle">&nbsp;教师中心菜单</td>
			        </tr>
					<tr  height="25" >
					  <td ><a href="structure.jsp" accessKey="K" class=clink>&nbsp;&nbsp;&#8226;&nbsp;课程结构管理(K)&nbsp;</a></td>
					</tr>
					<tr  height="25" >
					  <td ><a href="testquestions.jsp" accessKey="Q" class=clink>&nbsp;&nbsp;&#8226;&nbsp;试题和题库管理(Q)&nbsp;</a></td>
					</tr>
					<tr  height="25" >
					  <td ><a href="testpapers.jsp" accessKey="P" class=clink>&nbsp;&nbsp;&#8226;&nbsp;试卷和阅卷管理(P)&nbsp;</a></td>
					</tr>
					<tr  height="25" >
					  <td ><a href="archievement.jsp" accessKey="S" class=clink>&nbsp;&nbsp;&#8226;&nbsp;学生成绩报表(S)&nbsp;</a></td>
					</tr>
					<!--<tr  height="25" >
					  <td ><a href="javascript:alert('该功能尚未实现！');void 0;" accessKey="I" class=clink>&nbsp;&nbsp;&#8226;&nbsp;进入我的短消息(I)&nbsp;</a></td>
					</tr>-->
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
			        <td colspan="2" class="contentwindowtitle">欢迎<%=session.getAttribute("realname")%>老师，你可以在这里设置当前课程。</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					    <tr height="5">
						  <td></td>
						</tr>
					    <tr height="10">
						  <td  width="100%" class="content"  >&nbsp;&nbsp;&nbsp;&nbsp;以下是你有权访问的所有课程，你现在的当前课程是<span id="nowcourse" ></span>，你在教师中心进行课程结构管理、题库管理和试卷管理时是针对<span id="nowcourse1"></span>的。<span id="nowcourse2"></span></td>
						</tr>
					    <tr height="5">
						  <td class="content" ><hr/></td>
						</tr>
						<tr height="18">
						  <td colspan="5" >
						    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
								<tr height="22" class="trow">
								  <td width="320">课程名称</td>
								  <td width="100">试题总数</td>
								  <td width="100">试卷数</td>
								  <td width="100">学习人数</td>
								  <td>操作</td>
								</tr>
							  </table>
						  </td>
					    </tr>
						<tr>
						  <td><div class="contentdiv">
						    <table  id="datatable"  height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<%
int clsIndex = 0;
String cls;
String nowCourse = "";
for (int i = 0; i < cf1.allRecords.length; i++) {
  if (cf1.allRecords[i][1].equals(username)) {
    for (int j = 0; j < cf.allRecords.length; j++) {
      if (cf.allRecords[j][0].equals(cf1.allRecords[i][0])) {
        if (clsIndex++ % 2 == 0) cls = "orow";
        else cls = "erow";
        if (cf1.allRecords[i][2].equals("1")) {
          nowCourse = cf.allRecords[j][1];
          session.setAttribute("nowcourseid",cf.allRecords[j][0]);
          session.setAttribute("nowcoursename",cf.allRecords[j][1]);
%>
								<tr  height="22" class="<%=cls%>">
								  <td width="320" class="emp"><%=cf.allRecords[j][1]%></td>
								  <td width="100" class="emp"><%=cf.allRecords[j][2]%></td>
								  <td width="100" class="emp"><%=cf.allRecords[j][3]%></td>
								  <td width="100" class="emp"><%=cf.allRecords[j][4]%></td>
								  <td class="emp">当前课程</td>
								</tr>
<%
        }
        else {
%>
								<tr height="22" class="<%=cls%>">
								  <td width="320"><%=cf.allRecords[j][1]%></td>
								  <td width="100"><%=cf.allRecords[j][2]%></td>
								  <td width="100"><%=cf.allRecords[j][3]%></td>
								  <td width="100"><%=cf.allRecords[j][4]%></td>
								  <td><input type="button" class="bt"  value="设为当前课程" onclick="setCourseActive('<%=cf.allRecords[j][0]%>');"></td>
								</tr>
<%
        }
        break;
      }
    }
  }
}
%>
								<tr>
								  <td class="content" colspan="5"></td>
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
</form>
</body>
<script>
nowcourse.innerHTML = "<%=nowCourse%>";
nowcourse1.innerHTML = "<%=nowCourse%>";
if (<%=clsIndex%> > 1) nowcourse2.innerHTML = '如果你希望改变当前课程，你只要在某一门课程后的按钮上点一下即可。';
</script>
<script>
for (var i = 0; i < (datatable.rows.length - 1); i++) {
  datatable.rows[i].title="第"+(i+1)+"条记录，共"+(datatable.rows.length - 1)+"条记录";
}
</script>
</html>