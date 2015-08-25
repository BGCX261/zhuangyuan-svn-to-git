<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
String nowcourseid = (String)session.getAttribute("nowcourseid");
String allselectednodes = request.getParameter("allselectednodes");
session.setAttribute("allselect", allselectednodes);
int allCount = 0;
%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心>>新增试卷</title>

<style>

.menuitems {
	padding-left:15px;
	padding-right:10px;
}
.rightmenu {
    padding-top:2px;
    padding-bottom:1px;
	cursor:default;
	font:menutext;
	position:absolute;
	text-align:left;
	font-size : 12px;
	line-height:20px;
	width:115px;
	background-color:menu;
	border:1 solid buttonface;
	visibility:hidden;
	border:2 outset buttonhighlight;
	z-index:100;
}
.editcoursenode {
    padding-top:2px;
    padding-bottom:1px;
	position:absolute;
	text-align:left;
	font-size : 12px;
	line-height:20px;
	width:250px;
	height:300px;
	border:1 solid black;
	background-color:menu;
	visibility:hidden;
	overflow:auto;
	z-index:200;
}
</style>
<style>
  .rhinput { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; font-family:宋体;font-size:12px;}
  .cp { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; }
</style>
<script src="css/css.js"></script>
<script src="css/util.js"></script>

<script>
<%=zy.util.CsvFile.getCT(nowcourseid)%>
var rightmenunodeid = 0;
var selectedNodeNames = ""
var selectedNodeName = ""

for (var i = 0; i < atree.length; i++) {
	for (var j = 0; j < atree.length; j++) {
	  if (atree[j][2] == atree[i][0]) {
		atree[i][3] = false;
		break;
	  }
	}
}

var qstructures = new Array(
    "单项选择题", "多项选择题", "复合题", "连线题", "判断题", "问答题");
var qdifficultys = new Array(
    "特别容易", "容易", "难度中等", "难", "特别难");

function selectUnselectAll(theCheckBox) {
  var gg = document.getElementsByName('hhc');
  for (var j = 0; j < gg.length; j++)gg[j].checked=theCheckBox.checked;
}

function doOnContextMenu() {
  var strid = event.srcElement.id;
  if (strid.indexOf('node') == 0) {
    showmenuie5();
	rightmenunodeid = strid.substring(4) * 1;
    return false;
  }
  return true;
}

function queryquestion() {
  var allSelectedNodes = "", allSelectedNodesCount = 0;
  for (var i = 0; i < atree.length; i++) {
    if (document.getElementById("ncheck"+atree[i][0]).checked) {
	  allSelectedNodesCount++;
	  allSelectedNodes += (atree[i][0] + ",");
	}
  }
  if (allSelectedNodesCount >= 1) {
    allSelectedNodes = "("+allSelectedNodes.substring(0, allSelectedNodes.length - 1)+")";
  }
  else if (allSelectedNodesCount == atree.length) {
    allSelectedNodes = "";
  }
  else if (allSelectedNodesCount == 0) {
    alert("请选择一个或者多个节点后再点击查询试题按钮！");
    return;
  }
  location = "addpaper_right.jsp?allselectednodes="+allSelectedNodes;
}

function doWrap(a) {
  if (document.getElementById('subnodes'+a).style.display == "none") {
    document.getElementById('subnodes'+a).style.display = "";
	document.getElementById('treenodeimage'+a).src = 'images/expand.gif';
  }
  else {
    document.getElementById('subnodes'+a).style.display = "none";
  	document.getElementById('treenodeimage'+a).src = 'images/wrap.gif';
  }
}

function doPopWrap(a) {
  if (document.getElementById('popsubnodes'+a).style.display == "none") {
    document.getElementById('popsubnodes'+a).style.display = "";
	document.getElementById('poptreenodeimage'+a).src = 'images/expand.gif';
  }
  else {
    document.getElementById('popsubnodes'+a).style.display = "none";
  	document.getElementById('poptreenodeimage'+a).src = 'images/wrap.gif';
  }
}

