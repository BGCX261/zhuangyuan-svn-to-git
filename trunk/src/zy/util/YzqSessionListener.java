package zy.util;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class YzqSessionListener
    implements HttpSessionListener {
    public static int onlineCount = 0;
    public static java.util.Vector allActiveSessions = new java.util.Vector();

    public void sessionCreated(HttpSessionEvent hse) {
        javax.servlet.http.HttpSession session;
        boolean haveThisSession = false;
        for (int i = 0; i < allActiveSessions.size(); i++) {
            session = (javax.servlet.http.HttpSession) allActiveSessions.get(i);
            if (session.getId().equals(hse.getSession().getId())) {
                haveThisSession = true;
            }
        }
        if (!haveThisSession) {
            onlineCount += 1;
            try {
                allActiveSessions.add(hse.getSession());
            }
            catch (Exception e) {
            }
        }
    }

    public void sessionDestroyed(HttpSessionEvent hse) {
        javax.servlet.http.HttpSession session;
        boolean haveThisSession = false;
        for (int i = 0; i < allActiveSessions.size(); i++) {
            session = (javax.servlet.http.HttpSession) allActiveSessions.get(i);
            if (session.getId().equals(hse.getSession().getId())) {
                haveThisSession = true;
            }
        }
        if (haveThisSession) {
            onlineCount -= 1;
            try {
                allActiveSessions.remove(hse.getSession());
            }
            catch (Exception e) {
            }
        }
    }

    public static boolean haveUserLogined(String userName) {
        boolean result = false;
        javax.servlet.http.HttpSession tmp;
        for (int i = 0; i < allActiveSessions.size(); i++) {
            tmp = (javax.servlet.http.HttpSession) allActiveSessions.get(i);
            if (tmp.getAttribute("username") != null &&
                tmp.getAttribute("username").equals(userName)) {
                result = true;
                break;
            }
        }
        return result;
    }

    public static int whenUserLogin(javax.servlet.http.HttpSession theSession,
                                    String userName) {
        int result = 1;
        zy.util.CsvFile ss = zy.util.CsvFile.getACsvFile("sessionstrategy");
        int theSessionStrategy = 0;
        if (ss != null && ss.allRecords != null && ss.allRecords.length > 0 &&
            ss.allRecords[0].length > 0) {
            theSessionStrategy = Integer.parseInt(ss.allRecords[0][0]);
        }

        javax.servlet.http.HttpSession session;
        boolean haveThisSession = false;
        for (int i = 0; i < allActiveSessions.size(); i++) {
            session = (javax.servlet.http.HttpSession) allActiveSessions.get(i);
            if (session.getId().equals(theSession.getId())) {
                haveThisSession = true;
            }
            else {
                if (userName.equals(session.getAttribute(
                    "username"))) {
                    if (theSessionStrategy == 2) {
                        session.removeAttribute("username");
                        session.removeAttribute("password");
                        session.removeAttribute("realname");
                        session.removeAttribute("email");
                        session.removeAttribute("usertype");
                        result = 1;
                    }
                    else if (theSessionStrategy == 1) {
                        result = 0;
                    }
                }
            }
        }
        if (!haveThisSession) {
            allActiveSessions.add(theSession);
        }
        return result;
    }
}