
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%
    String userEmail = (String) session.getAttribute("userEmail");

    List<String[]> missions =
        (List<String[]>) request.getAttribute("missions");

    String result = request.getParameter("result");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Programming Missions | CodeQuest</title>

    

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background:
                radial-gradient(ellipse at top, #281337 0%, #100817 65%);
            color: #f8f2ff;
            font-family: Arial, sans-serif;
            min-height: 100vh;
        }

        .missions-container {
            width: 90%;
            max-width: 1250px;
            margin: auto;
            padding: 30px 0 70px;
        }

        /* Navigation */

        .missions-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 5px 22px;
            border-bottom: 1px solid #493052;
        }

        .logo {
            font-size: 23px;
            font-weight: bold;
            color: white;
            text-decoration: none;
        }

        .logo span {
            color: #bd7aff;
        }

        .missions-nav a.dashboard-link {
            color: #d49aff;
            text-decoration: none;
            font-weight: bold;
        }

        .missions-nav a.dashboard-link:hover {
            color: #ffbd45;
        }

        /* Heading */

        .missions-heading {
            text-align: center;
            margin: 55px 0 40px;
        }

        .eyebrow {
            color: #ffbd45;
            letter-spacing: 4px;
            font-size: 13px;
            font-weight: bold;
        }

        .missions-heading h1 {
            font-size: clamp(30px, 5vw, 48px);
            margin: 15px 0 10px;
            color: #d49aff;
        }

        .missions-heading p {
            color: #c8b9d4;
            font-size: 16px;
        }

        /* Result messages */

        .result-message {
            max-width: 850px;
            margin: 0 auto 25px;
            padding: 16px 20px;
            border-radius: 12px;
            text-align: center;
            font-weight: bold;
        }

        .success-message {
            background: #123c2b;
            border: 1px solid #37c987;
            color: #8df5bd;
        }

        .error-message {
            background: #451d32;
            border: 1px solid #d75b8d;
            color: #ffb2d0;
        }

        /* Mission cards */

        .mission-grid {
    display: grid;
    grid-template-columns: minmax(0, 850px);
    justify-content: center;
    gap: 25px;
    width: 100%;
}

        .mission-card {
            background: linear-gradient(145deg, #291936, #191020);
            border: 1px solid #694080;
            border-radius: 20px;
            padding: 27px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.25);
            transition: 0.3s ease;
        }

        .mission-card:hover {
            transform: translateY(-5px);
            border-color: #bd7aff;
            box-shadow: 0 10px 35px rgba(151, 72, 210, 0.2);
        }

        .card-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 22px;
        }

        .mission-number {
            color: #ffbd45;
            font-size: 13px;
            font-weight: bold;
            letter-spacing: 2px;
        }

        .difficulty {
            padding: 7px 14px;
            border: 1px solid #bd7aff;
            border-radius: 30px;
            color: #d49aff;
            font-size: 12px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .mission-card h2 {
            color: #d49aff;
            font-size: 25px;
            margin: 0 0 12px;
        }

        .mission-description {
            color: #e2d6ed;
            line-height: 1.7;
            font-size: 16px;
            min-height: 50px;
        }

        .mission-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 20px 0;
        }

        .meta-item {
            background: #352342;
            padding: 8px 12px;
            border-radius: 8px;
            color: #d7c2e8;
            font-size: 13px;
        }

        /* Question area */

        .question-area {
            border-top: 1px solid #493052;
            padding-top: 20px;
            margin-top: 20px;
        }

        .question-label {
            color: #ffbd45;
            font-size: 13px;
            font-weight: bold;
            letter-spacing: 1.5px;
            margin-bottom: 15px;
        }

        .answer-option {
            display: flex;
            align-items: center;
            gap: 12px;
            background: #21152d;
            border: 1px solid #493052;
            border-radius: 10px;
            padding: 13px 15px;
            margin-bottom: 11px;
            cursor: pointer;
            color: #f4eafa;
            transition: 0.2s ease;
        }

        .answer-option:hover {
            border-color: #bd7aff;
            background: #352044;
        }

        .answer-option input {
            accent-color: #bd7aff;
            width: 17px;
            height: 17px;
            cursor: pointer;
        }

        .answer-option:has(input:checked) {
            border-color: #bd7aff;
            background: #402553;
        }

        /* Card footer */

        .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-top: 23px;
            padding-top: 18px;
            border-top: 1px solid #493052;
        }

        .xp-reward {
            color: #ffbd45;
            font-weight: bold;
            font-size: 18px;
            white-space: nowrap;
        }

        .submit-btn {
            padding: 13px 20px;
            background: linear-gradient(100deg, #8135bd, #a64de0);
            border: 1px solid #d49aff;
            border-radius: 10px;
            color: white;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .submit-btn:hover {
            background: linear-gradient(100deg, #a64de0, #c477ff);
            box-shadow: 0 0 20px rgba(189, 122, 255, 0.4);
            transform: translateY(-2px);
        }

        .empty-message {
            background: #21152d;
            border: 1px solid #493052;
            padding: 30px;
            border-radius: 15px;
            color: #c8b9d4;
            text-align: center;
        }

        .login-note {
            color: #c8b9d4;
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
        }

        .login-note a {
            color: #d49aff;
            text-decoration: none;
            font-weight: bold;
        }

        @media (max-width: 750px) {
            .mission-grid {
                grid-template-columns: 1fr;
            }

            .missions-container {
                width: 92%;
            }

            .missions-heading {
                margin: 40px 0 30px;
            }
        }

        @media (max-width: 450px) {
            .mission-card {
                padding: 19px;
            }

            .card-footer {
                align-items: flex-start;
                flex-direction: column;
            }

            .submit-btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="missions-container">

    <nav class="missions-nav">

        <a href="<%= request.getContextPath() %>/index.jsp"
           class="logo">
            CODE<span>QUEST</span>
        </a>

        <span>
            <%= userEmail == null ? "Guest Player" : "Student: " + userEmail %>
        </span>

        <% if (userEmail != null) { %>
           <a class="dashboard-link"
   href="<%= request.getContextPath() %>/studentDashboard.jsp">
   ← Back to Dashboard
</a>
        <% } else { %>
            <a class="dashboard-link"
               href="<%= request.getContextPath() %>/login.jsp">
                Login →
            </a>
        <% } %>

    </nav>

    <section class="missions-heading">

        <div class="eyebrow">⚔ YOUR NEXT CHALLENGE AWAITS ⚔</div>

        <h1>Choose Your Mission</h1>

        <p>Test your programming skills, earn XP and level up!</p>

    </section>

   <% if (result != null && userEmail != null) { %>

<div class="result-actions">

    <a href="<%= request.getContextPath() %>/studentDashboard.jsp">
        FINISH & BACK TO DASHBOARD
    </a>

    <a href="<%= request.getContextPath() %>/missions">
        VIEW MISSIONS
    </a>

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

                    <p class="mission-description">
                        <%= mission[2] %>
                    </p>

                    <div class="mission-meta">

                        <span class="meta-item">
                            📚 <%= mission[3] %>
                        </span>

                        <span class="meta-item">
                            ⚡ <%= mission[4] %>
                        </span>

                    </div>

                    <div class="question-area">

                        <div class="question-label">
                            SELECT YOUR ANSWER
                        </div>

                        <form action="<%= request.getContextPath() %>/submitAnswer"
                              method="post">

                            <input type="hidden"
                                   name="missionId"
                                   value="<%= mission[0] %>">

                            <label class="answer-option">
                                <input type="radio"
                                       name="answer"
                                       value="A"
                                       required>
                                <span>A. <%= mission[5] %></span>
                            </label>

                            <label class="answer-option">
                                <input type="radio"
                                       name="answer"
                                       value="B">
                                <span>B. <%= mission[6] %></span>
                            </label>

                            <label class="answer-option">
                                <input type="radio"
                                       name="answer"
                                       value="C">
                                <span>C. <%= mission[7] %></span>
                            </label>

                            <label class="answer-option">
                                <input type="radio"
                                       name="answer"
                                       value="D">
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
            Want to earn XP? <a href="<%= request.getContextPath() %>/login.jsp">
                Login to submit your answers.
            </a>
        </p>

    <% } %>

</div>

</body>
</html>
