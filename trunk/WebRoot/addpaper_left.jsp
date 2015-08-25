<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}
String nowcourseid = (String)session.getAttribute("nowcourseid");
String paperid = request.getParameter("paperid");
boolean isEdit = paperid != null &&  paperid.length() != 0;
if (isEdit) {
  if (paperid.charAt(0) == '-') {
    paperid = paperid.substring(1);
    isEdit = false;
  }
}
%>
<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版&gt;&gt;教师中心&gt;&gt;新增试卷</title>

<style>
  .rhinput { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; font-family:宋体;font-size:12px;}
  .cp { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; }
</style>
<script src="css/util.js"></script>
<script src="css/css.js"></script>

<script>

var MainthemecountBefore = 0;

var onetow= new Array("一","二","三","四","五","六","七","八","九","十","十一","十二");
function deleteMt(ii) {
  if (MainthemecountBefore == 1) {
    alert("至少应该有一个大题！");
    return;
  }
  var tmp = ii.parentNode.parentNode.rowIndex;
  pstable.deleteRow(tmp);
  pstable.deleteRow(tmp);
  resetNum("mtnum");
  MainthemecountBefore --;
}

function averageMt(ii) {
  var jjjj = Math.floor(ii.parentNode.parentNode.rowIndex / 2);
  var tmp2 =  document.getElementsByName("mtscore");
  if (!(tmp2[jjjj].value * 1)) {
      alert("请在该大题的分数处输入一个整数！");
      return;
  }
  var allqscore =  document.getElementsByName("qscore");
  var mtqnums =  document.getElementsByName("mtqnum");
  var tmp =  document.getElementsByName("mtname");
  var qcount = 0;
  for (var i = 0; i < tmp.length; i++) {
    for (var j = 0; j < (mtqnums[i].value * 1); j++) {
      if (i == jjjj) {
        allqscore[qcount].value = (tmp2[jjjj].value * 1) / (mtqnums[i].value * 1);
      }
      qcount++;
    }
  }
  resetNum("mtnum");
  MainthemecountBefore --;
}

function deleteAQ(ss) {
  var themenum = Math.floor(ss.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.rowIndex / 2);
  ss.parentNode.parentNode.parentNode.deleteRow(ss.parentNode.parentNode.rowIndex);
  resetNum('mtnum1');
  var tmp =  document.getElementsByName("mtqnum");
  for (var i = 0; i < tmp.length; i++) {
    if (i == themenum) {
      tmp[i].value = (tmp[i].value*1) - 1;
    }
  }
}

function resetNum(name1) {
  var tmp =  document.getElementsByName(name1);
  if (name1 != "mtnum1") {
    parent.rightframe.ssss.options.length = 0;
    parent.rightframe.sssss.options.length = 1;
  }
  for (var i = 0; i < tmp.length; i++) {
    if (name1 == "mtnum1") {
      tmp[i].innerHTML = i + 1;
    }
    else {
      tmp[i].innerHTML = onetow[i];
	  parent.rightframe.addAOption("ssss", "将选中试题添加到第"+onetow[i]+"大题","");
	  parent.rightframe.addAOption("sssss", "在选中节点上对第"+onetow[i]+"大题自动组卷","");
    }
  }
}

function addAQ2Mt(qcode, themenum) {
  var cell = pstable.rows.item(2 * themenum + 1).cells.item(0);
  var row = cell.firstChild.insertRow(cell.firstChild.rows.length);
  cell = row.insertCell(0);
  cell.className = "content";
  cell.width = "200";
  cell.innerHTML = '&nbsp;&nbsp;第<span id="mtnum1" name="mtnum1" class="content">0</span>小题 试题编号： <span name="paperqcode" id="paperqcode" class="content">'+qcode+'</span>';
  cell = row.insertCell(1);
  cell.className = "content";
  cell.innerHTML = '&nbsp;分数：<input type="text" name="qscore" id="qscore" size="3" class="rhinput" maxlength="4">&nbsp;&nbsp;<img align="center" src="images/closeup_1.gif" class="btnohl" onmouseover="this.src=\'images/closeup.gif\';this.className=\'bthl\';" onmouseout="this.src=\'images/closeup_1.gif\';this.className=\'btnohl\';"  onmousedown="this.src=\'images/closeup.gif\';this.className=\'btnodn\';"  onclick="deleteAQ(this);">';
  resetNum("mtnum1");

  var tmp =  document.getElementsByName("mtqnum");
  for (var i = 0; i < tmp.length; i++) {
    if (i == themenum) {
      tmp[i].value = ((tmp[i].value*1) + 1);
    }
  }
}

