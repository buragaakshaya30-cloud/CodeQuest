
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        username = "Student";
    }

    int xp = 0;
    int level = 1;

    Object xpValue = session.getAttribute("xp");
    Object levelValue = session.getAttribute("level");

    if (xpValue != null) xp = (Integer) xpValue;
    if (levelValue != null) level = (Integer) levelValue;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Start Quest | CodeQuest</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    color: white;
    min-height: 100vh;
    background:
        linear-gradient(rgba(24, 8, 42, 0.78), rgba(24, 8, 42, 0.88)),
        url("images/castle.png") center/cover fixed;
}

nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 18px 5%;
    background: rgba(35, 12, 43, 0.95);
    border-bottom: 2px solid #e9b84b;
}

.logo {
    font-size: 27px;
    font-weight: bold;
    color: #ffd36b;
}

nav a {
    color: white;
    text-decoration: none;
    margin: 0 12px;
}

.profile {
    border: 1px solid #e9b84b;
    border-radius: 25px;
    padding: 10px 18px;
}

.container {
    width: 90%;
    max-width: 1200px;
    margin: 35px auto;
}

.heading {
    text-align: center;
    margin-bottom: 30px;
}

.heading h1 {
    color: #ffd36b;
    font-size: 45px;
    margin-bottom: 12px;
}

.progress {
    background: rgba(35, 12, 43, 0.95);
    border: 1px solid #e9b84b;
    border-radius: 15px;
    padding: 18px;
    margin-bottom: 25px;
}

.progress-bar {
    height: 13px;
    background: #49364f;
    border-radius: 20px;
    margin-top: 12px;
    overflow: hidden;
}

.progress-fill {
    height: 100%;
    width: 0%;
    background: linear-gradient(90deg, #a020f0, #ffd36b);
    border-radius: 20px;
}

.level-card {
    display: grid;
    grid-template-columns: 90px 1fr auto;
    align-items: center;
    gap: 22px;
    background: rgba(255, 239, 216, 0.96);
    color: #29152f;
    border: 2px solid #e9b84b;
    border-radius: 20px;
    padding: 24px;
    margin: 18px 0;
    transition: 0.3s;
}

.level-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 0 22px rgba(255, 193, 75, 0.5);
}

