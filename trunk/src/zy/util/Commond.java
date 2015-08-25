/*
 * @(#)commond.java	Jul 24, 2008
 *
 * Copyright 2007 北京中科集讯科技有限公司保留所有版权。
 */
package zy.util;

import java.io.*;

/**
 * 
 * 这个类是用来执行DOS命令的
 * <p>
 * 注意事项，虽然这个类可以当作线程来用，但是一般不这么做，而是直接调用run方法，这个方法会等到执行完毕后返回，
 * 如果对是否执行完毕和输出都不感兴趣，可以直接使用start()方法，另外还提供了一个静态方法execute，可以直接使用
 * 
 * <p>
 * 例子代码 ……
 *      //Commond类的使用
 * 		Commond c = new Commond("cmd /C \"dir c:\\\""); //查看C盘根目录 dir c:\
 *		System.out.println("StartExec:" + c.getCommond());
 *		c.run();//不要用c.start();如果使用c.start()，下面的输出将无意义！
 *		System.out.println("<OUTPUT>");
 *		System.out.println(c.getOutput());
 *		System.out.println("</OUTPUT>");
 *		System.out.println("<Error>");
 *		System.out.println(c.getError());
 *		System.out.println("</Error>");
 *		System.out.println("<Return>");
 *		System.out.println(c.getReturnValue());
 *		System.out.println("</Return>");
 *		System.out.println("EndExec");
 *
 *		//静态方法的使用
 *      //查看C盘根目录 dir c:\
 * 		execute("cmd /C \"dir c:\\\"");
 *      //执行一条很长的命令
 *		execute("C:\\ffmpeg\\forasf\\ffmpeg -y -i C:\\Tomcat\\webapps\\upload\\2011\\337979\\1216725267218_2838\\default.avi -ab 15000 -vframes 28 C:\\Tomcat\\webapps\\upload\\2011\\337979\\1216725267218_2838\\default.asf");
 *      
 * <p>
 * 
 * @see
 * 
 * <p>
 * 更新日志 <div> <table border=1>
 * <tr>
 * <td>修改人</td>
 * <td>版本号</td>
 * <td>时间</td>
 * <td>修改内容</td>
 * </tr>
 * <tr>
 * <td>余振清 </td>
 * <td>1.0.0</td>
 * <td>Jul 24, 2008</td>
 * <td>创建</td>
 * </tr>
 * <tr>
 * <td></td>
 * <td></td>
 * <td></td>
 * <td></td>
 * </tr>
 * </table> <div>
 * <p>
 * <p>
 * @author 余振清
 *         <p>
 * @version 1.0.0 Jul 24, 2008
 *          <p>
 */
public class Commond extends Thread{

	private String commond = null;

	private String output = null;

	private String error = null;

	private int returnValue = 0;

	/**
	 * 
	 * 产生一个对象
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 * @param commond
	 */
	public Commond(String commond) {
		this.commond = commond;
	}

	/**
	 * 
	 * 执行，并返回结果，如果没有命令，将返回65536，执行中断，将返回-65536
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 * @return
	 */
	public void run() {
		StringBuffer outputBuffer = new StringBuffer();
		StringBuffer errorBuffer = new StringBuffer();
		try {

			Process process = Runtime.getRuntime().exec(commond);
			new GetOutput(process.getErrorStream(),errorBuffer).start();
			new GetOutput(process.getInputStream(),outputBuffer).start();
			returnValue = process.waitFor();
			this.output = outputBuffer.toString();
			this.error = errorBuffer.toString();
		} catch (IOException e) {
			returnValue = 65536;
			e.printStackTrace();
		} catch (InterruptedException e) {
			returnValue = -65536;
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * 得到命令行
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 * @return
	 */
	public String getCommond() {
		return commond;
	}

	/**
	 * 
	 * 设置命令行
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 * @param commond
	 */
	public void setCommond(String commond) {
		this.commond = commond;
	}

	/**
	 * 
	 * 得到错误输出
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 * @return
	 */
	public String getError() {
		return error;
	}

	/**
	 * 
	 * 得到标准输出
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 * @return
	 */
	public String getOutput() {
		return output;
	}

	/**
	 * 
	 * 得到命令行返回DOS返回值
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 * @return
	 */
	public int getReturnValue() {
		return returnValue;
	}
	/**
	 * 
	 * 执行一条命令，并将结果打印出来
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * @see 
	 * @param line
	 */
	public static final void execute(String line) {
		Commond c = new Commond(line);
		System.out.println("StartExec:" + c.getCommond());
		c.run();
		System.out.println("<OUTPUT>");
		System.out.println(c.getOutput());
		System.out.println("</OUTPUT>");
		System.out.println("<Error>");
		System.out.println(c.getError());
		System.out.println("</Error>");
		System.out.println("<Return>");
		System.out.println(c.getReturnValue());
		System.out.println("</Return>");
		System.out.println("EndExec");
	}

	private static class GetOutput extends Thread {
		InputStream is;

		StringBuffer buffer;

		GetOutput(InputStream is, StringBuffer buffer) {
			this.is = is;
			this.buffer = buffer;
		}

		public void run() {
			try {
				InputStreamReader isr = new InputStreamReader(is);
				BufferedReader br = new BufferedReader(isr);
				String line = null;
				while ((line = br.readLine()) != null) {
					buffer.append(line);
					buffer.append("\n");
				}
				br.close();
			} catch (IOException ioe) {
				ioe.printStackTrace();
			}
		}
	}

	/**
	 * 这方法是干什么的
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 * @param args
	 */
	public static void main(String[] args) {
	}

}
