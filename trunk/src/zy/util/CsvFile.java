package zy.util;

/**
 * <p>zy.util.CsvFile: </p>
 * <p>Copyright: yuzhenqing (c) 2004</p>
 * <p>Company: </p>
 * @author yuzhenqing
 * @version 1.0 2004-07-10
 *
 * <p>
 * 用来对csv文件进行操作，csv文件是本系统存取数据的地方
 * </p>
 * 
 */

public class CsvFile {

    public static String MOTHER_PATH = "";
    public static final char SAPERATE_CHAR = '`';
    public static final String[] qstructures = new String[] {
        "单项选择题", "多项选择题", "复合题", "连线题", "判断题", "问答题"};
    public static final String[] qdifficultys = new String[] {
        "特别容易", "容易", "难度中等", "难", "特别难"};
    public static final String[] onetow = new String[] {
        "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"};
    private static final int COLUMN_SEPERATOR = 0;
    private static final int ROW_SEPERATOR = 1;
    private static final byte[] ROW_SEPERATOR_BYTES = new byte[] {
        1};
    private static final byte[] COLUMN_SEPERATOR_BYTES = new byte[] {
        0};

    public String charset = "gb2312";
    public String[][] allRecords = new String[0][0];
    public String filePath = "";

    public static java.util.Hashtable all = new java.util.Hashtable();
    static {
    	/*
        MOTHER_PATH = new java.io.File(".").getAbsolutePath();
        MOTHER_PATH = MOTHER_PATH.substring(0,
                                            MOTHER_PATH.indexOf(java.io.File.separator +
            "bin" + java.io.File.separator)) + java.io.File.separator + "d";
        */
    	MOTHER_PATH = StartMe.MOTHER_PATH;
        System.out.println("MOTHER_PATH:" + MOTHER_PATH);
        CsvFile temp = new CsvFile(MOTHER_PATH + java.io.File.separator +
                                   "u.csv");
        all.put("user",
                temp);
        all.put(MOTHER_PATH + java.io.File.separator + "u.csv",
                temp);

        temp = new CsvFile(MOTHER_PATH + java.io.File.separator + "c.csv");
        all.put("course",
                temp);
        all.put(MOTHER_PATH + java.io.File.separator + "c.csv",
                temp);

        temp = new CsvFile(MOTHER_PATH + java.io.File.separator + "admin.csv");
        all.put("admin",
                temp);
        all.put(MOTHER_PATH + java.io.File.separator + "admin.csv",
                temp);

        temp = new CsvFile(MOTHER_PATH + java.io.File.separator +
                           "sessionstrategy.csv");
        all.put("sessionstrategy",
                temp);
        all.put(MOTHER_PATH + java.io.File.separator + "sessionstrategy.csv",
                temp);

        temp = new CsvFile(MOTHER_PATH + java.io.File.separator +
                           "compareset.csv");
        all.put("compareset",
                temp);
        all.put(MOTHER_PATH + java.io.File.separator + "compareset.csv",
                temp);

        temp = new CsvFile(MOTHER_PATH + java.io.File.separator +
                           "judgeset.csv");
        all.put("judgeset",
                temp);
        all.put(MOTHER_PATH + java.io.File.separator + "judgeset.csv",
                temp);

        temp = new CsvFile(MOTHER_PATH + java.io.File.separator + "c_t.csv");
        all.put("course_teacher",
                temp);
        all.put(MOTHER_PATH + java.io.File.separator + "c_t.csv",
                temp);

        temp = new CsvFile(MOTHER_PATH + java.io.File.separator + "class.csv");
        all.put("class",
                temp);
        all.put(MOTHER_PATH + java.io.File.separator + "class.csv",
                temp);

        temp = new CsvFile(MOTHER_PATH + java.io.File.separator + "grade.csv");
        all.put("grade",
                temp);
        all.put(MOTHER_PATH + java.io.File.separator + "grade.csv",
                temp);
    }

    public static CsvFile getACsvFile(String name) {
        Object o = all.get(name);
        if (o != null) {
            return (CsvFile) o;
        }
        if (!name.endsWith(".csv")) {
            return o == null ? new CsvFile(name) : (CsvFile) o;
        }
        else {
            return new CsvFile(name);
        }
    }

    public static int getTeachersCount() {
        int rst = 0;
        CsvFile c = (CsvFile) all.get("user");
        for (int i = 0; i < c.allRecords.length; i++) {
            if (c.allRecords[i][4].equals("1")) {
                rst++;
            }
        }
        return rst;
    }

    public static int newAdminPass(String newpass) {
        int rst = 0;
        CsvFile c = (CsvFile) all.get("admin");
        c.allRecords = new String[][] {
            {
            newpass}
        };
        c.toFile();
        return rst;
    }

    public static int newSessionStrategy(String SessionStrategy) {
        int rst = 0;
        CsvFile c = (CsvFile) all.get("sessionstrategy");
        c.allRecords = new String[][] {
            {
            SessionStrategy}
        };
        c.toFile();
        return rst;
    }

    public static int newJudgeset(String Judgeset) {
        int rst = 0;
        CsvFile c = (CsvFile) all.get("judgeset");
        c.allRecords = new String[][] {
            {
            Judgeset}
        };
        c.toFile();
        return rst;
    }

    public static int newCompareset(String compareset) {
        System.out.println(compareset);
        int rst = 0;
        CsvFile c = (CsvFile) all.get("compareset");
        c.allRecords = new String[][] {
            {
            compareset}
        };
        c.toFile();
        return rst;
    }

    public static int getStudentsCount() {
        int rst = 0;
        CsvFile c = (CsvFile) all.get("user");
        for (int i = 0; i < c.allRecords.length; i++) {
            if (c.allRecords[i][4].equals("2")) {
                rst++;
            }
        }
        return rst;
    }

    public static String getCourseNameById(String cid) {
        CsvFile c = (CsvFile) all.get("course");
        for (int i = 0; i < c.allRecords.length; i++) {
            if (c.allRecords[i][0].equals(cid)) {
                return c.allRecords[i][1];
            }
        }
        return "";
    }

    public static void delCourse(String cid) {
        CsvFile c = (CsvFile) all.get("course");
        String[][] allRecords1 = new String[c.allRecords.length - 1][];
        int idx = 0;
        for (int i = 0; i < c.allRecords.length; i++) {
            if (!c.allRecords[i][0].equals(cid)) {
                allRecords1[idx++] = c.allRecords[i];
            }
        }
        c.allRecords = allRecords1;
        c.toFile();
    }

    public static void delClass(String cid) {
        CsvFile c = (CsvFile) all.get("class");
        String[][] allRecords1 = new String[c.allRecords.length - 1][];
        int idx = 0;
        for (int i = 0; i < c.allRecords.length; i++) {
            if (!c.allRecords[i][0].equals(cid)) {
                allRecords1[idx++] = c.allRecords[i];
            }
        }
        c.allRecords = allRecords1;
        c.toFile();
    }

    public static void delGrade(String cid) {
        CsvFile c = (CsvFile) all.get("grade");
        String[][] allRecords1 = new String[c.allRecords.length - 1][];
        int idx = 0;
        for (int i = 0; i < c.allRecords.length; i++) {
            if (!c.allRecords[i][0].equals(cid)) {
                allRecords1[idx++] = c.allRecords[i];
            }
        }
        c.allRecords = allRecords1;
        c.toFile();

        c = (CsvFile) all.get("class");
        for (int i = 0; i < c.allRecords.length; i++) {
            if (c.allRecords[i][1].equals(cid)) {
                c.allRecords[i][1] = "未知单位";
            }
        }
        c.toFile();

    }

    public static void delUser(String cid) {
        CsvFile c = (CsvFile) all.get("user");
        String[][] allRecords1 = new String[c.allRecords.length - 1][];
        int idx = 0;
        for (int i = 0; i < c.allRecords.length; i++) {
            if (!c.allRecords[i][0].equals(cid)) {
                allRecords1[idx++] = c.allRecords[i];
            }
        }
        c.allRecords = allRecords1;
        c.toFile();
    }

