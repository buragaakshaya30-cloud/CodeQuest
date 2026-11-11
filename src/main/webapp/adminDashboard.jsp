
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String adminUsername = (String) session.getAttribute("adminUsername");

    if (adminUsername == null) {
        response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
        return;
    }

    String context = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | CodeQuest</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            color: #f8f2ff;
            background:
                linear-gradient(rgba(13, 5, 25, 0.48),
                                rgba(13, 5, 25, 0.72)),
                url("images/admin.png") center center / cover fixed no-repeat;
            background-color: #100817;
            min-height: 100vh;
        }

        .admin-dashboard {
            min-height: 100vh;
            padding: 25px 5.5%;
        }

        /* Navigation */

        .admin-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 0 25px;
            border-bottom: 1px solid rgba(189, 122, 255, 0.65);
            gap: 20px;
        }

        .admin-logo {
            font-size: 34px;
            font-weight: 900;
            color: white;
            text-decoration: none;
            letter-spacing: -1px;
        }

        .admin-logo span {
            color: #ffc45c;
        }

        .nav-actions {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .nav-btn {
            display: inline-block;
            padding: 14px 30px;
            border: 2px solid #ffc45c;
            border-radius: 35px;
            color: #ffc45c;
            background: rgba(35, 17, 49, 0.85);
            text-decoration: none;
            font-size: 17px;
            font-weight: bold;
            box-shadow: 0 0 15px rgba(255, 196, 92, 0.35);
            transition: 0.3s;
        }

        .nav-btn:hover {
            background: #ffc45c;
            color: #180c22;
            transform: translateY(-2px);
        }

        /* Hero */

        .admin-content {
            padding-top: 65px;
        }

        .hero-label {
            color: #cf83ff;
            font-size: 17px;
            font-weight: bold;
            letter-spacing: 5px;
            margin-bottom: 15px;
        }

        .admin-content h1 {
            font-family: Georgia, serif;
            font-size: clamp(42px, 6vw, 68px);
            margin-bottom: 12px;
        }

        .admin-content h1 span {
            color: #ffc45c;
        }

        .hero-description {
            font-size: 20px;
            color: #eee1f5;
            line-height: 1.6;
        }

        /* Logged in badge */

        .admin-user {
            display: inline-flex;
            align-items: center;
            gap: 13px;
            margin-top: 22px;
            padding: 14px 24px;
            border: 2px solid #ffc45c;
            border-radius: 35px;
            background: rgba(32, 15, 45, 0.9);
            color: white;
            font-size: 18px;
            font-weight: bold;
            box-shadow: 0 0 17px rgba(255, 196, 92, 0.35);
        }

        .admin-user .crown {
            color: #ffc45c;
            font-size: 24px;
        }

        /* Quick access cards */

        .quick-links {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 22px;
            margin-top: 45px;
        }

        .quick-card {
            display: block;
            padding: 27px 22px;
            text-align: center;
            text-decoration: none;
            color: white;
            background: rgba(31, 16, 44, 0.88);
            border: 2px solid #bd7aff;
            border-radius: 17px;
            box-shadow: 0 0 17px rgba(189, 122, 255, 0.25);
            transition: 0.3s;
        }

        .quick-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 0 25px rgba(189, 122, 255, 0.55);
            border-color: #ffc45c;
        }

        .quick-icon {
            font-size: 35px;
            margin-bottom: 13px;
        }

        .quick-card h3 {
            color: #ffc45c;
            font-size: 21px;
            margin-bottom: 9px;
        }

        .quick-card p {
            color: #dfd1e9;
            font-size: 14px;
            line-height: 1.5;
        }

        /* Programming missions panel */

        .admin-card {
            margin-top: 45px;
            padding: 35px;
            background: rgba(31, 16, 44, 0.91);
            border: 2px solid #ffc45c;
            border-radius: 23px;
            box-shadow: 0 0 25px rgba(255, 196, 92, 0.4);
            backdrop-filter: blur(8px);
        }

        .card-heading {
            display: flex;
            align-items: center;
            gap: 22px;
            margin-bottom: 25px;
        }

        .card-icon {
            font-size: 43px;
            color: #ffc45c;
        }

        .admin-card h2 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .admin-card .description {
            color: #e7d9ef;
            font-size: 18px;
            line-height: 1.5;
        }

        .card-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
        }

        .action-btn {
            display: inline-block;
            padding: 15px 27px;
            border: 2px solid #ffc45c;
            border-radius: 15px;
            color: #ffc45c;
            background: transparent;
            text-decoration: none;
            font-size: 17px;
            font-weight: bold;
            transition: 0.3s;
        }

        .action-btn.primary {
            background: linear-gradient(100deg, #a020e8, #6815b7);
            color: white;
            border-color: #bd7aff;
        }

        .action-btn:hover {
            background: #ffc45c;
            color: #180c22;
            transform: translateY(-3px);
        }

        /* Responsive */

        @media (max-width: 850px) {
            .quick-links {
                grid-template-columns: 1fr;
            }

            .admin-nav {
                flex-direction: column;
            }

            .nav-actions {
                flex-wrap: wrap;
                justify-content: center;
            }

            .admin-content {
                padding-top: 40px;
            }
        }

        @media (max-width: 500px) {
            .admin-dashboard {
                padding: 20px 5%;
            }

            .admin-logo {
                font-size: 28px;
            }

            .nav-btn {
                padding: 11px 19px;
                font-size: 14px;
            }

            .admin-card {
                padding: 22px;
            }

            .card-heading {
                align-items: flex-start;
            }

            .action-btn {
                width: 100%;
                text-align: center;
            }
        }
        .leaderboard-nav-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 12px 24px;
    border: 1.5px solid #e6b84d;
    border-radius: 30px;
    color: #ffd36f !important;
    text-decoration: none !important;
    font-size: 15px;
    font-weight: 600;
    background: rgba(42, 17, 57, 0.65);
    transition: all 0.3s ease;
}

