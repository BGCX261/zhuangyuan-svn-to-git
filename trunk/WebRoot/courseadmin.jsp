<%@page contentType="text/html;charset=UTF-8"%>
<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("3")) {
  response.sendRedirect("error.html?message=2");
}

zy.util.CsvFile cf = (zy.util.CsvFile)zy.util.CsvFile.all.get("course");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>管理中心</title>

<script src="css/css.js"></script>
<script src="css/util.js"></script>
<script>
function setCourseActive(courseid) {
  document.form1.activecourseid.value = courseid;
  document.form1.submit();
}
function doDel(cid) {
  var ss = cid.substring(2) * 1;
  if (ss < 29) {
    //alert("你要删除的是系统定义的演示课程，删除操作将不能进行！");return;
  }
  location="delcourse.jsp?CID="+cid;
}
function doAdd() {
  var aa = prompt("请输入课程名称，例如“高一政治”","");
  if (aa == null ) {
	  return;
  }
  if ( aa == "") {
    alert("请输入课程名称!");
    return;
  }
  else {
    location = "addcourse.jsp?V="+httpAddrEncode(aa);
  }
}
function doUpdate(cid) {
  var ss = cid.substring(2) * 1;
  if (ss < 29) {
    //alert("你要修改的是系统定义的演示课程，修改操作将不能进行！");return;
  }
  location="updatecourse.jsp?CID="+cid+"&V="+httpAddrEncode(document.getElementById("cc"+cid).value);
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
		<td><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" >
				  <tr  height="17" >
				    <td class="contentwindowtitle" width="10">&nbsp;</td>
			        <td colspan="2" class="contentwindowtitle">欢迎管理员进入本，你可以在这里添加课程、删除课程、修改课程。</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					    <tr height="5">
						  <td></td>
						</tr>
					    <tr height="10">
						  <td  width="100%" class="content"  >&nbsp;&nbsp;&nbsp;&nbsp;以下是本系统的所有课程&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" class="bt" value="添加课程"  onclick="doAdd();">
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
for (int j = 0; j < cf.allRecords.length; j++) {
	if (clsIndex++ % 2 == 0) cls = "orow";
	else cls = "erow";
%>
								<tr  height="22" class="<%=cls%>">
								  <td width="320" ><input type="text" id="cc<%=cf.allRecords[j][0]%>" value="<%=cf.allRecords[j][1]%>"></td>
								  <td width="100" ><%=cf.allRecords[j][2]%></td>
								  <td width="100" ><%=cf.allRecords[j][3]%></td>
								  <td width="100" ><%=cf.allRecords[j][4]%></td>
								  <td ><input type="button" class="bt" value="删除"  onclick="doDel('<%=cf.allRecords[j][0]%>');"> <input type="button" class="bt" value="更新"  onclick="doUpdate('<%=cf.allRecords[j][0]%>');"></td>
								</tr>
<%
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
</html>