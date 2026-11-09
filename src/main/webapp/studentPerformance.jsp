
<%@ page import="java.util.List" %>

<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
        return;
    }

    List<String[]> students =
        (List<String[]>) request.getAttribute("students");

    if (students == null) {
        response.sendRedirect(request.getContextPath() + "/studentPerformance");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Performance - CodeQuest</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px;
            font-family: Arial, sans-serif;
            background: #171027;
            color: white;
        }

        .container {
            max-width: 1100px;
            margin: 30px auto;
            background: #24183b;
            padding: 30px;
            border-radius: 15px;
            border: 1px solid #8b6bc5;
        }

        h1 {
            text-align: center;
            color: #d9b6ff;
            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #c5b8d9;
            margin-bottom: 30px;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 650px;
        }

        th {
            background: #6541a5;
            color: white;
            padding: 15px;
        }

        td {
            padding: 14px;
            text-align: center;
            border-bottom: 1px solid #51416b;
        }

        tr:hover {
            background: #34234f;
        }

        .empty {
            text-align: center;
            padding: 25px;
            color: #d8c9e8;
        }

        .back-btn {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 22px;
            background: #d6ad55;
            color: #21152f;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .back-btn:hover {
            background: #edc875;
        }

        .count {
            text-align: right;
            color: #e6ca8b;
            margin-bottom: 15px;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Student Performance</h1>

    <p class="subtitle">
        Track student XP, levels and completed missions
    </p>

    <p class="count">
        Total Students: <%= students.size() %>
    </p>

    <div class="table-wrapper">

        <table>
            <tr>
                <th>S.No</th>
                <th>Student</th>
                <th>Email</th>
                <th>XP</th>
                <th>Level</th>
                <th>Completed Missions</th>
            </tr>

            <%
                if (students.isEmpty()) {
            %>
                <tr>
                    <td colspan="6" class="empty">
                        No students registered yet.
                    </td>
                </tr>
            <%
                } else {
                    int count = 1;

                    for (String[] student : students) {
            %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= student[0] %></td>
                    <td><%= student[1] %></td>
                    <td><%= student[2] %></td>
                    <td><%= student[3] %></td>
                    <td><%= student[4] %></td>
                </tr>
            <%
                    }
                }
            %>

        </table>

    </div>

    <a href="<%= request.getContextPath() %>/adminDashboard.jsp"
       class="back-btn">
        Back to Admin Dashboard
    </a>

</div>

</body>
</html>
