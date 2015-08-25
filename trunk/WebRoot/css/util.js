var SAPERATE_CHAR = "`";
var TOTAL_SCORE_SELECT = new Array(70,100,120,150,180,200,210);

function isInt()
{
  var patrn = /^(0|([1-9]\d*))$/;

  if (!patrn.exec(this))
  {
    return false;
  }
  else
  {
    return true;
  }
}

function trim()
{
  return this.replace(/(^[\s,\t]*)|([\s,\t]*$)/g, "");
}

function isFloat()
{
  var pattern = /^((0.\d+)|([1-9]\d*\.\d+))$/;

  return (pattern.test(this)) ? true : false;
}

String.prototype.trim = trim;
String.prototype.isInt = isInt;
String.prototype.isFloat = isFloat;

function isIntD(inputStr)
{
  var flag = true;

  if (inputStr == null || inputStr == "")
  {
    flag = false;
  }
  else
  {
    var patrn = /^\d+$/;

    if (!patrn.exec(inputStr))
    {
      flag = false;
    }
    else
    {
      flag = true;
    }
  }
  return flag ;
}


function isBetween(val, min, max)
{
  if ((val < min) || (val > max))
  {
    return false;
  }
  else
  {
    return true;
  }
}

function isDate(inputStr)
{
  var the1st = inputStr.indexOf('-');
  var the2nd = inputStr.lastIndexOf('-');

  if (the1st == the2nd)
  {
    return false;
  }
  else
  {
    var y = inputStr.substring(0,the1st);
    var m = inputStr.substring(the1st + 1,the2nd);
    var d = inputStr.substring(the2nd + 1,inputStr.length);
    var maxDays = 31;
    var patrn = /^[1-9](\d){3}$/;

    if (isIntD(m) == false || isIntD(d) == false || isIntD(y) == false)
    {
      return false;
    }
    else if (!patrn.exec(y))
    {
      return false;
    }
    else if (!isBetween (m*1, 1, 12))
    {
      return false ;
    }
    else if (m*1 == 4 || m*1 == 6 || m*1 == 9 || m*1 == 11)
    {
      maxDays = 30;
    }
    else if (m==2)
    {
      if (y % 4 > 0)
      {
        maxDays = 28;
      }
      else if ((y % 100 == 0) && (y % 400 > 0))
      {
        maxDays = 28;
      }
      else
      {
        maxDays = 29;
      }
    }
    if (isBetween(d, 1, maxDays) == false)
    {
      return(false);
    }
    else
    {
      return new Date(y*1,m*1-1,d*1).getTime();
    }
  }
}

function isDateTime(inputStr)
{
  var the1st = inputStr.indexOf('-');
  var the2nd = inputStr.lastIndexOf('-');
  var the3rd = inputStr.indexOf(' ');
  var the4th = inputStr.indexOf(':');

  if (the1st == the2nd)
  {
    return 0;
  }
  else if ( the3rd == the4th )
  {
    return 0;
  }
  else if ( the2nd == the3rd )
  {
    return 0;
  }
  else if ( the2nd == the4th )
  {
    return 0;
  }
  else
  {
    var y = inputStr.substring(0,the1st);
    var m = inputStr.substring(the1st + 1,the2nd);
    var d = inputStr.substring(the2nd + 1,the3rd);
    var h = inputStr.substring(the3rd+1,the4th);
    var n = inputStr.substring(the4th+1,inputStr.length);
    var maxDays = 31;
    var patrn = /^[1-9](\d){3}$/;

    if ( isIntD(h) == false || isIntD(n) == false )
    {
     return 0;
    }
    if ( h*1 >=24 || h*1 < 0 )
    {
     return 0;
    }
    if ( n*1 >=60 || n*1 < 0 )
    {
     return 0;
    }

    if (isIntD(m) == false || isIntD(d) == false || isIntD(y) == false )
    {
      return 0;
    }
    else if (!patrn.exec(y))
    {
      return 0;
    }
    else if (!isBetween (m*1, 1, 12))
    {
      return 0 ;
    }
    else if (m*1 == 4 || m*1 == 6 || m*1 == 9 || m*1 == 11)
    {
      maxDays = 30;
    }
    else if (m==2)
    {
      if (y % 4 > 0)
      {
        maxDays = 28;
      }
      else if ((y % 100 == 0) && (y % 400 > 0))
      {
        maxDays = 28;
      }
      else
      {
        maxDays = 29;
      }
    }
    if (isBetween(d, 1, maxDays) == false)
    {
      return(0);
    }
    else
    {
      return new Date(y*1,m*1-1,d*1,h*1,n*1).getTime();
    }
  }
}