.leaderboard-nav-btn:hover {
    background: #e6b84d;
    color: #291337 !important;
    transform: translateY(-2px);
    box-shadow: 0 5px 18px rgba(230, 184, 77, 0.25);
}
        
    </style>
</head>

<body>

<div class="admin-dashboard">

    <!-- Navigation -->
    <nav class="admin-nav">

        <a href="<%= context %>/adminDashboard.jsp" class="admin-logo">
            CODE<span>QUEST</span>
        </a>

        <div class="nav-actions">


<a href="<%= request.getContextPath() %>/adminlogout"
   class="nav-btn">
    Logout ↗
</a>

        </div>

    </nav>

    <!-- Hero section -->
    <section class="admin-content">

        <p class="hero-label">ADMIN CONTROL CENTER</p>

        <h1>
            Admin <span>Dashboard</span>
        </h1>

        <p class="hero-description">
            Manage programming missions, students, and platform activities.
        </p>

        <div class="admin-user">
            <span class="crown">♛</span>
            Logged in as: <%= adminUsername %>
        </div>

    </section>

    <!-- Quick access -->
    <section class="quick-links">

        <a href="<%= context %>/addMission.jsp" class="quick-card">
            <div class="quick-icon">✚</div>
            <h3>Add New Mission</h3>
            <p>Create new programming challenges for students.</p>
        </a>

        <a href="<%= context %>/manageMissions" class="quick-card">
            <div class="quick-icon">☷</div>
            <h3>Manage Missions</h3>
            <p>Edit, update and manage existing missions.</p>
        </a>

        <a href="<%= context %>/studentPerformance" class="quick-card">
          <div class="quick-icon">
    <svg width="32" height="32" viewBox="0 0 32 32" fill="white">
        <rect x="4" y="17" width="6" height="11" rx="1"/>
        <rect x="13" y="10" width="6" height="18" rx="1"/>
        <rect x="22" y="4" width="6" height="24" rx="1"/>
    </svg>
</div>
            <h3>Student Performance</h3>
            <p>Review student progress and mission submissions.</p>
        </a>

    </section>

    <!-- Programming Missions -->
    <section class="admin-card">

        <div class="card-heading">

            <div class="card-icon">▱</div>

            <div>
                <h2>Programming Missions</h2>

                <p class="description">
                    Create and manage programming challenges for students.
                </p>
            </div>

        </div>

        <div class="card-actions">

            <a href="<%= context %>/addMission.jsp"
               class="action-btn primary">
                + Add New Mission
            </a>

            <a href="<%= context %>/manageMissions"
               class="action-btn">
                ☷ Manage Missions
            </a>
<a href="<%= context %>/studentPerformance"
   class="action-btn">

    <svg width="16" height="16" viewBox="0 0 32 32"
         fill="gold"
         style="vertical-align: middle; margin-right: 5px;">

        <rect x="4" y="17" width="6" height="11" rx="1"/>
        <rect x="13" y="10" width="6" height="18" rx="1"/>
        <rect x="22" y="4" width="6" height="24" rx="1"/>

    </svg>

    View Student Performance
</a>
        </div>

    </section>

</div>

</body>
</html>
