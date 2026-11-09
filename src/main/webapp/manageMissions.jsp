
<%@ page import="java.util.List" %>

<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
        return;
    }

    List<String[]> missions =
        (List<String[]>) request.getAttribute("missions");

    if (missions == null) {
        response.sendRedirect(request.getContextPath() + "/manageMissions");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Missions | CodeQuest</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 30px;
            background: #100817;
            color: #f8f2ff;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 30px;
            background: #21152d;
            border: 1px solid #493052;
            border-radius: 15px;
        }

        h1 {
            text-align: center;
            color: #bd7aff;
        }

        .subtitle {
            text-align: center;
            color: #d8c8e8;
            margin-bottom: 30px;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 750px;
            border-collapse: collapse;
        }

        th {
            padding: 14px;
            background: #6541a5;
            color: white;
        }

        td {
            padding: 13px;
            text-align: center;
            border-bottom: 1px solid #493052;
        }

        tr:hover {
            background: #34234f;
        }

        .action {
            display: inline-block;
            padding: 8px 12px;
            margin: 3px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
        }

        .edit {
            background: #bd7aff;
            color: #100817;
        }

        .delete {
            background: #e05b6b;
            color: white;
        }

        .back {
            display: inline-block;
            margin-top: 25px;
            padding: 12px 20px;
            background: #d6ad55;
            color: #21152f;
            text-decoration: none;
            border-radius: 7px;
            font-weight: bold;
        }

        .empty {
            padding: 25px;
            color: #d8c8e8;
        }
        button.delete {
    border: none;
    cursor: pointer;
    font-size: 14px;
}
    </style>
</head>

<body>

<div class="container">

    <h1>Manage Missions</h1>

    <p class="subtitle">
        View, edit and delete programming missions
    </p>

    <div class="table-wrapper">

        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Category</th>
                <th>Difficulty</th>
                <th>XP Reward</th>
                <th>Actions</th>
            </tr>

            <%
                if (missions.isEmpty()) {
            %>
                <tr>
                    <td colspan="6" class="empty">
                        No missions available.
                    </td>
                </tr>
            <%
                } else {
                    for (String[] mission : missions) {
            %>
                <tr>
                    <td><%= mission[0] %></td>
                    <td><%= mission[1] %></td>
                    <td><%= mission[3] %></td>
                    <td><%= mission[4] %></td>
                    <td><%= mission[9] %></td>

                    <td>
                        <a class="action edit"
                           href="<%= request.getContextPath() %>/editMission?id=<%= mission[0] %>">
                            Edit
                        </a>

                        
<form action="<%= request.getContextPath() %>/deleteMission"
      method="post"
      style="display:inline;">

    <input type="hidden" name="id" value="<%= mission[0] %>">

    <button type="submit"
            class="action delete"
            onclick="return confirm('Are you sure you want to delete this mission?');">
        Delete
    </button>

</form>

                    </td>
                </tr>
            <%
                    }
                }
            %>

        </table>

    </div>

    <a class="back"
       href="<%= request.getContextPath() %>/adminDashboard.jsp">
        Back to Dashboard
    </a>

</div>

</body>
</html>
