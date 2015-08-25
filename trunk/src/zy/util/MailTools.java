/*
 * @(#)MailTools.java	Aug 12, 2008
 *
 * Copyright 2007 北京中科集讯科技有限公司保留所有版权。
 */
package zy.util;

import java.util.Date;
import java.util.Properties;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

/**
 * 这个类里面存放一些收发邮件的实用方法
 * <p>
 * 注意事项
 * <p>
 * 例子代码 ……
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
 * <td>Aug 12, 2008</td>
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
 * @version 1.0.0 Aug 12, 2008
 *          <p>
 */
public class MailTools {
	public static final int HTML_TYPE = 0;

	public static final int TEXT_TYPE = 1;

	public static String MAIL_SMTP_HOST = "smtp.youdian.com";

	public static String MAIL_SMTP_USER = "yuzhenqing";

	public static String MAIL_SMTP_PASSWORD = "yuzhenqing";

	public static Properties props = new Properties();

	/**
	 * 产生一个对象
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 */

	public MailTools() {
		// TODO Auto-generated constructor stub
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
		// TODO Auto-generated method stub
		try {
			sendTextMail("yuzhenqing@youdian.com", "yuzhenqing",
					"524689774@qq.com", "asfas阿司法所发", "<html><body><h1>阿三分散发三分散</h1><font color=red>撒发送开发哈萨克和发生</font></body></html>",
					HTML_TYPE);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * 这方法是发送邮件的
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 * 
	 * <p>
	 * 
	 * @see
	 * @param fromAddress
	 * @param fromPersonal
	 * @param toAddress
	 * @param title
	 * @param content
	 * @param contentType
	 * @throws Exception
	 */
	public static void sendTextMail(String fromAddress, String fromPersonal,
			String toAddress, String title, String content, int contentType)
			throws Exception {
		props.put("mail.smtp.host", MAIL_SMTP_HOST);
		props.put("mail.smtp.auth", "true");// 同时通过验证
		Session s = Session.getInstance(props);// 根据属性新建一个邮件会话
		// s.setDebug(true);

		MimeMessage message = new MimeMessage(s);// 由邮件会话新建一个消息对象

		// 设置邮件
		InternetAddress from = new InternetAddress(fromAddress);
		from.setPersonal(fromPersonal);
		message.setFrom(from);// 设置发件人
		InternetAddress to = new InternetAddress(toAddress);
		message.setRecipient(Message.RecipientType.TO, to);// 设置收件人,并设置其接收类型为TO
		message.setSubject(title);// 设置主题
		message.setSentDate(new Date());// 设置发信时间
		if (contentType == TEXT_TYPE) {
			message.setText(content);// 设置信件内容
		} else {
//			给消息对象设置内容
			BodyPart mdp=new MimeBodyPart();//新建一个存放信件内容的BodyPart对象
			mdp.setContent(content,"text/html;charset=UTF-8");//给BodyPart对象设置内容和格式/编码方式
			Multipart mm=new MimeMultipart();//新建一个MimeMultipart对象用来存放BodyPart对
//			象(事实上可以存放多个)
			mm.addBodyPart(mdp);//将BodyPart加入到MimeMultipart对象中(可以加入多个BodyPart)
			message.setContent(mm);//把mm作为消息对象的内容
		}

		// 发送邮件
		message.saveChanges();// 存储邮件信息
		Transport transport = s.getTransport("smtp");
		transport.connect(MAIL_SMTP_HOST, MAIL_SMTP_USER, MAIL_SMTP_PASSWORD);// 以smtp方式登录邮箱
		transport.sendMessage(message, message.getAllRecipients());// 发送邮件,其中第二个参数是所有
		// 已设好的收件人地址
		transport.close();
	}
}
