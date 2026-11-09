
package com.codequest.servlet;

import java.io.IOException;
import java.util.List;

import com.codequest.dao.MissionDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/manageMissions")
public class ManageMissionsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check admin login
        if (session == null ||
            session.getAttribute("adminUsername") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adminLogin.jsp"
            );
            return;
        }

        MissionDAO dao = new MissionDAO();

        List<String[]> missions = dao.getAllMissions();

        request.setAttribute("missions", missions);

        request.getRequestDispatcher(
            "/manageMissions.jsp"
        ).forward(request, response);
    }
}
