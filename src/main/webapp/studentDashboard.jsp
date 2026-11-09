
<%@ page import="java.util.List" %>
<%@ page import="com.codequest.dao.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String userEmail = (String) session.getAttribute("userEmail");
    Integer userId = (Integer) session.getAttribute("userId");

    if (userEmail == null || userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    UserDAO dao = new UserDAO();

    int totalMissions = dao.getTotalMissions();
    int totalXP = dao.getTotalXP(userEmail);
    int level = dao.getLevel(userEmail);
    int completedMissions = dao.getCompletedMissions(userId);

    List<String[]> completedMissionDetails =
            dao.getCompletedMissionDetails(userId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard | CodeQuest</title>

    <link rel="stylesheet" href="css/style.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            color: #f8f2ff;
            background: #100817;
        }

        .student-dashboard {
            min-height: 100vh;
            padding: 30px 7%;
            background:
                linear-gradient(
                    rgba(16, 8, 23, 0.78),
                    rgba(16, 8, 23, 0.90)
                ),
                url("images/student-bg.png") center center / cover fixed;
        }

        /* Navigation */
        .dashboard-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 18px;
            padding: 10px 0 25px;
            border-bottom: 1px solid rgba(189, 122, 255, 0.35);
        }

        .dashboard-logo {
            color: white;
            font-size: 29px;
            font-weight: 900;
            text-decoration: none;
            letter-spacing: -1px;
        }

        .dashboard-logo span {
            color: #bd7aff;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .nav-btn {
            display: inline-block;
            padding: 12px 23px;
            border: 1px solid #ffc45c;
            border-radius: 30px;
            color: #ffc45c;
            background: rgba(40, 20, 55, 0.85);
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .nav-btn:hover {
            background: #ffc45c;
            color: #100817;
            box-shadow: 0 0 18px rgba(255, 196, 92, 0.5);
            transform: translateY(-2px);
        }

        .dashboard-user {
            display: block;
            width: fit-content;
            margin: 18px 0 0 auto;
            padding: 10px 22px;
            color: #e1c9f5;
            background: rgba(40, 20, 55, 0.8);
            border: 1px solid rgba(189, 122, 255, 0.4);
            border-radius: 25px;
            font-size: 14px;
        }

        /* Welcome */
        .welcome-section {
            margin: 55px 0 35px;
        }

        .welcome-label {
            color: #bd7aff;
            letter-spacing: 4px;
            font-size: 13px;
            font-weight: bold;
        }

        .welcome-section h1 {
            font-size: 42px;
            margin: 15px 0;
            font-family: Georgia, serif;
        }

        .welcome-section h1 span {
            color: #ffc45c;
        }

        .welcome-description {
            color: #d4c5df;
            font-size: 16px;
            line-height: 1.8;
        }

        /* Statistics */
        .dashboard-stats {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
            margin: 40px 0 55px;
        }

        .stat-card {
            position: relative;
            padding: 30px;
            min-height: 155px;
            border-radius: 18px;
            border: 1px solid rgba(189, 122, 255, 0.55);
            background: rgba(35, 19, 48, 0.86);
            backdrop-filter: blur(10px);
            box-shadow: 0 0 18px rgba(150, 70, 220, 0.12);
            transition: 0.3s ease;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-7px);
            border-color: #ffc45c;
            box-shadow: 0 0 25px rgba(255, 196, 92, 0.25);
        }

        .stat-card::after {
            content: "";
            position: absolute;
            width: 90px;
            height: 90px;
            right: -25px;
            top: -25px;
            border-radius: 50%;
            background: rgba(189, 122, 255, 0.10);
        }

        .stat-icon {
            font-size: 25px;
            margin-bottom: 12px;
        }

        .stat-card p {
            margin: 0;
            color: #d4c5df;
            font-size: 16px;
        }

        .stat-card h2 {
            margin: 12px 0 0;
            font-size: 36px;
            color: #bd7aff;
        }

        /* Programming journey */
        .missions-section {
            padding: 35px;
            border: 1px solid rgba(189, 122, 255, 0.55);
            border-radius: 20px;
            background: rgba(32, 17, 45, 0.91);
            backdrop-filter: blur(10px);
            box-shadow: 0 0 25px rgba(150, 70, 220, 0.15);
        }

        .section-heading {
            font-family: Georgia, serif;
            font-size: 29px;
            margin: 0 0 12px;
            color: #fff4ff;
        }

        .mission-message {
            color: #d4c5df;
            line-height: 1.8;
        }

        .completed-mission {
            padding: 22px;
            margin-top: 20px;
            border: 1px solid rgba(189, 122, 255, 0.35);
            border-left: 4px solid #ffc45c;
            border-radius: 13px;
            background: rgba(16, 8, 23, 0.85);
            transition: 0.3s;
        }

        .completed-mission:hover {
            border-color: #ffc45c;
            transform: translateX(4px);
        }

        .completed-mission h3 {
            color: #bd7aff;
            margin-top: 0;
            font-size: 21px;
        }

        .completed-mission p {
            color: #d4c5df;
            line-height: 1.6;
        }

        .completed-mission .xp {
            color: #ffc45c;
            font-weight: bold;
        }

        .completed-mission .status {
            color: #20c997;
            font-weight: bold;
        }

        /* Footer */
        .dashboard-footer {
            text-align: center;
            margin-top: 55px;
            padding: 20px;
            color: #b9a5c9;
            font-size: 13px;
        }

        @media (max-width: 700px) {
            .student-dashboard {
                padding: 22px 5%;
            }

            .dashboard-nav {
                flex-direction: column;
                align-items: center;
            }

            .nav-actions {
                justify-content: center;
            }

            .dashboard-user {
                margin: 15px auto 0;
            }

            .dashboard-stats {
                grid-template-columns: 1fr;
            }

            .welcome-section h1 {
                font-size: 30px;
            }

            .missions-section {
                padding: 22px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            .stat-card,
            .completed-mission,
            .nav-btn {
                transition: none;
            }
        }
    </style>
</head>

<body>

<div class="student-dashboard">

    <nav class="dashboard-nav">

        <a href="studentHome.jsp" class="dashboard-logo">
            CODE<span>QUEST</span>
        </a>

        <div class="nav-actions">

            <a href="<%= request.getContextPath() %>/studentHome.jsp"
               class="nav-btn">
                🏠 Home
            </a>

            <a href="<%= request.getContextPath() %>/leaderboard"
               class="nav-btn">
                🏆 Leaderboard
            </a>

            <a href="<%= request.getContextPath() %>/logout"
               class="nav-btn">
                Logout →
            </a>

        </div>

    </nav>

    <div class="dashboard-user">
        Logged in as: <%= userEmail %>
    </div>

    <section class="welcome-section">

        <p class="welcome-label">✦ YOUR LEARNING SPACE ✦</p>

        <h1>
            Welcome to <span>CodeQuest!</span>
        </h1>

        <p class="welcome-description">
            Your programming journey continues here.
            Explore missions, earn XP and improve your coding skills.
        </p>

    </section>

    <section class="dashboard-stats">

        <div class="stat-card">
            <div class="stat-icon">📚</div>
            <p>Total Missions</p>
            <h2><%= totalMissions %></h2>
        </div>

        <div class="stat-card">
            <div class="stat-icon">⭐</div>
            <p>Total XP</p>
            <h2><%= totalXP %></h2>
        </div>

        <div class="stat-card">
            <div class="stat-icon">👑</div>
            <p>Current Level</p>
            <h2><%= level %></h2>
        </div>

        <div class="stat-card">
            <div class="stat-icon">🏆</div>
            <p>Completed Missions</p>
            <h2><%= completedMissions %></h2>
        </div>

    </section>

    <section class="missions-section">

        <h2 class="section-heading">
            ✦ Your Programming Journey
        </h2>

        <p class="mission-message">
            Here are the programming missions you have completed.
        </p>

        <%
            if (completedMissionDetails.isEmpty()) {
        %>

            <p class="mission-message">
                You haven't completed any missions yet.
                Start solving challenges to earn XP!
            </p>

        <%
            } else {
                for (String[] mission : completedMissionDetails) {
        %>

            <div class="completed-mission">

                <h3><%= mission[0] %></h3>

                <p>Category: <%= mission[1] %></p>

                <p>Difficulty: <%= mission[2] %></p>

                <p>Selected Answer: <%= mission[3] %></p>

                <p class="xp">
                    XP Earned: +<%= mission[4] %>
                </p>

                <p class="status">
                    Status: Completed ✓
                </p>

            </div>

        <%
                }
            }
        %>

    </section>

    <footer class="dashboard-footer">
        Created by Buraga Akshaya · CodeQuest
    </footer>

</div>

</body>
</html>
