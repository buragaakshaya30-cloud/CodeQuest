
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | CodeQuest</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body class="auth-page">

    <div class="auth-container">

        <a href="index.jsp" class="auth-logo">
            CODE<span>QUEST</span>
        </a>

        <div class="auth-card">

            <p class="auth-label">START YOUR JOURNEY</p>

            <h1>Create Account</h1>

            <p class="auth-description">
                Join CodeQuest and begin your programming adventure.
            </p>

            <%
                String error = (String) request.getAttribute("error");

                if (error != null) {
            %>
                <p class="auth-error"><%= error %></p>
            <%
                }
            %>

            <form action="<%= request.getContextPath() %>/register" method="post">

                <label for="username">Username</label>
                <input
                    type="text"
                    id="username"
                    name="username"
                    placeholder="Enter your username"
                    required>

                <label for="email">Email Address</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="Enter your email"
                    required>

                <label for="password">Password</label>
                <input
                    type="password"
                    id="password"
                    name="password"
                    placeholder="Create a password"
                    required>

                <button type="submit" class="auth-button">
                    CREATE ACCOUNT →
                </button>

            </form>

            <p class="auth-switch">
                Already have an account?
                <a href="login.jsp">Login here</a>
            </p>

        </div>

        <p class="auth-credit">Created by Buraga Akshaya</p>

    </div>

</body>
</html>
