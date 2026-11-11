<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    response.setHeader("Cache-Control",
        "no-cache, no-store, must-revalidate, private");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    if (session.getAttribute("adminUsername") != null &&
        session.getAttribute("adminId") != null) {

        response.sendRedirect(
            request.getContextPath() + "/adminDashboard.jsp"
        );
        return;
    }
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String context = request.getContextPath();

    if (session.getAttribute("adminUsername") != null) {
        response.sendRedirect(context + "/adminDashboard.jsp");
        return;
    }

    String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login | CodeQuest</title>

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
    background: radial-gradient(ellipse at top, #38204f, transparent 60%), #100817;
}

.login-box {
    width: 100%;
    max-width: 520px;
    padding: 42px;
    border: 1px solid #92703b;
    border-radius: 20px;
    background: linear-gradient(145deg, #261632, #171020);
    box-shadow: 0 0 35px rgba(255, 196, 92, 0.10);
}

.logo {
    text-align: center;
    font-size: 28px;
    font-weight: 800;
    margin-bottom: 32px;
}

.logo span {
    color: #bd7aff;
}

.icon {
    text-align: center;
    font-size: 38px;
    margin-bottom: 12px;
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
    border: 1px solid #765a34;
    border-radius: 9px;
    background: #160e20;
    color: white;
    font-size: 15px;
    outline: none;
}

input:focus {
    border-color: #ffc45c;
    box-shadow: 0 0 10px rgba(255, 196, 92, 0.2);
}

.password-wrapper {
    position: relative;
    width: 100%;
}

.password-wrapper input {
    padding-right: 75px;
}

.toggle-password {
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    border: none;
    background: transparent;
    color: #ffc45c;
    font-weight: bold;
    cursor: pointer;
    font-size: 14px;
}

.login-btn {
    width: 100%;
    margin-top: 27px;
    padding: 15px;
    border: 1px solid #ffc45c;
    border-radius: 9px;
    background: linear-gradient(100deg, #a86c19, #70450d);
    color: white;
    font-weight: bold;
    font-size: 16px;
    cursor: pointer;
}

.login-btn:hover {
    background: #c58a2e;
    box-shadow: 0 0 18px rgba(255, 196, 92, 0.35);
}

.message {
    text-align: center;
    margin: 15px 0;
    color: #ff9bb3;
}

.back-link {
    display: block;
    text-align: center;
    margin-top: 25px;
    color: #ffc45c;
    text-decoration: none;
}
</style>
</head>

<body>

<div class="login-box">

    <div class="logo">CODE<span>QUEST</span></div>

    <div class="icon">♛</div>

    <h1>Admin Login</h1>

    <p class="subtitle">
        Manage the CodeQuest learning kingdom.
    </p>

    <% if (error != null && !error.trim().isEmpty()) { %>
        <div class="message"><%= error %></div>
    <% } %>

    <form action="${pageContext.request.contextPath}/adminlogin" method="post">

        <label for="username">Admin Username</label>

        <input
            type="text"
            id="username"
            name="username"
            placeholder="admin"
            autocomplete="username"
            required>

        <label for="password">Password</label>

        <div class="password-wrapper">

            <input
                type="password"
                id="password"
                name="password"
                placeholder="admin123"
                autocomplete="current-password"
                required>

            <button
                type="button"
                class="toggle-password"
                onclick="togglePassword()">
                Show
            </button>

        </div>

        <button type="submit" class="login-btn">
            LOGIN AS ADMIN →
        </button>

    </form>

    <a class="back-link" href="<%= context %>/index.jsp">
        ← Back to Choose Login
    </a>

</div>

<script>
function togglePassword() {
    const password = document.getElementById("password");
    const button = document.querySelector(".toggle-password");

    if (password.type === "password") {
        password.type = "text";
        button.textContent = "Hide";
    } else {
        password.type = "password";
        button.textContent = "Show";
    }
}
</script>
<script>
window.addEventListener("pageshow", function(event) {
    if (event.persisted) {
        window.location.reload();
    }
});
</script>
</body>
</html>