    public static int addUser(String username, String passwd, String realname,
                               String type, String classname) {
        CsvFile c = (CsvFile) all.get("user");
        String[][] allRecords1 = new String[c.allRecords.length + 1][];
        int idx = 0;
        for (int i = 0; i < c.allRecords.length; i++) {
            if (username.equals(c.allRecords[i][0])) {
                return 0;
            }
            allRecords1[idx++] = c.allRecords[i];
        }
        allRecords1[idx] = new String[] {
            username, passwd, realname, "", type, classname};
        c.allRecords = allRecords1;
        c.toFile();
        return 1;
    }

    public static void addCourse(String value) {
        CsvFile c = (CsvFile) all.get("course");
        String[][] allRecords1 = new String[c.allRecords.length + 1][];
        int idx = 0;
        String cid = "JC1";
        if (c.allRecords.length > 0) {
            cid = "JC" +
                (Integer.parseInt(c.allRecords[c.allRecords.length -
                                  1][0].substring(2)) +
                 1);
        }
        for (int i = 0; i < c.allRecords.length; i++) {
            allRecords1[idx++] = c.allRecords[i];
        }
        allRecords1[idx] = new String[] {
            cid,
            value,
            "0",
            "0",
            "0"
        };
        c.allRecords = allRecords1;
        java.io.File dirname = new java.io.File(MOTHER_PATH +
                                                java.io.File.separator + "c" +
                                                java.io.File.separator + cid);
        if (!dirname.exists()) {
            dirname.mkdir();
        }
        dirname = new java.io.File(MOTHER_PATH + java.io.File.separator + "c" +
                                   java.io.File.separator + cid +
                                   java.io.File.separator + "paper");
        if (!dirname.exists()) {
            dirname.mkdir();
        }
        dirname = new java.io.File(MOTHER_PATH + java.io.File.separator + "c" +
                                   java.io.File.separator + cid +
                                   java.io.File.separator + "1");
        if (!dirname.exists()) {
            dirname.mkdir();
        }
        dirname = new java.io.File(MOTHER_PATH + java.io.File.separator + "c" +
                                   java.io.File.separator + cid +
                                   java.io.File.separator + "atree.js");
        if (!dirname.exists()) {
            try {
                dirname.createNewFile();
            }
            catch (Exception e) {
                e.printStackTrace();
            }
        }

        String dd = "var atree = new Array( new Array(1,\"" + value +
            "\",0,false,\"0\"));";
        try {
            java.io.PrintWriter pout = new java.io.PrintWriter(new java.io.
                FileOutputStream(dirname));
            pout.print(dd);
            pout.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        c.toFile();
    }

    public static void addClass(String value, String value1) {
        CsvFile c = (CsvFile) all.get("class");
        String[][] allRecords1 = new String[c.allRecords.length + 1][];
        int idx = 0;
        for (int i = 0; i < c.allRecords.length; i++) {
            allRecords1[idx++] = c.allRecords[i];
        }
        allRecords1[idx] = new String[] {
            value,
            value1
        };
        c.allRecords = allRecords1;
        c.toFile();
    }

    public static void addGrade(String value) {
        CsvFile c = (CsvFile) all.get("grade");
        String[][] allRecords1 = new String[c.allRecords.length + 1][];
        int idx = 0;
        for (int i = 0; i < c.allRecords.length; i++) {
            allRecords1[idx++] = c.allRecords[i];
        }
        allRecords1[idx] = new String[] {
            value
        };
        c.allRecords = allRecords1;
        c.toFile();
    }

    public static void addClass(String value) {
        CsvFile c = (CsvFile) all.get("user");
        addClass(value, c.allRecords[0][0]);
    }

    public static void updateCourse(String cid, String value) {
        CsvFile c = (CsvFile) all.get("course");
        for (int i = 0; i < c.allRecords.length; i++) {
            if (c.allRecords[i][0].equals(cid)) {
                c.allRecords[i][1] = value;
            }
        }
        c.toFile();
    }

    public static void setTeacherCouser(String cid, String value) {
        value = value.trim();
        String[] values = value.split("\\s");
        java.util.Vector cv = new java.util.Vector();
        CsvFile c = (CsvFile) all.get("course");
        for (int k = 0; k < values.length; k++) {
            for (int i = 0; i < c.allRecords.length; i++) {
                if (c.allRecords[i][1].equals(values[k])) {
                    if (!cv.contains(c.allRecords[i][0])) {
                        cv.add(c.allRecords[i][0]);
                    }
                }
            }
        }

        c = (CsvFile) all.get("course_teacher");
        for (int i = c.allRecords.length - 1; i >= 0; i--) {
            if (c.allRecords[i][1].equals(cid)) {
                String[][] allRecords1 = new String[c.allRecords.length - 1][];
                for (int k = 0; k < i; k++) {
                    allRecords1[k] = c.allRecords[k];
                }
                for (int k = i + 1; k < c.allRecords.length; k++) {
                    allRecords1[k - 1] = c.allRecords[k];
                }
                c.allRecords = allRecords1;
            }
        }
        String[][] allRecords1 = new String[c.allRecords.length + cv.size()][];
        System.arraycopy(c.allRecords, 0, allRecords1, 0, c.allRecords.length);
        for (int i = 0; i < cv.size(); i++) {
            allRecords1[c.allRecords.length + i] = new String[] {
                (String) cv.get(i), cid, i == 0 ? "1" : "0"};
        }
        c.allRecords = allRecords1;
        c.toFile();
    }

    public static void modifyUserPassword(String cid, String value) {
        CsvFile c = (CsvFile) all.get("user");
        for (int i = 0; i < c.allRecords.length; i++) {
            if (c.allRecords[i][0].equals(cid)) {
                c.allRecords[i][1] = value;
            }
        }
        c.toFile();
    }

    public static void updateClass(String id, String value, String grade) {
        CsvFile c = (CsvFile) all.get("class");
        int idInt = Integer.parseInt(id);
        for (int i = 0; i < c.allRecords.length; i++) {
            if (i == idInt) {
                c.allRecords[i][0] = value;
                c.allRecords[i][1] = grade;
            }
        }
        c.toFile();
    }

    public static void updateGrade(String id, String value) {
        CsvFile c = (CsvFile) all.get("grade");
        int idInt = Integer.parseInt(id);
        for (int i = 0; i < c.allRecords.length; i++) {
            if (i == idInt) {
                c.allRecords[i][0] = value;
            }
        }
        c.toFile();
    }

    public static String getAClassGradeText(String cid, String value) {
        String rst = "<select id=\"dd" + cid + "\">";
        CsvFile c = (CsvFile) all.get("grade");
        for (int i = 0; i < c.allRecords.length; i++) {
            if (value.equals(c.allRecords[i][0])) {
                rst += "<option value=\"" + c.allRecords[i][0] + "\" selected>" +
                    c.allRecords[i][0] + "</option>";
            }
            else {
                rst += "<option value=\"" + c.allRecords[i][0] + "\">" +
                    c.allRecords[i][0] + "</option>";
            }
        }
        rst += "</select>";
        return rst;
    }

    public static String getClassOptions() {
        String rst = "";
        CsvFile c = (CsvFile) all.get("class");
        for (int i = 0; i < c.allRecords.length; i++) {
            rst += "<option value=\"" + c.allRecords[i][0] + "\">" +
                c.allRecords[i][1] + " " + c.allRecords[i][0] + "</option>";
        }
        return rst;
    }

    public static String delQuestion(String nowcourseid) {
        int a1, a2;
        a1 = nowcourseid.indexOf('_');
        a2 = nowcourseid.indexOf('_', a1 + 1);
        String dirname = MOTHER_PATH + java.io.File.separator + "c" +
            java.io.File.separator + nowcourseid.substring(0, a1) +
            java.io.File.separator + "" +
            nowcourseid.substring(a1 + 1, a2) +
            java.io.File.separator + "";
        CsvFile csvq = getACsvFile(dirname + "q.csv");
        for (int i = 0; i < csvq.allRecords.length; i++) {
            if (csvq.allRecords[i][0].equals(nowcourseid)) {
                String[][] allRecords1 = new String[csvq.allRecords.length - 1][];
                for (int j = 0; j < i; j++) {
                    allRecords1[j] = csvq.allRecords[j];
                }
                for (int j = i + 1; j < csvq.allRecords.length; j++) {
                    allRecords1[j - 1] = csvq.allRecords[j];
                }
                csvq.allRecords = allRecords1;
                break;
            }
        }
        csvq.toFile();

        csvq = getACsvFile(MOTHER_PATH + java.io.File.separator + "c.csv");
        for (int i = 0; i < csvq.allRecords.length; i++) {
            if (csvq.allRecords[i][0].equals(nowcourseid.substring(0, a1))) {

                csvq.allRecords[i][2] = "" +
                    (Integer.parseInt(csvq.allRecords[i][2]) - 1);
            }
        }
        csvq.toFile();

        java.io.File file = new java.io.File(dirname + nowcourseid + ".1");
        if (file.exists()) {
            file.delete();
        }
        file = new java.io.File(dirname + nowcourseid + ".2");
        if (file.exists()) {
            file.delete();
        }
        file = new java.io.File(dirname + nowcourseid + ".3");
        if (file.exists()) {
            file.delete();
        }
        return null;
    }

    public static String delPaper(String nowcourseid) {
        int a1, a2;
        a1 = nowcourseid.indexOf('_');
        a2 = nowcourseid.indexOf('_', a1 + 1);
        String dirname = MOTHER_PATH + java.io.File.separator + "c" +
            java.io.File.separator + nowcourseid.substring(0, a1) +
            java.io.File.separator + "" +
            nowcourseid.substring(a1 + 1, a2) + java.io.File.separator + "";
        CsvFile csvq = getACsvFile(dirname + "q.csv");
        for (int i = 0; i < csvq.allRecords.length; i++) {
            if (csvq.allRecords[i][0].equals(nowcourseid)) {
                String[][] allRecords1 = new String[csvq.allRecords.length - 1][];
                for (int j = 0; j < i; j++) {
                    allRecords1[j] = csvq.allRecords[j];
                }
                for (int j = i + 1; j < csvq.allRecords.length; j++) {
                    allRecords1[j - 1] = csvq.allRecords[j];
                }
                csvq.allRecords = allRecords1;
                break;
            }
        }
        csvq.toFile();

        csvq = getACsvFile(MOTHER_PATH + java.io.File.separator + "c.csv");
        for (int i = 0; i < csvq.allRecords.length; i++) {
            if (csvq.allRecords[i][0].equals(nowcourseid.substring(0, a1))) {
                csvq.allRecords[i][3] = "" +
                    (Integer.parseInt(csvq.allRecords[i][3]) - 1);
            }
        }
        csvq.toFile();

        java.io.File file = new java.io.File(dirname + nowcourseid + ".1");
        if (file.exists()) {
            file.delete();
        }
        file = new java.io.File(dirname + nowcourseid + ".2");
        if (file.exists()) {
            file.delete();
        }
        file = new java.io.File(dirname + nowcourseid + ".3");
        if (file.exists()) {
            file.delete();
        }
        return null;
    }

    public static void updateST(String nowcourseid, String st, String ss) {
        System.out.println(nowcourseid);
        System.out.println(st);
        String dirname = MOTHER_PATH + java.io.File.separator + "c" +
            java.io.File.separator + nowcourseid +
            java.io.File.separator;
        try {
            java.io.PrintWriter pout = new java.io.PrintWriter(new java.io.
                FileOutputStream(dirname + "atree.js"));
            pout.print(st);
            pout.close();
            if (ss != null && ss.length() > 0) {
                java.io.File f = new java.io.File(dirname + ss);
                f.mkdir();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String addQuestion(String nowcourseid, String qnodeid,
                                     String qcontent, String qcontenttext,
                                     String subcount, String issubjective,
                                     String qanswer, String qstructure,
                                     String qdifficulty, String questionid,
                                     String userid) {
        try {
            boolean isAdd = false;
            if (questionid == null || questionid.length() == 0) {
                isAdd = true;
                questionid = "1";
                CsvFile csv = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                          "c" +
                                          java.io.File.separator + nowcourseid +
                                          java.io.File.separator + "" +
                                          qnodeid + java.io.File.separator +
                                          "all.csv");
                if (csv.allRecords.length != 0) {
                    questionid = "" +
                        (Integer.parseInt(csv.allRecords[0][0]) + 1);
                }
                csv.allRecords = new String[1][1];
                csv.allRecords[0][0] = questionid;
                csv.toFile();
                questionid = nowcourseid + "_" + qnodeid + "_" + questionid;
            }
            int subcountInt = Integer.parseInt(subcount);
            if (qcontent.indexOf("<P") == 0) {
                qcontent = qcontent.substring(qcontent.indexOf(">") + 1,
                                              qcontent.indexOf("</P>"))
                    + qcontent.substring(qcontent.indexOf("</P>") + 4);
            }
            if (qstructure.equals("1")) {
                qcontent = qcontent + "<yzq/>答：";
                for (int i = 0; i < subcountInt; i++) {
                    qcontent = qcontent + "<input type=\"radio\" value=\"" +
                        (char) ('A' + i) + "\" name=\"s" + questionid + "\">" +
                        (char) ('A' + i) + "&nbsp;&nbsp;";
                }
                qcontent = qcontent + "<input type=\"hidden\" value=\"" +
                    issubjective +
                    "\" name=\"a" + questionid + "\">";
                qcontent = qcontent + "<span id=\"r" + questionid +
                    "\" type=\"1\" ></span><br/><br/>";
            }
            else if (qstructure.equals("2")) {
                qcontent = qcontent + "<yzq/>答：";
                for (int i = 0; i < subcountInt; i++) {
                    qcontent = qcontent + "<input type=\"checkbox\" value=\"" +
                        (char) ('A' + i) + "\" name=\"s" + questionid + "\">" +
                        (char) ('A' + i) + "&nbsp;&nbsp;";
                }
                qcontent = qcontent + "<input type=\"hidden\" value=\"" +
                    issubjective +
                    "\" name=\"a" + questionid + "\">";
                qcontent = qcontent + "<span id=\"r" + questionid +
                    "\" type=\"2\" ></span><br/><br/>";
            }
            else if (qstructure.equals("3")) {
                qcontent = qcontent + "<yzq/>答（请严格按照大小写填入）：";
                for (int i = 0; i < subcountInt; i++) {
                    qcontent = qcontent + "<br/>" + (i + 1) +
                        "、<input type=\"text\" size=\"80\" name=\"s" +
                        questionid + "\">";
                }
                qcontent = qcontent + "<span id=\"r" + questionid +
                    "\" type=\"3\" ></span>";
                qcontent = qcontent + "<input type=\"hidden\" value=\"" +
                    issubjective +
                    "\" name=\"a" + questionid + "\"><br/>";
            }
            else if (qstructure.equals("4")) {
                qcontent = qcontent + "<yzq/>答（请严格按照大小写填入）：<br/>";
                for (int i = 0; i < subcountInt; i++) {
                    qcontent = qcontent + (char) ('A' + i) +
                        "－<input type=\"text\" size=\"3\" name=\"s" +
                        questionid + "\">" +
                        "&nbsp;&nbsp;";
                }
                qcontent = qcontent + "<input type=\"hidden\" value=\"" +
                    issubjective +
                    "\" name=\"a" + questionid + "\">";
                qcontent = qcontent + "<span id=\"r" + questionid +
                    "\" type=\"4\" ></span><br/><br/>";
            }
            else if (qstructure.equals("5")) {
                qcontent = qcontent + "<br/><yzq/>答：";
                qcontent = qcontent +
                    "<input type=\"radio\" value=\"Y\" name=\"s" +
                    questionid + "\">正确" + "&nbsp;&nbsp;" +
                    "<input type=\"radio\" value=\"N\" name=\"s" + questionid +
                    "\">错误";
                qcontent = qcontent + "<input type=\"hidden\" value=\"" +
                    issubjective +
                    "\" name=\"a" + questionid + "\">";
                qcontent = qcontent + "<span id=\"r" + questionid +
                    "\" type=\"5\" ></span><br/><br/>";
            }
            else if (qstructure.equals("6")) {
                qcontent = qcontent + "<yzq/>答：<br/>";
                qcontent = qcontent +
                    "<textarea rows=\"6\" cols=\"60\" name=\"s" +
                    questionid + "\">" + "</textarea>";
                qcontent = qcontent + "<input type=\"hidden\" value=\"" +
                    issubjective +
                    "\" name=\"a" + questionid + "\">";
                qcontent = qcontent + "<span id=\"r" + questionid +
                    "\" type=\"6\" ></span><br/><br/>";
            }

            CsvFile csv1 = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator + "" +
                                       questionid + ".1");
            csv1.allRecords = new String[][] {
                {
                qcontent}
            };
            csv1.toFile();

            CsvFile csv2 = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator + "" +
                                       questionid + ".2");
            csv2.allRecords = new String[][] {
                {
                qcontenttext}
            };
            csv2.toFile();

            CsvFile csv3 = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator + "" +
                                       questionid + ".3");
            csv3.allRecords = new String[][] {
                {
                qanswer}
            };
            csv3.toFile();

            CsvFile csvq = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator +
                                       "q.csv");
            if (qcontenttext != null && qcontenttext.length() >= 31) {
                qcontenttext = qcontenttext.substring(0, 28) + "……";
            }
            if (isAdd) {
                csvq.addARecordToFile(new String[] {questionid, qcontenttext,
                                      qstructure,
                                      qdifficulty,
                                      "" + System.currentTimeMillis(),
                                      qnodeid, subcount, issubjective, userid,
                                      "", "",
                                      "", "", ""});
                csvq = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                   "c.csv");
                for (int i = 0; i < csvq.allRecords.length; i++) {
                    if (csvq.allRecords[i][0].equals(nowcourseid)) {
                        csvq.allRecords[i][2] = "" +
                            (Integer.parseInt(csvq.allRecords[i][2]) + 1);
                    }
                }
                csvq.toFile();
            }
            else {
                for (int i = 0; i < csvq.allRecords.length; i++) {
                    if (csvq.allRecords[i][0].equals(questionid)) {
                        csvq.allRecords[i][1] = qcontenttext;
                        csvq.allRecords[i][3] = qdifficulty;
                        csvq.allRecords[i][6] = subcount;
                        csvq.allRecords[i][7] = issubjective;
                        csvq.allRecords[i][9] = "" + System.currentTimeMillis();
                        csvq.allRecords[i][10] = userid;
                        break;
                    }
                }
                csvq.toFile();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String getPaperData(String nowcourseid, String paperid) {
        CsvFile csv1 = getACsvFile(MOTHER_PATH + java.io.File.separator + "c" +
                                   java.io.File.separator + nowcourseid +
                                   java.io.File.separator + "" +
                                   "paper" + java.io.File.separator + "" +
                                   paperid +
                                   ".1");
        return csv1.allRecords[0][0];
    }

    public static String addPaper(String nowcourseid, String paperdata,
                                  String userid, String paperid) {
        String qnodeid = "paper";
        try {
            boolean isAdd = false;
            if (paperid == null || paperid.length() == 0) {
                isAdd = true;
                paperid = "1";
                CsvFile csv = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                          "c" +
                                          java.io.File.separator + nowcourseid +
                                          java.io.File.separator + "" +
                                          qnodeid + java.io.File.separator +
                                          "all.csv");
                if (csv.allRecords.length != 0) {
                    paperid = "" + (Integer.parseInt(csv.allRecords[0][0]) + 1);
                }
                csv.allRecords = new String[1][1];
                csv.allRecords[0][0] = paperid;
                csv.toFile();
                paperid = nowcourseid + "_" + qnodeid + "_" + paperid;
            }

            CsvFile csv1 = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator + "" +
                                       paperid + ".1");
            csv1.allRecords = new String[][] {
                {
                paperdata}
            };
            csv1.toFile();

            String[] ca = getPaperContentAndAnswer(nowcourseid, paperdata);
            CsvFile csv2 = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator + "" +
                                       paperid + ".2");
            csv2.allRecords = new String[][] {
                {
                ca[0]}
            };
            csv2.toFile();

