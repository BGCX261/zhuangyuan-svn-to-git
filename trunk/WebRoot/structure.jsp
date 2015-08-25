<%@page contentType="text/html;charset=UTF-8"%>
<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
String nowcourseid = (String)session.getAttribute("nowcourseid");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心>>课程结构管理</title>
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
.rhinput {
	BORDER-RIGHT: #C4DEF7 1px solid;
	BORDER-TOP: #C4DEF7 1px solid;
	BORDER-LEFT: #C4DEF7 1px solid;
	BORDER-BOTTOM: #C4DEF7 1px solid;
}
</style>
<script src="css/util.js"></script>
<script src="css/css.js"></script>
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

  qcode.value = qcode.value.replace(/(^[\s,\t]*)|([\s,\t]*$)/g, "")
  qcontent.value = qcontent.value.replace(/(^[\s,\t]*)|([\s,\t]*$)/g, "")

  var tmp = "";
  if (qcode.value != "") tmp += "&qcode="+httpAddrEncode(qcode.value);
  if (qcontent.value != "") tmp += "&qcontent="+httpAddrEncode(qcontent.value);
  if (qstructure.value != "") tmp += "&qstructure="+qstructure.value;
  if (qstarttime.value != "") {
    var opentimevalue = isDate(qstarttime.value);
    if (!opentimevalue) {
      alert("创建时间的格式不对，格式为2004-08-09");
      return false;
    }
    tmp += "&qstarttime="+opentimevalue;
  }
  if (qendtime.value != "") {
    var closetimevalue = isDate(qendtime.value);
    if (!closetimevalue) {
      alert("创建时间的格式不对，格式为2004-08-09");
      return false;
    }
    tmp += "&qendtime="+closetimevalue;
  }
  location = "testquestions.jsp?allselectednodes="+allSelectedNodes+tmp;
}

function addquestion() {
  var allSelectedNodes = "", allSelectedNodesCount = 0;
  for (var i = 0; i < atree.length; i++) {
    if (document.getElementById("ncheck"+atree[i][0]).checked) {
	  allSelectedNodesCount++;
	  if (allSelectedNodesCount > 1) {
	    alert("只能选择一个节点！");
            return;
	  }
	  allSelectedNodes += atree[i][0];
	}
  }
  if (allSelectedNodesCount == 0) {
    alert("请选择一个节点后再点击新增试题按钮！");
    return;
  }
  location = "addquestion.jsp?nodeid="+allSelectedNodes;
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
  var result = "";
  var depthstr = '';
  for (var i = 0; i < depth; i++) {
    depthstr = depthstr + '&nbsp;&nbsp;';
  }
  if (atree[theindex][3]) {
	result += depthstr;
	result += '<span class="content" id="node'+atree[theindex][0]+'"><img border="0" align="center" src="images/leaf.gif"><input type="checkbox" id="ncheck'+atree[theindex][0]+'">&nbsp;';
	result += atree[theindex][1];
        result += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="bt" value="添加子节点" onclick="addNew('+atree[theindex][0]+')"> <input type="button" class="bt" value="修改该节点" onclick="modify('+atree[theindex][0]+')"> <input type="button" class="bt" value="删除该节点" onclick="deleteNode('+atree[theindex][0]+')"></span>';
        result += '<br>';
  }
  else {
    	result += '<span class="content" id="node'+atree[theindex][0]+'">'+depthstr+'<img border="0" align="center" src="images/expand.gif" id="treenodeimage'+atree[theindex][0]+'"  onclick="doWrap('+atree[theindex][0]+');"><input type="checkbox"  id="ncheck'+atree[theindex][0]+'">&nbsp;';
	result += atree[theindex][1];
	result += '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="bt" value="添加子节点" onclick="addNew('+atree[theindex][0]+')"> <input type="button" class="bt" value="修改该节点" onclick="modify('+atree[theindex][0]+')"> <input type="button" class="bt" value="删除该节点" onclick="deleteNode('+atree[theindex][0]+')"></span>';
	result += '<br>';
    	result += '<span id="subnodes'+atree[theindex][0]+'" class="content" >';
	for (var i = 0; i < atree.length; i++) {
	  if (atree[i][2] == atree[theindex][0]) {
	    result += buildtree(i, depth + 1);
	  }
	}
    	result += '</span>';
  }
  return result;
}

