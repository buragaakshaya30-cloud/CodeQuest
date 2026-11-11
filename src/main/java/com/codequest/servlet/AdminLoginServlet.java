
package com.codequest.servlet;

import java.io.IOException;

import com.codequest.dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminlogin")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO dao = new AdminDAO();

        if (dao.validateAdmin(username, password)) {

            int adminId = dao.getAdminId(username);

            if (adminId == -1) {
                response.sendRedirect(
                    request.getContextPath() + "/adminLogin.jsp?error=failed");
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("adminUsername", username);
            session.setAttribute("adminId", adminId);

            response.sendRedirect(
                request.getContextPath() + "/adminDashboard.jsp");

        } else {
            request.setAttribute("error",
                "Invalid username or password.");

            request.getRequestDispatcher("/adminLogin.jsp")
                   .forward(request, response);
        }
    }
}
