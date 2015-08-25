<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
request.setCharacterEncoding("UTF-8");
String nowcourseid = (String)session.getAttribute("nowcourseid");
String allselectednodes = request.getParameter("allselectednodes");
String papername = request.getParameter("papername");
if (papername == null) papername = "";
String papertype = request.getParameter("papertype");
if (papertype == null) papertype = "";
String paperscore = request.getParameter("paperscore");
if (paperscore == null) paperscore = "";
session.setAttribute("allselect", allselectednodes);
int allCount = 0;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<style>
  .rhinput { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; font-family:宋体;font-size:12px;}
  .cp { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; }
</style>
<title>状元考试系统1.0版>>教师中心>>试卷管理</title>

<script src="css/util.js"></script>
<script src="css/css.js"></script>
<script>
function selectUnselectAll(theCheckBox) {
  var gg = document.getElementsByName('hhc');
  for (var j = 0; j < gg.length; j++)gg[j].checked=theCheckBox.checked;
}

function doEditPaper() {
  var hhcs = document.getElementsByName("hhc");
  var selectedCount = 0;
  var hhc111s = document.getElementsByName("hhc111");
  var papertype = "";
  var qid = "";
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      selectedCount ++;
      qid = hhcs[i].value;
      papertype = hhc111s[i].value;
    }
  }

  if (selectedCount > 1) {
    alert("只能选择一个试卷进行编辑");
    return;
  }
  else if (selectedCount == 0) {
    alert("请选择你要编辑的试卷");
    return;
  }
  else {
    if (papertype == '1')
    location = "addpaper.jsp?paperid="+qid;
    else
    location = "addpaper1.jsp?paperid="+qid;
  }
}
function doNewPaperWith() {
  var hhcs = document.getElementsByName("hhc");
  var selectedCount = 0;
  var hhc111s = document.getElementsByName("hhc111");
  var papertype = "";
  var qid = "";
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      selectedCount ++;
      qid = hhcs[i].value;
      papertype = hhc111s[i].value;
    }
  }

  if (selectedCount > 1) {
    alert("只能选择一个试卷作为模板");
    return;
  }
  else if (selectedCount == 0) {
    alert("请选择你要作为模板的试卷");
    return;
  }
  else {
    if (papertype == '1')
    location = "addpaper.jsp?paperid=-"+qid;
    else
    location = "addpaper1.jsp?paperid=-"+qid;
  }
}

function doQuery() {
  location = "testpapers.jsp?papername="+papername.value+"&papertype="+papertype.value+"&paperscore="+paperscore.value;
}

function doViewPaper() {
  var hhcs = document.getElementsByName("hhc");
  var hhc111s = document.getElementsByName("hhc111");
  var papertype = "";
  var selectedCount = 0;
  var qid = "";
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      selectedCount ++;
      qid = hhcs[i].value;
      papertype = hhc111s[i].value;
    }
  }

  if (selectedCount > 1) {
    alert("只能选择一个试卷进行查看");
    return;
  }
  else if (selectedCount == 0) {
    alert("请选择你要查看的试卷");
    return;
  }
  else {
    if (papertype == '1') {
      open("viewpaper.jsp?paperid="+qid,'viewpaper');
    }
    else {
      open("viewpaper1.jsp?paperid="+qid,'viewpaper');
    }
  }
}

function doViewPaper1() {
  var hhcs = document.getElementsByName("hhc");
  var hhc111s = document.getElementsByName("hhc111");
  var papertype = "";
  var selectedCount = 0;
  var qid = "";
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      selectedCount ++;
      qid = hhcs[i].value;
      papertype = hhc111s[i].value;
    }
  }

  if (selectedCount > 1) {
    alert("只能选择一个试卷进行查看");
    return;
  }
  else if (selectedCount == 0) {
    alert("请选择你要查看的试卷");
    return;
  }
  else {
    if (papertype == '1') {
      open("viewpaper.jsp?showCard=YES&paperid="+qid,'viewpaper');
    }
    else {
      open("viewpaper1.jsp?showCard=YES&paperid="+qid,'viewpaper');
    }
  }
}

