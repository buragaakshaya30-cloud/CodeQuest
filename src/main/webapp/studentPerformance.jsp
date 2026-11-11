
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>

<%!
    private String safe(String value) {
        if (value == null) return "";
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }

    private int number(String value) {
        try {
            return Integer.parseInt(value);
        } catch (Exception e) {
            return 0;
        }
    }
%>

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

    int totalStudents = students.size();
    int highestXP = 0;
    int totalLevels = 0;
    int totalCompletions = 0;

    for (String[] student : students) {
        int xp = number(student[2]);
        int level = number(student[3]);
        int completed = number(student[4]);

        if (xp > highestXP) highestXP = xp;

        totalLevels += level;
        totalCompletions += completed;
    }

    double averageLevel = totalStudents == 0
        ? 0 : (double) totalLevels / totalStudents;

    String averageLevelText =
        String.format(Locale.US, "%.2f", averageLevel);

    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Student Performance | CodeQuest</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap"
rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    min-height: 100vh;
    color: #321b42;
    background:
        linear-gradient(rgba(38, 16, 53, .72), rgba(38, 16, 53, .82)),
        url('<%= ctx %>/images/castle.png') center center / cover fixed;
    background-color: #261334;
}

/* NAVBAR */

.navbar {
    min-height: 75px;
    padding: 0 6%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: rgba(37, 15, 49, .96);
    border-bottom: 2px solid #d9ae52;
}

.logo {
    color: #fff5df;
    font-family: 'Playfair Display', serif;
    font-size: 27px;
    font-weight: 800;
    letter-spacing: .5px;
}

.logo span {
    color: #edbd55;
}

.nav-right {
    display: flex;
    align-items: center;
    gap: 15px;
}

.nav-link {
    text-decoration: none;
    color: #f2d48d;
    font-size: 14px;
    font-weight: 600;
    padding: 10px 19px;
    border: 1px solid #c99b43;
    border-radius: 25px;
    transition: .3s;
}

.nav-link:hover {
    background: #e5b94f;
    color: #321b42;
}

/* MAIN */

.container {
    width: 92%;
    max-width: 1350px;
    margin: 38px auto 45px;
}

/* HEADER */

.page-heading {
    text-align: center;
    margin-bottom: 28px;
}

.page-heading h1 {
    display: inline-block;
    color: #fff0cf;
    font-family: 'Playfair Display', serif;
    font-size: clamp(30px, 4vw, 43px);
    font-weight: 800;
    padding: 9px 30px;
    border-top: 2px solid #e7bb5b;
    border-bottom: 2px solid #e7bb5b;
    text-shadow: 0 3px 12px rgba(0,0,0,.25);
}

.page-heading p {
    color: #f1dfc2;
    margin-top: 10px;
    font-size: 14px;
}

/* SUMMARY CARDS */

.stats-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 18px;
    margin-bottom: 27px;
}

.stat-card {
    min-height: 112px;
    padding: 18px 15px;
    display: flex;
    align-items: center;
    gap: 15px;
    background: linear-gradient(135deg, #fff9ed, #f4dfbd);
    border: 1px solid #d8a94c;
    border-radius: 17px;
    box-shadow: 0 7px 18px rgba(0,0,0,.18);
    transition: .25s;
}

.stat-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 22px rgba(0,0,0,.23);
}

