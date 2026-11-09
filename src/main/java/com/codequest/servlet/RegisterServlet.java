
package com.codequest.servlet;

import java.io.IOException;

import com.codequest.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || email == null || password == null ||
            username.trim().isEmpty() || email.trim().isEmpty() ||
            password.isEmpty()) {

            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
            return;
        }

        if (userDAO.usernameExists(username) ||
            userDAO.emailExists(email)) {

            request.setAttribute("error",
                    "Username or email already exists.");

            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
            return;
        }

        boolean registered =
                userDAO.registerUser(username, email, password);

        if (registered) {
            response.sendRedirect("login.jsp?registered=success");
        } else {
            request.setAttribute("error",
                    "Registration failed. Please try again.");

            request.getRequestDispatcher("register.jsp")
                   .forward(request, response);
        }
    }
}
