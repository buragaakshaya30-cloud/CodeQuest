
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String context = request.getContextPath();

    if (session.getAttribute("userEmail") != null) {
        response.sendRedirect(context + "/studentDashboard.jsp");
        return;
    }

    if (session.getAttribute("adminUsername") != null) {
        response.sendRedirect(context + "/adminDashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CodeQuest | Choose Your Path</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    min-height: 100vh;
    font-family: Arial, sans-serif;
    color: #f8f2ff;
    background:
        radial-gradient(ellipse at 50% 0%, #38204f 0%, transparent 55%),
        #100817;
}

.page {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.navbar {
    padding: 25px 7%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #493052;
}

.logo {
    color: #fff;
    font-size: 28px;
    font-weight: 800;
    letter-spacing: 1px;
    text-decoration: none;
}

.logo span {
    color: #bd7aff;
}

.nav-note {
    color: #c8b9d4;
    font-size: 14px;
}

.main {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 65px 20px;
    text-align: center;
}

.eyebrow {
    color: #ffc45c;
    letter-spacing: 5px;
    font-size: 13px;
    font-weight: bold;
    margin-bottom: 18px;
}

h1 {
    font-family: Georgia, serif;
    font-size: clamp(38px, 6vw, 66px);
    margin-bottom: 15px;
}

h1 span {
    color: #bd7aff;
}

.subtitle {
    color: #c8b9d4;
    font-size: 17px;
    line-height: 1.7;
    margin-bottom: 48px;
}

.login-options {
    width: 100%;
    max-width: 850px;
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 28px;
}

.login-card {
    background: linear-gradient(145deg, #261632, #171020);
    border: 1px solid #624079;
    border-radius: 20px;
    padding: 38px 30px;
    text-align: center;
    transition: 0.3s ease;
}

.login-card:hover {
    transform: translateY(-8px);
    border-color: #bd7aff;
    box-shadow: 0 0 30px rgba(189, 122, 255, 0.2);
}

.login-icon {
    font-size: 48px;
    margin-bottom: 20px;
}

.login-card h2 {
    font-family: Georgia, serif;
    font-size: 29px;
    margin-bottom: 13px;
}

.login-card p {
    color: #c8b9d4;
    line-height: 1.6;
    min-height: 50px;
    margin-bottom: 25px;
}

.student-card {
    border-top: 3px solid #bd7aff;
}

.admin-card {
    border-top: 3px solid #ffc45c;
}

.login-btn {
    display: inline-block;
    padding: 14px 28px;
    border-radius: 10px;
    text-decoration: none;
    color: white;
    font-weight: bold;
    background: linear-gradient(100deg, #8135bd, #542477);
    border: 1px solid #bd7aff;
    transition: 0.3s;
}

.login-btn:hover {
    background: #9c4bdd;
    box-shadow: 0 0 20px rgba(189, 122, 255, 0.5);
}

.admin-card .login-btn {
    background: linear-gradient(100deg, #a86c19, #70450d);
    border-color: #ffc45c;
}

.admin-card .login-btn:hover {
    background: #c58a2e;
    box-shadow: 0 0 20px rgba(255, 196, 92, 0.4);
}

.register-note {
    margin-top: 35px;
    color: #c8b9d4;
}

.register-note a {
    color: #d49aff;
    text-decoration: none;
    font-weight: bold;
}

.footer {
    text-align: center;
    padding: 22px;
    border-top: 1px solid #493052;
    color: #8f7d9d;
    font-size: 13px;
}

@media (max-width: 650px) {
    .navbar {
        padding: 20px;
    }

    .nav-note {
        display: none;
    }

    .login-options {
        grid-template-columns: 1fr;
        max-width: 420px;
    }

    .main {
        padding: 45px 18px;
    }
}
</style>
</head>

<body>
<div class="page">

    <nav class="navbar">
        <a class="logo" href="<%= context %>/index.jsp">
            CODE<span>QUEST</span>
        </a>
        <span class="nav-note">Your journey. Your challenge. Your victory.</span>
    </nav>

    <main class="main">

        <div class="eyebrow">✦ ENTER THE WORLD OF CODEQUEST ✦</div>

        <h1>Choose Your <span>Path</span></h1>

        <p class="subtitle">
            Learn programming, complete challenges and earn experience points.
            <br>Choose how you want to enter your quest.
        </p>

        <div class="login-options">

            <div class="login-card student-card">
                <div class="login-icon">🎓</div>
                <h2>Student Login</h2>
                <p>
                    Enter your learning space, solve programming missions,
                    earn XP and climb the leaderboard.
                </p>
                <a class="login-btn" href="<%= context %>/login.jsp">
                    ENTER AS STUDENT →
                </a>
            </div>

            <div class="login-card admin-card">
                <div class="login-icon">👑</div>
                <h2>Admin Login</h2>
                <p>
                    Manage programming missions, add challenges
                    and monitor student performance.
                </p>
                <a class="login-btn" href="<%= context %>/adminLogin.jsp">
                    ENTER AS ADMIN →
                </a>
            </div>

        </div>

        <p class="register-note">
            New student?
            <a href="<%= context %>/register.jsp">Create an account</a>
        </p>

    </main>

    <footer class="footer">
        CODEQUEST · Learn by playing. Level up by learning.
    </footer>

</div>
</body>
</html>
