<%@page contentType="text/html;charset=UTF-8"%>

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
<style>
  .rhinput { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; font-family:宋体;font-size:12px;}
  .cp { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; }
</style>
<title>状元考试系统1.0版>>教师中心>>学生成绩报表</title>

<script src="css/util.js"></script>
<script src="css/css.js"></script>
<script>
<%
zy.util.CsvFile class_csv = (zy.util.CsvFile) zy.util.CsvFile.all.get("class");
out.println("var allclass = new Array('请选择'");
for (int k = 0; k < class_csv.allRecords.length; k++) {
  out.println(",'"+class_csv.allRecords[k][0]+"'");
}
out.println(");");
zy.util.CsvFile grade_csv = (zy.util.CsvFile) zy.util.CsvFile.all.get("grade");
out.println("var allgrade = new Array('请选择'");
for (int k = 0; k < grade_csv.allRecords.length; k++) {
  out.println(",'"+grade_csv.allRecords[k][0]+"'");
}
out.println(");");
%>
function selectUnselectAll(theCheckBox) {
  var gg = document.getElementsByName('hhc');
  for (var j = 0; j < gg.length; j++)gg[j].checked=theCheckBox.checked;
}
function doSelect(aa,bb) {
  var gg = document.getElementsByName('alias');
  for (var j = 0; j < gg.length; j++) {

    if (gg[j].paperid == aa) {
      gg[j].disabled = !bb.checked;
    }
  }
}
function generateSelectHtml(f) {
  var dd = "";
  for (var i = 1; i < f.length; i++) {
    dd += '<option value="'+f[i]+'">'+f[i]+'</option>';
  }
  return dd;
}
function generateSelectHtml1(f,ll) {
  ll.options.length = 0;
  for (var i = 1; i < f.length; i++) {
    ll.options[ll.options.length] = new Option(f[i],f[i]);
  }
}
function report(type) {
  var hhcs = document.getElementsByName("hhc");
  var aliass = document.getElementsByName("alias");
  var qid = "";
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      qid += hhcs[i].value+SAPERATE_CHAR;
      qid += aliass[i].value+SAPERATE_CHAR;
	  if (aliass[i].value == '') {
		  alert("选中的试卷的别名不能为空");
		  return;
	  }
    }
  }
  if (qid == "") {
    alert("请选择要输出报表的试卷！");
    return;
  }
  if (titlename.value == '') {
    alert("输出报表的标题不能为空！");
    return;
  }
  document.form1.reportwhat.value = qid;
  document.form1.reporttype.value = type;
  document.form1.reportorcg.value = classorgrade.value;
  document.form1.reportcg.value = classgrade.value;
  document.form1.reporttitle.value = titlename.value;
  document.form1.submit();
}
</script>

