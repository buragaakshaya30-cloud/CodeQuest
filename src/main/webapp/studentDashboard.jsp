
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");

    if (userEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String displayName = userEmail.contains("@")
            ? userEmail.substring(0, userEmail.indexOf("@"))
            : userEmail;

    displayName = displayName.substring(0, 1).toUpperCase()
            + displayName.substring(1);

    int totalMissions = 0;
    int totalXP = 0;
    int currentLevel = 1;
    int completedMissions = 0;

    boolean dbError = false;
    List<String[]> recentActivities = new ArrayList<String[]>();

    String dbUrl = System.getenv("DB_URL");
    String dbUser = System.getenv("DB_USERNAME");
    String dbPassword = System.getenv("DB_PASSWORD");

    try {
        if (dbUrl == null || dbUser == null || dbPassword == null) {
            throw new Exception("Database environment variables are missing.");
        }

        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection con = DriverManager.getConnection(
                dbUrl, dbUser, dbPassword)) {

            int userId = 0;

            // STUDENT DETAILS
            String userSql =
                "SELECT id, total_xp, player_level FROM users WHERE email = ?";

            try (PreparedStatement ps = con.prepareStatement(userSql)) {
                ps.setString(1, userEmail);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        userId = rs.getInt("id");
                        totalXP = rs.getInt("total_xp");
                        currentLevel = rs.getInt("player_level");
                    }
                }
            }

            // TOTAL MISSIONS
            String missionSql = "SELECT COUNT(*) FROM missions";

            try (PreparedStatement ps = con.prepareStatement(missionSql);
                 ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    totalMissions = rs.getInt(1);
                }
            }

            // COMPLETED MISSIONS
            String completedSql =
                "SELECT COUNT(*) FROM mission_submissions " +
                "WHERE user_id = ? AND is_correct = 1";

            try (PreparedStatement ps = con.prepareStatement(completedSql)) {
                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        completedMissions = rs.getInt(1);
                    }
                }
            }

            // RECENT ACTIVITY
            String activitySql =
                "SELECT m.title, ms.completed_at, m.xp_reward " +
                "FROM mission_submissions ms " +
                "JOIN missions m ON ms.mission_id = m.id " +
                "WHERE ms.user_id = ? AND ms.is_correct = 1 " +
                "ORDER BY ms.completed_at DESC LIMIT 5";

            try (PreparedStatement ps = con.prepareStatement(activitySql)) {
                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        String title = rs.getString("title");
                        String date = rs.getString("completed_at");
                        int reward = rs.getInt("xp_reward");

                        recentActivities.add(new String[]{
                            title,
                            date == null ? "" : date,
                            String.valueOf(reward)
                        });
                    }
                }
            }
        }

    } catch (Exception e) {
        dbError = true;
        application.log("Student Dashboard database error", e);
    }

    int progress = Math.min(100,
            Math.max(0, (int)(totalXP * 100.0 / 250)));
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Student Dashboard | CodeQuest</title>

<style>

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Arial, sans-serif;
    color: white;
    min-height: 100vh;

    background:
        linear-gradient(rgba(25, 9, 43, 0.38),
                        rgba(25, 9, 43, 0.55)),
        url("images/castle.png") center center / cover fixed;
}

/* NAVIGATION */

nav {
    height: 72px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 5%;

    background: rgba(31, 12, 48, 0.96);
    border-bottom: 2px solid #e8b64c;

    position: relative;
    z-index: 10;
}

.logo {
    color: #ffd36b;
    font-family: Georgia, serif;
    font-size: 27px;
    font-weight: bold;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 38px;
}
nav a,
.nav-actions a,
.navbar a {
    text-decoration: none;
}

.nav-links a {
    text-decoration: none;
    color: white;
    font-size: 15px;
    font-weight: 600;
    transition: 0.3s;
}

.nav-links a:hover {
    color: #ffd36b;
}

