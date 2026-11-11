
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>

<%!
    private String safe(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }
%>

<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect(
            request.getContextPath() + "/adminLogin.jsp");
        return;
    }

    List<String[]> missions =
        (List<String[]>) request.getAttribute("missions");

    if (missions == null) {
        response.sendRedirect(
            request.getContextPath() + "/manageMissions");
        return;
    }

    String ctx = request.getContextPath();
    int totalMissions = missions.size();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Manage Missions | CodeQuest</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap"
rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    min-height: 100vh;
    font-family: 'Poppins', sans-serif;
    color: #35203e;
    background:
        linear-gradient(rgba(36, 14, 51, .76), rgba(36, 14, 51, .84)),
        url('<%= ctx %>/images/castle.png') center center / cover fixed;
    background-color: #241033;
}

/* NAVIGATION */

.navbar {
    min-height: 75px;
    padding: 0 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: rgba(36, 14, 49, .96);
    border-bottom: 2px solid #d8aa4d;
}

.logo {
    font-family: 'Playfair Display', serif;
    color: #fff3dc;
    font-size: 27px;
    font-weight: 800;
}

.logo span {
    color: #e9b84e;
}

.nav-link {
    text-decoration: none;
    color: #f5d992;
    border: 1px solid #d7a849;
    border-radius: 25px;
    padding: 10px 21px;
    font-size: 13px;
    font-weight: 600;
    transition: .3s;
}

.nav-link:hover {
    background: #e5b64c;
    color: #32163d;
}

/* MAIN */

.container {
    width: 91%;
    max-width: 1250px;
    margin: 43px auto;
}

/* PAGE HEADING */

.page-heading {
    text-align: center;
    margin-bottom: 30px;
}

.page-heading h1 {
    font-family: 'Playfair Display', serif;
    color: #fff0cd;
    font-size: clamp(32px, 4vw, 43px);
    text-shadow: 0 3px 15px rgba(0,0,0,.3);
}

.page-heading p {
    color: #e8d7ec;
    font-size: 14px;
    margin-top: 9px;
}

/* SUMMARY */

