
package com.codequest.servlet;

import java.io.IOException;

import com.codequest.dao.MissionDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/addMission")
public class AddMissionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin session
        if (session == null ||
            session.getAttribute("adminUsername") == null ||
            session.getAttribute("adminId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adminLogin.jsp");
            return;
        }

        try {
            int adminId = (Integer) session.getAttribute("adminId");

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String difficulty = request.getParameter("difficulty");

            String optionA = request.getParameter("optionA");
            String optionB = request.getParameter("optionB");
            String optionC = request.getParameter("optionC");
            String optionD = request.getParameter("optionD");

            String correctAnswer = request.getParameter("correctAnswer");

            int xpReward = Integer.parseInt(
                request.getParameter("xpReward"));

            if (title == null || title.isBlank() ||
                optionA == null || optionB == null ||
                optionC == null || optionD == null ||
                correctAnswer == null ||
                !correctAnswer.matches("[ABCD]") ||
                xpReward <= 0) {

                response.sendRedirect(
                    request.getContextPath() +
                    "/addMission.jsp?error=invalid");
                return;
            }

            // Convert selected option letter into answer text
            String correctAnswerText;

            switch (correctAnswer) {
                case "A":
                    correctAnswerText = optionA;
                    break;
                case "B":
                    correctAnswerText = optionB;
                    break;
                case "C":
                    correctAnswerText = optionC;
                    break;
                case "D":
                    correctAnswerText = optionD;
                    break;
                default:
                    response.sendRedirect(
                        request.getContextPath() +
                        "/addMission.jsp?error=invalid");
                    return;
            }

            MissionDAO dao = new MissionDAO();

            boolean added = dao.addMission(
                title, description, category, difficulty,
                optionA, optionB, optionC, optionD,
                correctAnswerText, xpReward, adminId
            );

            if (added) {
                response.sendRedirect(
                    request.getContextPath() +
                    "/addMission.jsp?success=true");
            } else {
                response.sendRedirect(
                    request.getContextPath() +
                    "/addMission.jsp?error=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() +
                "/addMission.jsp?error=invalid");
        }
    }
}
