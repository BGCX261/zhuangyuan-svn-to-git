<%@page contentType="text/html;charset=UTF-8"%>

<%
String username = (String)session.getAttribute("username");
String usertype = (String)session.getAttribute("usertype");
if (username == null || !usertype.equals("1")) {
  response.sendRedirect("error.html?message=2");
}

String allselectednodes = (String)session.getAttribute("allselect");
if (allselectednodes ==  null) {allselectednodes = "";}
String isNew = (String)request.getParameter("new");
String nowcourseid = (String)session.getAttribute("nowcourseid");
String questionid = request.getParameter("questionid");
String qqqqid = questionid == null ? "" : questionid;
if (isNew != null) {
  qqqqid = "";
}
String qnodeid = request.getParameter("nodeid");
String newqnodeid = request.getParameter("newnodeid");
if (newqnodeid == null) newqnodeid = qnodeid;
String qcontent = "";
String qanswer = "";
String qdifficulty = "";
String qsubcount = "";
String issubjective = "";
String qstructure = "";
if (questionid != null) {
  zy.util.CsvFile csv1 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                 qnodeid + java.io.File.separator+""+questionid+".1");
  qcontent =  csv1.allRecords[0][0].substring(0, csv1.allRecords[0][0].indexOf("<yzq/>答"));

  csv1 = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                 qnodeid + java.io.File.separator+""+questionid+".3");
  qanswer =  csv1.allRecords[0][0];
  zy.util.CsvFile csvq = zy.util.CsvFile.getACsvFile(zy.util.CsvFile.MOTHER_PATH + java.io.File.separator+"c"+java.io.File.separator + nowcourseid + java.io.File.separator+"" +
                                 qnodeid + java.io.File.separator+"q.csv");
  for (int i = 0; i < csvq.allRecords.length; i++) {
    if (csvq.allRecords[i][0].equals(questionid)) {
      qstructure = csvq.allRecords[i][2];
      qdifficulty = csvq.allRecords[i][3];
      qsubcount = csvq.allRecords[i][6];
      issubjective = csvq.allRecords[i][7];
      break;
    }
  }
}
else {
  questionid = "";
}
%>