.summary {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    padding: 17px 22px;
    margin-bottom: 22px;
    background: linear-gradient(110deg, #fff6e5, #f3dfbf);
    border: 1px solid #d6a746;
    border-radius: 15px;
    box-shadow: 0 6px 17px rgba(0,0,0,.17);
}

.summary-label {
    color: #70516e;
    font-size: 13px;
    font-weight: 600;
}

.summary-count {
    color: #4a2055;
    font-family: 'Playfair Display', serif;
    font-size: 26px;
    font-weight: 800;
}

/* TABLE PANEL */

.mission-panel {
    padding: 19px;
    background: linear-gradient(145deg, #fff9f0, #f3e0c9);
    border: 2px solid #d6a746;
    border-radius: 21px;
    box-shadow: 0 15px 35px rgba(0,0,0,.25);
}

.panel-heading {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 10px;
    padding: 7px 5px 20px;
}

.panel-heading h2 {
    font-family: 'Playfair Display', serif;
    font-size: 21px;
    color: #49204f;
}

.panel-heading span {
    color: #82627a;
    font-size: 12px;
    font-weight: 600;
}

/* TABLE */

.table-wrapper {
    width: 100%;
    overflow-x: auto;
}

table {
    width: 100%;
    min-width: 760px;
    border-collapse: separate;
    border-spacing: 0;
}

thead {
    background: linear-gradient(100deg, #42164e, #692878);
}

th {
    padding: 17px 12px;
    color: #f8df9c;
    text-align: center;
    font-size: 13px;
    font-weight: 700;
    white-space: nowrap;
}

th:first-child {
    border-radius: 11px 0 0 0;
}

th:last-child {
    border-radius: 0 11px 0 0;
}

td {
    padding: 16px 12px;
    text-align: center;
    color: #392342;
    font-size: 13px;
    border-bottom: 1px solid #e5d1b8;
    background: rgba(255,255,255,.48);
}

tbody tr:nth-child(even) td {
    background: rgba(237,221,201,.65);
}

tbody tr:hover td {
    background: #fff0ce;
}

.mission-id {
    color: #7b6380;
    font-weight: 600;
}

.mission-title {
    color: #482052;
    font-weight: 700;
}

.category {
    display: inline-block;
    padding: 5px 12px;
    background: #eee1f4;
    border: 1px solid #d4b6e0;
    border-radius: 20px;
    color: #663275;
    font-size: 11px;
    font-weight: 600;
}

.difficulty {
    display: inline-block;
    padding: 5px 12px;
    border-radius: 20px;
    background: #fff0cc;
    border: 1px solid #e1bd70;
    color: #79501c;
    font-size: 11px;
    font-weight: 700;
}

.xp {
    color: #76228e;
    font-weight: 800;
}

/* ACTION BUTTONS */

.actions {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
}

.action {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    min-width: 65px;
    padding: 8px 13px;
    border-radius: 8px;
    text-decoration: none;
    border: none;
    font-family: 'Poppins', sans-serif;
    font-size: 12px;
    font-weight: 700;
    cursor: pointer;
    transition: .25s;
}

.edit {
    background: #ead8f3;
    border: 1px solid #b78acb;
    color: #542466;
}

.edit:hover {
    background: #692878;
    color: white;
    transform: translateY(-2px);
}

.delete {
    background: #f8e1dc;
    border: 1px solid #d99a8e;
    color: #a13f39;
}

.delete:hover {
    background: #bd514d;
    color: white;
    transform: translateY(-2px);
}

/* EMPTY STATE */

.empty {
    padding: 35px 15px;
    color: #795e7b;
    font-size: 14px;
}

/* BOTTOM BUTTON */

.bottom-actions {
    padding: 23px 4px 5px;
}

.back-button {
    display: inline-flex;
    align-items: center;
    gap: 9px;
    padding: 12px 23px;
    text-decoration: none;
    color: #ffe6a9;
    background: linear-gradient(110deg, #42164e, #70277c);
    border: 1px solid #dcae4d;
    border-radius: 28px;
    font-size: 13px;
    font-weight: 600;
    transition: .3s;
}

.back-button:hover {
    background: #e3b64e;
    color: #321b42;
    transform: translateY(-2px);
}

footer {
    text-align: center;
    padding: 18px;
    color: #e6d3eb;
    font-size: 11px;
    letter-spacing: .5px;
}

/* RESPONSIVE */

@media(max-width: 650px) {
    .navbar {
        padding: 13px 5%;
    }

    .logo {
        font-size: 22px;
    }

    .nav-link {
        padding: 8px 12px;
        font-size: 11px;
    }

    .container {
        width: 94%;
        margin: 28px auto;
    }

    .mission-panel {
        padding: 10px;
        border-radius: 15px;
    }

    .panel-heading h2 {
        font-size: 17px;
    }

    .summary {
        padding: 13px 16px;
    }
}
</style>
</head>

<body>

<nav class="navbar">
    <div class="logo">CODE<span>QUEST</span></div>

    <a class="nav-link" href="<%= ctx %>/adminDashboard.jsp">
        ← Admin Dashboard
    </a>
</nav>

<main class="container">

    <header class="page-heading">
        <h1>Manage Missions</h1>
        <p>View, edit and manage your programming challenges</p>
    </header>

    <section class="summary">
        <div>
            <div class="summary-label">Mission Library</div>
            <div class="summary-count"><%= totalMissions %> Missions</div>
        </div>
        <div class="summary-label">CodeQuest · Admin Control Center</div>
    </section>

    <section class="mission-panel">

        <div class="panel-heading">
            <h2>Mission Overview</h2>
            <span><%= totalMissions %> Records</span>
        </div>

        <div class="table-wrapper">

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Mission Title</th>
                        <th>Category</th>
                        <th>Difficulty</th>
                        <th>XP Reward</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    if (missions.isEmpty()) {
                %>

                    <tr>
                        <td colspan="6" class="empty">
                            No missions available yet.
                        </td>
                    </tr>

                <%
                    } else {
                        for (String[] mission : missions) {
                %>

                    <tr>
                        <td class="mission-id">
                            <%= safe(mission[0]) %>
                        </td>

                        <td class="mission-title">
                            <%= safe(mission[1]) %>
                        </td>

                        <td>
                            <span class="category">
                                <%= safe(mission[3]) %>
                            </span>
                        </td>

                        <td>
                            <span class="difficulty">
                                <%= safe(mission[4]) %>
                            </span>
                        </td>

                        <td class="xp">
                            <%= safe(mission[9]) %> XP
                        </td>

                        <td>
                            <div class="actions">

                                <a class="action edit"
                                   href="<%= ctx %>/editMission?id=<%= safe(mission[0]) %>">
                                    Edit
                                </a>

                                <form action="<%= ctx %>/deleteMission"
                                      method="post"
                                      style="display:inline;">

                                    <input type="hidden"
                                           name="id"
                                           value="<%= safe(mission[0]) %>">

                                    <button type="submit"
                                            class="action delete"
                                            onclick="return confirm('Are you sure you want to delete this mission?');">
                                        Delete
                                    </button>

                                </form>

                            </div>
                        </td>
                    </tr>

                <%
                        }
                    }
                %>

                </tbody>
            </table>

        </div>

        <div class="bottom-actions">
            <a class="back-button"
               href="<%= ctx %>/adminDashboard.jsp">
                ← Back to Dashboard
            </a>
        </div>

    </section>

</main>

<footer>
    Created by Buraga Akshaya · CodeQuest © 2026
</footer>

</body>
</html>
