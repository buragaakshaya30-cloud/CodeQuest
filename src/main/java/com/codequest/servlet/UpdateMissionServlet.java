
package com.codequest.servlet;

import java.io.IOException;

import com.codequest.dao.MissionDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/updateMission")
public class UpdateMissionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("adminUsername") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adminLogin.jsp"
            );
            return;
        }

        try {
            int missionId = Integer.parseInt(
                request.getParameter("missionId")
            );

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            String difficulty = request.getParameter("difficulty");

            String optionA = request.getParameter("optionA");
            String optionB = request.getParameter("optionB");
            String optionC = request.getParameter("optionC");
            String optionD = request.getParameter("optionD");

            String correctAnswer =
                request.getParameter("correctAnswer");

            int xpReward = Integer.parseInt(
                request.getParameter("xpReward")
            );

            if (missionId <= 0 || xpReward <= 0 ||
                title == null || title.trim().isEmpty() ||
                description == null || description.trim().isEmpty() ||
                category == null || category.trim().isEmpty() ||
                !difficulty.matches("Easy|Medium|Hard") ||
                optionA == null || optionA.trim().isEmpty() ||
                optionB == null || optionB.trim().isEmpty() ||
                optionC == null || optionC.trim().isEmpty() ||
                optionD == null || optionD.trim().isEmpty() ||
                correctAnswer == null ||
                !correctAnswer.matches("(?i)[ABCD]")) {

                response.sendRedirect(
                    request.getContextPath() + "/manageMissions"
                );
                return;
            }

            MissionDAO dao = new MissionDAO();

            boolean updated = dao.updateMission(
                missionId,
                title.trim(),
                description.trim(),
                category.trim(),
                difficulty,
                optionA.trim(),
                optionB.trim(),
                optionC.trim(),
                optionD.trim(),
                correctAnswer.toUpperCase(),
                xpReward
            );

            if (updated) {
                response.sendRedirect(
                    request.getContextPath() +
                    "/manageMissions?result=updated"
                );
            } else {
                response.sendRedirect(
                    request.getContextPath() +
                    "/manageMissions?result=failed"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect(
                request.getContextPath() + "/manageMissions?result=invalid"
            );
        }
    }
}