function addNew(nid) {
    var aa = prompt("请输入节点的名称，例如：\n第一章 唯物辩证法的基本范畴","");
    var maxid = 0;
    for (var i = 0; i < atree.length; i++) {
        if (atree[i][0] > maxid) maxid = atree[i][0];
    }
    if (aa != null) {
	if (aa == "") {
            alert("节点名称不能为空！");
	}
	else {
            var bb = null;
            var subnodecount = 0;
            for (var i = 0; i < atree.length; i++) {
                if (atree[i][0] == nid) bb = atree[i];
                if (atree[i][2] == nid) subnodecount ++;
            }
            atree[atree.length] = new Array(maxid+1, aa, nid, true, bb[4]+"."+(subnodecount+1));
	}
    }
    for (var i = 0; i < atree.length; i++) {
            for (var j = 0; j < atree.length; j++) {
              if (atree[j][2] == atree[i][0]) {
                    atree[i][3] = false;
                    break;
              }
            }
    }
    coursestruct.innerHTML = buildtree(0,0);
    document.form1.ss.value = maxid+1;
    doSave();
}

function modify(nid) {
    var bb = null;
    var subnodecount = 0;
    for (var i = 0; i < atree.length; i++) {
        if (atree[i][0] == nid) bb = atree[i];
        if (atree[i][2] == nid) subnodecount ++;
    }
    var aa = prompt("请输入节点的名称，例如：\n第一章 唯物辩证法的基本范畴",bb[1]);
    if (aa != null) {
	if (aa == "") {
            alert("节点名称不能为空！");
	}
	else {
            bb[1]=aa;
	}
    }
    coursestruct.innerHTML = buildtree(0,0);
    doSave();
}

function deleteNode(nid) {
    if (!confirm("删除该节点将会删除该节点以及该节点下的所有子节点，你确定要这么做吗？")) {
	return;
    }
    deleteNode1(nid);
    var ss = new Array();
    for (var i = 0; i < atree.length; i++) {
        if (atree[i][0] != -1) ss[ss.length] = atree[i];
    }
    atree = ss;
    for (var i = 0; i < atree.length; i++) {
            for (var j = 0; j < atree.length; j++) {
              if (atree[j][2] == atree[i][0]) {
                    atree[i][3] = false;
                    break;
              }
        }
    }
    coursestruct.innerHTML = buildtree(0,0);
    doSave();
}

function deleteNode1(nid) {
    for (var i = 0; i < atree.length; i++) {
        if (atree[i][0] == nid) atree[i][0] = -1;atree[i][3] = true;
        if (atree[i][2] == nid) deleteNode1(atree[i][0]);
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

function doEditQuestion() {
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
    alert("只能选择一个试题进行编辑");
    return;
  }
  else if (selectedCount == 0) {
    alert("请选择你要编辑的试题");
    return;
  }
  else {
    location = "addquestion.jsp?nodeid="+qid.substring(qid.indexOf("_")+1,qid.lastIndexOf("_"))+"&questionid="+qid;
  }
}

function doEditQuestion1() {
  var allSelectedNodes = "", allSelectedNodesCount = 0;
  for (var i = 0; i < atree.length; i++) {
    if (document.getElementById("ncheck"+atree[i][0]).checked) {
	  allSelectedNodesCount++;
	  if (allSelectedNodesCount > 1) {
	    alert("左边的树上只能选择一个节点！");
            return;
	  }
	  allSelectedNodes += atree[i][0];
	}
  }
  if (allSelectedNodesCount == 0) {
    alert("请在左边的树上选择一个节点后再点击该按钮！");
    return;
  }

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
    alert("只能选择一个试题进行作为模板");
    return;
  }
  else if (selectedCount == 0) {
    alert("请选择你要作为模板的试题");
    return;
  }
  else {
    location = "addquestion.jsp?new=Y&newnodeid="+allSelectedNodes+"&nodeid="+qid.substring(qid.indexOf("_")+1,qid.lastIndexOf("_"))+"&questionid="+qid;
  }
}