function getInputValue(name)
{
  var rslt = "";
  var xx = document.getElementsByName(name);
  for (var i = 0; i < xx.length; i++) {
      if (xx[i].type == 'radio' || xx[i].type == 'checkbox') {
        if (xx[i].checked)  rslt += xx[i].value;
	  }
	  else if (xx[i].type == 'text') {
	    rslt += xx[i].value;
		rslt += SAPERATE_CHAR;
	  }
	  else {
	    rslt += xx[i].value;
	  }
  }
  return rslt;
}

function getInputValue1(name)
{
  var rslt = "";
  var xx = document.getElementsByName(name);
  for (var i = 0; i < xx.length; i++) {
	rslt += xx[i].value;
  }
  return rslt;
}

function setInputValue(name, value) {
  var xx = document.getElementsByName(name);
  for (var i = 0; i < xx.length; i++) {
    if (xx[i].type == 'radio') {
      if (xx[i].value == value)  xx[i].checked = true;
    }
    else if (xx[i].type == 'checkbox') {
      if (value.indexOf(xx[i].value) >= 0)  xx[i].checked = true;
    }
    else if (xx[i].type == 'text') {
	  var tmp = value.indexOf(SAPERATE_CHAR);
	  if (tmp != -1) {
        xx[i].value = value.substring(0,tmp);
	    value = value.substring(tmp+1);
	  }
    }
    else if (xx[i].type == 'select') {
      for (var j = 0; j < xx[i].options.length; j++) {
	    if (xx[i].options[j].value == value) {
		  xx[i].options[j].selected = true;
		  break;
		}
	  }
    }
    else {
      xx[i].value = value;
    }
  }
}

function encode(inputString) {
    var buffer = "";
    var len = inputString.length;
    var a, i;
    for (i = 0; i < len; i++) {
        a = inputString.charAt(i);
        //空格转换成&#32;
        if (a == ' ') {
            buffer += "&#32;";
        }
        //<转换成&#38;
        else if (a == '&') {
            buffer+="&#38;";
        }
        //<转换成&#60;
        else if (a == '<') {
            buffer+="&#60;";
        }
        //>转换成&#62;
        else if (a == '>') {
            buffer+="&#62;";
        }
        //回车转换成<br>
        else if (a == '\n') {
            buffer+="<br>";
        }
        else {
            buffer+=a;
        }
    }
    return buffer;
}

function getDateTimeString(milli) {
	var d = new Date(milli);
	var rst = d.getFullYear()+"";
	if (d.getMonth() < 9)
	{
		rst += "-0" + (d.getMonth() + 1);
	}
	else {
		rst += "-" + (d.getMonth() + 1);
	}
	if (d.getDate() < 10)
	{
		rst += "-0" + d.getDate();
	}
	else {
		rst += "-" + d.getDate();
	}
	if (d.getHours() < 10)
	{
		rst += " 0" + d.getHours();
	}
	else {
		rst += " " + d.getHours();
	}
	if (d.getMinutes() < 10)
	{
		rst += ":0" + d.getMinutes();
	}
	else {
		rst += ":" + d.getMinutes();
	}
	return rst;
}

function getDateString(milli) {
	var d = new Date(milli);
	var rst = d.getFullYear()+"";
	if (d.getMonth() < 9)
	{
		rst += "-0" + (d.getMonth() + 1);
	}
	else {
		rst += "-" + (d.getMonth() + 1);
	}
	if (d.getDate() < 10)
	{
		rst += "-0" + d.getDate();
	}
	else {
		rst += "-" + d.getDate();
	}
	return rst;
}

function httpAddrEncode(str) {
  //先去掉头尾空格
  str = str.replace(/(^[\s,\t]*)|([\s,\t]*$)/g, "");
  var res = '', len = str.length, mych;
  for (var i = 0; i < len; i++) {
    mych =  str.charAt(i);
    if (mych == '&' || mych == '#' || mych == '%' || mych == '+' || mych == '"') {
      res += '%'+str.charCodeAt(i).toString(16);
    }
    else {
      res += mych;
    }
  }
  return res;
}

function createTotalScoreSelect() {
	var tmp = '<select  name="paperscore" id="paperscore" class="content">';
	for (var i = 0; i < TOTAL_SCORE_SELECT.length; i++)
	{
		tmp += '<option value='+TOTAL_SCORE_SELECT[i]+'>'+TOTAL_SCORE_SELECT[i]+'</option>';
	}
	tmp += '</select>';
	document.write(tmp);
}