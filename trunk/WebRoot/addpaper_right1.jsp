<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.io.File"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
request.setCharacterEncoding("UTF-8");
int allCount = 0;
%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心>>添加/编辑试卷</title>
<script src="css/util.js"></script>
<script src="css/css.js"></script>
<script>
function doUpload() {
  if (document.form1.rpath.value == '') {
    alert('资源路径不能为空');
    return;
  }
  document.form1.submit();
}

function doView(addr) {
  open(addr, "viewfile");
}
function doInsert(addr,thename) {
  if (opener && !opener.closed && opener.addAFile) {
    opener.addAFile(addr,thename);
    window.close();
  }
}
</script>

</head>
<body align=right leftmargin=10 topmargin=0>
<form name="form1" method="post" action="uploadcontrol1.jsp" enctype="multipart/form-data">
<table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0">
  <tr height="5"><td></td></tr>
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
			        <td id="detailtitle" colspan="2" class="contentwindowtitle">选择作为试卷卷面的文件上传到服务器</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					        <tr height="25">
						  <td class="content">试卷文件路径 <input type="file" size="30" name="rpath"/> <br/><input type="button" class="bt" value="上传作为试卷" onclick="doUpload();"/></td>
						</tr>
					        <tr height="5">
						  <td class="content"><hr/></td>
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