.stat-icon {
    width: 55px;
    height: 55px;
    flex-shrink: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    background: linear-gradient(145deg, #ffedbd, #e9c36c);
    border: 1px solid #d3a13e;
    color: #693b17;
    font-size: 23px;
    font-weight: 700;
}

.stat-info p {
    font-size: 12px;
    color: #74536b;
    font-weight: 600;
    margin-bottom: 4px;
}

.stat-info h2 {
    font-family: 'Playfair Display', serif;
    font-size: 27px;
    color: #482052;
    line-height: 1.1;
}

/* TABLE PANEL */

.performance-panel {
    background: linear-gradient(145deg, #fff9f0, #f4e1c9);
    border: 2px solid #d6a746;
    border-radius: 20px;
    padding: 13px;
    box-shadow: 0 15px 35px rgba(0,0,0,.25);
    overflow: hidden;
}

.panel-heading {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 13px 13px 17px;
    gap: 10px;
}

.panel-heading h2 {
    font-family: 'Playfair Display', serif;
    color: #482052;
    font-size: 21px;
}

.panel-heading span {
    font-size: 12px;
    color: #795d78;
    font-weight: 600;
}

/* TABLE */

.table-wrapper {
    width: 100%;
    overflow-x: auto;
}

table {
    width: 100%;
    min-width: 750px;
    border-collapse: separate;
    border-spacing: 0;
}

thead {
    background: linear-gradient(100deg, #42164e, #692878);
}

th {
    padding: 17px 12px;
    color: #f8df9c;
    font-size: 13px;
    font-weight: 700;
    text-align: center;
    white-space: nowrap;
}

th:first-child {
    border-radius: 11px 0 0 0;
}

th:last-child {
    border-radius: 0 11px 0 0;
}

td {
    padding: 15px 12px;
    text-align: center;
    color: #382044;
    font-size: 13px;
    font-weight: 500;
    border-bottom: 1px solid #e6d2b9;
    background: rgba(255,255,255,.48);
}

tbody tr:nth-child(even) td {
    background: rgba(237, 221, 201, .65);
}

tbody tr:hover td {
    background: #fff0ce;
}

tbody tr:first-child td {
    background: #f9e3a6;
}

tbody tr:first-child td:first-child {
    border-radius: 8px 0 0 8px;
}

tbody tr:first-child td:last-child {
    border-radius: 0 8px 8px 0;
}

.student-name {
    font-weight: 700;
    color: #4a2058;
}

.student-email {
    color: #735e72;
    font-size: 12px;
}

.rank-number {
    display: inline-flex;
    justify-content: center;
    align-items: center;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    border: 1px solid #d4a34a;
    background: #fff5e2;
    color: #47204f;
    font-weight: 700;
}

.rank-one {
    background: linear-gradient(145deg, #fff0a8, #d69a24);
    border: 2px solid #f2ca65;
    color: #542c08;
}

.rank-two {
    background: linear-gradient(145deg, #ffffff, #b9b6c2);
    border: 2px solid #dedbe4;
    color: #3d3a48;
}

.rank-three {
    background: linear-gradient(145deg, #ffd2a4, #b56b37);
    border: 2px solid #e4a06c;
    color: #54280f;
}

.xp-value {
    color: #76228e;
    font-weight: 800;
}

.level-badge {
    display: inline-block;
    min-width: 65px;
    padding: 5px 11px;
    border: 1px solid #d6a13b;
    border-radius: 20px;
    background: #fff0c9;
    color: #593319;
    font-size: 11px;
    font-weight: 700;
}

/* EMPTY STATE */

.empty-state {
    text-align: center;
    padding: 40px 15px;
    color: #745d79;
    font-size: 14px;
}

/* BACK BUTTON */

.bottom-actions {
    padding: 22px 5px 7px;
}

.back-button {
    display: inline-flex;
    align-items: center;
    gap: 9px;
    text-decoration: none;
    padding: 12px 23px;
    background: linear-gradient(110deg, #42164e, #70277c);
    border: 1px solid #dcae4d;
    border-radius: 28px;
    color: #ffe6a9;
    font-size: 13px;
    font-weight: 600;
    transition: .3s;
    box-shadow: 0 5px 12px rgba(0,0,0,.15);
}

.back-button:hover {
    background: #e3b64e;
    color: #321b42;
    transform: translateY(-2px);
}

footer {
    text-align: center;
    color: #e7d4ed;
    padding: 18px;
    font-size: 11px;
    letter-spacing: .5px;
}

/* RESPONSIVE */

@media(max-width: 950px) {
    .stats-grid {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media(max-width: 600px) {
    .navbar {
        padding: 13px 5%;
        flex-wrap: wrap;
        gap: 12px;
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
        margin-top: 25px;
    }

    .stats-grid {
        grid-template-columns: 1fr 1fr;
        gap: 10px;
    }

    .stat-card {
        min-height: 95px;
        padding: 12px 9px;
        gap: 9px;
    }

    .stat-icon {
        width: 39px;
        height: 39px;
        font-size: 17px;
    }

    .stat-info p {
        font-size: 10px;
    }

    .stat-info h2 {
        font-size: 22px;
    }

    .page-heading h1 {
        font-size: 28px;
    }

    .performance-panel {
        padding: 8px;
        border-radius: 14px;
    }

    .panel-heading h2 {
        font-size: 17px;
    }
}
</style>
</head>

<body>

<nav class="navbar">
    <div class="logo">CODE<span>QUEST</span></div>

    <div class="nav-right">
        <a class="nav-link" href="<%= ctx %>/adminDashboard.jsp">
            ← Admin Dashboard
        </a>
    </div>
</nav>

<main class="container">

    <header class="page-heading">
        <h1>Student Performance</h1>
        <p>Track student XP, levels and completed missions</p>
    </header>

    <!-- SUMMARY CARDS -->

    <section class="stats-grid">

        <div class="stat-card">
            <div class="stat-icon">♟</div>
            <div class="stat-info">
                <p>Total Students</p>
                <h2><%= totalStudents %></h2>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">✦</div>
            <div class="stat-info">
                <p>Highest XP</p>
                <h2><%= highestXP %></h2>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">▥</div>
            <div class="stat-info">
                <p>Average Level</p>
                <h2><%= averageLevelText %></h2>
            </div>
        </div>

        <div class="stat-card">
            <div class="stat-icon">✓</div>
            <div class="stat-info">
                <p>Total Completions</p>
                <h2><%= totalCompletions %></h2>
            </div>
        </div>

    </section>

    <!-- STUDENT TABLE -->

    <section class="performance-panel">

        <div class="panel-heading">
            <h2>Student Progress Overview</h2>
            <span><%= totalStudents %> Students Registered</span>
        </div>

        <div class="table-wrapper">

            <table>
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Student</th>
                        <th>Email</th>
                        <th>XP</th>
                        <th>Level</th>
                        <th>Completed Missions</th>
                    </tr>
                </thead>

                <tbody>

                <%
                    if (students.isEmpty()) {
                %>

                    <tr>
                        <td colspan="6" class="empty-state">
                            No student performance records available.
                        </td>
                    </tr>

                <%
                    } else {
                        int rank = 1;

                        for (String[] student : students) {

                            String rankClass = "";

                            if (rank == 1) {
                                rankClass = "rank-one";
                            } else if (rank == 2) {
                                rankClass = "rank-two";
                            } else if (rank == 3) {
                                rankClass = "rank-three";
                            }
                %>

                    <tr>
                        <td>
                            <span class="rank-number <%= rankClass %>">
                                <%= rank %>
                            </span>
                        </td>

                        <td class="student-name">
                            <%= safe(student[0]) %>
                        </td>

                        <td class="student-email">
                            <%= safe(student[1]) %>
                        </td>

                        <td class="xp-value">
                            <%= number(student[2]) %> XP
                        </td>

                        <td>
                            <span class="level-badge">
                                Level <%= number(student[3]) %>
                            </span>
                        </td>

                        <td>
                            <%= number(student[4]) %>
                        </td>
                    </tr>

                <%
                            rank++;
                        }
                    }
                %>

                </tbody>
            </table>

        </div>

        <div class="bottom-actions">
            <a href="<%= ctx %>/adminDashboard.jsp" class="back-button">
                ← Back to Admin Dashboard
            </a>
        </div>

    </section>

</main>

<footer>
    Created by Buraga Akshaya · CodeQuest © 2026
</footer>

</body>
</html>