function addMt() {
  if (MainthemecountBefore == 12) {
    alert("最多只能有十二个大题！");
    return;
  }
  var tmp = pstable.insertRow(pstable.rows.length);
  tmp.className = "trow";
  tmp.insertCell(0).innerHTML ='<input type="hidden" name="mtqnum" id="mtqnum" value ="0"/>第<span id="mtnum" name="mtnum" class="content">一</span>大题：<input  type="text" class="rhinput" size="15" value="输入大题名称" id="mtname" name="mtname" maxlength="36"/>，<select  class="rhinput" id="mtstyle"  name="mtstyle" ><option value="0">选择试题结构</option><option value="1">单项选择题</option><option value="2">多项选择题</option><option value="3">复合题</option><option value="4">连线题</option><option value="5">判断题</option><option value="6">问答题</option></select>，总分<input type="text" class="rhinput" size="3" title="输入该大题总分" id="mtscore" name="mtscore" maxlength="4"/>&nbsp;&nbsp;<img align="center" src="images/closeup_1.gif" class="btnohl" onmouseover="this.src=\'images/closeup.gif\';this.className=\'bthl\';" onmouseout="this.src=\'images/closeup_1.gif\';this.className=\'btnohl\';" onmousedown="this.src=\'images/closeup.gif\';this.className=\'btnodn\';" onclick="deleteMt(this);" title="删除大题" >'+
  '&nbsp;&nbsp;<img align="center" src="images/average_1.gif" class="btnohl" onmouseover="this.src=\'images/average.gif\';this.className=\'bthl\';" onmouseout="this.src=\'images/average_1.gif\';this.className=\'btnohl\';" onmousedown="this.src=\'images/average.gif\';this.className=\'btnodn\';" onclick="averageMt(this);" title="所有小题分数平均" >';
  tmp = pstable.insertRow(pstable.rows.length);
  tmp.className = "orow";
  tmp.insertCell(0).innerHTML ='<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0"></table>';
  resetNum("mtnum");
  MainthemecountBefore++;
}

function doOnload() {
<% if (paperid == null || paperid.length() == 0) { %>
  addMt();addMt();addMt();addMt();
<% } else { String paperdata = zy.util.CsvFile.getPaperData(nowcourseid, paperid); %>
  setPaperData('<%=paperdata%>');
<% } %>
}

function ok2() {
  var hhcs = parent.rightframe.document.getElementsByName("hhc");
  var hhc1s = parent.rightframe.document.getElementsByName("hhc1");
  var mtno = parent.rightframe.ssss.selectedIndex;
  var tmp1 =  document.getElementsByName("mtstyle");
  if (tmp1[mtno].value == '0') {
    alert("请先选择该大题的试题结构后再往里面添加试题！");
    return;
  }
  var allqcode =  document.getElementsByName("paperqcode");
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      if (hhc1s[i].value != tmp1[mtno].value) {
        alert("编号为"+hhcs[i].value+"的试题的试题结构跟大题要求的试题结构不一致，添加试题失败！");
        return;
      }
      for (var j = 0; j < allqcode.length; j++) {
        if (allqcode[j].innerHTML == hhcs[i].value) {
          alert("编号为"+hhcs[i].value+"的试题已经存在，添加试题失败！");
          return;
        }
      }
    }
  }
  for (var i = 0; i < hhcs.length; i++) {
    if (hhcs[i].checked) {
      addAQ2Mt(hhcs[i].value,mtno);
      hhcs[i].checked = false;
    }
  }
}