</head>
<body align=right leftmargin=10 topmargin=0>
<form style="display:none" name="form1" method="post" target="report" action="report.jsp">
<input type="hidden" name="reporttype" value="">
<input type="hidden" name="reportwhat" value="">
<input type="hidden" name="reportorcg" value="">
<input type="hidden" name="reportcg" value="">
<input type="hidden" name="reporttitle" value="">
</form>
<table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0">
  <tr height="5"><td></td></tr>
  <tr height="30">
    <td>
      <table height="30" width="100%"  border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td class="pagetitleleft" width="340"><marquee>状元考试系统1.0版</marquee></td>
	      <td class="pagetitleleft" >&nbsp;</td>
	      <td class="pagetitleright" width="360"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr height=15><td class="pagetitleright" colspan=25 align=right valign=bottom>当前位置 教师中心>>学生成绩报表&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:location='logoutcontrol.jsp';void 0;" class="tlink" accessKey='O'>&nbsp;退出登录&nbsp;</a>|<a  href='1/zyhelp.htm' class="tlink" accessKey='E' target="help">&nbsp;帮助&nbsp;</a> </td></tr>
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
			        <td id="detailtitle" colspan="2" class="contentwindowtitle">以下时本系统中所有课程的所有试卷，请选择其中的几份试卷输出成绩报表</td>
			      </tr>
				  <tr >
				    <td width="10"></td>
					<td width="100%">
					  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
					       <tr height="25">
						  <td class="content">
                                                     报表输出形式 <select class="content" name="classorgrade" onchange="if (this.selectedIndex == 0) {cgname.innerHTML='部门';generateSelectHtml1(allclass,classgrade);}else {cgname.innerHTML='单位';generateSelectHtml1(allgrade,classgrade);}if (classgrade.options && classgrade.options.length >=1)titlename.value=classgrade.options[classgrade.selectedIndex].text+'成绩报表';"><option value="class">按部门输出成绩报表</option><option value="grade">按单位输出成绩报表</option></select>
                                                     请选择<span id="cgname" name="cgname">部门</span> <select class="content" id="classgrade" name="classgrade" onchange="titlename.value=this.options[this.selectedIndex].text+'成绩报表';"><script>document.write(generateSelectHtml(allclass));</script></select>
                                                     报表名称 <input name="titlename" type="text" size="60" ><script>if (classgrade.options && classgrade.options.length >=1)titlename.value=classgrade.options[classgrade.selectedIndex].text+'成绩报表';</script>
                                                   </td>
						</tr>
					       <tr height="5">
						  <td class="content"><hr/></td>
						</tr>
						<tr height="18">
						  <td colspan="5" >
						    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
								<tr height="18" class="trow">
								  <td  width="20"><input type="checkbox" onclick="selectUnselectAll(this);"></td>
								  <td  width="220">试卷名称</td>
								  <td  width="80">试题类型</td>
								  <td  width="70">总分</td>
								  <td  width="70">试题数</td>
								  <td  width="120">开放时间</td>
								  <td  width="120">关闭时间</td>
                                                                  <td  title="用于在报表的表头上显示，如果不添，则为试卷名称">别名</td>
								</tr>
							  </table>
						  </td>
					    </tr>
						<tr >
						  <td><div class="contentdiv">
						    <table  id="datatable" height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<%
  zy.util.CsvFile course_csv = (zy.util.CsvFile) zy.util.CsvFile.all.get("course");
  String nowcourseid = "";
  for (int k = 0; k < course_csv.allRecords.length; k++) {
    nowcourseid = course_csv.allRecords[k][0];
    zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper" + java.io.File.separator+"q.csv");
    String cls = "orow";
    boolean isValid ;
    String typeStr;
    for (int i = 0; i < csv.allRecords.length; i++) {
      if (allCount % 2 == 0) cls = "orow";
      else cls = "erow";
      isValid = true;
      if (isValid) {
        if (csv.allRecords[i][11].equals("1")) {
          typeStr = "题库选题";
        }
        else {
          typeStr = "上传文档";
        }
%>
								<tr  height="22" class="<%=cls%>">
								  <td width="20"><input type="checkbox" id="hhc" name = "hhc" value="<%=csv.allRecords[i][0]%>" onclick="doSelect('<%=csv.allRecords[i][0]%>',this);"></td>
								  <td width="220"><%=csv.allRecords[i][1]%></td>
								  <td  width="80"><%=typeStr%></td>
								  <td  width="70"><%=csv.allRecords[i][2]%></td>
								  <td  width="70"><%=csv.allRecords[i][6]%></td>
								  <td  width="120"><script>document.write(getDateTimeString(<%=csv.allRecords[i][3]%>));</script></td>
								  <td  width="120"><script>document.write(getDateTimeString(<%=csv.allRecords[i][4]%>));</script></td>
                                                                  <td title="用于在报表的表头上显示，如果不添，则为试卷名称" ><input name="alias" type="text" size="30" value="<%=csv.allRecords[i][1]%>" paperid="<%=csv.allRecords[i][0]%>" disabled></td>
								</tr>
<%    allCount++;
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
						<tr height="22" >
						  <td><input type="button" class="bt" value="HTML成绩报表(H)" accesskey="H" onclick="report('html');"> <input type="button" class="bt" value="EXCEL成绩报表(E)" accesskey="E" onclick="report('xls');"> <input type="button" class="bt"  accesskey="X" value="返回(X)" onclick="location='teacherindex.jsp';"></td>
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