<%@page contentType="text/html;charset=UTF-8"%>
<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("3")) {
  response.sendRedirect("error.html?message=2");
}


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>

<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>

<title>状元考试系统1.0版>>管理中心</title>

<script src="css/css.js"></script>
<script src="css/util.js"></script>
<script>
</script>
</head>
<body align=right leftmargin=10 topmargin=0>
<form name="form1" method="post" action="restore.jsp"  enctype="multipart/form-data">
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
			        <td colspan="2" class="contentwindowtitle">欢迎管理员进入本页，你可以在这里备份和还原数据。</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					    <tr height="5">
						  <td></td>
						</tr>
					    <tr height="10">
						  <td  width="100%" class="content"  >数据备份是将状元考试系统的所有用户数据包括课程、部门、单位、学生、教师、试题、试卷打包，你可以下载备份的包保存起来。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" class="bt" value="备份"  onclick="location='bak_.jsp'"> <br/>

						  </td>
						</tr>
					    <tr height="5">
						  <td class="content" ><hr/></td>
						</tr>
					    <tr height="10">
						  <td  width="100%" class="content"  >数据还原是上传已有的数据备份包，并覆盖现有的数据。&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="file" class="rhinput bt" name="ff" size="40" accept="image/jpeg" >  <input type="submit" class="bt" value="还原"  > <br/>

						  </td>
						</tr>
					    <tr height="5">
						  <td class="content" ><hr/></td>
						</tr>
					    <tr height="10">
						  <td  width="100%" class="content" align="center" >   <input type="button" class="bt" value="返回管理中心"  onclick="location='adminindex.jsp';"> <br/>

						  </td>
						</tr>
						<tr height="100%">
						  <td colspan="5" >
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


<script>
<% if (session.getAttribute("error") != null) { %>
alert('<%=session.getAttribute("error")%>');
<% session.removeAttribute("error");} %>
</script>