            CsvFile csv3 = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator + "" +
                                       paperid + ".3");
            csv3.allRecords = new String[][] {
                {
                ca[1]}
            };
            csv3.toFile();

            CsvFile csvq = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator +
                                       "q.csv");
            if (isAdd) {
                csvq.addARecordToFile(getPaperRecord(paperid, paperdata, userid));
                csvq = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                   "c.csv");
                for (int i = 0; i < csvq.allRecords.length; i++) {
                    if (csvq.allRecords[i][0].equals(nowcourseid)) {
                        csvq.allRecords[i][3] = "" +
                            (Integer.parseInt(csvq.allRecords[i][3]) + 1);
                    }
                }
                csvq.toFile();
            }
            else {
                for (int i = 0; i < csvq.allRecords.length; i++) {
                    if (csvq.allRecords[i][0].equals(paperid)) {
                        csvq.allRecords[i] = getPaperRecord(paperid, paperdata,
                            userid);
                        break;
                    }
                }
                csvq.toFile();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 创建一个实例
     * @param filePath 文件路径
     */
    public CsvFile(String filePath) {
        if (filePath == null) {
            throw new java.lang.NullPointerException("filePath cannot be null");
        }
        this.filePath = filePath;
        toMem();
    }

    /**
     * 将文件的内容写入数组allRecords
     * @return 如果没有出错，返回null，否则返回出错信息。
     */
    public String toMem() {
        try {
            java.io.File f = new java.io.File(filePath);
            if (!f.exists()) {
                allRecords = new String[0][0];
                return "The file is not exist";
            }
            java.io.FileInputStream in = new java.io.FileInputStream(filePath);
            int rows = 0, cols = 0, ch;
            allRecords = new String[0][0];
            byte[] token = new byte[1024], token1;
            int now = 0;
            while ( (ch = in.read()) != -1) {
                if (ch == COLUMN_SEPERATOR || ch == ROW_SEPERATOR) {
                    if (allRecords.length < (rows + 1)) {
                        String[][] allRecords1 = new String[allRecords.length +
                            1][];
                        System.arraycopy(allRecords, 0, allRecords1, 0,
                                         allRecords.length);
                        allRecords = allRecords1;
                        allRecords[rows] = new String[cols];
                        cols = 0;
                    }
                    if (allRecords[rows].length < (cols + 1)) {
                        String[] record = new String[cols + 1];
                        System.arraycopy(allRecords[rows], 0, record, 0,
                                         allRecords[rows].length);
                        allRecords[rows] = record;
                    }
                    token1 = new byte[now];
                    System.arraycopy(token, 0, token1, 0, now);
                    allRecords[rows][cols++] = new String(token1);
                    if (ch == ROW_SEPERATOR) {
                        rows++;
                    }
                    now = 0;
                }
                else {
                    if (token.length < now + 1) {
                        token1 = new byte[token.length + 1024];
                        System.arraycopy(token, 0, token1, 0, token.length);
                        token = token1;
                    }
                    token[now++] = (byte) ch;
                }
            }
            in.close();
            return null;
        }
        catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    public static String[] getPaperContentAndAnswer(String nowcourseid,
        String paperdata) {
        String content = "", answer = "";
        String jsString = "<script>var allquestions = new Array(";
        int start = 0,
            end = paperdata.indexOf(SAPERATE_CHAR, start);
        content += "<p align=\"center\" class=\"papertitle\">" +
            paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        content += "<p align=\"right\" class=\"papertitle1\">" + "总分" +
            paperdata.substring(start, end) + "分 ";
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        String stime = "";
        try {
            content +=
                "<input type=\"hidden\" id=\"paperopentime\" name=\"paperopentime\" value=\"" +
                paperdata.substring(start, end) + "\"/>";
            stime = new java.util.Date(Long.parseLong(paperdata.substring(start,
                end))).toString();
            //    toLocaleString();
            stime = stime.substring(0, stime.length() - 3);
        }
        catch (Exception e) {
            stime = paperdata.substring(start, end);
        }
        content += "考试时间 " + stime + "～";
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        try {
            content +=
                "<input type=\"hidden\" id=\"paperclosetime\" name=\"paperclosetime\" value=\"" +
                paperdata.substring(start, end) + "\"/>";
            stime = new java.util.Date(Long.parseLong(paperdata.substring(start,
                end))).toString();
            //    toLocaleString();
            stime = stime.substring(0, stime.length() - 3);
        }
        catch (Exception e) {
            stime = paperdata.substring(start, end);
        }
        content += stime + "</p>";
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        int mtcount = 0;
        try {
            mtcount = Integer.parseInt(paperdata.substring(start, end));
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        String mtname, mtqnum, mtscore, mstyle;
        int mtqnumint = 0, xtnum = 1;
        String xtcode, xtscore;
        for (int i = 0; i < mtcount; i++) {
            start = end + 1;
            end = paperdata.indexOf(SAPERATE_CHAR, start);
            mtname = paperdata.substring(start, end);
            start = end + 1;
            end = paperdata.indexOf(SAPERATE_CHAR, start);
            mstyle = paperdata.substring(start, end);
            start = end + 1;
            end = paperdata.indexOf(SAPERATE_CHAR, start);
            mtscore = paperdata.substring(start, end);
            start = end + 1;
            end = paperdata.indexOf(SAPERATE_CHAR, start);
            mtqnum = paperdata.substring(start, end);
            content += "<p class=\"mttitle\">" + onetow[i] + "&nbsp;&nbsp;" +
                mtname +
                "（共" + mtqnum + "道小题，总分" + mtscore + "分）</p>";
            mtqnumint = 0;
            try {
                mtqnumint = Integer.parseInt(mtqnum);
            }
            catch (Exception e) {
                e.printStackTrace();
            }
            for (int j = 0; j < mtqnumint; j++) {
                start = end + 1;
                end = paperdata.indexOf(SAPERATE_CHAR, start);
                xtcode = paperdata.substring(start, end);
                start = end + 1;
                jsString += "\"" + xtcode + "\",";
                end = paperdata.indexOf(SAPERATE_CHAR, start);
                xtscore = paperdata.substring(start, end);
                content += (xtnum++) + "(" + xtscore + "分)&nbsp;&nbsp;" +
                    getXTContent(nowcourseid, xtcode, xtscore, mstyle) + "";
                answer += getXTAnswer(nowcourseid, xtcode, xtscore, mstyle);
            }
        }
        jsString += "0);</script>";
        content = content + jsString;
        return new String[] {
            content, answer};
    }

    private static String getXTContent(String nowcourseid, String xtcode,
                                       String xtscore, String mstyle) {
        String qnodeid = xtcode.substring(xtcode.indexOf('_') + 1,
                                          xtcode.indexOf('_',
            xtcode.indexOf('_') + 1));
        CsvFile csv1 = getACsvFile(MOTHER_PATH + java.io.File.separator + "c" +
                                   java.io.File.separator + nowcourseid +
                                   java.io.File.separator + "" +
                                   qnodeid + java.io.File.separator + "" +
                                   xtcode +
                                   ".1");
        if (csv1.allRecords != null && csv1.allRecords.length >= 1) {
            return csv1.allRecords[0][0];
        }
        else {
            return "<font color=\"red\">该试题已经被人从题库中删除！</font><br/><br/>";
        }
    }

    private static String getXTAnswer(String nowcourseid, String xtcode,
                                      String xtscore, String mstyle) {
        String qnodeid = xtcode.substring(xtcode.indexOf('_') + 1,
                                          xtcode.indexOf('_',
            xtcode.indexOf('_') + 1));
        CsvFile csv1 = getACsvFile(MOTHER_PATH + java.io.File.separator + "c" +
                                   java.io.File.separator + nowcourseid +
                                   java.io.File.separator + "" +
                                   qnodeid + java.io.File.separator + "" +
                                   xtcode +
                                   ".3");
        if (csv1.allRecords != null && csv1.allRecords.length >= 1) {
            return xtscore + "," + csv1.allRecords[0][0] + '\0';
        }
        else {
            return "";
        }
    }

    private static String[] getPaperRecord(String paperid, String paperdata,
                                           String userid) {
        int start = 0, end;
        String[] rst = new String[14];
        rst[0] = paperid;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[1] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[2] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[3] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[4] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[5] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[6] = paperdata.substring(start, end);
        rst[7] = "" + System.currentTimeMillis();
        rst[8] = userid;
        rst[9] = "" + System.currentTimeMillis();
        rst[10] = userid;
        rst[11] = "1";
        rst[12] = "0";
        rst[13] = "0";
        return rst;
    }

    /**
     * 将allRecords的内容写入文件，一般用在删除数据时。
     * @return 如果没有出错，返回null，否则返回出错信息。
     */
    public String toFile() {
        try {
            java.io.File f = new java.io.File(filePath);
            if (f.exists()) {
                f.delete();
            }
            f.createNewFile();
            java.io.FileOutputStream out = new java.io.FileOutputStream(f);
            for (int i = 0; i < allRecords.length; i++) {
                for (int j = 0; j < allRecords[0].length; j++) {
                    out.write(allRecords[i][j].getBytes());
                    if (j != allRecords[i].length - 1) {
                        out.write(COLUMN_SEPERATOR_BYTES);
                    }
                    else {
                        out.write(ROW_SEPERATOR_BYTES);
                    }
                }
            }
            out.close();
            return null;
        }
        catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    public static String[][] getAllSelectCourse(String username) {
        String[][] rst = new String[0][];
        zy.util.CsvFile csv_course_user = (zy.util.CsvFile) zy.util.CsvFile.all.
            get(
            "course_teacher");
        zy.util.CsvFile csv_course = (zy.util.CsvFile) zy.util.CsvFile.all.get(
            "course");
        for (int j = 0; j < csv_course_user.allRecords.length; j++) {
            if (csv_course_user.allRecords[j][1].equals(username)) {
                String[][] rst1 = new String[rst.length + 1][];
                System.arraycopy(rst, 0, rst1, 0, rst.length);
                for (int i = 0; i < csv_course.allRecords.length; i++) {
                    if (csv_course.allRecords[i][0].equals(csv_course_user.
                        allRecords[j][
                        0])) {
                        rst1[rst1.length - 1] = csv_course.allRecords[i];
                    }
                }
                rst = rst1;
            }
        }
        return rst;
    }

    /**
     * 向文件中增加记录，在进行添加记录时用到。
     * @return 如果没有出错，返回null，否则返回出错信息。
     */
    public String addARecordToFile(String[] data) {
        try {
            String[][] allRecords1 = new String[allRecords.length + 1][];
            System.arraycopy(allRecords, 0, allRecords1, 0, allRecords.length);
            allRecords1[allRecords.length] = data;
            allRecords = allRecords1;

            java.io.File f = new java.io.File(filePath);
            if (!f.exists()) {
                f.createNewFile();
            }
            java.io.FileOutputStream out = new java.io.FileOutputStream(f, true);
            for (int i = 0; i < data.length; i++) {
                out.write(data[i].getBytes());
                if (i != data.length - 1) {
                    out.write(COLUMN_SEPERATOR_BYTES);
                }
            }
            out.write(ROW_SEPERATOR_BYTES);
            out.close();
            return null;
        }
        catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    /**
     *单元测试
     */
    public static boolean unitTest() {
        return true;
    }

    public static String getCT(String activecourseid) {
        java.io.File f = new java.io.File(MOTHER_PATH + java.io.File.separator +
                                          "c" + java.io.File.separator +
                                          activecourseid +
                                          java.io.File.separator + "atree.js");
        if (!f.exists()) {
            return "var atree=new Array();";
        }
        try {
            java.io.FileInputStream in = new java.io.FileInputStream(f);
            int fl = in.available();
            byte[] data = new byte[fl];
            in.read(data, 0, fl);
            in.close();
            return new String(data);
        }
        catch (Exception e) {
            e.printStackTrace();
            return "var atree=new Array();";
        }
    }

    public static void delExaming(String nowcourseid, String paperid, String
                                  username) {
        zy.util.CsvFile csv2 = getACsvFile(zy.util.CsvFile.MOTHER_PATH +
                                           java.io.File.separator + "c" +
                                           java.io.File.separator + nowcourseid +
                                           java.io.File.separator + "" +
                                           "paper" + java.io.File.separator +
                                           paperid + ".csv");
        String[][] allRecords1 = new String[csv2.allRecords.length - 1][];
        int idx = 0;
        for (int i = 0; i < csv2.allRecords.length; i++) {
            if (!csv2.allRecords[i][0].equals(username)) {
                allRecords1[idx++] = csv2.allRecords[i];
            }
        }
        csv2.allRecords = allRecords1;
        csv2.toFile();

        String ans = zy.util.CsvFile.MOTHER_PATH +
            java.io.File.separator + "c" +
            java.io.File.separator + nowcourseid +
            java.io.File.separator + "" +
            "paper" + java.io.File.separator +
            paperid + "_" +
            username + ".ans";
        java.io.File ff = new java.io.File(ans);
        if (ff.exists()) {
            ff.delete();
        }

        String score = zy.util.CsvFile.MOTHER_PATH +
            java.io.File.separator + "c" +
            java.io.File.separator + nowcourseid +
            java.io.File.separator + "" +
            "paper" + java.io.File.separator +
            paperid + "_" +
            username + ".score";
        java.io.File ff1 = new java.io.File(score);
        if (ff1.exists()) {
            ff.delete();
        }
    }

    public static String dealExaming(String actionname, String answer,
                                     String nowcourseid, String paperid, String
                                     username, String issubjective) {
        zy.util.CsvFile csv = getACsvFile(zy.util.CsvFile.MOTHER_PATH +
                                          java.io.File.separator + "c" +
                                          java.io.File.separator + nowcourseid +
                                          java.io.File.separator + "" +
                                          "paper" + java.io.File.separator +
                                          paperid + ".3");
        zy.util.CsvFile csv1 = getACsvFile(zy.util.CsvFile.MOTHER_PATH +
                                           java.io.File.separator + "c" +
                                           java.io.File.separator + nowcourseid +
                                           java.io.File.separator + "" +
                                           "paper" + java.io.File.separator +
                                           paperid + "_" +
                                           username + ".ans");
        csv1.allRecords = new String[][] {
            {
            answer}
        };
        csv1.toFile();

        if (actionname.equals("handin")) {
            float score = 0;
            float totalScore = 0;
            int start = 0, end = 0;
            int start1 = 0, end1 = 0;
            String qanswer = "";
            String rightAnswer = "";
            String scoreString = "";
            boolean needJudge = false;
            for (int i = 0; i < csv.allRecords[0].length - 1; i++) {
                end = issubjective.indexOf('\u0002', start);
                end1 = answer.indexOf('\u0002', start1);
                rightAnswer = csv.allRecords[0][i].substring(csv.allRecords[0][
                    i].
                    indexOf(',') + 1);
                score = 0;
                boolean isSjt = false;
                try {
                    score = Float.parseFloat(csv.allRecords[0][i].substring(0,
                        csv.allRecords[0][i].indexOf(',')));
                }
                catch (Exception e) {}
                isSjt = issubjective.substring(start, end).equals("Y");
                qanswer = answer.substring(start1, end1);
                start = end + 1;
                start1 = end1 + 1;
                if (!isSjt) {
                    if (qanswer.indexOf(SAPERATE_CHAR) < 0) {
                        if (qanswer.equalsIgnoreCase(rightAnswer)) {
                            totalScore += score;
                            scoreString += score + "\u0002";
                        }
                        else {
                            scoreString += "0" + "\u0002";
                        }
                    }
                    else {
                        int subcount = 0;
                        int rightCount = 0;
                        while (rightAnswer.indexOf(SAPERATE_CHAR) >= 0) {
                            if (rightAnswer.substring(0,
                                rightAnswer.indexOf(SAPERATE_CHAR)).
                                equals(
                                qanswer.substring(0,
                                                  qanswer.indexOf(SAPERATE_CHAR)))) {
                                rightCount++;
                            }
                            subcount++;
                            rightAnswer = rightAnswer.substring(rightAnswer.
                                indexOf(
                                SAPERATE_CHAR) + 1);
                            qanswer = qanswer.substring(qanswer.indexOf(
                                SAPERATE_CHAR) + 1);
                        }
                        totalScore += 1.0 * rightCount / subcount * score;
                        scoreString += (1.0 * rightCount / subcount * score) +
                            "\u0002";
                    }
                }
                else {
                    needJudge = true;
                    scoreString += "0" + "\u0002";
                }
            }
            zy.util.CsvFile csv2 = getACsvFile(zy.util.CsvFile.MOTHER_PATH +
                                               java.io.File.separator + "c" +
                                               java.io.File.separator +
                                               nowcourseid +
                                               java.io.File.separator + "" +
                                               "paper" + java.io.File.separator +
                                               paperid + ".csv");
            csv2.addARecordToFile(new String[] {username,
                                  System.currentTimeMillis() + "",
                                  totalScore + "",
                                  needJudge ? "0" : "1"});
            zy.util.CsvFile csv4 = getACsvFile(zy.util.CsvFile.MOTHER_PATH +
                                               java.io.File.separator + "c" +
                                               java.io.File.separator +
                                               nowcourseid +
                                               java.io.File.separator + "" +
                                               "paper" + java.io.File.separator +
                                               paperid + "_" +
                                               username + ".score");
            csv4.allRecords = new String[][] {
                {
                scoreString}
            };
            csv4.toFile();
            return Math.round(totalScore) + "";
        }
        else {
            return null;
        }
    }

    public static String dealJudge(String nowcourseid, String paperid, String
                                   username, String judgeusername, String
                                   newscores, String newtotalscore) {
        zy.util.CsvFile csv4 = getACsvFile(zy.util.CsvFile.MOTHER_PATH +
                                           java.io.File.separator + "c" +
                                           java.io.File.separator + nowcourseid +
                                           java.io.File.separator + "" +
                                           "paper" + java.io.File.separator +
                                           paperid + "_" +
                                           username + ".score");
        csv4.allRecords[0][0] = newscores;
        csv4.toFile();
        zy.util.CsvFile csv2 = getACsvFile(zy.util.CsvFile.MOTHER_PATH +
                                           java.io.File.separator + "c" +
                                           java.io.File.separator + nowcourseid +
                                           java.io.File.separator + "" +
                                           "paper" + java.io.File.separator +
                                           paperid + ".csv");
        for (int i = 0; i < csv2.allRecords.length; i++) {
            if (csv2.allRecords[i][0].equals(username)) {
                csv2.allRecords[i][2] = newtotalscore;
                csv2.allRecords[i][3] = "1";
            }
        }
        csv2.toFile();

        return newtotalscore;
    }

    public static String getMyScore(String nowcourseid, String paperid, String
                                    username) {
        try {
            zy.util.CsvFile csv2 = getACsvFile(zy.util.CsvFile.MOTHER_PATH +
                                               java.io.File.separator + "c" +
                                               java.io.File.separator +
                                               nowcourseid +
                                               java.io.File.separator + "" +
                                               "paper" + java.io.File.separator +
                                               paperid + ".csv");
            for (int i = 0; i < csv2.allRecords.length; i++) {
                if (csv2.allRecords[i][0].equals(username)) {
                    String rst = Math.round(Float.parseFloat(csv2.allRecords[i][
                        2])) + "";
                    if (csv2.allRecords[i][3].equals("0")) {
                        rst += "(待阅卷)";
                    }
                    return rst;
                }
            }
            return null;
        }
        catch (Exception e) {
            return null;
        }

    }

    public static String dealReport(String reporttype, String reportorcg,
                                    String reportcg, String reporttitle,
                                    String reportwhat) {
        String[] paperIds = new String[0];
        String[] paperAliases = new String[0];
        String paperId, paperAliase;
        while (reportwhat.length() > 0) {
            paperId = reportwhat.substring(0, reportwhat.indexOf(SAPERATE_CHAR));
            reportwhat = reportwhat.substring(reportwhat.indexOf(SAPERATE_CHAR) +
                                              1);
            paperAliase = reportwhat.substring(0,
                                               reportwhat.indexOf(SAPERATE_CHAR));
            reportwhat = reportwhat.substring(reportwhat.indexOf(SAPERATE_CHAR) +
                                              1);
            String[] paperIds1 = new String[paperIds.length + 1];
            System.arraycopy(paperIds, 0, paperIds1, 0, paperIds.length);
            paperIds1[paperIds.length] = paperId;
            paperIds = paperIds1;
            String[] paperAliases1 = new String[paperAliases.length + 1];
            System.arraycopy(paperAliases, 0, paperAliases1, 0,
                             paperAliases.length);
            paperAliases1[paperAliases.length] = paperAliase;
            paperAliases = paperAliases1;
        }
        int colsCount = paperAliases.length + 3;
        if (paperAliases.length == 1) {
            --colsCount;
        }
        if (reportorcg.equals("grade")) {
            ++colsCount;
        }
        int total = 0, tmpScore = 0;
        String[][] all = new String[1][];
        String[] temp = new String[colsCount];
        int idx = 0;
        temp[idx++] = "姓名";
        if (reportorcg.equals("grade")) {
            temp[idx++] = "班级";
        }
        for (int i = 0; i < paperAliases.length; i++) {
            temp[idx++] = paperAliases[i];
        }
        if (paperAliases.length != 1) {
            temp[idx++] = "总分";
        }
        temp[idx++] = "名次";
        all[0] = temp;
        if (reportorcg.equals("grade")) {
            CsvFile class_csv = (CsvFile) CsvFile.all.get("class");
            for (int k = 0; k < class_csv.allRecords.length; k++) {
                if (class_csv.allRecords[k][1].equals(reportcg)) {
                    CsvFile user_csv = (CsvFile) CsvFile.all.get("user");
                    for (int i = 0; i < user_csv.allRecords.length; i++) {
                        if (user_csv.allRecords[i][5].equals(class_csv.
                            allRecords[k][0])) {
                            temp = new String[colsCount];
                            idx = 0;
                            temp[idx++] = user_csv.allRecords[i][2];
                            total = 0;
                            temp[idx++] = class_csv.allRecords[k][0];

                            for (int j = 0; j < paperAliases.length; j++) {
                                tmpScore = getScoreOf(paperIds[j],
                                    user_csv.allRecords[i][0]);
                                if (tmpScore == -1) {
                                    temp[idx++] = "未完成";
                                    total += 0;
                                }
                                else if (tmpScore == -2) {
                                    temp[idx++] = "不用做";
                                    total += 0;
                                }
                                else {
                                    temp[idx++] = "" + tmpScore;
                                    total += tmpScore;
                                }
                            }
                            if (paperAliases.length != 1) {
                                temp[idx++] = "" + total;
                            }
                            temp[idx++] = "0";

                            String[][] all1 = new String[all.length + 1][];
                            System.arraycopy(all, 0, all1, 0, all.length);
                            all1[all.length] = temp;
                            all = all1;
                        }
                    }
                }
            }
        }
        else {
            CsvFile user_csv = (CsvFile) CsvFile.all.get("user");
            for (int i = 0; i < user_csv.allRecords.length; i++) {
                if (user_csv.allRecords[i][5].equals(reportcg)) {
                    temp = new String[colsCount];
                    idx = 0;
                    temp[idx++] = user_csv.allRecords[i][2];
                    total = 0;
                    if (reportorcg.equals("grade")) {
                        temp[idx++] = "班级";

                    }
                    for (int j = 0; j < paperAliases.length; j++) {
                        tmpScore = getScoreOf(paperIds[j],
                                              user_csv.allRecords[i][0]);
                        if (tmpScore == -1) {
                            temp[idx++] = "未完成";
                            total += 0;
                        }
                        else if (tmpScore == -2) {
                            temp[idx++] = "不用做";
                            total += 0;
                        }
                        else {
                            temp[idx++] = "" + tmpScore;
                            total += tmpScore;
                        }

                    }
                    if (paperAliases.length != 1) {
                        temp[idx++] = "" + total;
                    }
                    temp[idx++] = "0";

                    String[][] all1 = new String[all.length + 1][];
                    System.arraycopy(all, 0, all1, 0, all.length);
                    all1[all.length] = temp;
                    all = all1;
                }
            }
        }
        idx = all[0].length - 2;
        int tmpa, tmpb, tmpc = 100000, order = 0;
        for (int i = 1; i < all.length; i++) {
            for (int j = i + 1; j < all.length; j++) {
                if (all[i][idx].equals("未完成")) {
                    tmpa = -1;
                }
                else if (all[i][idx].equals("不用做")) {
                    tmpa = -2;
                }
                else {
                    tmpa = Integer.parseInt(all[i][idx]);
                }
                if (all[j][idx].equals("未完成")) {
                    tmpb = -1;
                }
                else if (all[j][idx].equals("不用做")) {
                    tmpb = -2;
                }
                else {
                    tmpb = Integer.parseInt(all[j][idx]);
                }
                if (tmpb > tmpa) {
                    String[] tmp = all[j];
                    all[j] = all[i];
                    all[i] = tmp;
                }
            }
            if (all[i][idx].equals("未完成")) {
                tmpa = -1;
            }
            else if (all[i][idx].equals("不用做")) {
                tmpa = -2;
            }
            else {
                tmpa = Integer.parseInt(all[i][idx]);
            }
            if (tmpa < tmpc) {
                order++;
            }
            all[i][idx + 1] = "" + order;
            tmpc = tmpa;
        }
        for (int i = 0; i < all.length; i++) {
            for (int j = 0; j < all[0].length; j++) {
            }
        }
        String aaa = "<html><meta http-equiv=\"content-type\" content=\"text/html; charset=gb2312\"><head><style>.topcell{border-bottom:.5pt black solid;}.datacell{border-left:.5pt black solid;border-bottom:.5pt black solid;}.rightcell{border-left:.5pt black solid;}</style></head><body leftmargin=50 topmargin=30 align=center>";
        aaa += "<h1 align=center>" + reporttitle +
            "</h1><br><table cellpadding=0 cellspacing=0 align=center>";

        aaa += "<tr height=10><td width=10>&nbsp;</td>";
        for (int i = 0; i < all[0].length; i++) {
            aaa += "<td class=topcell width=10>&nbsp;</td>";
        }
        aaa += "<td width=10></td></tr>";

        aaa += "<tr><td width=10>&nbsp;</td>";
        for (int i = 0; i < all[0].length; i++) {
            aaa += "<td class=datacell style='background:#d6d3ce' width=" +
                (all[0][i].length() * 20) + ">" + all[0][i] + "</td>";
        }
        aaa += "<td class=rightcell width=10>&nbsp;</td></tr>";

        for (int k = 1; k < all.length; k++) {
            aaa += "<tr ><td width=10>&nbsp;</td>";
            for (int i = 0; i < all[0].length; i++) {
                aaa += "<td class=datacell width=" + (all[k][i].length() * 30) +
                    ">" +
                    all[k][i] + "</td>";
            }
            aaa += "<td class=rightcell width=10>&nbsp;</td></tr>";
        }

        aaa += "</table></body>";
        if (reporttype.equals("xls")) {
            String fileName = "r" + System.currentTimeMillis() +
                Math.round(Math.random() * 1000) + ".xls";
            java.io.File f = new java.io.File(".." + java.io.File.separator +
                                              "webapps" +
                                              java.io.File.separator +
                                              "zhuangyuan" +
                                              java.io.File.separator +
                                              "report" + java.io.File.separator +
                                              fileName);
            try {
                f.createNewFile();
                java.io.FileOutputStream out = new java.io.FileOutputStream(f);
                out.write(aaa.getBytes());
                out.close();
                aaa = "report/" + fileName;
            }
            catch (Exception e) {
                e.printStackTrace();
            }

        }
        return aaa;
    }

    public static int getScoreOf(String paperid, String username) {
        int a1, a2;
        a1 = paperid.indexOf('_');
        a2 = paperid.indexOf('_', a1 + 1);
        String dirname = MOTHER_PATH + java.io.File.separator + "c" +
            java.io.File.separator + paperid.substring(0, a1) +
            java.io.File.separator + "" +
            paperid.substring(a1 + 1, a2) + java.io.File.separator + "";
        CsvFile csv = getACsvFile(dirname + paperid + ".csv");
        for (int i = 0; i < csv.allRecords.length; i++) {
            if (csv.allRecords[i][0].equals(username)) {
                return Math.round(Float.parseFloat(csv.allRecords[i][2]));
            }
        }

        String courseid = paperid.substring(0, a1);
        csv = getACsvFile(MOTHER_PATH + java.io.File.separator + "c_t.csv");
        for (int i = 0; i < csv.allRecords.length; i++) {
            if (csv.allRecords[i][0].equals(courseid) &&
                csv.allRecords[i][1].equals(username)) {
                return -1;
            }
        }

        return -2;
    }

    public static String addPaper1(String nowcourseid, String paperdata,
                                   String userid, String paperid,
                                   String paperlocation) {
        String qnodeid = "paper";
        try {
            boolean isAdd = false;
            if (paperid == null || paperid.length() == 0) {
                isAdd = true;
                paperid = "1";
                CsvFile csv = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                          "c" +
                                          java.io.File.separator + nowcourseid +
                                          java.io.File.separator + "" +
                                          qnodeid + java.io.File.separator +
                                          "all.csv");
                if (csv.allRecords.length != 0) {
                    paperid = "" + (Integer.parseInt(csv.allRecords[0][0]) + 1);
                }
                csv.allRecords = new String[1][1];
                csv.allRecords[0][0] = paperid;
                csv.toFile();
                paperid = nowcourseid + "_" + qnodeid + "_" + paperid;
            }

            CsvFile csv1 = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator + "" +
                                       paperid + ".1");
            csv1.allRecords = new String[][] {
                {
                paperdata}
            };
            csv1.toFile();

            String[] ca = getPaperContentAndAnswer1(nowcourseid, paperdata,
                paperlocation);
            CsvFile csv2 = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator + "" +
                                       paperid + ".2");
            csv2.allRecords = new String[][] {
                {
                ca[0]}
            };
            csv2.toFile();

            CsvFile csv3 = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator + "" +
                                       paperid + ".3");
            csv3.allRecords = new String[][] {
                {
                ca[1]}
            };
            csv3.toFile();

            CsvFile csvq = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                       "c" +
                                       java.io.File.separator + nowcourseid +
                                       java.io.File.separator + "" +
                                       qnodeid + java.io.File.separator +
                                       "q.csv");
            if (isAdd) {
                csvq.addARecordToFile(getPaperRecord1(paperid, paperdata,
                    paperlocation,
                    userid));
                csvq = getACsvFile(MOTHER_PATH + java.io.File.separator +
                                   "c.csv");
                for (int i = 0; i < csvq.allRecords.length; i++) {
                    if (csvq.allRecords[i][0].equals(nowcourseid)) {
                        csvq.allRecords[i][3] = "" +
                            (Integer.parseInt(csvq.allRecords[i][3]) + 1);
                    }
                }
                csvq.toFile();
            }
            else {
                for (int i = 0; i < csvq.allRecords.length; i++) {
                    if (csvq.allRecords[i][0].equals(paperid)) {
                        csvq.allRecords[i] = getPaperRecord1(paperid, paperdata,
                            paperlocation, userid);
                        break;
                    }
                }
                csvq.toFile();
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String[] getPaperContentAndAnswer1(String nowcourseid,
        String paperdata, String paperlocation) {
        String content = "", answer = "";
        String jsString = "<script>var paperlocation='" + paperlocation +
            "';var allquestions = new Array(";
        int start = 0,
            end = paperdata.indexOf(SAPERATE_CHAR, start);
        content += "<p align=\"center\" class=\"papertitle\">" +
            paperdata.substring(start, end) + "答题卡";
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        content += "<p align=\"center\" class=\"papertitle1\">" + "总分" +
            paperdata.substring(start, end) + "分 ";
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        String stime = "";
        try {
            content +=
                "<input type=\"hidden\" id=\"paperopentime\" name=\"paperopentime\" value=\"" +
                paperdata.substring(start, end) + "\"/>";
            stime = new java.util.Date(Long.parseLong(paperdata.substring(start,
                end))).toString();
            //    toLocaleString();
            stime = stime.substring(0, stime.length() - 3);
        }
        catch (Exception e) {
            stime = paperdata.substring(start, end);
        }
        content += "考试时间 " + stime + "～";
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        try {
            content +=
                "<input type=\"hidden\" id=\"paperclosetime\" name=\"paperclosetime\" value=\"" +
                paperdata.substring(start, end) + "\"/>";
            stime = new java.util.Date(Long.parseLong(paperdata.substring(start,
                end))).toString();
            //    toLocaleString();
            stime = stime.substring(0, stime.length() - 3);
        }
        catch (Exception e) {
            stime = paperdata.substring(start, end);
        }
        content += stime + "</p>";
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        int mtcount = 0;
        try {
            mtcount = Integer.parseInt(paperdata.substring(start, end));
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        String mtname, mtqnum, mtscore, mstyle;
        int mtqnumint = 0, xtnum = 1;
        String xtcode, xtscore, xtanswer;
        for (int i = 0; i < mtcount; i++) {
            start = end + 1;
            end = paperdata.indexOf(SAPERATE_CHAR, start);
            mtname = paperdata.substring(start, end);
            start = end + 1;
            end = paperdata.indexOf(SAPERATE_CHAR, start);
            mstyle = paperdata.substring(start, end);
            start = end + 1;
            end = paperdata.indexOf(SAPERATE_CHAR, start);
            mtscore = paperdata.substring(start, end);
            start = end + 1;
            end = paperdata.indexOf(SAPERATE_CHAR, start);
            mtqnum = paperdata.substring(start, end);
            content += "<p class=\"mttitle\">" + onetow[i] + "&nbsp;&nbsp;" +
                mtname +
                "（共" + mtqnum + "道小题，总分" + mtscore + "分）</p>";
            mtqnumint = 0;
            try {
                mtqnumint = Integer.parseInt(mtqnum);
            }
            catch (Exception e) {
                e.printStackTrace();
            }
            for (int j = 0; j < mtqnumint; j++) {
                start = end + 1;
                end = paperdata.indexOf(SAPERATE_CHAR, start);
                xtcode = "yzq_" + xtnum;
                xtanswer = paperdata.substring(start, end);
                start = end + 1;
                jsString += "\"" + xtcode + "\",";
                end = paperdata.indexOf(SAPERATE_CHAR, start);
                xtscore = paperdata.substring(start, end);
                if (mtname.indexOf("书面表达") >= 0 ||
                    mtname.indexOf("问答") >= 0 ||
                    mtname.indexOf("作文") >= 0 ||
                    mtname.indexOf("写作") >= 0 ||
                    mtname.indexOf("简答") >= 0 ||
                    mtname.indexOf("论述") >= 0 ||
                    mtname.indexOf("证明") >= 0 ||
                    mtname.indexOf("计算") >= 0 ||
                    mtname.indexOf("COMPOSITION") >= 0 ||
                    mtname.indexOf("Composition") >= 0 ||
                    mtname.indexOf("composition") >= 0) {
                    content += (xtnum++) + "(" + xtscore + "分)&nbsp;&nbsp;" +
                        "答：<br/><textarea  rows=\"26\" cols=\"48\" name=\"s" +
                        xtcode +
                        "\"/></textarea>&nbsp;&nbsp;<input type=\"hidden\" value=\"" +
                        mstyle +
                        "\" name=\"a" + xtcode + "\"><span id=\"r" + xtcode +
                        "\" type=\"" +
                        mstyle + "\" ></span><br/>" + "";
                }
                else {
                    content += (xtnum++) + "(" + xtscore + "分)&nbsp;&nbsp;" +
                        "答：<input type=\"text\" size=\"35\" name=\"s" + xtcode +
                        "\"/>&nbsp;&nbsp;<input type=\"hidden\" value=\"" +
                        mstyle +
                        "\" name=\"a" + xtcode + "\"><span id=\"r" + xtcode +
                        "\" type=\"" +
                        mstyle + "\" ></span><br/>" + "";
                }
                answer += xtscore + "," + xtanswer + '\0';
            }
        }
        jsString += "0);</script>";
        content = content + jsString;
        return new String[] {
            content, answer};
    }

    private static String[] getPaperRecord1(String paperid, String paperdata,
                                            String paperlocation
                                            , String userid) {
        int start = 0, end;
        String[] rst = new String[14];
        rst[0] = paperid;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[1] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[2] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[3] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[4] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[5] = paperdata.substring(start, end);
        start = end + 1;
        end = paperdata.indexOf(SAPERATE_CHAR, start);
        rst[6] = paperdata.substring(start, end);
        rst[7] = "" + System.currentTimeMillis();
        rst[8] = userid;
        rst[9] = "" + System.currentTimeMillis();
        rst[10] = userid;
        rst[11] = "2";
        rst[12] = "0";
        rst[13] = "0";
        return rst;
    }

    public static void main(String[] args) {
    }
}
