var version=navigator.userAgent.substring(navigator.userAgent.lastIndexOf("MSIE")+5,navigator.userAgent.lastIndexOf("MSIE")+8);

var cssarray = new Array("likeeos.css", "windows2000.css", "red.css","qinghua.css","w3c.css");

if (version < 5.5)
{
    cssarray = new Array("likeeos_ie4.css","windows2000_ie4.css", "red_ie4.css","qinghua_ie4.css","w3c_ie4.css");
}

var cssarrayid = Math.round(Math.random() * (cssarray.length - 1));
//var cssarrayid = 4;

document.write("<link href=\"css/"+cssarray[cssarrayid]+"\" rel=\"stylesheet\" type=\"text/css\">");

function getRandomColor() {
  var tmpRR = (Math.round(Math.random() * 255)).toString(0x10);
  if (tmpRR.length == 1) tmpRR = '0' + tmpRR;
  var tmpBB = (Math.round(Math.random() * 255)).toString(0x10);
  if (tmpBB.length == 1) tmpBB = '0' + tmpBB;
  var tmpGG = (Math.round(Math.random() * 255)).toString(0x10);
  if (tmpGG.length == 1) tmpGG = '0' + tmpGG;
  return "#"+tmpRR + tmpBB + tmpGG ;
}

function createAPicture() {
    document.write("<tr>");
	for (var j = 0; j < 25; j++) {
	  if (j > Math.round(Math.random() * 18)){
	    document.write("<td bgcolor="+getRandomColor()+"> </td>");
	  }
	  else {
	    document.write("<td > </td>");
	  }
	}
	document.write("</tr>");
}
