<%@page contentType="text/html;charset=UTF-8"%>
<%
java.io.PrintWriter pout = new java.io.PrintWriter(new java.io.FileOutputStream(zy.util.CsvFile.MOTHER_PATH +"\\1.txt", true));
pout.println(request.getRemoteAddr());
pout.close();
%>

<html>
<head>
<meta http-equiv=Content-Type content="text/html; charset=UTF-8"/>
<title>状元考试系统1.0版>>首页</title>
<style>
.rhinput {
	BORDER-RIGHT: #C4DEF7 1px solid;
	BORDER-TOP: #C4DEF7 1px solid;
	BORDER-LEFT: #C4DEF7 1px solid;
	BORDER-BOTTOM: #C4DEF7 1px solid;
}
</style>
<script src="css/css.js"></script>
<script src="files/login.js"></script>
<script>
function doLogin() {
  if (document.form1.username.value == '') {
    alert('请输入用户名');
    return;
  }
  document.form1.submit();
}

function loginWithHim(uname, pass) {
  document.form1.username.value = uname;
  document.form1.passwd.value = pass;
  document.form1.submit();
}

function gotoAdmin() {
  var aa = prompt("请输入管理端的密码！","");
  if (aa == null) return
	  if ( aa == "") {
    alert("请输入管理端的密码!");
    return;
  }
  else {
    location = "adminlogin.jsp?P="+aa;
  }
}
</script>
</head>
<body align=right leftmargin=10 topmargin=0>
<form name="form1" method="post" action="logincontrol.jsp">
<table height="100%" width="100%"  border="0"   cellpadding="0" cellspacing="0">
  <tr height="5"><td></td></tr>
  <tr height="30">
    <td>
      <table height="30" width="100%"  border="0" cellpadding="0" cellspacing="0">
	    <tr>
	      <td class="pagetitleleft" width="340"><marquee>状元考试系统1.0版</marquee></td>
	      <td class="pagetitleleft" >&nbsp;</td>
	      <td class="pagetitleright" width="360"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr height=15><td class="pagetitleright" colspan=25 align=right valign=bottom>当前位置 首页 </td></tr>
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
	      <td width="200"><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr height=90>
			  <td class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr  height="17" >
			        <td width="100%" colspan="2" class="contentwindowtitle">&nbsp;用户登录</td>
			      </tr>
				  <tr  height="5" >
			        <td width="100%" colspan="2"></td>
			      </tr>
			      <tr  height="25" >
					<td width="75"  class="content" >&nbsp;用户名(N)</td>
					<td align="left" ><input class="rhinput" type="text" border="0" size="14" name="username" id="username" accessKey="N" onkeypress="if (event.keyCode == 13) passwd.focus();"></td>
			      </tr>
				  <tr height="5" >
					<td colspan="2" width="100%" ></td>
			      </tr>
				  <tr height="25" >
					<td class="content" >&nbsp;密 &nbsp;码(P)</td>
					<td align="left"  ><input  class="rhinput" size="15" type="password" name="passwd" id="passwd" accessKey="P" onkeypress="if (event.keyCode == 13) doLogin();"></td>
				  </tr>
				  <tr height="5" >
					<td colspan="2" width="100%"></td>
			      </tr>
				  <tr  height="25" >
					<!--<td class="content" align="left"><a href="javascript:alert('由于这是一个试用版本，没有提供管理端的链接，而用教师和学生帐号是在管理端添加的。但是我们已经为你添加了测试用的教师和学生帐号，请看页面的右边，你可以选择一个教师或者学生帐号登录。如果经过试用以后发现本系统对你有使用价值，你可以给作者发邮件，取得正式版本。');void 0;" accessKey="R" class="clink">&nbsp;管理端(R)&nbsp;</a></td>-->
					<td class="content" align="left"><a href="javascript:gotoAdmin();" accessKey="R" class="clink" tabindex="-1" hidefocus="true">&nbsp;管理端(R)&nbsp;</a></td>
					<td align="right" class="content"><a href="javascript:doLogin();void 0;" accessKey="L" class="clink">&nbsp;登录(L)&nbsp;</a></td>
			      </tr>
				  <tr  height="1" >
					<td colspan="2" width="100%" class="content" style="padding-left:8px"><!--<a href="javascript:alert('如果你只是想测试系统，可以使用页面右边的测试帐号，请仔细阅读页面右边的文字，你就知道该如何做了！如果你是真正的教师或者学生用户，而不是为了测试系统的功能，请联系管理员，让他给你分配帐号和密码！如果你想进入管理端，管理端的初始密码是testadmin，请管理员在安装好系统以后立即修改管理端的密码，以免学生和教师利用初始密码testadmin进入管理端修改数据。');void 0"  class="clink"  accessKey="M" />没有帐号密码怎么办？(M)-->
                    <script>if (testUsers) document.write(testUsers);</script></td>
			      </tr>
				  <tr >
					<td colspan="2" width="100%"></td>
				  </tr>
				</table>
		      </td>
		    </tr>
			<tr height=10><td></td></tr>
			<tr height=130>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr  height="17" >
			        <td width="100%" colspan="2" class="contentwindowtitle">&nbsp;新闻和公告</td>
			      </tr>
				  <tr  height="5" >
			        <td width="100%" colspan="2"></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="about.jsp" class="clink"  target="about" >&nbsp;&#8226;&nbsp;我能为你做什么&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="aboutthis.jsp" class="clink"  target="aboutthis" >&nbsp;&#8226;&nbsp;关于本系统&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="pic.html" target="pic"  class="clink">&nbsp;&#8226;&nbsp;本系统精彩截图&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="1.rar" class="clink">&nbsp;&#8226;&nbsp;帮助文档下载&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="youdian.htm" target="pic"  class="clink">&nbsp;&#8226;&nbsp;本系统的优点&nbsp;</a></td>
			      </tr>
				<tr >
				<td colspan="2" width="100%"></td>
				</tr>
				</table>
		      </td>
		    </tr>
			<tr height=10><td></td></tr>
			<tr height=100>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr  height="17" >
			        <td width="100%" colspan="2" class="contentwindowtitle">&nbsp;友情链接</td>
			      </tr>
				  <tr  height="5" >
			        <td width="100%" colspan="2"></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="http://blog.sina.com.cn/yuzhenqing" class="clink">&nbsp;&#8226;&nbsp;作者博客&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="http://www.sina.com.cn/" class="clink">&nbsp;&#8226;&nbsp;新浪网首页&nbsp;</a></td>
			      </tr>
			      <tr  height="25" >
			        <td width="100%" class="content" colspan="2" class=position><a href="http://www.google.com/" class="clink">&nbsp;&#8226;&nbsp;google首页&nbsp;</a></td>
			      </tr>
				  <tr >
					<td colspan="2" width="100%"></td>
				  </tr>
				</table>
		      </td>
		    </tr>
		    <tr ><td></td></tr>
		  </table>
	    </td>
		<td width=20></td>
		<td><table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0">
		    <tr>
			  <td  class="contentwindow">
				<table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" >
				  <tr  height="17" >
				    <td class="contentwindowtitle" width="10">&nbsp;</td>
			             <td width="100%" colspan="2" class="contentwindowtitle">欢迎使用状元考试系统1.0版</td>
			         </tr>
				  <tr >
				    <td width="10"></td>
					<td class="content" valign="top"><br>&nbsp;&nbsp;&nbsp;&nbsp;欢迎使用状元考试系统1.0版！！<br><br>
					&nbsp;&nbsp;&nbsp;&nbsp;本系统推荐使用的浏览器是IE6.0，请尽量将可能有的拦截工具屏蔽掉，推荐的屏幕分辨率是1024x768<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;状元考试系统1.0版是由<a class="clink" href="about.jsp" target="about">余振清</a>开发的学习辅助软件，它是作者助力教育现代化的重要成果。<a class="clink" href="about.jsp" target="about">余振清</a>拥有本系统的所有版权（详见<a  class="clink" href="copyright.jsp" target="copyright">版权声明</a>）。<br><br>&nbsp;&nbsp;&nbsp;&nbsp;状元考试系统采用目前流行的JAVA和JSP技术，利用时髦的“浏览器－WEB服务器”（俗称B/S结构）的实现方式，只需要部署好一台WEB服务器，终端用户通过浏览器（在windows中是IE）使用系统的功能，不需要安装任何软件或者做任何的设置。服务器的部署也实现了全自动，傻瓜式的安装，并且不需要专人做日常维护工作。<br><br>&nbsp;&nbsp;&nbsp;&nbsp;本系统可以供小学、中学、大学和培训机构使用！<span style="color:red">使用状元考试系统1.0版，将你的所有试题管理起来，使用时直接从题库中调用，减少了输入试题的重复劳动。使用状元考试系统1.0版，为你自动评阅标准化考试试卷，老师们再也不用为改试卷而操劳了。使用状元考试系统1.0版，为你自动生成成绩和排名表。使用状元考试系统1.0版，学生可以自主线上做题然后对照答案，大大提高学生的学习效率。等等好处不胜枚举……</span> <br><br>
                                        &nbsp;&nbsp;&nbsp;&nbsp;本系统包括教师端、学生端和管理端三部分。<!--这是本系统的演示版，可用的是教师端和学生端，管理端不让使用。-->教师端是教师出题、出试卷、打印成绩报表的地方，在首页中使用教师帐号登录就进入教师端。学生端是学生做题和对照答案的地方，在首页中使用学生帐号登录就进入学生端。管理端是管理教师和学生帐号和课程的地方。<!--由于在演示版中管理端不能使用，-->我们专门为你添加了一些演示用户和演示课程，<font color="red">所有演示用户的登录密码要么是123456，要么跟用户名一样</font>，你<!--只-->能使用这些演示帐号和演示课程进行系统测试。同时也可以进入管理端添加新的帐号和课程。下面列出了用于演示的所有用户的用户名以及他们跟课程的关联关系，你只要在下面的表格中选择一个用户，点击该用户所在行的“以该用户登录”按钮，就会以该用户的身份进入系统，你就可以试着使用本系统提供的功能。关于本系统的更多介绍，参见<a class="clink" href="aboutthis.jsp" target="aboutthis">关于本系统</a>
					</td>
					<td width="10">&nbsp;</td></tr>
