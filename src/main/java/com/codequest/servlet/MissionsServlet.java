
package com.codequest.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.codequest.dao.MissionDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/missions")
public class MissionsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check student login
        if (session == null ||
            session.getAttribute("userEmail") == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp");
            return;
        }

        MissionDAO dao = new MissionDAO();

        List<String[]> allMissions = dao.getAllMissions();

        String difficulty = request.getParameter("difficulty");

        List<String[]> filteredMissions = new ArrayList<>();

        // Filter missions based on difficulty
        if (difficulty == null || difficulty.trim().isEmpty()) {

            filteredMissions = allMissions;

        } else {

            for (String[] mission : allMissions) {

                // Mission array index 4 contains difficulty
                if (mission[4] != null &&
                    mission[4].equalsIgnoreCase(difficulty)) {

                    filteredMissions.add(mission);
                }
            }
        }

        request.setAttribute("missions", filteredMissions);
        request.setAttribute("selectedDifficulty", difficulty);

        request.getRequestDispatcher("/missions.jsp")
               .forward(request, response);
    }
}