.logout {
    padding: 10px 23px;
    border: 1px solid #e9b84b;
    border-radius: 25px;
    color: #ffd36b !important;
}
.logout-btn {
    text-decoration: none !important;
}

/* MAIN CONTAINER */

.container {
    width: 90%;
    max-width: 1320px;
    margin: 28px auto;
}

/* WELCOME SECTION */

.welcome {
    margin-bottom: 22px;
}

.welcome h1 {
    font-family: Georgia, serif;
    font-size: 39px;
    margin-bottom: 9px;
    color: #fff5e9;
}

.welcome h1 span {
    color: #ffd36b;
}

.welcome p {
    color: #f0e3f5;
    font-size: 16px;
}

.welcome-line {
    width: 330px;
    height: 2px;
    margin-top: 18px;
    background: linear-gradient(90deg, #ffd36b, transparent);
}

/* PROGRESS SECTION */

.progress-section {
    display: grid;
    grid-template-columns: 155px 1fr;
    align-items: center;
    gap: 28px;

    padding: 20px 28px;
    margin-bottom: 23px;

    background: rgba(42, 17, 58, 0.96);
    border: 2px solid #d7a443;
    border-radius: 19px;

    box-shadow: 0 8px 25px rgba(0,0,0,0.25);
}

.avatar {
    text-align: center;
}

.avatar-circle {
    width: 105px;
    height: 105px;
    border-radius: 50%;
    margin: auto;

    display: grid;
    place-items: center;

    font-size: 43px;
    background: linear-gradient(145deg, #9e2ac9, #42105f);

    border: 4px solid #ffd36b;
    box-shadow: 0 0 20px rgba(255,211,107,0.4);
}

.avatar h3 {
    color: #ffd36b;
    font-family: Georgia, serif;
    margin-top: 9px;
    font-size: 17px;
}

.progress-details h2 {
    font-family: Georgia, serif;
    color: #fff0c9;
    font-size: 23px;
}

.progress-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    margin-bottom: 13px;
}

.progress-top strong {
    color: #fff0c9;
    font-size: 17px;
}

.progress-bar {
    height: 15px;
    background: #42284f;
    border: 1px solid #a96cc1;
    border-radius: 30px;
    overflow: hidden;
}

.progress-fill {
    height: 100%;
    width: <%= progress %>%;

    background: linear-gradient(90deg, #ffcf45, #ff9d24);
    border-radius: 30px;

    transition: width 0.7s ease;
}

.progress-percent {
    text-align: right;
    color: #ffd36b;
    font-size: 14px;
    font-weight: bold;
    margin-top: 8px;
}

/* STATISTICS CARDS */

.stats {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 16px;
    margin-bottom: 25px;
}

.stat-card {
    display: flex;
    align-items: center;
    gap: 16px;

    min-height: 112px;
    padding: 17px 19px;

    background: linear-gradient(145deg,
        rgba(255, 242, 222, 0.98),
        rgba(250, 218, 187, 0.98));

    border: 2px solid #e6ae42;
    border-radius: 15px;

    box-shadow: 0 5px 14px rgba(0,0,0,0.2);
    transition: 0.3s;
}

.stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 9px 22px rgba(255,190,70,0.25);
}

.stat-symbol {
    font-size: 29px;
    color: #a34d83;
}

.stat-card h3 {
    color: #59334f;
    font-family: Georgia, serif;
    font-size: 14px;
    margin-bottom: 7px;
}

.stat-card h2 {
    color: #32163d;
    font-family: Georgia, serif;
    font-size: 29px;
}

/* SECTION TITLE */

.quick-title {
    font-family: Georgia, serif;
    color: #fff0d0;
    font-size: 25px;
    margin: 27px 0 16px;
}

/* QUICK ACCESS CARDS */

.quick-links {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 19px;
}

.quick-card {
    min-height: 125px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;

    padding: 20px 23px;

    text-decoration: none;
    color: #32163d;

    background: linear-gradient(135deg,
        rgba(255, 231, 224, 0.98),
        rgba(249, 210, 211, 0.98));

    border: 2px solid #e7ad40;
    border-radius: 18px;

    box-shadow: 0 6px 18px rgba(0,0,0,0.2);
    transition: 0.3s;
}

.quick-card:hover {
    transform: translateY(-5px);
    background: linear-gradient(135deg, #fff0d8, #f7d5e6);
    box-shadow: 0 9px 25px rgba(255,191,74,0.3);
}

.quick-info {
    flex: 1;
}

.quick-info h2 {
    font-family: Georgia, serif;
    font-size: 22px;
    color: #35133f;
    margin-bottom: 8px;
}

.quick-info p {
    color: #4e3154;
    font-size: 14px;
    line-height: 1.5;
}

.quick-icon {
    display: none;
}

.arrow {
    width: 38px;
    height: 38px;
    flex-shrink: 0;

    display: grid;
    place-items: center;

    background: #6c2387;
    color: #ffd36b;

    border: 2px solid #eab94e;
    border-radius: 50%;

    font-size: 22px;
    transition: 0.3s;
}

.quick-card:hover .arrow {
    transform: translateX(5px);
    background: #8c30a9;
}

/* RECENT ACTIVITY */

.activity-section {
    margin-top: 26px;
    padding: 20px 25px;

    background: rgba(42, 17, 58, 0.97);
    border: 2px solid #e7b348;
    border-radius: 18px;

    box-shadow: 0 6px 20px rgba(0,0,0,0.2);
}

.activity-section h2 {
    font-family: Georgia, serif;
    font-size: 23px;
    color: #ffd36b;
    margin-bottom: 13px;
}

.activity-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;

    padding: 13px 7px;
    border-top: 1px solid rgba(231,179,72,0.3);
}

.activity-left {
    display: flex;
    align-items: center;
    gap: 13px;
}

.check {
    width: 27px;
    height: 27px;
    flex-shrink: 0;

    display: grid;
    place-items: center;

    background: #239d65;
    color: white;

    border-radius: 50%;
    font-weight: bold;
}

.activity-name {
    font-size: 14px;
    color: #f2e7f7;
    line-height: 1.5;
}

.activity-date {
    color: #c9b5d4;
    font-size: 11px;
}

.activity-xp {
    color: #ffd36b;
    font-weight: bold;
    white-space: nowrap;
    font-size: 14px;
}

.no-activity {
    text-align: center;
    padding: 22px;
    color: #e2d1ec;
    border-top: 1px solid rgba(231,179,72,0.3);
}

/* ERROR */

.db-error {
    padding: 14px;
    margin-bottom: 20px;
    border: 1px solid #ff8a8a;
    border-radius: 10px;
    background: rgba(120, 30, 40, 0.9);
    color: white;
}

/* FOOTER */

footer {
    text-align: center;
    padding: 20px;
    margin-top: 25px;
    color: #e0cce9;
    font-size: 13px;
    border-top: 1px solid rgba(231,179,72,0.3);
}

/* RESPONSIVE */

@media(max-width: 950px) {
    .stats {
        grid-template-columns: repeat(2, 1fr);
    }

    .quick-links {
        grid-template-columns: 1fr;
    }
}

@media(max-width: 650px) {
    nav {
        height: auto;
        padding: 15px 5%;
        flex-wrap: wrap;
    }

    .nav-links {
        gap: 14px;
        flex-wrap: wrap;
    }

    .container {
        width: 93%;
    }

    .welcome h1 {
        font-size: 29px;
    }

    .progress-section {
        grid-template-columns: 1fr;
        text-align: center;
    }

    .progress-top {
        flex-direction: column;
    }

    .stats {
        grid-template-columns: 1fr 1fr;
    }

    .stat-card {
        padding: 14px;
    }

    .stat-card h2 {
        font-size: 23px;
    }
}

</style>

</head>

<body>

<!-- NAVIGATION -->

<nav>

    <div class="logo">👑 CodeQuest</div>

    <div class="nav-links">
        <a href="studentHome.jsp"> Home </a>
        <a href="startQuest.jsp"> Start Quest</a>
        <a href="leaderboard.jsp"> Leaderboard</a>
    </div>

    <a href="logout" class="nav-links logout">
        Logout 
    </a>

</nav>

<div class="container">

    <!-- WELCOME -->

    <section class="welcome">

        <h1>
            Welcome Back, <span><%= displayName %></span> 
        </h1>

        <p>
            Continue your coding journey, complete missions and level up!
        </p>

        <div class="welcome-line"></div>

    </section>

    <% if (dbError) { %>
        <div class="db-error">
            Unable to load dashboard information. Please check the database connection.
        </div>
    <% } %>

    <!-- PROGRESS -->

    <section class="progress-section">

        <div class="avatar">

            <div class="avatar-circle">👑</div>

            <h3>Level <%= currentLevel %></h3>

        </div>

        <div class="progress-details">

            <div class="progress-top">

                <h2>Your Progress</h2>

                <strong><%= totalXP %> / 250 XP</strong>

            </div>

            <div class="progress-bar">

                <div class="progress-fill"></div>

            </div>

            <div class="progress-percent">
                <%= progress %>% Completed
            </div>

        </div>

    </section>

    <!-- STATISTICS -->

    <section class="stats">

        <div class="stat-card">

            <div class="stat-symbol">⚑</div>

            <div>
                <h3>Total Missions</h3>
                <h2><%= totalMissions %></h2>
            </div>

        </div>

        <div class="stat-card">

            <div class="stat-symbol">★</div>

            <div>
                <h3>Total XP</h3>
                <h2><%= totalXP %> XP</h2>
            </div>

        </div>

        <div class="stat-card">

            <div class="stat-symbol">♛</div>

            <div>
                <h3>Current Level</h3>
                <h2>Level <%= currentLevel %></h2>
            </div>

        </div>

        <div class="stat-card">

            <div class="stat-symbol">✓</div>

            <div>
                <h3>Completed Missions</h3>
                <h2><%= completedMissions %></h2>
            </div>

        </div>

    </section>

    <!-- QUICK ACCESS -->

    <h2 class="quick-title">Continue Your Adventure</h2>

    <section class="quick-links">

        <a href="startQuest.jsp" class="quick-card">

            <div class="quick-info">

                <h2>Start Your Quest</h2>

                <p>
                    Choose a level, solve challenges and earn XP.
                </p>

            </div>

            <div class="arrow">➜</div>

        </a>

        <a href="missions" class="quick-card">

            <div class="quick-info">

                <h2>Explore Missions</h2>

                <p>
                    Practice and complete programming missions.
                </p>

            </div>

            <div class="arrow">➜</div>

        </a>

        <a href="leaderboard.jsp" class="quick-card">

            <div class="quick-info">

                <h2>View Leaderboard</h2>

                <p>
                    Track your rank and compete with other learners.
                </p>

            </div>

            <div class="arrow">➜</div>

        </a>

    </section>

    <!-- RECENT ACTIVITY -->

    <section class="activity-section">

        <h2>◷ Recent Activity</h2>

        <% if (!recentActivities.isEmpty()) { %>

            <% for (String[] activity : recentActivities) { %>

                <div class="activity-item">

                    <div class="activity-left">

                        <div class="check">✓</div>

                        <div class="activity-name">

                            Completed: <%= activity[0] %>

                            <div class="activity-date">
                                <%= activity[1] %>
                            </div>

                        </div>

                    </div>

                    <div class="activity-xp">
                        +<%= activity[2] %> XP
                    </div>

                </div>

            <% } %>

        <% } else { %>

            <div class="no-activity">

                No completed missions yet.
                Start your first mission and your activity will appear here!

            </div>

        <% } %>

    </section>

</div>

<footer>
    Created by Buraga Akshaya
    <br><br>
    © CodeQuest | Learn • Play • Level Up
</footer>

</body>
</html>