<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>教师中心>>试题管理</title>
<style>
  .rhinput { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; font-family:宋体;font-size:12px;}
  .cp { BORDER-RIGHT: #C4DEF7 1px solid; BORDER-TOP: #C4DEF7 1px solid; BORDER-LEFT: #C4DEF7 1px solid; BORDER-BOTTOM: #C4DEF7 1px solid; }
</style>

<script src="css/css.js"></script>
<script src="css/util.js"></script>
<script>
var fileUploadCount = 0;
var theSelection;
var nowStyle = 0;
var styleAnswerPanel = new Array();
var qid = "<%=questionid%>";

var allentries = new Array(161,162,163,164,165,166,167,168,169,170,171,172,174,175,176,177,178,179,180,181,182,183,184,185,186,187,
188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,
219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,
250,251,252,253,254,255,338,339,352,353,376,402,710,732,913,914,915,916,917,918,919,920,921,922,923,924,925,926,927,928,929,
931,932,933,934,935,936,937,945,946,947,948,949,950,951,952,953,954,955,956,957,958,959,960,961,962,963,964,965,966,967,968,
969,977,978,982,8194,8195,8201,8204,8205,8211,8212,8216,8217,8218,8220,8221,8222,8224,8225,8226,8230,8240,8242,
8243,8249,8250,8254,8260,8364,8465,8472,8476,8482,8501,8592,8593,8594,8595,8596,8629,8656,8657,8658,8659,8660,8704,8706,
8707,8709,8711,8712,8713,8715,8719,8721,8722,8727,8730,8733,8734,8736,8743,8744,8745,8746,8747,8756,8764,8773,8776,8800,
8801,8804,8805,8834,8835,8836,8838,8839,8853,8855,8869,8901,8968,8969,8970,8971,9001,9002,9674,9824,9827,9829,9830);

var formula = new Array(
'f2_1','垂直分式','<table border="0" cellpadding="0" cellspacing="0"><tr><td class="fp" style="font-size:12px">&nbsp;</td></tr><tr><td  style="font-family:宋体;font-size:6px;"><img width="100%" height="8" src="images/f_line.gif"></td></tr><tr><td  class="fp" style="font-size:12px">&nbsp;</td></tr></table>',

'f2_5','斜线分式','<table border="0" cellpadding="0" cellspacing="0"><tr><td class="fp" style="font-size:12px">&nbsp;</td><td width="7" height="23"><img width="7" height="100%" src="images/f_sqrt_2.gif"></td><td class="fp" style="font-size:12px">&nbsp;</td></tr></table>',

'f2_6','平方根','<table border="0" cellpadding="0" cellspacing="0"><tr><td height="100%" width="15" rowspan="2"><img  height="100%" width="15" src="images/f_sqrt.gif"></td><td style="BORDER-TOP: black 2px solid;font-family:宋体;font-size:6px;">&nbsp;</td></tr><tr> <td class="fp" style="font-size:12px">&nbsp;</td></tr></table>',

'f2_7','N次根','<table border="0" cellpadding="0" cellspacing="0"><tr><td height="1"></td><td height="100%" width="7" rowspan="3"><img  height="100%" width="7" src="images/f_sqrt_2.gif"></td><td style="BORDER-TOP: black 2px solid;font-family:宋体;font-size:1px;">&nbsp;</td></tr><tr><td height="15" class="fp" style="font-size:12px">&nbsp;</td><td rowspan="2"  class="fp" style="font-size:12px">&nbsp;</td></tr><tr><td height="10"><img width="100%" height="100%" src="images/f_sqrt_1.gif"></td></tr></table>',

'f2_8','除法','<table border="0" cellpadding="0" cellspacing="0"><tr><td height="100%" width="6" rowspan="2"><img  height="100%" width="6" src="images/f_div.gif"></td><td style="BORDER-TOP: black 2px solid;font-family:宋体;font-size:6px;">&nbsp;</td></tr><tr> <td class="fp" style="font-size:12px">&nbsp;</td></tr></table>',

'f2_9','代商除法','<table border="0" cellpadding="0" cellspacing="0"><tr><td></td><td class="fp" style="font-size:12px">&nbsp;</td></tr><tr><td height="100%" width="6" rowspan="2"><img  height="100%" width="6" src="images/f_div.gif"></td><td style="BORDER-TOP: black 2px solid;font-family:宋体;font-size:6px;">&nbsp;</td></tr><tr> <td class="fp" style="font-size:12px">&nbsp;</td></tr></table>',

'f3_3',	'右上下标',	'<table border="0" cellpadding="0" cellspacing="0"><tr><td  height="100%" rowspan="3" class="fp" style="font-size:25px">&nbsp;</td><td  height="100%"  class="fp" style="font-size:8px">&nbsp;</td></tr><tr><td>&nbsp;</td></tr><tr><td  height="100%"  class="fp" style="font-size:8px">&nbsp;</td></tr></table>',

'f3_6',	'左上下标',	'<table border="0" cellpadding="0" cellspacing="0"><tr><td  height="100%"  class="fp" style="font-size:8px">&nbsp;</td><td  height="100%" rowspan="3" class="fp" style="font-size:25px">&nbsp;</td></tr><tr><td>&nbsp;</td></tr><tr><td  height="100%"  class="fp" style="font-size:8px">&nbsp;</td></tr></table>',

'f3_7',	'顶标',	'<table border="0" cellpadding="0" cellspacing="0"><tr><td  height="100%"  class="fp" style="font-size:8px">&nbsp;</td></tr><tr><td  height="100%" class="fp" style="font-size:25px">&nbsp;</td></tr></table>',

'f3_8',	'底标',	'<table border="0" cellpadding="0" cellspacing="0"><tr><td  height="100%" class="fp" style="font-size:25px">&nbsp;</td></tr><tr><td  height="100%"  class="fp" style="font-size:8px">&nbsp;</td></tr></table>',

'f3_9',	'顶底标',	'<table border="0" cellpadding="0" cellspacing="0"><tr><td  height="100%"  class="fp" style="font-size:8px">&nbsp;</td></tr><tr><td  height="100%" class="fp" style="font-size:25px">&nbsp;</td></tr><tr><td  height="100%"  class="fp" style="font-size:8px">&nbsp;</td></tr></table>',

'f4_1',	'无极限求和',	'<table border="0" cellpadding="0" cellspacing="0"><tr><td  height="25"><img height="100%" width="17"  src="images/f_sum.gif"></td><td  class="fp" style="font-size:18px">&nbsp;</td></tr></table>',

'f4_2',	'底标极限求和',	'<table border="0" cellpadding="0" cellspacing="0"><tr><td  height="25"><img height="100%" width="100%"  src="images/f_sum.gif"></td><td  class="fp" style="font-size:18px">&nbsp;</td></tr><tr><td  class="fp" style="font-size:10px">&nbsp;</td><td></td></tr></table>',

'f4_3',	'顶标底标极限求和',	'<table border="0" cellpadding="0" cellspacing="0"></tr><tr><td  class="fp" style="font-size:10px">&nbsp;</td><td></td></tr><tr><td  height="25" ><img height="100%" width="100%"  src="images/f_sum.gif"></td><td  class="fp" style="font-size:18px">&nbsp;</td></tr><tr><td  class="fp" style="font-size:10px">&nbsp;</td><td></td></tr></table>',

'f4_4',	'下标极限求和',	'<table border="0" cellpadding="0" cellspacing="0"><tr><td  height="25"><img height="100%" width="17"  src="images/f_sum.gif"></td><td  class="fp" style="font-size:18px">&nbsp;</td></tr><tr><td></td><td  class="fp" style="font-size:10px">&nbsp;</td></tr></table>',

'f4_5',	'上标下标极限求和',	'<table border="0" cellpadding="0" cellspacing="0"></tr><tr></td><td><td  class="fp" style="font-size:10px">&nbsp;</td><td></td></tr><tr><td  height="25"><img height="100%" width="17"  src="images/f_sum.gif"></td><td  class="fp" style="font-size:18px">&nbsp;</td></tr><tr></td><td><td  class="fp" style="font-size:10px">&nbsp;</td></tr></table>'

//'f7_1',	'充分条件',	'&nbsp;',
//'f7_2',	'必要条件',	'&nbsp;',
//'f7_3',	'充要条件',	'&nbsp;'
);

var temps = new Array(null,
new Array('<p>单项选择题是一种从多个（本系统规定是两到七个）备选项中选择答案的试题结构，只有一个答案是正确的。请在此处输入单项选择题题干（在输入的时候，你可以使用上面的工具栏上的功能，将鼠标停留在工具栏上的某一个按钮上一段时间，会显示该按钮的提示信息）……</p><p>A 请在此处输入单项选择题第一个备选项的内容……</p><p>B&nbsp;请在此处输入单项选择题第二个备选项的内容……</p><p>C&nbsp;请在此处输入单项选择题第三个备选项的内容……</p><p>D&nbsp;请在此处输入单项选择题第四个备选项的内容，如果你还有更多的备选项，请按照这样的方式继续输入……</p>',
4, 'A','N','3'),
new Array(
'<p>多项选择题是一种从多个（本系统规定是两到七个）备选项中选择答案的试题结构，有一个或者多个答案是正确的。本系统中我们规定，只有全部选对方能得分。请在此处输入多项选择题题干（在输入的时候，你可以使用上面的工具栏上的功能，将鼠标停留在工具栏上的某一个按钮上一段时间，会显示该按钮的提示信息）……</p><p>A 请在此处输入多项选择题第一个备选项的内容……</p><p>B&nbsp;请在此处输入多项选择题第二个备选项的内容……</p><p>C&nbsp;请在此处输入多项选择题第三个备选项的内容……</p><p>D&nbsp;请在此处输入多项选择题第四个备选项的内容，如果你还有更多的备选项，请按照这样的方式继续输入……</p>',
4, 'AB','N','3'),
new Array(
'<p>请在此处输入复合题的内容，复合题是一种应用广泛的试题结构，比如填空题，听力题，阅读理解题等等，这些题目的共同特点是在同一份内容下面有多个问题需要回答，如果是填空题，空格的地方请用下划线表示，并在其中标以数字。例如：</p><p>中国的四大发明按照年代先后分别是_____(1)______，_____(2)______，_____(3)______，_____(4)______。</p><p>对于象听力题，阅读理解题这样的题型，请按照如下结构出题：</p><p>这里输入试题的主题干。</p><p>1. 这里输入第一小题的题干</p><p>A 这里输入第一小题第一个选项的内容</p><p>B 这里输入第一小题第二个选项的内容</p><p>C 这里输入第一小题第三个选项的内容</p><p>D 这里输入第一小题第四个选项的内容</p><p>1. 这里输入第二小题的题干</p><p>A 这里输入第二小题第一个选项的内容</p><p>B 这里输入第二小题第二个选项的内容</p><p>C 这里输入第二小题第三个选项的内容</p><p>D 这里输入第二小题第四个选项的内容</p><p>……</p>',
3, '```','N','3'),
new Array(
'连线题是将左右选项进行配对的一种试题结构，本系统中连线题的判分方法是连错一个不得分。请在这里输入连线题的主题干<p><table cellSpacing="0" cellPadding="0" bgColor="white" border="0">  <tbody>    <tr>      <td class="tp0_lt" vAlign="center">A         请在这里输入连线题第一个左选项&nbsp;</td>      <td class="tp0_t" vAlign="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>      <td class="tp0_t" vAlign="center">&nbsp;a&nbsp;请在这里输入连线题第一个右选项</td>    </tr>    <tr>      <td class="tp0_l" vAlign="center">B&nbsp;请在这里输入连线题第二个左选项</td>      <td class="tp0" vAlign="center">&nbsp;</td>      <td class="tp0" vAlign="center">&nbsp;b&nbsp;请在这里输入连线题第二个右选项</td>    </tr>    <tr>      <td class="tp0_l" vAlign="center">C&nbsp;请在这里输入连线题第三个左选项</td>      <td class="tp0" vAlign="center">&nbsp;</td>      <td class="tp0" vAlign="center">&nbsp;c&nbsp;请在这里输入连线题第三个右选项</td>    </tr>    <tr>      <td class="tp0_l" vAlign="center">D&nbsp;请在这里输入连线题第四个左选项，如果还有更多选项，请照此方式继续输入</td>      <td class="tp0" vAlign="center">&nbsp;</td>      <td class="tp0" vAlign="center">&nbsp;d&nbsp;请在这里输入连线题第四个右选项，如果还有更多选项，请照此方式继续输入</td>    </tr>  </tbody></table></p>',
4, 'a`b`c`d`','N','3'),
new Array(
'判断题是一种判断论断是否正确的试题结构。请在此处输入判断题的题干！',2,'N','N','3'),
new Array(
'问答题是一种一问一答形式的试题结构。请在此处输入问答题的题干，如果你的问答题的答案不是纯文本，可以以插入批注的形式在这里输入答案。',1,'请在这里输入问答题的参考答案','Y','3')
);

var dd;
function previewDocument() {
  dd = open("preview.html");
  setTimeout("dd.document.body.innerHTML = composition.document.body.innerHTML;",1000);
}

function changeStyle(theStyle) {
  if (nowStyle == theStyle) return;
  nowStyle = theStyle;
  setTheTemplate(theStyle,temps[theStyle][0],temps[theStyle][1],temps[theStyle][2],temps[theStyle][3],temps[theStyle][4]);
}

function setCourseActive(courseid) {
  alert('setCourseActive');
}

function hlbutton(bt) {
  for (var name in bt) alert(name);
}
function popupdialog(dg) {
  if ( dg.style.display == "none"){
    dg.style.left = event.x + 10;
    dg.style.top = event.y + 12;
    dg.style.display = "" ;
    theSelection = composition.document.selection.createRange();
  }
  else {
    dg.style.display = "none";
  }
}
function doCreateTable() {
  var number = '1234567890';
  var a1 = tablerow.value,a2=tablecol.value;
  if (a1.length == 0) {
    alert('请输入行数！');
return;
  }
  if (a2.length == 0) {
    alert('请输入列数！');
return;
  }
  for (var i = 0; i < a1.length; i++) {
    if (number.indexOf(a1.charAt(i)) < 0) {
alert('行数为数字！');
return;
}
  }
  for (var i = 0; i < a2.length; i++) {
    if (number.indexOf(a2.charAt(i)) < 0) {
alert('列数为数字！');
return;
}
  }
  if (a1 * 1 == 0) {
    alert('行数不能等于零！');
return;
  }
  if (a2 * 1 == 0) {
    alert('列数不能等于零！');
return;
  }
  hidedialog(rowcoldialog);

  var row = a1 * 1, col = a2 * 1;
  var string;
  string="<table border='0' bgcolor="+"white"+" cellspacing='0' cellpadding='0'>";
  for(var i=1;i<=row;i++){
    string=string+"<tr>";
    for(var j=1;j<=col;j++){
	if (iftborder.checked) {
	  if (i == 1 && j == 1)
      string=string+"<td valign='center' class='tp_lt'>&nbsp;</td>";
 	  else if ( j == 1)
     string=string+"<td valign='center' class='tp_l'>&nbsp;</td>";
 	  else if ( i == 1)
     string=string+"<td valign='center' class='tp_t'>&nbsp;</td>";
	 else
     string=string+"<td valign='center' class='tp'>&nbsp;</td>";
    }
	else {
	  if (i == 1 && j == 1)
      string=string+"<td valign='center' class='tp0_lt'>&nbsp;</td>";
 	  else if ( j == 1)
     string=string+"<td valign='center' class='tp0_l'>&nbsp;</td>";
 	  else if ( i == 1)
     string=string+"<td valign='center' class='tp0_t'>&nbsp;</td>";
	 else
     string=string+"<td valign='center' class='tp0'>&nbsp;</td>";
	}
	}
    string=string+"</tr>";
  }
  string=string+"</table>";
  composition.focus();
  theSelection.pasteHTML(string);
  theSelection.select();
}

function addComment() {
  theSelection = composition.document.selection.createRange();
  string="<table border='0' bgcolor="+"white"+" cellspacing='0' cellpadding='0'>";
  string=string+"<tr>";
  string=string+"<td valign='center' class='cm'>请在这里输入批注的内容，批注的内容在教师查看试卷以及学生做题时不显示，在对照答案时显示！</td>";
  string=string+"</tr>";
  string=string+"</table>";
  composition.focus();
  theSelection.pasteHTML(string);
  theSelection.select();
}
function pasteText() {
  theSelection = composition.document.selection.createRange();
  string=window.clipboardData.getData("Text");
  composition.focus();
  theSelection.pasteHTML(encode(string));
  theSelection.select();
}

function hidedialog(dg) {
  dg.style.display = "none" ;
}
function createSymbols() {
  var count = 0;
  var cc = 0;
  for (var j = 0; j < allentries.length; j++) {
  if (count % 8 == 0){
    document.write("<tr height='25'>");
    document.write("<td>&nbsp;");
    document.write("</td>");
    cc = 0;
  }
  document.write("<td>");
  document.write("<input class='bt1' type='button' value='&#"+allentries[j]+";' onclick='doAddSymbol(this.value);'>");
  document.write("</td>");
  if (count % 8 == 7) {
    document.write("</tr>");
  }
  count++;
  cc++;
  }

  if (cc != 8) {
    document.write("<td colspan="+(cc - 8) + "></td>");
    document.write("</tr>");
  }
}

function doAddSymbol(val) {
    composition.focus();
    theSelection.pasteHTML(val);
    theSelection.select();
	hidedialog(symboldialog)
}

function addFormula(idx) {
  composition.focus();
  theSelection.pasteHTML(formula[3*idx+2]);
  theSelection.select();
  hidedialog(formuladialog)
}

function createFormulas() {
  var count = 0;
  var cc = 0;
  for (var j = 0; j < formula.length / 3; j++) {
  if (count % 10 == 0){
    document.write("<tr height='25'>");
    document.write("<td>&nbsp;");
    document.write("</td>");
    cc = 0;
  }
  document.write("<td>");
  document.write('<img align="center" src="images/'+formula[3 * j]+'_1.gif" class="btnohl" onmouseover="this.src=\'images/'+formula[3 * j]+'.gif\';this.className=\'bthl\';" onmouseout="this.src=\'images/'+formula[3 * j]+'_1.gif\';this.className=\'btnohl\';" onmousedown="this.src=\'images/'+formula[3 * j]+'.gif\';this.className=\'btnodn\';"   title="'+formula[3 * j+1]+'" onclick="addFormula('+j+');">');
  document.write("</td>");
  if (count % 10 == 9) {
    document.write("</tr>");
  }
  count++;
  cc++;
  }

  if (cc != 10) {
    document.write("<td colspan="+(cc - 8) + "></td>");
    document.write("</tr>");
  }
}

function doAddFile() {
  theSelection = composition.document.selection.createRange();
  var a = "eoslinkupload"+(Math.round(Math.random()*100000));
  fileUploadCount ++;
  var b = document.createElement("INPUT");
  b.setAttribute("type","file");
  b.setAttribute("name",a);
  b.setAttribute("id",a);
  b.style.display="none";
  document.form1.appendChild(b);
  document.form1.elements[document.form1.elements.length - 1].style.visibility = "hidden";
  document.form1.elements[document.form1.elements.length - 1].click();
  previewLink(document.form1.elements[document.form1.elements.length - 1].value)
}

function endWith(bb,aa) {
        bb = bb.toLowerCase();
        aa = aa.toLowerCase();
	if (bb.lastIndexOf(aa) >= 0)
	{
		return bb.lastIndexOf(aa) == (bb.length - aa.length);
	}
	else {
		return false;
	}
}

function cleanServerAddr() {
  var durl = document.URL, serveraddr;
  if (durl.indexOf('http://') != 0) {
    return;
  }
  var endindex = durl.indexOf('/',7);
  if (endindex <= 0) {
    return;
  }

  serveraddr = durl.substring(0, endindex);
  var theimages = composition.document.images;
  for (var i = 0; i <  theimages.length; i++) {
     if ( theimages[i].src.indexOf(serveraddr) == 0) {
       theimages[i].src = theimages[i].src.substring(endindex);
     }
  }
  var thelinks = composition.document.links;
  for (var i = 0; i <  thelinks.length; i++) {
     if ( thelinks[i].href.indexOf(serveraddr) == 0) {
       thelinks[i].href = thelinks[i].href.substring(endindex);
     }
  }
}


function addAFile(addr,thename) {
  composition.focus();
  theSelection = composition.document.selection.createRange();
  if (endWith(thename,".gif")
     || endWith(thename,".jpg")
     || endWith(thename,".jpeg")
     || endWith(thename,".bmp")
     || endWith(thename,".png")
     || endWith(thename,".ico")) {
    theSelection.pasteHTML("<img border=\"0\" src=\""+addr+"\">");
    theSelection.select();
    theSelection = null;
  }
  //else if (endWith(thename,".swf")) {
  //  theSelection.pasteHTML("<object classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0\" >  <param name=\"flash_component\" value=\"ImageViewer.swc\">  <param name=\"movie\" value=\""+thename+"\">  <param name=\"quality\" value=\"high\">  <param name=\"FlashVars\" value=\"flashlet={imageLinkTarget:'_blank',captionFont:'Verdana',titleFont:'Verdana',showControls:true,frameShow:false,slideDelay:5,captionSize:10,captionColor:#333333,titleSize:10,transitionsType:'Random',titleColor:#333333,slideAutoPlay:false,imageURLs:['img1.jpg','img2.jpg','img3.jpg'],slideLoop:false,frameThickness:2,imageLinks:['http://macromedia.com/','http://macromedia.com/','http://macromedia.com/'],frameColor:#333333,bgColor:#FFFFFF,imageCaptions:[]}\">  <embed src=\""+thename+"\" quality=\"high\" flashvars=\"flashlet={imageLinkTarget:'_blank',captionFont:'Verdana',titleFont:'Verdana',showControls:true,frameShow:false,slideDelay:5,captionSize:10,captionColor:#333333,titleSize:10,transitionsType:'Random',titleColor:#333333,slideAutoPlay:false,imageURLs:['img1.jpg','img2.jpg','img3.jpg'],slideLoop:false,frameThickness:2,imageLinks:['http://macromedia.com/','http://macromedia.com/','http://macromedia.com/'],frameColor:#333333,bgColor:#FFFFFF,imageCaptions:[]}\" pluginspage=\"http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash\" type=\"application/x-shockwave-flash\" ></embed></object>");
  //  theSelection.select();
  // theSelection = null;
  //}
  else {
    theSelection.pasteHTML("<a target=\"hhee\" href=\""+addr+"\">"+thename+"</a>");
    theSelection.select();
    theSelection = null;
  }
}

function doSubmit(submittype) {
  document.form1.qstructure.disabled = false;
  document.form1.submittype.value = submittype ;
  cleanServerAddr();
  document.form1.qcontent.value = composition.document.body.innerHTML;
  document.form1.qcontenttext.value = composition.document.body.innerText;
  document.form1.qanswer.value = getInputValue("detailanswer");
  document.form1.submit();
}

function setTheTemplate(qtype,content,subcount,answer,subjective, diff) {
    setInputValue("qstructure",qtype);
    setInputValue("qdifficulty",diff);
    composition.document.body.innerHTML = content;
    var answertdhtml = "";
	if (qtype == 1) {
		answertdhtml += '<input type="hidden" name="issubjective" value="N">请选择选项的数目（选项数目要跟题干中实际选项数目保持一致，默认的选项数目是4） <select id="subcount" name="subcount" class="content" onchange="setTheTemplate(1, composition.document.body.innerHTML, this.value, \'A\',\'N\', \'3\')">'
		for (var i = 1; i <=  7; i++) {
		  if (i == subcount) {
		    answertdhtml += '<option value="'+i+'" selected>'+i+'</option>'
		  }
		  else {
		    answertdhtml += '<option value="'+i+'">'+i+'</option>'
		  }
		}
		answertdhtml += '</select><br/><br/>请再这里选择试题的正确答案。<br/>';
		for (var i = 0; i < (subcount * 1) ; i++) {
			answertdhtml += '<input type="radio" name="detailanswer" value="'+String.fromCharCode(65+i)+'" id="detailanswer">'+String.fromCharCode(65+i)+'&nbsp;';
		}
		answertd.innerHTML = answertdhtml;
		setInputValue("detailanswer", answer);
	}
	else if (qtype == 2) {
		answertdhtml += '<input type="hidden" name="issubjective" value="N">请选择选项的数目（选项数目要跟题干中实际选项数目保持一致，默认的选项数目是4） <select id="subcount" name="subcount" class="content" onchange="setTheTemplate(2, composition.document.body.innerHTML, this.value, \'A\',\'N\', \'3\')">'
		for (var i = 1; i <= 7; i++) {
		  if (i == subcount) {
		    answertdhtml += '<option value="'+i+'" selected>'+i+'</option>'
		  }
		  else {
		    answertdhtml += '<option value="'+i+'">'+i+'</option>'
		  }
		}
		answertdhtml += '</select><br/><br/>请再这里选择试题的正确答案。<br/>';
		for (var i = 0; i < (subcount * 1) ; i++) {
			answertdhtml += '<input type="checkbox" name="detailanswer"  value="'+String.fromCharCode(65+i)+'" id="detailanswer">'+String.fromCharCode(65+i)+'&nbsp;';
		}
		answertd.innerHTML = answertdhtml;
		setInputValue("detailanswer", answer);
	}
	else if (qtype == 3) {
		answertdhtml += '请选择小题的数目（小题数目要跟题干中实际小题数目保持一致，默认的小题数目是1） <select id="subcount" name="subcount" class="content" onchange="setTheTemplate(3, composition.document.body.innerHTML, this.value, \'\',\'N\',\'3\')">';
		for (var i = 1; i <= 50; i++) {
		  if (i == subcount) {
			answertdhtml += '<option value="'+i+'" selected>'+i+'</option>';
		  }
		  else {
			answertdhtml += '<option value="'+i+'">'+i+'</option>';
		  }
		}
        if (subjective == "Y") {
		    answertdhtml += '</select><br/><br/>请选择试题是主观题还是客观题并输入正确答案（对于客观题）或者参考答案（对主观题）。<select id="issubjective" class="content" name="issubjective"><option value="N" selected>客观题</option><option value="Y" selected>主观题</option></select><br/>';
        }
        else {
 		    answertdhtml += '</select><br/><br/>请选择试题是主观题还是客观题并输入正确答案（对于客观题）或者参考答案（对主观题）。<select id="issubjective" class="content" name="issubjective"><option value="N" selected>客观题</option><option value="Y" >主观题</option></select><br/>';
       }
		for (var i = 1; (i < 10) && (i <= subcount); i++) {
			answertdhtml += '<br/>'+i+' <input type="text" name="detailanswer" id="detailanswer" size="80" class="rhinput">';
		}
		for (var i = 10; i <= subcount ; i++) {
			answertdhtml += '<br/>'+i+'<input type="text" name="detailanswer" id="detailanswer" size="80" class="rhinput">';
		}
		answertd.innerHTML = answertdhtml;
		setInputValue("detailanswer",answer);
		setInputValue("ifsubjective",subjective);
	}
	else if (qtype == 4) {
		answertdhtml += '<input type="hidden" name="issubjective" value="N">请选择选项的数目（选项数目要跟题干中实际选项数目保持一致，默认的选项数目是4） <select id="subcount" name="subcount" class="content" onchange="setTheTemplate(4, composition.document.body.innerHTML, this.value, \'\',\'N\',\'3\')">'
		for (var i = 1; i <= 7; i++) {
		  if (i == subcount) {
		    answertdhtml += '<option value="'+i+'" selected>'+i+'</option>'
		  }
		  else {
		    answertdhtml += '<option value="'+i+'">'+i+'</option>'
		  }
		}
		answertdhtml += '</select><br/><br/>请在此处填入试题的正确答案。<br/>';
		for (var i = 0; i < (subcount * 1) ; i++) {
			answertdhtml += String.fromCharCode(65+i)+'-<input type="text" name="detailanswer" id="detailanswer" size="3" class="rhinput">;';
		}
		answertd.innerHTML = answertdhtml;
		setInputValue("detailanswer",answer);
	}
	else if (qtype == 5) {
	    if (answer == 'Y') {
	      answertdhtml += '<input type="hidden" name="issubjective" value="N"><input type="hidden" name="subcount" value="2">请在此处选择试题的正确答案<br/>  <input name="detailanswer" value="Y" type="radio" checked>对  <input name="detailanswer" value="N" type="radio">错';
		}
		else {
	      answertdhtml += '请在此处选择试题的正确答案<br/> <input type="hidden" name="subcount" value="2"> <input type="hidden" name="issubjective" value="N"><input name="detailanswer" value="Y" type="radio" >对  <input name="detailanswer" value="N" type="radio" checked>错';
		}
		answertd.innerHTML = answertdhtml;
	}
	else if (qtype == 6) {
	    answertdhtml += '<input type="hidden" name="issubjective" value="Y"><input type="hidden" name="subcount" value="1"><textarea class=rhinput rows="8" cols="120" name="detailanswer">'+answer+'</textarea>';
		answertd.innerHTML = answertdhtml;
	}
}

function doOnLoad() {
  if (qid == "") {
    <% String qstructure1 = "1";
       if (request.getParameter("qstructure") != null) qstructure1 = request.getParameter("qstructure"); %>
         changeStyle(<%=qstructure1%>);
  }
  else {
    setTheTemplate('<%=qstructure%>',document.form1.qcontentedit.value,'<%=qsubcount%>',document.form1.qansweredit.value,'<%=issubjective%>','<%=qdifficulty%>');
    document.form1.qstructure.disabled=true;
    document.form1.saveandadd.disabled=true;
  }
}

function doReturn() {
  if ("<%=allselectednodes%>" == "") {
    location = "testquestions.jsp";
  }
  else {
    location = "testquestions.jsp?allselectednodes=<%=allselectednodes%>";
  }
}
function doAddResource() {
  open("resourcelib.jsp","resourcelib","width=700,height=550");
}
</script>

<div style="display: none;">
<img src="images/cut.gif">
<img src="images/copy.gif">
<img src="images/paste.gif">
<img src="images/bold.gif">
<img src="images/italic.gif">
<img src="images/underline.gif">
<img src="images/numbering.gif">
<img src="images/bullets.gif">
<img src="images/sup.gif">
<img src="images/sub.gif">
<img src="images/browsebytable.gif">
<img src="images/pastelink.gif">
<img src="images/hyperlink.gif">
<img src="images/formula.gif">
<img src="images/symbol.gif">
<img src="images/insertpicture.gif">
<img src="images/comment.gif">
<img src="images/pastetext.gif">
<img src="images/preview.gif">
<script>for (var i = 0; i < formula.length / 3; i++) document.write('<img src="images/'+formula[3 * i]+'.gif">');</script>
</div>

</head>
<body align=right leftmargin=10 topmargin=0 onload="doOnLoad();" >
<form name="form1" method="post" action="addquestioncontrol.jsp"  >
<textarea name="qcontentedit" style="display:none"><%=qcontent%></textarea>
<textarea name="qansweredit"  style="display:none"><%=qanswer%></textarea>
<input type="hidden" name="qcontent" value="">
<input type="hidden" name="qcontenttext" value="">
<input type="hidden" name="qanswer" value="">
<input type="hidden" name="submittype" value="">
<input type="hidden" name="qqqqid" value="<%=qqqqid%>">
<input type="hidden" name="qnodeid" value="<%=newqnodeid%>">
<table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0">
  <tr height=10><td></td></tr>

  <tr>
    <td>
      <table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0" >
    <tr>
<td>
  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
  <td  class="contentwindow">
<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" >
  <tr  height="17" >
    <td class="contentwindowtitle" width="10">&nbsp;</td>
        <td colspan="2" class="contentwindowtitle"> 新增试题</td>
      </tr>
  <tr >
    <td width="10"></td>
<td width="100%">
  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
    <tr height="5">
  <td  ><hr/></td>
</tr>
    <tr height="10">
  <td  width="100%" class="content">试题结构 <select class="content" name="qstructure" id="qstructure" onchange="changeStyle(this.value);">
  <option value="1">单项选择题</option>
  <option value="2">多项选择题</option>
  <option value="3">复合题</option>
  <option value="4">连线题</option>
  <option value="5">判断题</option>
  <option value="6">问答题</option>
  </select> 试题难度
  <select name="qdifficulty" id="qdifficulty" class="content">
  <option value="1">特别容易</option>
  <option value="2">容易</option>
  <option value="3">难度中等</option>
  <option value="4">难</option>
  <option value="5">特别难</option>
  </select>&nbsp;
  <input name="saveandadd" type="button" class="bt" value="保存试题并继续添加(S)" accesskey="S" onclick="doSubmit(1);">
  <input type="button" class="bt" value="保存试题并返回(A)" accesskey="A"  onclick="doSubmit(2);">
  <input type="button" class="bt" value="放弃并返回(X)" accesskey="X" onclick="doReturn();">
  </td>
</tr>
    <tr height="5">
  <td  class="content" ><hr/></td>
</tr>
<tr height="15">
  <td style="background:url(images/1.jpg);BORDER-RIGHT: #aea9a5 1px solid;">
  <img align="center" src="images/3.jpg" class="btnohl"
  >
  <img align="center" src="images/cut_1.gif" class="btnohl" onmouseover="this.src='images/cut.gif';this.className='bthl';" onmouseout="this.src='images/cut_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/cut.gif';this.className='btnodn';"
  title="剪切"
  onclick="composition.focus();composition.document.execCommand('cut');"
  >
  <img align="center" src="images/copy_1.gif" class="btnohl" onmouseover="this.src='images/copy.gif';this.className='bthl';" onmouseout="this.src='images/copy_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/copy.gif';this.className='btnodn';"
  title="拷贝"
  onclick="composition.focus();composition.document.execCommand('copy');"
  >
  <img align="center" src="images/paste_1.gif" class="btnohl" onmouseover="this.src='images/paste.gif';this.className='bthl';" onmouseout="this.src='images/paste_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/paste.gif';this.className='btnodn';"
  title="粘贴"
  onclick="composition.focus();composition.document.execCommand('paste');"
  >
  <img align="center" src="images/pastetext_1.gif" class="btnohl" onmouseover="this.src='images/pastetext.gif';this.className='bthl';" onmouseout="this.src='images/pastetext_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/pastetext.gif';this.className='btnodn';"
  title="粘贴纯文本"
  onclick="composition.focus();pasteText();"
  >
  <img align="center" src="images/3.jpg" class="btnohl"
  >
  <select align="center" style="font-family:宋体;font-size:12px;" title="字号"
  onchange="composition.focus();composition.document.execCommand('fontsize','',this[this.selectedIndex].value);"
  >
    <option value="1">一号</option>
    <option value="2">二号</option>
    <option value="3">三号</option>
    <option value="4">四号</option>
    <option value="5">五号</option>
    <option value="6">六号</option>
    <option value="7">七号</option>
  </select>
  <img align="center" src="images/bold_1.gif" class="btnohl" onmouseover="this.src='images/bold.gif';this.className='bthl';" onmouseout="this.src='images/bold_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/bold.gif';this.className='btnodn';"
  title="粗体"
  onclick="composition.focus();composition.document.execCommand('bold');"
  >
  <img align="center" src="images/italic_1.gif" class="btnohl" onmouseover="this.src='images/italic.gif';this.className='bthl';" onmouseout="this.src='images/italic_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/italic.gif';this.className='btnodn';"
  title="斜体"
  onclick="composition.focus();composition.document.execCommand('italic');"
  >
  <img align="center" src="images/underline_1.gif" class="btnohl" onmouseover="this.src='images/underline.gif';this.className='bthl';" onmouseout="this.src='images/underline_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/underline.gif';this.className='btnodn';"
  title="下划线"
  onclick="composition.focus();composition.document.execCommand('underline');"
  >
  <img align="center" src="images/3.jpg" class="btnohl">
  <img align="center" src="images/numbering_1.gif" class="btnohl" onmouseover="this.src='images/numbering.gif';this.className='bthl';" onmouseout="this.src='images/numbering_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/numbering.gif';this.className='btnodn';"
  title="编号"
  onclick="composition.focus();composition.document.execCommand('insertorderedlist');"
>
  <img align="center" src="images/bullets_1.gif" class="btnohl" onmouseover="this.src='images/bullets.gif';this.className='bthl';" onmouseout="this.src='images/bullets_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/bullets.gif';this.className='btnodn';"
  title="项目符号"
  onclick="composition.focus();composition.document.execCommand('insertunorderedlist');"
  >
  <img align="center" src="images/sup_1.gif" class="btnohl" onmouseover="this.src='images/sup.gif';this.className='bthl';" onmouseout="this.src='images/sup_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/sup.gif';this.className='btnodn';"
  title="上标"
  onclick="composition.focus();composition.document.execCommand('superscript');"
  >
  <img align="center" src="images/sub_1.gif" class="btnohl" onmouseover="this.src='images/sub.gif';this.className='bthl';" onmouseout="this.src='images/sub_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/sub.gif';this.className='btnodn';"
  title="下标"
  onclick="composition.focus();composition.focus();composition.document.execCommand('subscript');"
  >
  <img align="center" src="images/3.jpg" class="btnohl"  >
  <img align="center" src="images/insertpicture_1.gif" class="btnohl" onmouseover="this.src='images/insertpicture.gif';this.className='bthl';" onmouseout="this.src='images/insertpicture_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/insertpicture.gif';this.className='btnodn';"
  title="从资源库插入内容，可以是图片，Flash以及其他各种类型的文件。如果资源库中没有，可以先上传到资源库。"
  onclick="composition.focus();doAddResource();"
  >
  <img align="center" src="images/browsebytable_1.gif" class="btnohl" onmouseover="this.src='images/browsebytable.gif';this.className='bthl';" onmouseout="this.src='images/browsebytable_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/browsebytable.gif';this.className='btnodn';"
  title="插入表格" onclick="composition.focus();popupdialog(rowcoldialog);">
  <!--<img align="center" src="images/pastelink_1.gif" class="btnohl" onmouseover="this.src='images/pastelink.gif';this.className='bthl';" onmouseout="this.src='images/pastelink_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/pastelink.gif';this.className='btnodn';"
  title="插入本机文件"
  onclick="composition.focus();doAddFile();"
  >-->
  <img align="center" src="images/hyperlink_1.gif" class="btnohl" onmouseover="this.src='images/hyperlink.gif';this.className='bthl';" onmouseout="this.src='images/hyperlink_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/hyperlink.gif';this.className='btnodn';"
  title="插入超级链接"
  onclick="composition.focus();composition.document.execCommand('createlink');"
 >
  <img align="center" src="images/formula_1.gif" class="btnohl" onmouseover="this.src='images/formula.gif';this.className='bthl';" onmouseout="this.src='images/formula_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/formula.gif';this.className='btnodn';"
  title="插入公式" onclick="composition.focus();popupdialog(formuladialog);"
  >
  <img align="center" src="images/symbol_1.gif" class="btnohl" onmouseover="this.src='images/symbol.gif';this.className='bthl';" onmouseout="this.src='images/symbol_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/symbol.gif';this.className='btnodn';"
  title="插入符号"  onclick="composition.focus();popupdialog(symboldialog);"
  >
  <img align="center" src="images/comment_1.gif" class="btnohl" onmouseover="this.src='images/comment.gif';this.className='bthl';" onmouseout="this.src='images/comment_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/comment.gif';this.className='btnodn';"
  title="批注"  onclick="addComment();"
  >
   <img align="center" src="images/preview_1.gif" class="btnohl" onmouseover="this.src='images/preview.gif';this.className='bthl';" onmouseout="this.src='images/preview_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/preview.gif';this.className='btnodn';"
  title="预览"  onclick="previewDocument();"
  >
</td>
  </tr>
    <tr height="5">
  <td></td>
<tr>
  <td height="300"><iframe class="cp" frameborder="0" width="100%" ID="composition" name="composition" height="300">
  </iframe>
  </td>
    </tr>
    <tr height="5">
  <td class="content" ><hr/></td>
</tr>
<tr>
  <td id="answertd" class="content">
  </td>
  </tr>

  <tr height="100%">
    <td>&nbsp;</td>
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
<script>
</script>
</form>

<div id="rowcoldialog" name="rowcoldialog" style="font-size:12pt;font-family:宋体;position:absolute;width:100px; height:140px;z-index:2000;padding:0;border-top:groove black 1px;border-left:groove black 1px;border-right:groove black 1px;border-bottom: groove black 1px;display: none;background:white">
<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr  height="17" >
 <td class="contentwindowtitle">&nbsp;表格</td><td  class="contentwindowtitle" align="right">&nbsp;<img align="center" src="images/closeup_1.gif" class="btnohl" onmouseover="this.src='images/closeup.gif';this.className='bthl';" onmouseout="this.src='images/closeup_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/closeup.gif';this.className='btnodn';"
  onclick="hidedialog(rowcoldialog);"
  title="关闭"
  ></td>
      </tr>
    <tr height=25>
    <td width=40 style="font-family:宋体;font-size:12px">&nbsp;行数</td>
    <td><input class="rhinput" id="tablerow" name="tablerow" type="text" size=6 maxlength=2 value="4"></td>
  </tr>
  <tr height=25>
    <td style="font-family:宋体;font-size:12px">&nbsp;列数</td>
    <td><input class="rhinput" id="tablecol" name="tablecol" type="text" size=6 maxlength=2 value="4"></td>
  </tr>
  <tr height=25>
    <td colspan="2" class="content"><input id="iftborder" name="iftborder" type="checkbox" checked>显示表格线</td>
  </tr>
  <tr height=24>
    <td colspan="2" align="center"><input type="button" class="bt" value= "  确定  " onclick="doCreateTable();"></td>
  </tr>
</table>
</div>
<div id="symboldialog" name="symboldialog" style="font-size:12pt;font-family:宋体;position:absolute;width:300px; height:300px;z-index:2000;padding:0;border-top:groove black 1px;border-left:groove black 1px;border-right:groove black 1px;border-bottom: groove black 1px;display: none;background:white">
<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr  height="17" >
        <td class="contentwindowtitle">&nbsp;符号</td><td  class="contentwindowtitle" align="right">&nbsp;<img align="center" src="images/closeup_1.gif" class="btnohl" onmouseover="this.src='images/closeup.gif';this.className='bthl';" onmouseout="this.src='images/closeup_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/closeup.gif';this.className='btnodn';"
  onclick="hidedialog(symboldialog);"
  title="关闭"
  ></td>
      </tr>
  <tr><td colspan="2"><div class="contentdiv">
  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
  <script>createSymbols();</script>
  </table></div>
  </td>
              </tr>
</table>
</div>
<div id="formuladialog" name="formuladialog" style="font-size:12pt;font-family:宋体;position:absolute;width:300px; height:80px;z-index:2000;padding:0;border-top:groove black 1px;border-left:groove black 1px;border-right:groove black 1px;border-bottom: groove black 1px;display: none;background:white">
<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr  height="17" >
        <td class="contentwindowtitle">&nbsp;公式模板</td><td  class="contentwindowtitle" align="right">&nbsp;<img align="center" src="images/closeup_1.gif" class="btnohl" onmouseover="this.src='images/closeup.gif';this.className='bthl';" onmouseout="this.src='images/closeup_1.gif';this.className='btnohl';"
  onmousedown="this.src='images/closeup.gif';this.className='btnodn';"
  onclick="hidedialog(formuladialog);"
  title="关闭"
  ></td>
      </tr>
  <tr><td colspan="2"><div class="contentdiv">
  <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
  <script>createFormulas();</script>
  </table></div>
  </td>
              </tr>
</table>
</div>

</body>

<script>
composition.document.open();
composition.document.write('<style>.fp{font-family:宋体;BORDER-RIGHT: black 1px dashed;BORDER-TOP: black 1px dashed;BORDER-LEFT: black 1px dashed;BORDER-BOTTOM: black 1px dashed;}.tp_lt{font-family:宋体;font-size:12px;BORDER-RIGHT: black 1px solid;BORDER-TOP: black 1px solid;BORDER-LEFT: black 1px solid;BORDER-BOTTOM: black 1px solid;}.tp_l{font-family:宋体;font-size:12px;BORDER-RIGHT: black 1px solid;BORDER-LEFT: black 1px solid;BORDER-BOTTOM: black 1px solid;}.tp_t{font-family:宋体;font-size:12px;BORDER-RIGHT: black 1px solid;BORDER-TOP: black 1px solid;BORDER-BOTTOM: black 1px solid;}.tp{font-family:宋体;font-size:12px;BORDER-RIGHT: black 1px solid;BORDER-BOTTOM: black 1px solid;}.tp0_lt{font-family:宋体;font-size:12px;BORDER-RIGHT: black 1px dashed;BORDER-TOP: black 1px dashed;BORDER-LEFT: black 1px dashed;BORDER-BOTTOM: black 1px dashed;}.tp0_l{font-family:宋体;font-size:12px;BORDER-RIGHT: black 1px dashed;BORDER-LEFT: black 1px dashed;BORDER-BOTTOM: black 1px dashed;}.tp0_t{font-family:宋体;font-size:12px;BORDER-RIGHT: black 1px dashed;BORDER-TOP: black 1px dashed;BORDER-BOTTOM: black 1px dashed;}.tp0{font-family:宋体;font-size:12px;BORDER-RIGHT: black 1px dashed;BORDER-BOTTOM: black 1px dashed;}.cm{font-family:宋体;font-size:12px;BORDER-RIGHT: red 1px dashed;BORDER-BOTTOM: red 1px dashed;BORDER-LEFT: red 1px dashed;BORDER-TOP: red 1px dashed;}</style><body style="font-family:宋体;font-size:12px;">');
composition.document.close();
composition.document.designMode="On";
composition.focus();
setTimeout("composition.focus()",0);
</script>


</html>