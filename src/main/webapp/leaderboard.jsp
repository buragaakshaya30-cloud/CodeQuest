
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    boolean studentLoggedIn =
        session.getAttribute("userEmail") != null;

    boolean adminLoggedIn =
        session.getAttribute("adminUsername") != null &&
        session.getAttribute("adminId") != null;

    if (!studentLoggedIn && !adminLoggedIn) {
        response.sendRedirect(
            request.getContextPath() + "/adminLogin.jsp");
        return;
    }

    String ctx = request.getContextPath();
    List<String[]> leaderboard =
    	    (List<String[]>) request.getAttribute("leaderboard");

    	if (leaderboard == null) {
    	    response.sendRedirect(ctx + "/leaderboard");
    	    return;
    	}
%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Global Leaderboard | CodeQuest</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    min-height: 100vh;
    color: #fff;
    background:
        linear-gradient(rgba(22, 8, 34, .91), rgba(35, 12, 49, .94)),
        url('<%= ctx %>/images/castle.png') center center / cover fixed;
    background-color: #1b0b28;
}

/* NAVIGATION */

.navbar {
    width: 100%;
    min-height: 76px;
    padding: 0 5%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background: rgba(28, 9, 42, .96);
    border-bottom: 1px solid rgba(226, 174, 75, .55);
    box-shadow: 0 4px 20px rgba(0, 0, 0, .2);
}

.logo {
    font-family: 'Playfair Display', serif;
    font-size: 29px;
    font-weight: 800;
    color: #fff0ca;
    letter-spacing: -.5px;
}

.logo span {
    color: #e9b94e;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 35px;
}

.nav-links a {
    position: relative;
    color: #f4eaf7;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    padding: 27px 4px;
    transition: .3s;
}

.nav-links a:hover,
.nav-links a.active {
    color: #f3c65e;
}

.nav-links a.active::after {
    content: "";
    position: absolute;
    bottom: 14px;
    left: 0;
    width: 100%;
    height: 2px;
    background: #e9b94e;
    box-shadow: 0 0 9px #e9b94e;
}

.logout {
    text-decoration: none;
    color: #fce6a9;
    border: 1px solid #d9aa4d;
    border-radius: 25px;
    padding: 9px 23px;
    font-size: 13px;
    font-weight: 600;
    transition: .3s;
}

.logout:hover {
    background: #d9aa4d;
    color: #291137;
}

/* MAIN CONTAINER */

.container {
    width: 88%;
    max-width: 1200px;
    margin: 48px auto 55px;
}

/* HEADING */

.heading {
    text-align: center;
    margin-bottom: 35px;
}

.heading h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(34px, 4vw, 49px);
    color: #f9e5b2;
    letter-spacing: .5px;
    text-shadow: 0 3px 18px rgba(222, 166, 71, .18);
}

.heading .subtitle {
    color: #d8c4e1;
    font-size: 14px;
    margin-top: 9px;
    letter-spacing: 1px;
}

