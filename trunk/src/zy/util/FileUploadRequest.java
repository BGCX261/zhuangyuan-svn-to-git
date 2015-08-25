/*
 * @(#)FileUploadRequest.java	Mar 8, 2007
 *
 * Copyright 2007 北京中科集讯科技有限公司保留所有版权。
 */
package zy.util;

import java.awt.image.BufferedImage;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;

/**
 * 用于文件上传的Request
 * <p>
 * 注意事项
 * <p>
 * 例子代码 …… javax.servlet.http.HttpServletRequest requestUpload = new
 * FileUploadRequest(request); requestUpload.getParameter("myfile");
 * //得到的是上传图片对应的http地址，但是前面的部分http://www.xxx.com:yyyy/zzz用前缀替换了
 * requestUpload.getParameter("myfile__absolute"); //得到的是上传图片在服务器上的磁盘地址
 * requestUpload.getParameter("myfile__width"); //得到的是上传图片的宽度
 * requestUpload.getParameter("myfile__height"); //得到的是上传图片的高度
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
 * <td>Mar 8, 2007</td>
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
 * @version 1.0.0 Mar 8, 2007
 *          <p>
 */
public class FileUploadRequest extends HttpServletRequestWrapper {
	private HttpServletRequest delegateObj;

	private java.util.Hashtable fileParameter = new java.util.Hashtable();

	public static String FILE_UPLOAD_PREFIX_NAME = "/zhuangyuan/files/";

	public static String FILE_UPLOAD_DIR = "";

	public static String ENCODE = "UTF-8";

	public static boolean IF_SET_IMAGESIZE = true;
	// 如果这个值是true，那么如果遇到上传的是图片，将会设置图片的高度和宽度到request里面。

	static {
		FILE_UPLOAD_DIR = new java.io.File(".").getAbsolutePath();
		FILE_UPLOAD_DIR = FILE_UPLOAD_DIR.substring(0, FILE_UPLOAD_DIR
				.indexOf(java.io.File.separator + "bin"
						+ java.io.File.separator))
				+ java.io.File.separator
				+ "webapps"
				+ java.io.File.separator
				+ "zhuangyuan" + java.io.File.separator + "files" + java.io.File.separator;
	}

	public FileUploadRequest(HttpServletRequest request) {
		super(request);
		delegateObj = request;
		doUpload();
	}

