
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");

    List<String[]> missions =
        (List<String[]>) request.getAttribute("missions");

    String result = request.getParameter("result");
    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Programming Missions | CodeQuest</title>

<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    min-height: 100vh;
    font-family: 'DM Sans', sans-serif;
    color: #fff8ed;
    background:
        linear-gradient(rgba(24, 9, 37, .87), rgba(24, 9, 37, .94)),
        url('images/castle.png') center/cover fixed;
}

.page {
    width: 90%;
    max-width: 1150px;
    margin: auto;
    padding-bottom: 65px;
}

/* Navigation */
.navbar {
    min-height: 78px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid rgba(225, 177, 92, .35);
    gap: 15px;
}

.logo {
    font-family: 'Playfair Display', serif;
    font-size: 25px;
    font-weight: 800;
    color: #ffe5a8;
    text-decoration: none;
}

.logo span {
    color: #e9ad48;
}

.nav-right {
    display: flex;
    align-items: center;
    gap: 28px;
    flex-wrap: wrap;
}

.student {
    color: #e8d9c7;
    font-size: 13px;
}

.back-link {
    color: #f5c96f;
    text-decoration: none;
    font-size: 14px;
    font-weight: 700;
}

.back-link:hover {
    color: white;
}

/* Heading */
.hero {
    text-align: center;
    padding: 58px 0 38px;
}

.eyebrow {
    color: #e8b34f;
    font-size: 12px;
    font-weight: 800;
    letter-spacing: 4px;
}

.hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(34px, 5vw, 52px);
    color: #ffe4ae;
    margin: 13px 0;
}

.hero p {
    color: #d8c7df;
    font-size: 15px;
}

/* Result message */
.result-message {
    max-width: 850px;
    margin: 0 auto 25px;
    padding: 15px 20px;
    border-radius: 18px;
    text-align: center;
    background: rgba(255, 226, 175, .12);
    border: 1px solid #d8ad5d;
    color: #ffe5ad;
    font-weight: 700;
}

.result-actions {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 25px;
    flex-wrap: wrap;
}

.result-actions a {
    text-decoration: none;
    padding: 12px 20px;
    border-radius: 30px;
    color: #321b39;
    background: #e8bd68;
    font-weight: 800;
}

/* Mission cards */
.mission-grid {
    display: grid;
    grid-template-columns: minmax(0, 850px);
    justify-content: center;
    gap: 25px;
}

.mission-card {
    position: relative;
    overflow: hidden;
    padding: 32px;
    border-radius: 30px;
    background: linear-gradient(
        135deg,
        rgba(255, 239, 216, .98),
        rgba(246, 216, 207, .98)
    );
    color: #38203e;
    border: 1px solid rgba(238, 190, 102, .95);
    box-shadow: 0 16px 45px rgba(0, 0, 0, .22);
    transition: transform .25s ease, box-shadow .25s ease;
}

.mission-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 20px 48px rgba(0, 0, 0, .3);
}

.card-top {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    margin-bottom: 22px;
}

.mission-number {
    color: #9b6725;
    font-size: 12px;
    font-weight: 800;
    letter-spacing: 2px;
}

.difficulty {
    padding: 7px 16px;
    border-radius: 30px;
    background: #f2dfbd;
    color: #805321;
    border: 1px solid #d9b36b;
    font-size: 11px;
    font-weight: 800;
    text-transform: uppercase;
}

.mission-card h2 {
    font-family: 'Playfair Display', serif;
    font-size: 27px;
    color: #48264c;
    margin-bottom: 12px;
}

.mission-description {
    color: #654f66;
    line-height: 1.8;
    font-size: 15px;
    white-space: pre-wrap;
}

.mission-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-top: 20px;
}

.meta-item {
    padding: 9px 15px;
    border-radius: 30px;
    background: #f5e5d2;
    color: #76512e;
    font-size: 12px;
    font-weight: 700;
}

/* Question section */
.question-area {
    border-top: 1px solid #e1c6a9;
    margin-top: 24px;
    padding-top: 23px;
}

.question-label {
    color: #98651e;
    font-size: 12px;
    font-weight: 800;
    letter-spacing: 1.7px;
    margin-bottom: 15px;
}

.answer-option {
    display: flex;
    align-items: center;
    gap: 13px;
    padding: 15px 17px;
    margin-bottom: 11px;
    border: 1px solid #e4cbb2;
    border-radius: 16px;
    background: rgba(255, 255, 255, .48);
    color: #49334c;
    font-size: 14px;
    cursor: pointer;
    transition: .2s ease;
}

.answer-option:hover {
    border-color: #bd8736;
    background: #fff4e2;
    transform: translateX(3px);
}

.answer-option input {
    width: 17px;
    height: 17px;
    accent-color: #98602c;
    cursor: pointer;
    flex-shrink: 0;
}

.answer-option:has(input:checked) {
    border-color: #a66b2c;
    background: #f8e4c2;
    box-shadow: 0 0 0 2px rgba(166, 107, 44, .12);
}

/* Card footer */
.card-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    margin-top: 23px;
    padding-top: 20px;
    border-top: 1px solid #e1c6a9;
}

.xp-reward {
    color: #98651e;
    font-weight: 800;
    font-size: 17px;
    white-space: nowrap;
}