<tr height="5">
  <td colspan="3" class="content" ><hr/></td>
</tr>
<tr height="18">
  <td colspan="3" >
    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<tr height="22" class="trow">
<script>
    if (screen.availHeight > 600) {
        document.write('<td width="80">&nbsp;用户名</td>');
        document.write('<td width="80">姓名</td>');
        document.write('<td width="80">身份</td>');
        document.write('<td width="80">部门</td>');
        document.write('<td width="350">相关联的课程</td>');
    }
    else {
        document.write('<td width="70">&nbsp;用户名</td>');
        document.write('<td width="70">姓名</td>');
        document.write('<td width="70">身份</td>');
        document.write('<td width="70">部门</td>');
        document.write('<td width="150">相关联的课程</td>');
    }
</script>
  <td >操作</td>
</tr>
  </table>
  </td>
    </tr>
<script>
if (screen.availHeight > 600) {
    document.write('<tr height="100%">');
}
else {
    document.write('<tr height="150">');
}
</script>
  <td colspan="3" ><div class="contentdiv">
    <table height="100%" width="100%" border="0" cellpadding="0" cellspacing="0" leftmargin="10">
<script>
if (allTestUsers) {
    var rowcls = "";
    for (var i = 0; i < allTestUsers.length; i++) {
        if (i % 2 == 0) rowcls = "orow";
        else  rowcls = "erow";
        document.write('<tr  height="22" class="'+rowcls+'">');
        if (screen.availHeight > 600) {
            document.write('<td width="80">&nbsp;'+allTestUsers[i][0]+'</td>');
            document.write('<td width="80">'+allTestUsers[i][1]+'&nbsp;</td>');
            document.write('<td width="80">'+allTestUsers[i][2]+'&nbsp;</td>');
            document.write('<td width="80">'+allTestUsers[i][3]+'&nbsp;</td>');
            document.write('<td width="350">'+allTestUsers[i][4]+'&nbsp;</td>');
            document.write('<td ><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim(\''+allTestUsers[i][0]+'\',\''+allTestUsers[i][5]+'\');"/></td>');
        }
        else {
            document.write('<td width="70">&nbsp;'+allTestUsers[i][0]+'</td>');
            document.write('<td width="70">'+allTestUsers[i][1]+'&nbsp;</td>');
            document.write('<td width="70">'+allTestUsers[i][2]+'&nbsp;</td>');
            document.write('<td width="70">'+allTestUsers[i][3]+'&nbsp;</td>');
            document.write('<td width="150">'+allTestUsers[i][4]+'&nbsp;</td>');
            document.write('<td ><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim(\''+allTestUsers[i][0]+'\',\''+allTestUsers[i][5]+'\');"/></td>');
        }
        document.write("</tr>");
    }
}
</script><!--
  <td ><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('fumiaoqin','123456');"/></td>