function wrapallsubnodes() {
  wrapallsubnodesimpl(rightmenunodeid);
}

function wrapallsubnodesimpl(rightmenunodeid1) {
  document.getElementById('subnodes'+rightmenunodeid1).style.display = "none";
  document.getElementById('treenodeimage'+rightmenunodeid1).src = 'images/wrap.gif';
  for (var i = 0; i < atree.length; i++) {
    if (atree[i][2] == rightmenunodeid1) {
	  if (!atree[i][3])
	    wrapallsubnodesimpl(atree[i][0]);
	}
  }
}

function expandallsubnodes() {
  expandallsubnodesimpl(rightmenunodeid);
}

function expandallsubnodesimpl(rightmenunodeid1) {
  document.getElementById('subnodes'+rightmenunodeid1).style.display = "";
  document.getElementById('treenodeimage'+rightmenunodeid1).src = 'images/expand.gif';
  for (var i = 0; i < atree.length; i++) {
    if (atree[i][2] == rightmenunodeid1) {
	  if (!atree[i][3])
	    expandallsubnodesimpl(atree[i][0]);
	}
  }
}

function buildtree(theindex, depth) {
  var depthstr = '';
  for (var i = 0; i < depth; i++) {
    depthstr = depthstr + '&nbsp;&nbsp;';
  }
  if (atree[theindex][3]) {
	document.write(depthstr);
	document.write('<span class="content" id="node'+atree[theindex][0]+'"><img border="0" align="center" src="images/leaf.gif"><input type="checkbox" id="ncheck'+atree[theindex][0]+'">&nbsp;');
	document.write(atree[theindex][1]);
    document.write('</span>');
    document.write('<br>');
  }
  else {
    document.write('<span class="content" id="node'+atree[theindex][0]+'">'+depthstr+'<img border="0" align="center" src="images/expand.gif" id="treenodeimage'+atree[theindex][0]+'"  onclick="doWrap('+atree[theindex][0]+');"><input type="checkbox"  id="ncheck'+atree[theindex][0]+'">&nbsp;');
	document.write(atree[theindex][1]);
	document.write('</span>');
	document.write('<br>');
    document.write('<span id="subnodes'+atree[theindex][0]+'" class="content" >')
	for (var i = 0; i < atree.length; i++) {
	  if (atree[i][2] == atree[theindex][0]) {
	    buildtree(i, depth + 1);
	  }
	}
    document.write('</span>');
  }
}

function buildtreepop(theindex, depth) {
  var depthstr = '';
  for (var i = 0; i < depth; i++) {
    depthstr = depthstr + '&nbsp;&nbsp;';
  }
  if (atree[theindex][3]) {
	document.write(depthstr);
	document.write('<span class="content" id="popnode'+atree[theindex][0]+'"><img border="0" align="center" src="images/leaf.gif"><input type="checkbox" id="popncheck'+atree[theindex][0]+'">&nbsp;');
	document.write(atree[theindex][1]);
    document.write('</span>');
    document.write('<br>');
  }
  else {
    document.write('<span class="content" id="popnode'+atree[theindex][0]+'">'+depthstr+'<img border="0" align="center" src="images/expand.gif" id="poptreenodeimage'+atree[theindex][0]+'"  onclick="doPopWrap('+atree[theindex][0]+');"><input type="checkbox"  id="popncheck'+atree[theindex][0]+'">&nbsp;');
	document.write(atree[theindex][1]);
	document.write('</span>');
	document.write('<br>');
    document.write('<span id="popsubnodes'+atree[theindex][0]+'" class="content" >')
	for (var i = 0; i < atree.length; i++) {
	  if (atree[i][2] == atree[theindex][0]) {
	    buildtreepop(i, depth + 1);
	  }
	}
    document.write('</span>');
  }
}

