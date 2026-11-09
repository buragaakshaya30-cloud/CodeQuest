
package com.codequest.servlet;

import java.io.IOException;

import com.codequest.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (userDAO.validateUser(email, password)) {

            int userId = userDAO.getUserId(email);

            if (userId <= 0) {
                response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=invalid");
                return;
            }

            // Create a fresh session after successful login
            HttpSession oldSession = request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session = request.getSession(true);

            session.setAttribute("userEmail", email);
            session.setAttribute("userId", userId);

            String redirect = request.getParameter("redirect");

            if ("missions".equals(redirect)) {
                response.sendRedirect(
                    request.getContextPath() + "/missions");
            } else {
                response.sendRedirect(
                    request.getContextPath() + "/studentHome.jsp");
            }

        } else {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp?error=invalid");
        }
    }
}
