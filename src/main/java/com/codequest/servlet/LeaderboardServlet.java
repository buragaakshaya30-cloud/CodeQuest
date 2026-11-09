
package com.codequest.servlet;

import java.io.IOException;
import java.util.List;

import com.codequest.dao.LeaderboardDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        LeaderboardDAO dao = new LeaderboardDAO();

        List<String[]> leaderboard = dao.getLeaderboard();

        request.setAttribute("leaderboard", leaderboard);

        request.getRequestDispatcher("/leaderboard.jsp")
               .forward(request, response);
    }
}
