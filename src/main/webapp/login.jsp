
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, private");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("userEmail") != null) {
        String redirect = request.getParameter("redirect");

        if ("missions".equals(redirect)) {
            response.sendRedirect(request.getContextPath() + "/missions");
        } else {
            response.sendRedirect(request.getContextPath() + "/studentHome.jsp");
        }
        return;
    }

    String error = request.getParameter("error");
    String registered = request.getParameter("registered");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Login | CodeQuest</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 25px;
            font-family: Arial, sans-serif;
            color: #f8f2ff;
            background:
                radial-gradient(ellipse at top, #38204f, transparent 60%),
                #100817;
        }

        .login-box {
            width: 100%;
            max-width: 610px;
            padding: 42px;
            border: 1px solid #76509a;
            border-radius: 20px;
            background: linear-gradient(145deg, #261632, #171020);
            box-shadow: 0 0 35px rgba(189, 122, 255, 0.10);
        }

        .logo {
            text-align: center;
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 32px;
            color: #ffffff;
        }

        .logo span {
            color: #bd7aff;
        }

        .icon {
            text-align: center;
            font-size: 42px;
            margin-bottom: 12px;
            color: #bd7aff;
        }

        h1 {
            text-align: center;
            font-family: Georgia, serif;
            margin: 0 0 10px;
            font-size: 32px;
        }

        .subtitle {
            text-align: center;
            color: #c8b9d4;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin: 18px 0 8px;
            color: #e5d9ee;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 14px;
            border: 1px solid #76509a;
            border-radius: 9px;
            background: #160e20;
            color: white;
            font-size: 15px;
            outline: none;
        }

        input:focus {
            border-color: #bd7aff;
            box-shadow: 0 0 10px rgba(189, 122, 255, 0.2);
        }

        .password-wrapper {
            position: relative;
            width: 100%;
        }

        .password-wrapper input {
            padding-right: 65px;
        }

        .toggle-password {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            border: none;
            background: transparent;
            cursor: pointer;
            color: #bd7aff;
            font-size: 13px;
            font-weight: bold;
            padding: 6px;
        }

        .toggle-password:hover {
            color: #ffc45c;
        }

        .login-btn {
            width: 100%;
            margin-top: 27px;
            padding: 15px;
            border: 1px solid #ffc45c;
            border-radius: 9px;
            background: linear-gradient(100deg, #a52be2, #6816ae);
            color: white;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }

        .login-btn:hover {
            background: #8625c5;
            box-shadow: 0 0 18px rgba(189, 122, 255, 0.3);
        }

        .message {
            text-align: center;
            margin: 15px 0;
            padding: 12px;
            border-radius: 8px;
            color: #ff9bb3;
            background: rgba(255, 70, 100, 0.12);
        }

        .success {
            color: #9be7b0;
            background: rgba(60, 190, 100, 0.12);
        }

        .auth-switch {
            text-align: center;
            margin-top: 25px;
            color: #c8b9d4;
        }

        .auth-switch a {
            color: #ffc45c;
            text-decoration: none;
            font-weight: bold;
        }

        .auth-switch a:hover {
            text-decoration: underline;
        }

        .credit {
            text-align: center;
            color: #aa9bb8;
            margin-top: 25px;
            font-size: 14px;
        }

        @media (max-width: 600px) {
            .login-box {
                padding: 30px 24px;
            }
        }
    </style>
</head>

<body>

<div class="login-box">

    <div class="logo">
        CODE<span>QUEST</span>
    </div>

    <div class="icon">♙</div>

    <h1>Student Login</h1>

    <p class="subtitle">
        Continue your programming adventure.
    </p>

    <% if ("invalid".equals(error)) { %>
        <div class="message">
            Invalid email or password.
        </div>
    <% } %>

    <% if ("success".equals(registered)) { %>
        <div class="message success">
            Registration successful! Please log in.
        </div>
    <% } %>

    <form action="<%= request.getContextPath() %>/login" method="post">

        <input type="hidden" name="redirect"
               value="<%= request.getParameter("redirect") == null
               ? "" : request.getParameter("redirect") %>">

        <label for="email">Email Address</label>

        <input
            type="email"
            id="email"
            name="email"
            placeholder="Enter your email"
            autocomplete="username"
            required>

        <label for="password">Password</label>

        <div class="password-wrapper">

            <input
                type="password"
                id="password"
                name="password"
                placeholder="Enter your password"
                autocomplete="current-password"
                required>

            <button
                type="button"
                class="toggle-password"
                onclick="togglePassword()"
                aria-label="Show password">
                Show
            </button>

        </div>

        <button type="submit" class="login-btn">
            LOGIN →
        </button>

    </form>

    <p class="auth-switch">
        Don't have an account?
        <a href="register.jsp">Register here</a>
    </p>

    <p class="credit">
        Created by Buraga Akshaya
    </p>

</div>

<script>
    function togglePassword() {
        const password = document.getElementById("password");
        const button = document.querySelector(".toggle-password");

        if (password.type === "password") {
            password.type = "text";
            button.textContent = "Hide";
            button.setAttribute("aria-label", "Hide password");
        } else {
            password.type = "password";
            button.textContent = "Show";
            button.setAttribute("aria-label", "Show password");
        }
    }

    window.addEventListener("pageshow", function(event) {
        if (event.persisted) {
            window.location.reload();
        }
    });
</script>

</body>
</html>