function doDelQuestion() {
  var hhcs = document.getElementsByName("hhc");
  var qid = "";
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      qid += hhcs[i].value+SAPERATE_CHAR;
    }
  }
  if (qid == "") {
    alert("请选择要删除的试题！");
    return;
  }
  document.form1.delwhat.value = qid;
  document.form1.submit();
}

function doSave() {
   var sss = "var atree = new Array( ";
    for (var i = 0; i < atree.length; i++) {
        if (i != 0) sss += ",";
        sss += 'new Array('+atree[i][0]+',"'+atree[i][1]+'",'+atree[i][2]+','+atree[i][3]+',"'+atree[i][4]+'")';
    }
    sss += ");";
    document.form1.cs1.value=sss;
document.form1.submit();
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
</div>

<div id="coursenode" class="editcoursenode">
  <script>buildtreepop(0, 0);</script>
  <p align="center">&nbsp;<input type="button" class="bt" value="确定(O)"  accesskey="O" onclick="setCourseNode();">&nbsp;<input type="button" class="bt" value="取消(C)"  accesskey="C"  onclick="cancelEditCourseNode();"></p>
</div>

</head>
<body align=right leftmargin=10 topmargin=0>
<form name="form1" style="display:none" method="post" action="st.jsp">
<input type="hidden" name="cs1" value="">
<input type="hidden" name="ss" value="">
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
		    <tr height=15><td class="pagetitleright" colspan=25 align=right valign=bottom>当前位置 教师中心>>题库管理&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:location='logoutcontrol.jsp';void 0;" class="tlink" accessKey='O'>&nbsp;退出登录&nbsp;</a>|<a  href='1/zyhelp.htm' class="tlink" accessKey='E' target="help">&nbsp;帮助&nbsp;</a> </td></tr>
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
			  <td class="contentwindow">
				<table  height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				    <tr  height="17" >
			          <td width="100%" class="contentwindowtitle">&nbsp;课程结构</td>
			        </tr>
					<tr height="5">
					  <td class="content" align="left" valign="center"></td>
					</tr>
					<tr height="5">
					  <td class="content" align="left" valign="center">提示：你可以在这里编辑课程的结构，实际上就是章节关系。这是建立试题库的前提，因为每一道试题都关联到课程树上的一个节点，比如你要出某一节的练习题，可以选中课程树上该节前面的多选按钮后点击新增试题，如果你要出某一章的综合题，可以选中课程树上该章前面的多选按钮后点击新增试题。</td>
					</tr>
					<tr height="5">
					  <td class="content" ><hr/></td>
					</tr>
					<tr>
					  <td><div class="contentdiv" id="coursestruct"><script>document.write(buildtree(0, 0));</script></div></td>
					</tr>
					<tr height="5">
					  <td class="content" ><hr/></td>
					</tr>
					<tr height="22" align="center">
					  <td>
						&nbsp;<input type="button" class="bt" value="返回(R)"  accesskey="R"  title="返回到教师首页。" onclick="location='teacherindex.jsp';">
						<!--&nbsp;<input type="button" class="bt" value="保存(S)"  accesskey="S"  title="保存。" onclick="">
						&nbsp;<input type="button" class="bt" value="批量删除(B)"  accesskey="B"  title="批量删除。" onclick="">-->
                                           </td>
					</tr>
				</table>
		      </td>
		    </tr>
			<tr height=10><td></td></tr>
		  </table>
	    </td>
	  </tr>
    </table>
  </td>
  </tr>
  <tr height="10">
    <!--<td align="center" class="copyright" bgcolor=#101045>CopyRight &copy; 2004 RenHe Software Corperation All Rights Reserved.2004 人和软件有限公司. 保留所有权利</td>-->
    <td align="center" class="copyright" bgcolor=#101045> <a href="about.jsp" target="about">关于我们</a> <a href="copyright.jsp"  target="copyright">版权申明</a> <a href="noguilty.jsp"  target="noguilty">免责声明</a></td>
  </tr>
</table>
</body>
</html>