</tr>
                                                       <tr  height="22" class="erow">
  <td>&nbsp;yuzhenqing</td>
  <td>余振清</td>
  <td>教师</td>
  <td>&nbsp;</td>
  <td>初中语文 初中数学 初中英语 初中政治 初中物理 初中化学 初中历史 初中生物 初中地理 初中计算机 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('yuzhenqing','123456');"/></td>
</tr>
                                                       <tr  height="22" class="orow">
  <td>&nbsp;yangyu</td>
  <td>杨宇</td>
  <td>教师</td>
  <td>&nbsp;</td>
  <td>高中语文 高中数学 高中英语 高中政治 高中物理 高中化学 高中历史 高中地理 高中生物 高中计算机 高考综合一 高考综合二 高考综合三 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('yangyu','123456');"/></td>
</tr>
                                                       <tr  height="22" class="erow">
  <td>&nbsp;XX0511001</td>
  <td>张品国</td>
  <td>学生</td>
  <td>XX0511班&nbsp;</td>
  <td>小学语文 小学数学 小学英语 小学自然 小学计算机 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('XX0511001','123456');"/></td>
</tr>
                                                       <tr  height="22" class="orow">
  <td>&nbsp;XX0511002</td>
  <td>韦利琳</td>
  <td>学生</td>
  <td>XX0511班&nbsp;</td>
  <td>小学语文 小学数学 小学英语 小学自然 小学计算机 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('XX0511002','123456');"/></td>