.submit-btn {
    padding: 14px 25px;
    border: 1px solid #f3d18b;
    border-radius: 30px;
    color: #38203e;
    background: linear-gradient(110deg, #e6b85e, #f6d58f);
    font-size: 13px;
    font-weight: 800;
    cursor: pointer;
    transition: .25s ease;
}

.submit-btn:hover {
    background: #ffdf9b;
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(143, 94, 31, .2);
}

.empty-message {
    max-width: 850px;
    margin: auto;
    padding: 45px 25px;
    border-radius: 28px;
    background: rgba(255, 239, 216, .96);
    color: #49334c;
    text-align: center;
}

.empty-message h2 {
    font-family: 'Playfair Display', serif;
    margin-bottom: 12px;
}

.login-note {
    text-align: center;
    margin-top: 30px;
    color: #e2d3e8;
    font-size: 14px;
}

.login-note a {
    color: #f2c66d;
    text-decoration: none;
    font-weight: 800;
}

.footer {
    text-align: center;
    padding: 25px 10px;
    color: #cbb7d1;
    font-size: 12px;
}

@media(max-width: 650px) {
    .page {
        width: 92%;
    }

    .navbar {
        padding: 15px 0;
        align-items: flex-start;
    }

    .nav-right {
        gap: 12px;
        justify-content: flex-end;
    }

    .student {
        display: none;
    }

    .hero {
        padding: 40px 0 30px;
    }

    .mission-card {
        padding: 23px 19px;
        border-radius: 24px;
    }

    .mission-card h2 {
        font-size: 23px;
    }

    .card-footer {
        flex-direction: column;
        align-items: stretch;
    }

    .submit-btn {
        width: 100%;
    }
}
</style>
</head>

<body>
<div class="page">

    <nav class="navbar">
        <a class="logo" href="<%= ctx %>/studentDashboard.jsp">
            👑 Code<span>Quest</span>
        </a>

        <div class="nav-right">
            <span class="student">
                <%= userEmail == null ? "Guest Player" : "Student: " + userEmail %>
            </span>

            <% if (userEmail != null) { %>
                <a class="back-link" href="<%= ctx %>/studentDashboard.jsp">
                    ← Back to Dashboard
                </a>
            <% } else { %>
                <a class="back-link" href="<%= ctx %>/login.jsp">
                    Login →
                </a>
            <% } %>
        </div>
    </nav>

    <section class="hero">
        <div class="eyebrow">⚔ YOUR NEXT CHALLENGE AWAITS ⚔</div>
        <h1>Choose Your Mission</h1>
        <p>Test your programming skills, earn XP and level up!</p>
    </section>

    <% if (result != null && userEmail != null) { %>
        <div class="result-message">
            Your answer has been submitted. Check your updated XP and progress.
        </div>

        <div class="result-actions">
            <a href="<%= ctx %>/studentDashboard.jsp">Finish & Back to Dashboard</a>
            <a href="<%= ctx %>/missions">View Missions</a>
        </div>
    <% } %>

    <% if (missions == null || missions.isEmpty()) { %>

        <div class="empty-message">
            <h2>No Missions Available</h2>
            <p>New programming challenges will appear here soon.</p>
        </div>

    <% } else { %>

        <div class="mission-grid">
            <% int count = 1; %>

            <% for (String[] mission : missions) { %>

                <div class="mission-card">

                    <div class="card-top">
                        <span class="mission-number">
                            MISSION <%= count++ %>
                        </span>

                        <span class="difficulty">
                            <%= mission[4] %>
                        </span>
                    </div>

                    <h2><%= mission[1] %></h2>

                    <p class="mission-description"><%= mission[2] %></p>

                    <div class="mission-meta">
                        <span class="meta-item">📚 <%= mission[3] %></span>
                        <span class="meta-item">⚡ <%= mission[9] %> XP</span>
                    </div>

                    <div class="question-area">
                        <div class="question-label">SELECT YOUR ANSWER</div>

                        <form action="<%= ctx %>/submitAnswer" method="post">

                            <input type="hidden" name="missionId"
                                   value="<%= mission[0] %>">

                            <label class="answer-option">
                                <input type="radio" name="answer" value="A" required>
                                <span>A. <%= mission[5] %></span>
                            </label>

                            <label class="answer-option">
                                <input type="radio" name="answer" value="B">
                                <span>B. <%= mission[6] %></span>
                            </label>

                            <label class="answer-option">
                                <input type="radio" name="answer" value="C">
                                <span>C. <%= mission[7] %></span>
                            </label>

                            <label class="answer-option">
                                <input type="radio" name="answer" value="D">
                                <span>D. <%= mission[8] %></span>
                            </label>

                            <div class="card-footer">
                                <span class="xp-reward">
                                    🏆 +<%= mission[9] %> XP
                                </span>

                                <button type="submit" class="submit-btn">
                                    SUBMIT ANSWER →
                                </button>
                            </div>

                        </form>
                    </div>
                </div>

            <% } %>
        </div>

    <% } %>

    <% if (userEmail == null) { %>
        <p class="login-note">
            Want to earn XP?
            <a href="<%= ctx %>/login.jsp">Login to submit your answers.</a>
        </p>
    <% } %>

    <footer class="footer">
        Created by Buraga Akshaya · CodeQuest
    </footer>

</div>
</body>
</html>
