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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心>>资源库</title>
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
<form name="form1" method="post" action="uploadcontrol.jsp" enctype="multipart/form-data">
<table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0">
  <tr height="5"><td></td></tr>
  <!--<tr height="30">
    <td>
      <table height="30" width="100%"  border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td class="pagetitleleft" width="340"><marquee>状元考试系统1.0版</marquee></td>
	      <td class="pagetitleleft" >&nbsp;</td>
	      <td class="pagetitleright" width="360"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr height=15><td class="pagetitleright" colspan=25 align=right valign=bottom>当前位置 教师中心>>试卷管理&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:location='logoutcontrol.jsp';void 0;" class="tlink" accessKey='O'>&nbsp;退出登录&nbsp;</a>|<a  href='1/zyhelp.htm' class="tlink" accessKey='E' target="help">&nbsp;帮助&nbsp;</a> </td></tr>
			<tr height=5><td></td></tr>
		    <script>createAPicture();</script>
		  </table> </td>
	    </tr>
      </table>
	</td>
  </tr>-->
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
			        <td id="detailtitle" colspan="2" class="contentwindowtitle">查询结果</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					        <tr height="25">
						  <td class="content">资源路径 <input type="file" size="30" name="rpath"/> <br/><input type="button" class="bt" value="上传到资源库" onclick="doUpload();"/></td>
						</tr>
					        <tr height="5">
						  <td class="content"><hr/></td>
						</tr>
						<tr height="18">
						  <td colspan="5" >
						    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
								<tr align="left" height="18" class="trow">
								  <td width="180">资源名称</td>
								  <td  width="80">试题类型</td>
								  <td  width="80">资源大小</td>
								  <td  width="70">上传人</td>
								  <td  width="110">上传时间</td>
                                                                  <td  >操作</td>
								</tr>
							  </table>
						  </td>
					    </tr>
						<tr >
						  <td><div class="contentdiv">
						    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<%
        zy.util.CsvFile csvFile = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator + "files.csv");
        String cls = "orow";
        int k = 0;
        for (int i = csvFile.allRecords.length - 1; i >= 0; i--) {
          if (k++ % 2 == 0) cls = "orow";
          else cls = "erow";
%>

								<tr  height="22" class="<%=cls%>">
								  <td width="180"><%=csvFile.allRecords[i][0]%></td>
								  <td  width="80"><%=csvFile.allRecords[i][1]%></td>
								  <td  width="80"><%=csvFile.allRecords[i][2]%></td>
								  <td  width="70"><%=csvFile.allRecords[i][3]%></td>
								  <td  width="110"><script>document.write(getDateTimeString(<%=csvFile.allRecords[i][4]%>)); </script></td>
                                                                  <td><input type="button" class="bt" value="查看" onclick="doView('<%=csvFile.allRecords[i][5]%>');"/> <input type="button" class="bt" value="插入" onclick="doInsert('<%=csvFile.allRecords[i][5]%>','<%=csvFile.allRecords[i][0]%>');"/></td>
								</tr >

<%
        }
%>

<tr><td clospan="6"></td></tr>
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