function delPapers() {
  var hhcs = document.getElementsByName("hhc");
  var qid = "";
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      qid += hhcs[i].value+SAPERATE_CHAR;
    }
  }
  if (qid == "") {
    alert("请选择要删除的试卷！");
    return;
  }
  if (!confirm("你现在进行的是删除试卷的操作，你确认要这么做吗？")) {
    return;
  }
  document.form1.delwhat.value = qid;
  document.form1.submit();
}

</script>

</head>
<body align=right leftmargin=10 topmargin=0>
<form name="form1" style="display:none" method="post" action="delpapercontrol.jsp">
<input type="hidden" name="delwhat" value="">
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
		    <tr height=15><td class="pagetitleright" colspan=25 align=right valign=bottom>当前位置 教师中心>>试卷管理&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:location='logoutcontrol.jsp';void 0;" class="tlink" accessKey='O'>&nbsp;退出登录&nbsp;</a>|<a  href='1/zyhelp.htm' class="tlink" accessKey='E' target="help">&nbsp;帮助&nbsp;</a> </td></tr>
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
	      <td width="250"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
			  <td class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				    <tr  height="17" >
			          <td width="100%" class="contentwindowtitle">&nbsp;查询</td>
			        </tr>
					<tr height="5">
					  <td class="content" align="left" valign="center"></td>
					</tr>
					<tr height="5">
					  <td class="content" align="left" valign="center">提示：<br/>&nbsp;&nbsp;&nbsp;&nbsp;试卷有两种类型，一种是从题库中选择题目组成试卷，一种是上传一个文档（一般是WORD文档）组成试卷。<br/>&nbsp;&nbsp;&nbsp;&nbsp;试卷的总分也叫试卷的满分，总分只能是70、100、120、150中的一个。<br/>&nbsp;&nbsp;&nbsp;&nbsp;试卷只有在开放时间到达以后学生才能进入答题，学生必须在关闭时间达到前完成试卷，如果是在试卷关闭时间到达时，学生正在做题，系统将会自动交卷。教师在增加试卷时可以合理设置开放时间和关闭时间以控制试卷的用途，比如，如果该试卷是用于作业，可以将关闭时间与开放时间的差距设得很大，如果是用于考试，可以把关闭时间与开放时间得差距设置得很小。</td>
					</tr>
					<tr height="5">
					  <td class="content" ><hr/></td>
					</tr>
					<tr  height="25">
					  <td class="content">请输入查询条件：</td>
					</tr>
					<tr  height="25">
					  <td class="content">试卷名称&nbsp;&nbsp;<input id="papername" name="papername" type="text" class="rhinput" size="25" maxlength="20" value ="<%=papername%>"></td>
					</tr>
					<tr  height="25">
					  <td class="content">试卷类型&nbsp;&nbsp;<select id="papertype" name="papertype"  class="content"><option value="">所有类型</option><option value="1">题库选题</option><option value="2">上传文档</option></select></td>
					</tr >
					<tr  height="25">
					  <td class="content">试卷总分&nbsp;&nbsp;<select id="paperscore" class="content"><option value="">不限定总分</option><option value="70">70</option><option value="100">100</option><option value="120">120</option><option value="150">150</option></select></td>
					</tr>
					<tr height="5">
					  <td class="content" ><hr/></td>
					</tr>
					<tr height="25">
					  <td>&nbsp;<input type="button" class="bt" value="查询试卷(Q)"  accesskey="Q"  title="按照所选择的条件查询试卷。" onclick="doQuery();"> </td>
					</tr>

					<tr height="5">
					  <td class="content" ><hr/></td>
					</tr>
					<tr height="25">
					  <td>&nbsp;<input type="button" class="bt" value="新增题库选题类试卷(N)"  accesskey="N"  title="从题库中选择题目组成试卷。" onclick="location='addpaper.jsp';"></td>
					</tr>
					<tr height="25">
					  <td>&nbsp;<input type="button" class="bt" value="新增上传文档类试卷(M)"  accesskey="M"  title="上传一个word文档作为试卷。" onclick="location='addpaper1.jsp';"></td>
					</tr>
					<tr><td></td></tr>
				</table>
		      </td>
		    </tr>
			<tr height=10><td></td></tr>
		  </table>
	    </td>
		<td width=20></td>
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
					    <tr height="5">
						  <td class="content"><hr/></td>
						</tr>
						<tr height="18">
						  <td colspan="5" >
						    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
								<tr height="18" class="trow">
								  <td  width="20"><input type="checkbox" onclick="selectUnselectAll(this);"></td>
								  <td  >试卷名称</td>
								  <td  width="80">试题类型</td>
								  <td  width="70">总分</td>
								  <td  width="70">试题数</td>
								  <td  width="120">开放时间</td>
								  <td  width="120">关闭时间</td>
                                                                  <td  width="50">操作</td>
								</tr>
							  </table>
						  </td>
					    </tr>
						<tr >
						  <td><div class="contentdiv">
						    <table  id="datatable" height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<%
    zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                "paper" + java.io.File.separator+"q.csv");
    String cls = "orow";
    boolean isValid ;
    String typeStr;
    for (int i = 0; i < csv.allRecords.length; i++) {
      if (allCount % 2 == 0) cls = "orow";
      else cls = "erow";
      isValid = true;
      if (papername != null && papername.length() != 0) {
        if (csv.allRecords[i][1].indexOf(papername) < 0) {
          isValid = false;
        }
      }
      if (papertype != null && papertype.length() != 0) {
        if (!csv.allRecords[i][11].equals(papertype)) {
          isValid = false;
        }
      }
      if (paperscore != null && paperscore.length() != 0) {
        if (!csv.allRecords[i][2].equals(paperscore)) {
          isValid = false;
        }
      }
      if (isValid) {
        if (csv.allRecords[i][11].equals("1")) {
          typeStr = "题库选题";
        }
        else {
          typeStr = "上传文档";
        }
%>
								<tr  height="22" class="<%=cls%>">
								  <td width="20"><input type="checkbox" id="hhc" name = "hhc" value="<%=csv.allRecords[i][0]%>" />
                                                                       <input type="hidden" id="hhc111" name = "hhc111" value="<%=csv.allRecords[i][11]%>"/>
                                                                   </td>
								  <td><%=csv.allRecords[i][1]%></td>
								  <td  width="80"><%=typeStr%></td>
								  <td  width="70"><%=csv.allRecords[i][2]%></td>
								  <td  width="70"><%=csv.allRecords[i][6]%></td>
								  <td  width="120"><script>document.write(getDateTimeString(<%=csv.allRecords[i][3]%>));</script></td>
								  <td  width="120"><script>document.write(getDateTimeString(<%=csv.allRecords[i][4]%>));</script></td>
                                                                  <td  width="50"><input type="button" class="bt" value="阅卷" onclick="location='judgepaper.jsp?paperid=<%=csv.allRecords[i][0]%>';"></td>
								</tr>
<%    allCount++;
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
						  <td><input type="button" class="bt" value="编辑试卷(E)" accesskey="E" onclick="doEditPaper();"> <input type="button" class="bt" value="以选中试卷为模板新增试卷(T)" style="width:180px" accesskey="T" onclick="doNewPaperWith();"> <input type="button" class="bt" value="查看试卷(V)"  accesskey="V" onclick="doViewPaper();">  <input type="button" class="bt" value="预览卷面(W)"  accesskey="W" onclick="doViewPaper1();"> <input type="button" class="bt"  accesskey="D" value="删除试卷(D)" onclick="delPapers();"> <input type="button" class="bt"  accesskey="X" value="返回(X)" onclick="location='teacherindex.jsp';"></td>
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
for (var i = 0; i < papertype.options.length; i++) {
  if (papertype.options[i].value == "<%=papertype%>") {
    papertype.options[i].selected = true;
  }
}
for (var i = 0; i < paperscore.options.length; i++) {
  if (paperscore.options[i].value == "<%=paperscore%>") {
    paperscore.options[i].selected = true;
  }
}
</script>
<script>
for (var i = 0; i < (datatable.rows.length - 1); i++) {
  datatable.rows[i].title="第"+(i+1)+"条记录，共"+(datatable.rows.length - 1)+"条记录";
}
</script>
</html>