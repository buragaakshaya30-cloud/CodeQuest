
package com.codequest.servlet;

import java.io.IOException;

import com.codequest.dao.MissionDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/submitAnswer")
public class SubmitAnswerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String contextPath = request.getContextPath();

        HttpSession session = request.getSession(false);

        // Login is required only when no active student session exists.
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(contextPath + "/login.jsp");
            return;
        }

        try {
            int userId = (Integer) session.getAttribute("userId");

            int missionId = Integer.parseInt(
                request.getParameter("missionId")
            );

            String answer = request.getParameter("answer");

            if (answer == null || !answer.matches("[ABCD]")) {
                response.sendRedirect(contextPath + "/missions");
                return;
            }

            MissionDAO dao = new MissionDAO();

            int result = dao.submitAnswer(userId, missionId, answer);

            // Return to missions without destroying the login session.
            response.sendRedirect(
                contextPath + "/missions?result=" + result
            );

        } catch (NumberFormatException e) {
            response.sendRedirect(contextPath + "/missions");
        }
    }
}
