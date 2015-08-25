/*
 * @(#)FileUtil.java	Jul 17, 2008
 *
 * Copyright 2007 北京中科集讯科技有限公司保留所有版权。
 */
package zy.util;

import java.io.*;

/**
 * 
 * 这个类是用来处理一些跟文件有关的操作的
 * <p>
 * 注意事项
 * <p>
 * 例子代码
 * ……
 *
 * <p>
 * @see
 *
 * <p>
 * 更新日志
 * <div>
 * <table border=1>
 * <tr><td>修改人</td><td>版本号</td><td>时间</td><td>修改内容</td></tr>
 * <tr><td>余振清 </td><td>1.0.0</td><td>Jul 17, 2008</td><td>创建</td></tr>
 * <tr><td></td><td></td><td></td><td></td></tr>
 * </table>
 * <div>
 * <p>
 * <p>
 * @author 余振清
 * <p>
 * @version 1.0.0 Jul 17, 2008
 * <p>
 */
public class FileUtil {

    /**
     * 这方法是干什么的
     * <p>
     * 注意事项
     * <p>
     * 例如<br/>
     *
     * <p>
     * @see
     * @param args
     */
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        try {
            encodeFile(
                "C:\\zhuangyuan\\webapps\\zhuangyuan\\20080730222752.zip",
                "zyb");
            decodeFile(
                "C:\\20080730222752.zyb",
                "zip");
        }
        catch (Exception ee) {
            ee.printStackTrace();
        }

    }

    public static final String encodeFile(String path, String ext) throws
        IOException {
        String path1 = path.substring(0, path.lastIndexOf('.')) + "." + ext;
        FileInputStream in = new FileInputStream(path);
        File f = new File(path1);
        if (!f.exists()) {
            f.createNewFile();
        }
        FileOutputStream out = new FileOutputStream(path1);
        int b = 0;
        while ( (b = in.read()) != -1) {
            out.write(b+1);
        }
        out.close();
        in.close();
        return path1;
    }

    public static final String decodeFile(String path, String ext) throws
        IOException {
        String path1 = path.substring(0, path.lastIndexOf('.')) + "." + ext;
        FileInputStream in = new FileInputStream(path);
        File f = new File(path1);
        if (!f.exists()) {
            f.createNewFile();
        }
        FileOutputStream out = new FileOutputStream(path1);
        int b = 0;
        while ( (b = in.read()) != -1) {
            out.write(b-1);
        }
        out.close();
        in.close();
        return path1;
    }

    public static final void copyFile(String src, String des) throws
        IOException {
        FileInputStream s = new FileInputStream(src);
        FileOutputStream out = new FileOutputStream(des);
        int i = 0;
        while ( (i = s.read()) != -1) {
            out.write(i);
        }
        s.close();
        out.close();
    }

    public static final void moveFile(String src, String des) throws
        IOException {
        copyFile(src, des);
        new File(src).delete();
    }

}
