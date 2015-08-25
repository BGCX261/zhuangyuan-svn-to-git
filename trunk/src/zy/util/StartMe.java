package zy.util;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

/**
 * 
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2004</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */


public class StartMe
    extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1185448232929122969L;
	public static String FILEPATH = "";
    public static String TOMCATPATH = "";
    public static String MOTHER_PATH = "";
    public void init(ServletConfig config) throws ServletException {
        FILEPATH = config.getServletContext().getRealPath("");
        TOMCATPATH = FILEPATH.substring(0,
                                        FILEPATH.indexOf(java.io.File.separator +
            "webapps"));
        MOTHER_PATH = FILEPATH + java.io.File.separator +
            "WEB-INF" + java.io.File.separator + "d";
    }
}
