/*
 * @(#)ImageTools.java	Jul 15, 2008
 *
 * Copyright 2007 北京中科集讯科技有限公司保留所有版权。
 */
package zy.util;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;

import javax.imageio.ImageIO;
import javax.imageio.ImageWriter;
import javax.imageio.stream.FileImageOutputStream;

import com.gif4j.GifDecoder;
import com.gif4j.GifEncoder;
import com.gif4j.GifImage;
import com.gif4j.GifTransformer;


/**
 * 这个类是用来对图片进行处理的
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
 * <td>Jul 15, 2008</td>
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
 * @version 1.0.0 Jul 15, 2008
 *          <p>
 */
public class ImageTools {

	public static void main(String[] args) {

		try {
			long a = System.currentTimeMillis();

			new ImageTools("c:\\1.jpg").resizeTo("c:\\1_.jpg", 144, 176, java.awt.Color.white).saveAs(
					"C:\\1.bmp");
			System.out.println(System.currentTimeMillis() - a);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public GifImage gifImage = null;

	public BufferedImage image = null;

	public boolean isGif = false;

	public String imagePath = null;

	private ImageTools() {
	}

	/**
	 *
	 * 传入图片文件，生成一个针对该图片的处理句柄
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 *
	 * <p>
	 *
	 * @see
	 * @param imagePath
	 * @throws IOException
	 */
	public ImageTools(String imagePath) throws IOException {
		this.imagePath = imagePath;
		analyze(imagePath);
	}

	/**
	 *
	 * 获取高度
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
	public int getHeight() {
		if (isGif) {
			return gifImage.getScreenHeight();
		} else {
			return image.getHeight();
		}
	}

	/**
	 *
	 * 获取宽度
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
	public int getWidth() {
		if (isGif) {
			return gifImage.getScreenWidth();
		} else {
			return image.getWidth();
		}
	}

	/**
	 *
	 * 按比例缩放到一个由最大高度和最大宽度限定的框内
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 *
	 * <p>
	 *
	 * @see
	 * @param output
	 * @param maxImageWidth
	 *            最大宽度
	 * @param maxImageHeight
	 *            最大高度
	 * @return
	 * @throws IOException
	 */
	public ImageTools resize(String output, int maxImageWidth,
			int maxImageHeight) throws IOException {
		ImageTools rst = new ImageTools();
		rst.isGif = isGif;
		rst.imagePath = output;
		if (isGif) {
			GifImage gi = resizeGif(gifImage, new File(output), maxImageWidth,
					maxImageHeight);
			writeImage(gi, output);
			rst.gifImage = GifDecoder.decode(new File(output));
			rst.image = javax.imageio.ImageIO.read(new java.io.File(output));
		} else {
			BufferedImage lvResized = resize(image, maxImageWidth,
					maxImageHeight);
			writeImage(lvResized, output);
			rst.image = lvResized;
		}
		return rst;
	}

	/**
	 *
	 * 按比例缩放到一个由最大高度和最大宽度限定的框内，不够的地方补白
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 *
	 * <p>
	 *
	 * @see
	 * @param output
	 * @param maxImageWidth
	 *            最大宽度
	 * @param maxImageHeight
	 *            最大高度
	 * @param c
	 *            补白颜色
	 * @return
	 * @throws IOException
	 */
	public ImageTools resizeTo(String output, int maxImageWidth,
			int maxImageHeight, java.awt.Color c) throws IOException {
		BufferedImage lvResized = resizeTo(image, maxImageWidth,
				maxImageHeight, c);
		writeImage(lvResized, output);
		return new ImageTools(output);
	}

	/**
	 *
	 * 剪彩
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 *
	 * <p>
	 *
	 * @see
	 * @param ouputPath
	 * @param x1
	 *            左上角x
	 * @param y1
	 *            左上角y
	 * @param x2
	 *            右下角x
	 * @param y2
	 *            右下角y
	 * @return
	 * @throws IOException
	 */
	public ImageTools crop(String ouputPath, int x1, int y1, int x2, int y2)
			throws IOException {
		if (isGif) {
			writeImage(GifTransformer.crop(gifImage, new java.awt.Rectangle(x1,
					y1, x2 - x1, y2 - y1)),ouputPath);
		} else {
			writeImage(image.getSubimage(x1, y1, x2 - x1, y2 - y1),
					ouputPath);
		}
		return new ImageTools(ouputPath);
	}

	/**
	 *
	 * 另存为，可以另存为另一个文件，也可以另存为另一种格式，目前支持bmp,gif,jpg,png等格式
	 * <p>
	 * 注意事项
	 * <p>
	 * 例如<br/>
	 *
	 * <p>
	 *
	 * @see
	 * @param ouputPath
	 * @return
	 * @throws Exception
	 */
	public ImageTools saveAs(String ouputPath) throws Exception {
		if (ouputPath.equals(imagePath)) {
			return this;
		}
		String fileType0 = imagePath.substring(imagePath.lastIndexOf(".") + 1)
				.toLowerCase();
		String fileType = ouputPath.substring(ouputPath.lastIndexOf(".") + 1)
				.toLowerCase();
		if (fileType0.equals(fileType)) {
			java.io.FileInputStream in = new java.io.FileInputStream(imagePath);
			java.io.FileOutputStream out = new java.io.FileOutputStream(
					ouputPath);
			int i = 0;
			while ((i = in.read()) != -1) {
				out.write(i);
			}
			in.close();
			out.close();
			return new ImageTools(ouputPath);
		}
		writeImage(image, ouputPath);
		return new ImageTools(ouputPath);
	}

	private void analyze(String input) throws IOException {
		if (input.toLowerCase().endsWith(".gif")) {
			gifImage = GifDecoder.decode(new File(input));
			isGif = true;
		} else {
			isGif = false;
		}
		image = javax.imageio.ImageIO.read(new java.io.File(input));
		System.out.println("image.getType():"+image.getType());
	}

	private static void writeImage(GifImage gifImage, String filePath)
			throws IOException {
		GifEncoder.encode(gifImage, new java.io.File(filePath));
	}

	private static void writeImage(BufferedImage img, String filePath)
			throws IOException, UnsupportedOperationException {

		String fileType = filePath.substring(filePath.lastIndexOf(".") + 1)
				.toLowerCase();
		ImageWriter writer = null;
		Iterator it2 = ImageIO
				.getImageWritersByFormatName(fileType);
		if (it2.hasNext()) {
			writer = (ImageWriter)it2.next();
		} else {
			throw new java.lang.UnsupportedOperationException("不支持的文件格式转换!");
		}
		FileImageOutputStream fios = new FileImageOutputStream(new File(
				filePath));

		writer.setOutput(fios);
		writer.write(img);
		fios.close();
	}

	private static BufferedImage resize(BufferedImage src, int maxImageWidth,
			int maxImageHeight) throws IOException {
		Image resizedImage = null;
		double width = src.getWidth();
		double height = src.getHeight();
		double widthRatio = maxImageWidth / width;
		double heightRatio = maxImageHeight / height;
		double ratio = widthRatio;
		if (heightRatio < ratio)
			ratio = heightRatio;
		if (ratio > 1) {
			return src;
		} else {
			int resizedWidth = (int) (width * ratio);
			int resizedHeight = (int) (height * ratio);
			resizedImage = src.getScaledInstance(resizedWidth,resizedHeight,Image.SCALE_SMOOTH);
			BufferedImage bufferedImage = new BufferedImage(resizedWidth, resizedHeight,
					BufferedImage.TYPE_3BYTE_BGR);//24位真彩色图片
			Graphics lvGraphics = bufferedImage.createGraphics();
			lvGraphics.setColor(Color.white);
			lvGraphics
					.fillRect(0, 0, resizedWidth, resizedHeight);
			lvGraphics.drawImage(resizedImage, 0, 0, null);
			lvGraphics.dispose();
			return bufferedImage;
		}
	}

	private static BufferedImage resizeTo(BufferedImage src, int maxImageWidth,
			int maxImageHeight, java.awt.Color c) throws IOException {
		Image resizedImage = null;
		double width = src.getWidth();
		double height = src.getHeight();
		double widthRatio = maxImageWidth / width;
		double heightRatio = maxImageHeight / height;
		double ratio = widthRatio;
		int resizedWidth = 0;
		int resizedHeight = 0;
		if (heightRatio < ratio)
			ratio = heightRatio;
		if (ratio > 1) {
			resizedWidth = (int) (width * 1);
			resizedHeight = (int) (height * 1);
			resizedImage = src;
		} else {
			resizedWidth = (int) (width * ratio);
			resizedHeight = (int) (height * ratio);
			resizedImage = src.getScaledInstance(resizedWidth,resizedHeight,Image.SCALE_SMOOTH);
		}
		BufferedImage bufferedImage = new BufferedImage(maxImageWidth, maxImageHeight,
				BufferedImage.TYPE_3BYTE_BGR);//24位真彩色图片
		Graphics lvGraphics = bufferedImage.createGraphics();
		lvGraphics.setColor(c);
		lvGraphics
				.fillRect(0,0, maxImageWidth, maxImageHeight);
		lvGraphics.drawImage(resizedImage, (maxImageWidth - resizedWidth) / 2, (maxImageHeight - resizedHeight) / 2, null);
		lvGraphics.dispose();
		return bufferedImage;
	}

	private static GifImage resizeGif(GifImage gifImage, File pOutputFile,
			int maxImageWidth, int maxImageHeight) throws IOException {
		double width = gifImage.getScreenWidth();
		double height = gifImage.getScreenHeight();
		double widthRatio = maxImageWidth / width;
		double heightRatio = maxImageHeight / height;
		double ratio = widthRatio;
		if (heightRatio < ratio)
			ratio = heightRatio;
		if (ratio > 1) {
			return gifImage;
		} else {
			gifImage = GifTransformer.resize(gifImage, maxImageWidth,
					maxImageHeight, true);
			return gifImage;
		}
	}

}