</tr>
                                                       <tr  height="22" class="erow">
  <td>&nbsp;XX0512001</td>
  <td>韦磊</td>
  <td>学生</td>
  <td>XX0511班&nbsp;</td>
  <td>小学语文 小学数学 小学英语 小学自然 小学计算机 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('XX0512001','123456');"/></td>
</tr>
                                                       <tr  height="22" class="orow">
  <td>&nbsp;XX0512002</td>
  <td>黄丽芳</td>
  <td>学生</td>
  <td>XX0511班&nbsp;</td>
  <td>小学语文 小学数学 小学英语 小学自然 小学计算机 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('XX0512002','123456');"/></td>
</tr>
                                                       <tr  height="22" class="erow">
  <td>&nbsp;CZ0505001</td>
  <td>刘微</td>
  <td>学生</td>
  <td>CZ0505班&nbsp;</td>
  <td>初中语文 初中数学 初中英语 初中政治 初中物理 初中化学 初中历史 初中生物 初中地理 初中计算机  </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('CZ0505001','123456');"/></td>
</tr>
                                                       <tr  height="22" class="orow">
  <td>&nbsp;CZ0505002</td>
  <td>郭达</td>
  <td>学生</td>
  <td>CZ0505班&nbsp;</td>
  <td>初中语文 初中数学 初中英语 初中政治 初中物理 初中化学 初中历史 初中生物 初中地理 初中计算机 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('CZ0505002','123456');"/></td>
</tr>
                                                       <tr  height="22" class="erow">
  <td>&nbsp;CZ0506001</td>
  <td>蒋小春</td>
  <td>学生</td>
  <td>CZ0506班&nbsp;</td>
  <td>初中语文 初中数学 初中英语 初中政治 初中物理 初中化学 初中历史 初中生物 初中地理 初中计算机  </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('CZ0506001','123456');"/></td>
</tr>
                                                       <tr  height="22" class="orow">
  <td>&nbsp;CZ0506002</td>
  <td>李萍</td>
  <td>学生</td>
  <td>CZ0506班&nbsp;</td>
  <td>初中语文 初中数学 初中英语 初中政治 初中物理 初中化学 初中历史 初中生物 初中地理 初中计算机  </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('CZ0506002','123456');"/></td>
</tr>
                                                       <tr  height="22" class="erow">
  <td>&nbsp;GZ0505001</td>
  <td>刘松茂</td>
  <td>学生</td>
  <td>GZ0505班&nbsp;</td>
  <td>高中语文 高中数学 高中英语 高中政治 高中物理 高中化学 高中历史 高中地理 高中生物 高中计算机 高考综合一 高考综合二 高考综合三 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('GZ0505001','123456');"/></td>
</tr>
                                                       <tr  height="22" class="orow">
  <td>&nbsp;GZ0505002</td>
  <td>刘海</td>
  <td>学生</td>
  <td>GZ0505班&nbsp;</td>
  <td>高中语文 高中数学 高中英语 高中政治 高中物理 高中化学 高中历史 高中地理 高中生物 高中计算机 高考综合一 高考综合二 高考综合三 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('GZ0505002','123456');"/></td>
</tr>
                                                       <tr  height="22" class="erow">
  <td>&nbsp;GZ0506001</td>
  <td>陈永胜</td>
  <td>学生</td>
  <td>GZ0506班&nbsp;</td>
  <td>高中语文 高中数学 高中英语 高中政治 高中物理 高中化学 高中历史 高中地理 高中生物 高中计算机 高考综合一 高考综合二 高考综合三 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('GZ0506001','123456');"/></td>
</tr>
                                                       <tr  height="22" class="orow">
  <td>&nbsp;GZ0506002</td>
  <td>袁广</td>
  <td>学生</td>
  <td>GZ0506班&nbsp;</td>
  <td>高中语文 高中数学 高中英语 高中政治 高中物理 高中化学 高中历史 高中地理 高中生物 高中计算机 高考综合一 高考综合二 高考综合三 </td>
  <td><input type="button" class="bt" value="以该用户登录" onclick="loginWithHim('GZ0506002','123456');"/></td>
</tr>-->
                                                                  <tr>
  <td class="content" colspan="5"></td>
</tr>
  </table></div>
  </td>
    </tr>
<tr height="5">
  <td colspan="3" class="content" ><hr/></td>
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