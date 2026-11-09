
package com.codequest.servlet;

import java.io.IOException;

import com.codequest.dao.MissionDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/deleteMission")
public class DeleteMissionServlet extends HttpServlet {

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
                request.getParameter("id")
            );

            if (missionId <= 0) {
                response.sendRedirect(
                    request.getContextPath() + "/manageMissions"
                );
                return;
            }

            MissionDAO dao = new MissionDAO();

            boolean deleted = dao.deleteMission(missionId);

            if (deleted) {
                response.sendRedirect(
                    request.getContextPath() +
                    "/manageMissions?result=deleted"
                );
            } else {
                response.sendRedirect(
                    request.getContextPath() +
                    "/manageMissions?result=deleteFailed"
                );
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/manageMissions"
            );
        }
    }
}
