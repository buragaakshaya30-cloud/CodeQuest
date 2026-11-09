
package com.codequest.servlet;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(urlPatterns = {
    "/index.jsp",
    "/login.jsp",
    "/adminLogin.jsp",
    "/studentHome.jsp",
    "/studentDashboard.jsp",
    "/missions",
    "/leaderboard",
    "/adminDashboard.jsp",
    "/manageMissions",
    "/addMission.jsp",
    "/addMission",
    "/editMission",
    "/updateMission",
    "/deleteMission",
    "/studentPerformance"
    
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // Prevent browser caching
        res.setHeader("Cache-Control",
                "no-cache, no-store, must-revalidate, private");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        HttpSession session = req.getSession(false);
        String path = req.getServletPath();

        boolean adminLoggedIn = session != null
                && session.getAttribute("adminUsername") != null
                && session.getAttribute("adminId") != null;

        boolean studentLoggedIn = session != null
                && session.getAttribute("userEmail") != null
                && session.getAttribute("userId") != null;
     // If already logged in, do not allow login or index pages
        if (adminLoggedIn &&
            (path.equals("/index.jsp") || path.equals("/adminLogin.jsp"))) {

            res.sendRedirect(req.getContextPath() + "/adminDashboard.jsp");
            return;
        }

        if (studentLoggedIn &&
            (path.equals("/index.jsp") || path.equals("/login.jsp"))) {

            res.sendRedirect(req.getContextPath() + "/studentHome.jsp");
            return;
        }

        // Public pages
        boolean publicPage =
                path.equals("/index.jsp") ||
                path.equals("/login.jsp") ||
                path.equals("/adminLogin.jsp");

        // If already logged in, don't show login or index pages
        if (publicPage) {

            if (adminLoggedIn) {
                res.sendRedirect(req.getContextPath()
                        + "/adminDashboard.jsp");
                return;
            }

            if (studentLoggedIn) {
                res.sendRedirect(req.getContextPath()
                        + "/studentHome.jsp");
                return;
            }
        }

        boolean adminPage =
                path.equals("/adminDashboard.jsp") ||
                path.equals("/manageMissions") ||
                path.equals("/addMission.jsp") ||
                path.equals("/addMission") ||
                path.equals("/editMission") ||
                path.equals("/updateMission") ||
                path.equals("/deleteMission") ||
                path.equals("/studentPerformance");

        boolean studentPage =
                path.equals("/studentHome.jsp") ||
                path.equals("/studentDashboard.jsp") ||
                path.equals("/missions") ||
                path.equals("/leaderboard");

        if (adminPage && !adminLoggedIn) {
            res.sendRedirect(req.getContextPath()
                    + "/adminLogin.jsp");
            return;
        }

        if (studentPage && !studentLoggedIn) {
            res.sendRedirect(req.getContextPath()
                    + "/login.jsp");
            return;
        }

        // Prevent one account type from accessing the other dashboard
        if (adminPage && studentLoggedIn) {
            res.sendRedirect(req.getContextPath()
                    + "/studentHome.jsp");
            return;
        }

        if (studentPage && adminLoggedIn) {
            res.sendRedirect(req.getContextPath()
                    + "/adminDashboard.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