function selectallsubnodes() {
  document.getElementById('ncheck'+rightmenunodeid).checked = true;
  selectallsubnodesimpl(rightmenunodeid);
}

function selectallsubnodesimpl(rightmenunodeid1) {
  for (var i = 0; i < atree.length; i++) {
    if (atree[i][2] == rightmenunodeid1) {
	  document.getElementById('ncheck'+atree[i][0]).checked = true;
	  if (!atree[i][3])
	    selectallsubnodesimpl(atree[i][0]);
	}
  }
}

function cancelallsubnodes() {
  document.getElementById('ncheck'+rightmenunodeid).checked = false;
  cancelallsubnodesimpl(rightmenunodeid);
}

function cancelallsubnodesimpl(rightmenunodeid1) {
  for (var i = 0; i < atree.length; i++) {
    if (atree[i][2] == rightmenunodeid1) {
	  document.getElementById('ncheck'+atree[i][0]).checked = false;
	  if (!atree[i][3])
	    cancelallsubnodesimpl(atree[i][0]);
	}
  }
}

function selectsubnodes() {
  document.getElementById('ncheck'+rightmenunodeid).checked = true;
  for (var i = 0; i < atree.length; i++) {
    if (atree[i][2] == rightmenunodeid) {
	  document.getElementById('ncheck'+atree[i][0]).checked = true;
	}
  }
}

function cancelsubnodes() {
  document.getElementById('ncheck'+rightmenunodeid).checked = false;
  for (var i = 0; i < atree.length; i++) {
    if (atree[i][2] == rightmenunodeid) {
	  document.getElementById('ncheck'+atree[i][0]).checked = false;
	}
  }
}

function highlightie5() {
  if (event.srcElement.className == "menuitems") {
    event.srcElement.style.backgroundColor = "highlight";
    event.srcElement.style.color = "white";
  }
}

function lowlightie5() {
  if (event.srcElement.className == "menuitems") {
    event.srcElement.style.backgroundColor = "";
    event.srcElement.style.color = "black";
    window.status = "";
  }
}

function jumptoie5() {
  if (event.srcElement.className == "menuitems") {
    eval(event.srcElement.getAttribute("menuitemaction")+"()");
  }
}

function showmenuie5() {
  var rightedge = document.body.clientWidth-event.clientX;
  var bottomedge = document.body.clientHeight-event.clientY;
  if (rightedge < ie5menu.offsetWidth)
    ie5menu.style.left = document.body.scrollLeft + event.clientX - ie5menu.offsetWidth;
  else
    ie5menu.style.left = document.body.scrollLeft + event.clientX;
  if (bottomedge <ie5menu.offsetHeight)
    ie5menu.style.top = document.body.scrollTop + event.clientY - ie5menu.offsetHeight;
  else
    ie5menu.style.top = document.body.scrollTop + event.clientY;
  ie5menu.style.visibility = "visible";
  return false;
}

function hidemenuie5() {
  ie5menu.style.visibility = "hidden";
}

function editCourseNode(theid) {
  var rightedge = document.body.clientWidth-event.clientX;
  var bottomedge = document.body.clientHeight-event.clientY;
  if (rightedge < coursenode.offsetWidth)
    coursenode.style.left = document.body.scrollLeft + event.clientX - coursenode.offsetWidth;
  else
    coursenode.style.left = document.body.scrollLeft + event.clientX;
  if (bottomedge <ie5menu.offsetHeight)
    coursenode.style.top = document.body.scrollTop + event.clientY - coursenode.offsetHeight;
  else
    coursenode.style.top = document.body.scrollTop + event.clientY;
  coursenode.style.visibility = "visible";
  for (var i = 0; i < atree.length; i++) {
    if (atree[i][0] == theid) {
	  document.getElementById('popncheck'+atree[i][0]).checked = true;
	}
    else {
	  document.getElementById('popncheck'+atree[i][0]).checked = false;
	}
  }
}

function cancelEditCourseNode() {
  coursenode.style.visibility = "hidden";
}