	public void doUpload() {
		try {
			DiskFileUpload fu = new DiskFileUpload();
			fu.setSizeMax(-1);// 不限制大小
			// 设置缓冲区大小，这里是4kb
			fu.setSizeThreshold(4096);
			// 设置临时目录：
			fu.setRepositoryPath(delegateObj.getSession().getServletContext()
					.getRealPath(""));
			List fileItems = fu.parseRequest(delegateObj);
			for (int i = 0; i < fileItems.size(); i++) {
				FileItem fi = (FileItem) fileItems.get(i);
				if (fi.isFormField()) {
					addParameter(fileParameter, fi.getFieldName(), fi
							.getString(ENCODE));
				} else {
					if (fi.getSize() == 0L) {
						addParameter(fileParameter, fi.getFieldName(), "");
						addParameter(fileParameter, fi.getFieldName()
								+ "__absolute", "");
					} else {
						String relativeDir = getFileUploadRelativeDir();
						String dir = null;
						if (FILE_UPLOAD_DIR == null) {
							dir = delegateObj.getSession().getServletContext()
									.getRealPath(relativeDir);
						} else {
							dir = FILE_UPLOAD_DIR + relativeDir;
						}
						createDir(dir);
						String uuid = System.currentTimeMillis() + "_"
								+ Math.round(Math.random() * 10000);
						String fileName = fi.getName();
						String fileExt = fileName.lastIndexOf(".") < 0 ? ""
								: fileName
										.substring(fileName.lastIndexOf(".") + 1);

						String filePath = dir + java.io.File.separator + uuid
								+ "." + fileExt;

						String httpPath = filePathToHttpPath(relativeDir
								+ java.io.File.separator + uuid + "." + fileExt);
						fi.write(new java.io.File(filePath));
						addParameter(fileParameter, fi.getFieldName(), httpPath);

						addParameter(fileParameter, fi.getFieldName()
								+ "__absolute", filePath);
						addParameter(fileParameter, fi.getFieldName()
								+ "__ext", fileExt);
						addParameter(fileParameter, fi.getFieldName()
								+ "__size", ""+fi.getSize());
						addParameter(fileParameter, fi.getFieldName()
								+ "__filename", fileName);

						if (isImage(filePath) && IF_SET_IMAGESIZE) {
							BufferedImage image = javax.imageio.ImageIO
									.read(new java.io.File(filePath));
							int width = image.getWidth();
							int height = image.getHeight();
							addParameter(fileParameter, fi.getFieldName()
									+ "__width", "" + width);
							addParameter(fileParameter, fi.getFieldName()
									+ "__height", "" + height);
						}

					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static String getFileUploadRelativeDir() {
		return +(System.currentTimeMillis() / (7 * 24 * 3600 * 1000))
				+ java.io.File.separator
				+ (System.currentTimeMillis() / (1 * 3600 * 1000));
	}

	private static void createDir(String dir) {
		try {
			dir = dir + java.io.File.separator;
			int startIndex = 0;
			int endIndex = dir.indexOf(java.io.File.separator, startIndex);
			while (endIndex >= 0) {
				java.io.File f = new java.io.File(dir.substring(0, endIndex));
				if (!f.exists()) {
					f.mkdir();
				}
				startIndex = endIndex + 1;
				endIndex = dir.indexOf(java.io.File.separator, startIndex);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void addParameter(java.util.Hashtable t, String key,
			String value) {
		Object o = t.get(key);
		if (o != null) {
			if (!(o instanceof String)) {
				String[] oo = (String[]) o;
				String[] oo1 = new String[oo.length + 1];
				System.arraycopy(oo, 0, oo1, 0, oo.length);
				oo1[oo.length] = value;
				t.put(key, oo1);
			} else {
				String[] oo1 = new String[2];
				oo1[0] = (String) o;
				oo1[1] = value;
				t.put(key, oo1);
			}
		} else {
			t.put(key, value);
		}
	}

	private static String filePathToHttpPath(String filePath) {
		if (!java.io.File.separator.equals("//")) {
			return FILE_UPLOAD_PREFIX_NAME + "/"
					+ filePath.replace(java.io.File.separatorChar, '/');
		} else {
			return filePath;
		}
	}

	public String getParameter(String arg0) {
		// TODO Auto-generated method stub
		if (fileParameter.get(arg0) != null) {
			return decode((String) fileParameter.get(arg0));
		}
		return decode(super.getParameter(arg0));
	}

	public String[] getParameterValues(String arg0) {
		// TODO Auto-generated method stub
		if (fileParameter.get(arg0) != null) {
			return (fileParameter.get(arg0) instanceof String) ? new String[] { (String) fileParameter
					.get(arg0) }
					: (String[]) fileParameter.get(arg0);
		}
		return decode(super.getParameterValues(arg0));
	}

	public static String decode(String in) {
		if (in == null)
			return null;
		String result = in;
		if (in.indexOf("___dec(") == 0
				&& in.lastIndexOf(")") == (in.length() - 1)) {
			result = "";
			String[] aaa = in.substring(7, in.length() - 1).split("_");
			for (int i = 0; i < aaa.length; i++) {
				try {
					result += (char) Integer.parseInt(aaa[i]);
				} catch (Exception ee) {
					result = in;
					break;
				}
			}
		}
		return result;
	}

	public static String[] decode(String[] in) {
		if (in == null)
			return null;
		String[] result = new String[in.length];
		for (int i = 0; i < in.length; i++) {
			result[i] = decode(in[i]);
		}
		return result;
	}

	private static boolean isImage(String filePath) {
		boolean rst = false;
		if (filePath != null && filePath.length() > 4) {
			if (filePath.toLowerCase().endsWith(".gif")
					|| filePath.toLowerCase().endsWith(".bmp")
					|| filePath.toLowerCase().endsWith(".jpg")
					|| filePath.toLowerCase().endsWith(".png")
					|| filePath.toLowerCase().endsWith(".jpeg")) {
				rst = true;
			}
		}
		return rst;
	}

	public static void main(String[] args) {
		// System.out.println(decode("___dec(24ss214_242ss14_242ss14_)") + "");
		System.out.println(Runtime.getRuntime().totalMemory()
				- Runtime.getRuntime().freeMemory());
		String[] aaa = new String[100000];
		System.out.println(Runtime.getRuntime().totalMemory()
				- Runtime.getRuntime().freeMemory());
		for (int i = 0; i < 100000; i++) {
			aaa[i] = new String("aaa" + i);
		}
		System.out.println(Runtime.getRuntime().totalMemory()
				- Runtime.getRuntime().freeMemory());
	}
}