.heading-line {
    width: 190px;
    height: 1px;
    margin: 15px auto 0;
    background: linear-gradient(90deg, transparent, #e4b54e, transparent);
}

/* LEADERBOARD CARD */

.leaderboard-card {
    background: rgba(32, 12, 47, .88);
    border: 1px solid rgba(220, 170, 75, .8);
    border-radius: 24px;
    padding: 18px 22px 22px;
    box-shadow:
        0 15px 45px rgba(0, 0, 0, .3),
        0 0 25px rgba(193, 112, 224, .08);
    backdrop-filter: blur(10px);
    overflow: hidden;
}

/* TABLE HEADER */

.table-header {
    display: grid;
    grid-template-columns: .8fr 1.5fr 1fr 1fr;
    align-items: center;
    text-align: center;
    min-height: 65px;
    background: linear-gradient(100deg, #40134f, #572064);
    border-bottom: 1px solid rgba(232, 187, 94, .55);
    border-radius: 15px 15px 0 0;
    color: #f8d98e;
    font-size: 15px;
    font-weight: 700;
    letter-spacing: .3px;
}

/* STUDENT ROWS */

.student-row {
    display: grid;
    grid-template-columns: .8fr 1.5fr 1fr 1fr;
    align-items: center;
    text-align: center;
    min-height: 64px;
    border-bottom: 1px solid rgba(226, 187, 129, .22);
    color: #fff4e5;
    font-size: 14px;
    transition: background .25s;
}

.student-row:hover {
    background: rgba(255, 255, 255, .055);
}

.student-row.first {
    background: linear-gradient(90deg,
        rgba(190, 133, 48, .27),
        rgba(242, 199, 112, .10));
    border: 1px solid rgba(231, 184, 81, .65);
    border-radius: 12px;
    margin-top: 5px;
}

.student-row.second {
    background: rgba(190, 183, 209, .11);
    border-radius: 12px;
    margin-top: 5px;
}

.student-row.third {
    background: rgba(190, 111, 69, .15);
    border-radius: 12px;
    margin-top: 5px;
}

.rank {
    font-size: 17px;
    font-weight: 700;
    color: #f8e9c8;
}

.medal {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 34px;
    height: 34px;
    border-radius: 50%;
    font-size: 15px;
    font-weight: 800;
    color: #321638;
    box-shadow: 0 2px 7px rgba(0,0,0,.3);
}

.gold {
    background: linear-gradient(145deg, #fff0a8, #d99a22);
    border: 2px solid #ffdb75;
}

.silver {
    background: linear-gradient(145deg, #f6f4fa, #a6a2b3);
    border: 2px solid #ddd9e7;
}

.bronze {
    background: linear-gradient(145deg, #ffd0a0, #a85c2b);
    border: 2px solid #e8a16b;
}

.student-name {
    text-align: left;
    padding-left: 13%;
    font-weight: 600;
    color: #fff3e4;
}

.xp {
    color: #f2ca75;
    font-weight: 700;
}

.level {
    color: #e8d7f1;
    font-weight: 600;
}

/* EMPTY STATE */

.empty-state {
    text-align: center;
    padding: 45px 15px;
    color: #e3d1ed;
    font-size: 14px;
}

/* BACK BUTTON */

.back-area {
    padding-top: 24px;
}

.back-button {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    padding: 12px 23px;
    color: #f9df9b;
    text-decoration: none;
    background: linear-gradient(110deg, #42134f, #692476);
    border: 1px solid #d9a943;
    border-radius: 30px;
    font-size: 13px;
    font-weight: 600;
    transition: .3s;
}

.back-button:hover {
    background: #e3b54e;
    color: #291137;
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(220, 170, 75, .2);
}

/* FOOTER */

footer {
    text-align: center;
    padding: 18px;
    color: #bfaacb;
    font-size: 11px;
    letter-spacing: .5px;
}

/* RESPONSIVE */

@media(max-width: 800px) {
    .navbar {
        padding: 15px 4%;
        flex-wrap: wrap;
        gap: 12px;
    }

    .nav-links {
        order: 3;
        width: 100%;
        justify-content: center;
        gap: 22px;
    }

    .nav-links a {
        padding: 8px 0;
        font-size: 12px;
    }

    .nav-links a.active::after {
        bottom: 0;
    }

    .container {
        width: 94%;
        margin-top: 35px;
    }

    .leaderboard-card {
        padding: 10px;
        border-radius: 17px;
    }

    .table-header,
    .student-row {
        grid-template-columns: .65fr 1.3fr .85fr .85fr;
        font-size: 11px;
    }

    .student-name {
        padding-left: 4%;
    }

    .medal {
        width: 27px;
        height: 27px;
        font-size: 12px;
    }
}

@media(max-width: 450px) {
    .logo {
        font-size: 23px;
    }

    .logout {
        padding: 8px 13px;
        font-size: 11px;
    }

    .nav-links {
        gap: 13px;
    }

    .table-header,
    .student-row {
        grid-template-columns: .55fr 1.2fr .8fr .8fr;
        font-size: 10px;
    }

    .student-name {
        font-size: 10px;
        overflow-wrap: anywhere;
    }

    .rank {
        font-size: 13px;
    }

    .student-row {
        min-height: 55px;
    }
}
nav a[href*="Dashboard.jsp"] {
    padding: 7px 13px !important;
    font-size: 11px !important;
    border-radius: 20px;
    min-width: auto;
    height: auto;
    line-height: 1.4;
}
</style>
</head>

<body>

<!-- NAVBAR -->

<nav class="navbar">

    <div class="logo">&lt;/&gt; Code<span>Quest</span></div>

    <div class="nav-links">
      
        <a href="<%= ctx %>/startQuest.jsp">Start Quest</a>
        <a href="<%= ctx %>/leaderboard" class="active">Leaderboard</a>
    </div>

    <a href="<%= ctx %>/logout" class="logout">Logout </a>

</nav>

<!-- LEADERBOARD -->

<main class="container">

    <div class="heading">
        <h1>Global Leaderboard</h1>
        <p class="subtitle">Top Coders of CodeQuest</p>
        <div class="heading-line"></div>
    </div>

    <section class="leaderboard-card">

        <div class="table-header">
            <div>Rank</div>
            <div>Student</div>
            <div>XP</div>
            <div>Level</div>
        </div>

        <%
            if (leaderboard.isEmpty()) {
        %>

            <div class="empty-state">
                No students available in the leaderboard yet.
            </div>

        <%
            } else {
                int rank = 1;

                for (String[] student : leaderboard) {

                    String rowClass = "";
                    String medalClass = "";

                    if (rank == 1) {
                        rowClass = "first";
                        medalClass = "gold";
                    } else if (rank == 2) {
                        rowClass = "second";
                        medalClass = "silver";
                    } else if (rank == 3) {
                        rowClass = "third";
                        medalClass = "bronze";
                    }
        %>

            <div class="student-row <%= rowClass %>">

                <div class="rank">

                    <% if (rank <= 3) { %>
                        <span class="medal <%= medalClass %>">
                            <%= rank %>
                        </span>
                    <% } else { %>
                        <%= rank %>
                    <% } %>

                </div>

                <div class="student-name">
                    <%= safe(student[0]) %>
                </div>

                <div class="xp">
                    <%= safe(student[1]) %> XP
                </div>

                <div class="level">
                    Level <%= safe(student[2]) %>
                </div>

            </div>

        <%
                    rank++;
                }
            }
        %>

        <div class="back-area">
            <a href="<%= ctx %>/studentDashboard.jsp" class="back-button">
                <span>←</span> Back to Dashboard
            </a>
        </div>

    </section>

</main>

<footer>
    Created by Buraga Akshaya · CodeQuest © 2026
</footer>

</body>
</html>