function setCourseNode() {
  coursenode.style.visibility = "hidden";
}

function doViewQuestion() {
  var hhcs = document.getElementsByName("hhc");
  var selectedCount = 0;
  var qid = "";
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      selectedCount ++;
      qid = hhcs[i].value;
    }
  }

  if (selectedCount > 1) {
    alert("只能选择一个试题进行查看");
    return;
  }
  else if (selectedCount == 0) {
    alert("请选择你要查看的试题");
    return;
  }
  else {
    window.open("viewquestion.jsp?questionid="+qid,"viewquestion");
  }
}

function addAOption(theselectname, optionname, optionvalue) {
	var theselect = document.getElementById(theselectname);
	theselect.options[theselect.options.length] = new Option(optionname,optionvalue);
}


</script>

<div id="ie5menu" class="rightmenu" onmouseover="highlightie5()"
  onmouseout="lowlightie5()" onclick="jumptoie5();">
	<div class="menuitems" menuitemaction="selectallsubnodes">级联选择节点</div>
	<div class="menuitems" menuitemaction="cancelallsubnodes">级联取消节点</div>
	<hr>
	<div class="menuitems" menuitemaction="wrapallsubnodes">级联折叠</div>
	<div class="menuitems" menuitemaction="expandallsubnodes">级联展开</div>
	<hr>
	<div class="menuitems" menuitemaction="selectsubnodes">选择两层节点</div>
	<div class="menuitems" menuitemaction="cancelsubnodes">取消两层节点</div>
	<hr>
	<div class="menuitems" menuitemaction="queryquestion">查询试题</div>
</div>

<div id="coursenode" class="editcoursenode">
  <script>buildtreepop(0, 0);</script>
  <p align="center">&nbsp;<input type="button" class="bt" value="确定(O)"  accesskey="O" onclick="setCourseNode();">&nbsp;<input type="button" class="bt" value="取消(C)"  accesskey="C"  onclick="cancelEditCourseNode();"></p>
</div>

</head>
<body align="right" leftmargin="10" topmargin="0" onload="if(parent.leftframe.resetNum) parent.leftframe.resetNum('mtnum');">
<img style="display:none" src="images/closeup.gif"/>
<img style="display:none" src="images/closeup_1.gif"/>
<form style="display:none" name="form1" method="post" action="delquestioncontrol.jsp">
<input type="hidden" name="delwhat" value="">
</form>
<table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0">
  <tr height="5"><td></td></tr>
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
			          <td width="100%" class="contentwindowtitle">&nbsp;课程结构</td>
			        </tr>
					<tr height="5">
					  <td class="content" align="left" valign="center"></td>
					</tr>
					<tr height="5">
					  <td class="content" align="left" valign="center">提示：每一道试题都关联到课程树上的一个节点，<!--比如你要出某一节的练习题，可以选中课程树上该节前面的多选按钮后点击新增试题，如果你要出某一章的综合题，可以选中课程树上该章前面的多选按钮后点击新增试题。-->在节点的文字上点击鼠标右键，会有弹出式菜单出现！</td>
					</tr>
					<tr height="5">
					  <td class="content" ><hr/></td>
					</tr>
					<tr>
					  <td><div class="contentdiv" id="coursestruct"><script>buildtree(0, 0);</script></div></td>
					</tr>
					<tr height="5">
					  <td class="content" ><hr/></td>
					</tr>
					<tr height="22">
					  <td class="content">&nbsp;<input type="button" class="bt" value="查询试题(Q)"  accesskey="Q"  title="查询与所选择的节点关联的所有试题，请至少选择一个节点后再点击该按钮。" onclick="queryquestion();"></td>
					</tr>
					<tr height="5">
					  <td class="content" ></td>
					</tr>
					<tr height="22">
					  <td class="content">&nbsp;<select id="sssss" name="sssss" class="content" style="display:none"><option>在选中节点上对所有大题自动组卷</option></select><input type="button" class="bt" value="OK" title="执行"  style="display:none"></td>
					</tr>
				</table>
		      </td>
		    </tr>
			<tr height=10><td></td></tr>
		  </table>
	    </td>

		<td width=5></td>
		<td><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" >
				  <tr  height="17" >
				    <td class="contentwindowtitle" width="10">&nbsp;</td>
			        <td id="detailtitle" colspan="2" class="contentwindowtitle"><%=allselectednodes%></td>
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
								  <td  width="60">试题编号</td>
								  <td  width="70">试题结构</td>
								  <td  >试题内容</td>
								</tr>
							  </table>
						  </td>
					    </tr>
						<tr >
						  <td><div class="contentdiv">
						    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<%

