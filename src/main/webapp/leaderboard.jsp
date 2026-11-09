
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("userEmail") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<String[]> leaderboard =
        (List<String[]>) request.getAttribute("leaderboard");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Global Leaderboard | CodeQuest</title>

    <style>
        body {
            margin: 0;
            padding: 30px;
            font-family: Arial, sans-serif;
            background: #100817;
            color: white;
        }

        h1 {
            text-align: center;
            color: #ffbd45;
            margin-bottom: 30px;
        }

        .leaderboard {
            max-width: 850px;
            margin: auto;
            background: #21152f;
            padding: 25px;
            border-radius: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 16px;
            text-align: center;
            border-bottom: 1px solid #49345d;
        }

        th {
            color: #ffbd45;
        }

        tr:hover {
            background: #352348;
        }

        a {
            display: inline-block;
            margin-top: 25px;
            color: #ffbd45;
            text-decoration: none;
        }
    </style>
</head>

<body>

    <h1>🏆 Global Leaderboard</h1>

    <div class="leaderboard">

        <table>
            <tr>
                <th>Rank</th>
                <th>Student</th>
                <th>XP</th>
                <th>Level</th>
            </tr>

            <%
                if (leaderboard != null && !leaderboard.isEmpty()) {
                    int rank = 1;

                    for (String[] student : leaderboard) {
            %>

            <tr>
                <td><%= rank++ %></td>
                <td><%= student[0] %></td>
                <td><%= student[1] %></td>
                <td><%= student[2] %></td>
            </tr>

            <%
                    }
                } else {
            %>

            <tr>
                <td colspan="4">No students found.</td>
            </tr>

            <%
                }
            %>

        </table>

        <a href="<%= request.getContextPath() %>/studentDashboard.jsp">
            ← Back to Dashboard
        </a>

    </div>

</body>
</html>