function getResult(valid) {
  var rs = papername.value+SAPERATE_CHAR+paperscore.value+SAPERATE_CHAR;

  if (valid) {
    if (papername.value == '' || opentime.value == '' || closetime.value == '') {
      alert("试题名称，开放时间，关闭时间不能为空");
      return false;
    }
    var opentimevalue = isDateTime(opentime.value);
    var closetimevalue = isDateTime(closetime.value);

    if (!opentimevalue || !closetimevalue) {
      alert("开放时间，关闭时间的格式不对，格式为2004-08-09 07:00");
      return false;
    }

    if (closetimevalue <= opentimevalue) {
      alert("关闭时间必须大于开始时间！");
      return false;
    }
    //if (opentimevalue*1 < new Date().getTime()) {
    //  alert("开放时间，关闭时间必须大于当前时间！");
    //  return false;
    //}
    rs += opentimevalue+SAPERATE_CHAR+closetimevalue+SAPERATE_CHAR;
  }
  else {
    rs += opentime.value+SAPERATE_CHAR+closetime.value+SAPERATE_CHAR;
  }
  var mtqnums =  document.getElementsByName("mtqnum");
  var tmp =  document.getElementsByName("mtname");
  var tmp1 =  document.getElementsByName("mtstyle");
  var tmp2 =  document.getElementsByName("mtscore");
  var allqcode =  document.getElementsByName("paperqcode");
  var allqscore =  document.getElementsByName("qscore");
  var allscore = 0;
  if (valid) {
    for (var i = 0; i < tmp1.length; i++) {
      if (tmp[i].value == '' || tmp[i].value == '输入大题名称') {
        alert("请输入大题名称！");
        return false;
      }
      if (tmp1[i].value == '0') {
        alert("请选择大题的试题结构！");
        return false;
      }
      if (tmp2[i].value == '' || !tmp2[i].value.isInt() || (tmp2[i].value*1) < 1) {
        alert("请输入大题的总分，试题总分必须为大于零的整数！");
        return false;
      }
      allscore = allscore + (tmp2[i].value * 1);

    }
    if (allscore != (paperscore.value*1)) {
        alert("所有大题的总分之和必须等于试卷总分！");
        return false;
    }
  }

  var qcount = 0;
  rs += tmp.length+SAPERATE_CHAR;
  rs += allqscore.length+SAPERATE_CHAR;
  var mtscore1 = 0;
  for (var i = 0; i < tmp.length; i++) {
    rs += tmp[i].value+SAPERATE_CHAR;
    rs += tmp1[i].value+SAPERATE_CHAR;
    rs += tmp2[i].value+SAPERATE_CHAR;
    rs += mtqnums[i].value+SAPERATE_CHAR;
    mtscore1 = 0;
    for (var j = 0; j < (mtqnums[i].value * 1); j++) {
      if (allqscore[qcount].value == '' || !(allqscore[qcount].value.isInt() || allqscore[qcount].value.isFloat()) || (allqscore[qcount].value*1) < 0) {
        alert("请输入小题的分数，小题的分数必须为大于零的数字！");
        return false;
      }
      mtscore1 = mtscore1 + allqscore[qcount].value*1;

      rs += allqcode[qcount].innerHTML+SAPERATE_CHAR+allqscore[qcount].value+SAPERATE_CHAR;
      qcount++;
    }
    if (Math.abs(mtscore1 - (tmp2[i].value*1)) > 0.001) {
        alert("大题中各小题的分数之和必须等于大题总分！");
        return false;
    }
  }
  rs = rs;
  document.form1.paperdata.value = rs;
  return true;
}

function doEnd() {
  if (!getResult(true)) {
    return;
  }
  document.form1.action = 'addpapercontrol.jsp';
  document.form1.submit();
}