if (allselectednodes == null || allselectednodes.length() == 0) {
%>
<tr  height="22" class="erow"><td colspan="4" >没有要显示的试题，请在左边的树上选择节点后再点击查询试题按钮！</td></tr>
<%
}
else {
  allselectednodes = allselectednodes.substring(1);
  allselectednodes = allselectednodes.substring(0, allselectednodes.length() - 1);
  allselectednodes = allselectednodes+",";
  int startIndex = 0;
  int commaIndex = 0;
  String nodeid = "";
  String cls = "orow";
  while (startIndex < allselectednodes.length()) {
    commaIndex = allselectednodes.indexOf(',', startIndex);
    nodeid = allselectednodes.substring(startIndex,commaIndex);
    startIndex = commaIndex + 1;
    zy.util.CsvFile csv = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                nodeid + java.io.File.separator+"q.csv");

%>
   <script>for (var k = 0; k < atree.length; k++) if (atree[k][0] == '<%=nodeid%>') {selectedNodeName = atree[k][1];
document.getElementById("ncheck<%=nodeid%>").checked=true;}selectedNodeNames+=selectedNodeName+"，";</script>
<%
    for (int i = 0; i < csv.allRecords.length; i++) {
      if (allCount % 2 == 0) cls = "orow";
      else cls = "erow";
%>
								<tr  height="22" class="<%=cls%>">
								  <td width="20"><input type="checkbox" id="hhc" name = "hhc" value="<%=csv.allRecords[i][0]%>"><input type="hidden" id="hhc1" name = "hhc1" value="<%=csv.allRecords[i][2]%>"></td>
								  <td width="60"><%=csv.allRecords[i][0]%></td>
                                                                  <td width="70"><script>document.write(qstructures[<%=csv.allRecords[i][2]%>-1]);</script></td>
								  <td ><%=csv.allRecords[i][1]%></td>
								</tr>
<%    allCount++;
    }
  }
  if (allCount == 0) {
%>
<tr  height="22" class="erow"><td colspan="7" >你所选择多节点中没有要显示的试题，请在左边的树上重新选择节点后再点击查询试题按钮！</td></tr>
<%
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
						  <td class="content" ><input type="button" class="bt" value="显示详细试题内容(E)" accesskey="E" onclick="doViewQuestion();"> </td>
						</tr>
                                                <tr height="5">
						  <td class="content" ></td>
						</tr>
                 				<tr height="22" >
						  <td class="content" ><select id="ssss" name="ssss" class="content">
						  </select><input type="button" class="bt"  accesskey="M" value="OK" onclick="parent.leftframe.ok2();"></td>
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

<script>
coursestruct.oncontextmenu = doOnContextMenu;
document.body.onclick = hidemenuie5;
if (selectedNodeNames.length == 0) {
detailtitle.innerHTML = "请选择查询节点后点击查询试题按钮！"
}
else {
selectedNodeNames = selectedNodeNames.substring(0, selectedNodeNames.length - 1);
if (selectedNodeNames.length > 20) {
  selectedNodeNames = selectedNodeNames.substring(0, 17) + "……";
}
detailtitle.innerHTML = "共有<%=allCount%>条记录。"
}
</script>
</body>
</html>