.medal {
    width: 75px;
    height: 75px;
    border-radius: 50%;
    display: grid;
    place-items: center;
    font-size: 42px;
    background: linear-gradient(145deg, #ffe3a0, #b56b25);
    border: 4px solid #d18b35;
}

.level-info h2 {
    margin-bottom: 8px;
}

.level-info p {
    margin-bottom: 12px;
    color: #57445a;
}

.reward {
    color: #a05c12;
    font-weight: bold;
}

.status {
    text-align: center;
}

.status span {
    display: block;
    margin-bottom: 12px;
    font-weight: bold;
}

.level-btn {
    display: inline-block;
    background: linear-gradient(135deg, #9415d4, #6510a8);
    color: white;
    padding: 12px 24px;
    border-radius: 25px;
    text-decoration: none;
    font-weight: bold;
}

.level-btn:hover {
    background: #521080;
}

.locked {
    opacity: 0.65;
}

.locked .level-btn {
    background: #777;
    pointer-events: none;
}


.medals-section {
    background:light purple;
    border: 1px solid #e9b84b;
    border-radius: 18px;
    padding: 25px;
    text-align: center;
}
.medals {
    display: flex;
    justify-content: space-evenly;
    align-items: center;
    gap: 20px;
    flex-wrap: wrap;
}

.medal-item img {
    width: 110px;
    height: 110px;
    object-fit: contain;
    display: block;
    margin: 0 auto 12px;
    background: transparent;
}
.medal-item img:hover {
    transform: scale(1.08);
}

.medal-item h3 {
    margin-top: 8px;
    color: #ffd36b;
    font-size: 17px;
}

.medal-item p {
    color: white;
    font-size: 13px;
}
.medal-item {
    width: 150px;
    text-align: center;
}

.medal-item strong {
    display: block;
    font-size: 35px;
    margin-bottom: 8px;
}

@media(max-width: 700px) {
    .level-card {
        grid-template-columns: 1fr;
        text-align: center;
    }
    nav {
        flex-wrap: wrap;
        gap: 15px;
    }
}
</style>
</head>

<body>

<nav>
    <div class="logo">👑 CodeQuest</div>

    <div>
        <a href="studentHome.jsp">Home</a>
        <a href="startQuest.jsp">Start Quest</a>
        <a href="leaderboard">Leaderboard</a>
    </div>

    <div class="profile">
        <%= username %> | Level <%= level %> | <%= xp %> XP
    </div>
</nav>

<div class="container">

    <div class="heading">
        <h1>⚔ Start Quest</h1>
        <p>Choose a level, solve challenges, earn XP and collect medals!</p>
    </div>

    <div class="progress">
        <h3>Your Overall Progress</h3>
        <p>Level <%= level %> &nbsp; | &nbsp; <%= xp %> XP</p>
        <div class="progress-bar">
            <div class="progress-fill"></div>
        </div>
    </div>

    <div class="level-card">
        <div class="medal">🥉</div>
        <div class="level-info">
            <h2>Level 1 – Beginner</h2>
            <p>Learn programming basics and solve simple challenges.</p>
            <div class="reward">🏆 Reward: 100 XP + Bronze Medal</div>
        </div>
        <div class="status">
            <span>🟢 Beginner Level</span>
            <a class="level-btn" href="missions?level=1">Start Level</a>
        </div>
    </div>

    <div class="level-card <%= level < 2 ? "locked" : "" %>">
        <div class="medal">🥈</div>
        <div class="level-info">
            <h2>Level 2 – Intermediate</h2>
            <p>Improve your logic with moderate programming challenges.</p>
            <div class="reward">🏆 Reward: 200 XP + Silver Medal</div>
        </div>
        <div class="status">
            <span><%= level >= 2 ? "🟣 Unlocked" : "🔒 Locked" %></span>
            <a class="level-btn" href="<%= level >= 2 ? "missions?level=2" : "#" %>">
                <%= level >= 2 ? "Start Level" : "Complete Level 1" %>
            </a>
        </div>
    </div>

    <div class="level-card <%= level < 3 ? "locked" : "" %>">
        <div class="medal">🥇</div>
        <div class="level-info">
            <h2>Level 3 – Advanced</h2>
            <p>Solve complex problems and demonstrate your skills.</p>
            <div class="reward">🏆 Reward: 300 XP + Gold Medal</div>
        </div>
        <div class="status">
            <span><%= level >= 3 ? "🟡 Unlocked" : "🔒 Locked" %></span>
            <a class="level-btn" href="<%= level >= 3 ? "missions?level=3" : "#" %>">
                <%= level >= 3 ? "Start Level" : "Complete Level 2" %>
            </a>
        </div>
    </div>

<div class="medals-section">
    <h2>🏆 Your Medals</h2>

    <div class="medals">

        <div class="medal-item">
            <img src="images/bronze.png" alt="Bronze Medal">
            <h3>Bronze</h3>
            <p><%= level >= 1 ? "Achieved" : "Locked" %></p>
        </div>

        <div class="medal-item">
            <img src="images/silver.png" alt="Silver Medal">
            <h3>Silver</h3>
            <p><%= level >= 2 ? "Achieved" : "Locked" %></p>
        </div>

        <div class="medal-item">
            <img src="images/gold.png" alt="Gold Medal">
            <h3>Gold</h3>
            <p><%= level >= 3 ? "Achieved" : "Locked" %></p>
        </div>

        <div class="medal-item">
            <img src="images/platinum.png" alt="Platinum Medal">
            <h3>Platinum</h3>
            <p><%= level >= 4 ? "Achieved" : "Locked" %></p>
        </div>

    </div>
</div>

    </div>

</div>
</body>
</html>