function setPaperData(paperData) {
  papername.value = paperData.substring(0, paperData.indexOf(SAPERATE_CHAR));
  paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);

  setInputValue("paperscore", paperData.substring(0, paperData.indexOf(SAPERATE_CHAR)));
  paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);

  opentime.value = getDateTimeString(paperData.substring(0, paperData.indexOf(SAPERATE_CHAR))*1);
  paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);

  closetime.value = getDateTimeString(paperData.substring(0, paperData.indexOf(SAPERATE_CHAR))*1);
  paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);

  var tmpmtnum = paperData.substring(0, paperData.indexOf(SAPERATE_CHAR))*1
  paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);
  paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);
  for (var i = 0; i < tmpmtnum; i++) {
    addMt();
    var tmp =  document.getElementsByName("mtname");
    var tmp1 =  document.getElementsByName("mtstyle");
    var tmp2 =  document.getElementsByName("mtscore");
    tmp[tmp.length-1].value = paperData.substring(0, paperData.indexOf(SAPERATE_CHAR));
    paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);
    tmp1[tmp1.length-1].value = paperData.substring(0, paperData.indexOf(SAPERATE_CHAR));
    paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);
    tmp2[tmp2.length-1].value = paperData.substring(0, paperData.indexOf(SAPERATE_CHAR));
    paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);
    var tmpmtqnum = paperData.substring(0, paperData.indexOf(SAPERATE_CHAR))*1;
    paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);
    for (var j = 0; j < tmpmtqnum; j++) {
      var tmpqcode = paperData.substring(0, paperData.indexOf(SAPERATE_CHAR));
      paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);
      var tmpqscore = paperData.substring(0, paperData.indexOf(SAPERATE_CHAR));
      paperData = paperData.substring(paperData.indexOf(SAPERATE_CHAR)+1);
      addAQ2Mt (tmpqcode, i);
      var allqscore =  document.getElementsByName("qscore");
      allqscore[allqscore.length - 1].value = tmpqscore;
    }
  }
}

function doPreview() {
  getResult(false);
  document.form1.target = "preview";
  document.form1.action = "preview.jsp";
  document.form1.submit();
  document.form1.target = "";
}

</script>

</head>
<body align="right" leftmargin="10" topmargin="0" >
<img style="display:none" src="images/closeup.gif"/>
<img style="display:none" src="images/closeup_1.gif"/>
<form style="display:none" name="form1" method="post" action="">
<input type="hidden" name="paperdata" value="">
<% if (isEdit) { %>
<input type="hidden" name="paperid" value="<%=paperid%>">
<% } %>
</form>
<table height="100%" width="100%"  border="0" cellpadding="0" cellspacing="0">
  <tr height="5"><td></td></tr>
  <tr height=15><td></td></tr>
  <tr>
    <td>
      <table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0" >
	    <tr>
	      <td width="100%"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
			  <td class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				    <tr  height="17" >
			          <td width="100%" colspan="4" class="contentwindowtitle">&nbsp;试卷属性和选中试题</td>
			          </tr>
					<tr  height="25">
					  <td class="content">试卷名称&nbsp;&nbsp;<input name="papername" id="papername" type="text" class="rhinput" size="15" maxlength="30" ></td>
					  <td class="content">试卷总分&nbsp;&nbsp;<script>createTotalScoreSelect();</script></td>
					</tr>
					<tr  height="25">
					  <td class="content">开放时间&nbsp;&nbsp;<input name="opentime" id="opentime" type="text" class="rhinput" size="15" maxlength="16" value="1970-01-01 07:00"></td>
					  <td class="content">关闭时间&nbsp;&nbsp;<input name="closetime" id="closetime" type="text" class="rhinput" size="15" maxlength="16" value="3000-01-01 07:00"></td>
					</tr>
					<tr  height="25">
					  <td  colspan="4" class="content">（如果开放时间和关闭时间使用默认值，则该试卷没有时间限制，这样的试卷可以作为练习使用。）</td>
					</tr>
                                        <tr height="5">
					  <td  colspan="4" class="content"><hr/></td>
					</tr>
                                        <tr><td colspan="4" ><div class="contentdiv" id="paperstruct">
                                         <table id="pstable" height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
                                         </table>
                                         </div></td>
                                       </tr>
                                       <tr height="5">
					  <td  colspan="4" class="content"><hr/></td>
					</tr>
					<tr height="22">
					  <td colspan="4" >&nbsp;<input type="button" class="bt" value="添加大题(A)"  accesskey="A" onclick="addMt();"> <input type="button" class="bt" value="完成(S)"  accesskey="S" onclick="doEnd();">  <input type="button" class="bt" value="预览(P)"  accesskey="P" onclick="doPreview();" > <input type="button" class="bt" value="返回(X)"  accesskey="X" onclick="parent.location='testpapers.jsp';">
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
    <td align="center" class="copyright" bgcolor=#101045>&nbsp;</td>
  </tr>
</table>
</body>
</html>