
package com.codequest.servlet;

import java.io.IOException;

import com.codequest.dao.MissionDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/editMission")
public class EditMissionServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
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
                request.getParameter("id")
            );

            MissionDAO dao = new MissionDAO();

            String[] mission = dao.getMissionById(missionId);

            if (mission == null) {
                response.sendRedirect(
                    request.getContextPath() + "/manageMissions"
                );
                return;
            }

            request.setAttribute("mission", mission);

            request.getRequestDispatcher(
                "/editMission.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/manageMissions"
            );
        }
    }
}
