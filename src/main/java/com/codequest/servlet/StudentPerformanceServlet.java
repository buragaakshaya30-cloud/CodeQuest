
package com.codequest.servlet;

import java.io.IOException;
import java.util.List;

import com.codequest.dao.StudentPerformanceDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/studentPerformance")
public class StudentPerformanceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Only logged-in admin can access this page
        if (session == null ||
            session.getAttribute("adminUsername") == null) {

            response.sendRedirect(
                request.getContextPath() + "/adminLogin.jsp"
            );
            return;
        }

        StudentPerformanceDAO dao = new StudentPerformanceDAO();

        List<String[]> students = dao.getStudentPerformance();

        request.setAttribute("students", students);

        request.getRequestDispatcher(
            "/studentPerformance.jsp"
        ).forward(request, response);
    }
}
