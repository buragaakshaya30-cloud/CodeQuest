
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    if (session.getAttribute("adminUsername") == null) {
        response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
        return;
    }

    String[] mission = (String[]) request.getAttribute("mission");

    if (mission == null) {
        response.sendRedirect(request.getContextPath() + "/manageMissions");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Mission | CodeQuest</title>

    <style>
        body {
            margin: 0;
            padding: 30px;
            background: #100817;
            color: white;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 650px;
            margin: 20px auto;
            padding: 30px;
            background: #21152d;
            border: 1px solid #493052;
            border-radius: 15px;
        }

        h1 {
            text-align: center;
            color: #bd7aff;
        }

        label {
            display: block;
            margin-top: 15px;
            margin-bottom: 7px;
        }

        input, textarea, select {
            width: 100%;
            padding: 11px;
            box-sizing: border-box;
            border: 1px solid #6541a5;
            border-radius: 6px;
            background: #100817;
            color: white;
        }

        textarea {
            min-height: 85px;
            resize: vertical;
        }

        button, .back {
            display: inline-block;
            margin-top: 22px;
            padding: 12px 20px;
            border: none;
            border-radius: 7px;
            background: #bd7aff;
            color: #100817;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
        }

        .back {
            margin-left: 10px;
            background: #d6ad55;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Edit Mission</h1>

    <form action="<%= request.getContextPath() %>/updateMission"
          method="post">

        <input type="hidden" name="missionId"
               value="<%= mission[0] %>">

        <label>Mission Title</label>
        <input type="text" name="title"
               value="<%= mission[1] %>" required>

        <label>Description</label>
        <textarea name="description" required><%= mission[2] %></textarea>

        <label>Category</label>
        <input type="text" name="category"
               value="<%= mission[3] %>" required>

        <label>Difficulty</label>
        <select name="difficulty" required>
            <option value="Easy" <%= "Easy".equals(mission[4]) ? "selected" : "" %>>Easy</option>
            <option value="Medium" <%= "Medium".equals(mission[4]) ? "selected" : "" %>>Medium</option>
            <option value="Hard" <%= "Hard".equals(mission[4]) ? "selected" : "" %>>Hard</option>
        </select>

        <label>Option A</label>
        <input type="text" name="optionA"
               value="<%= mission[5] %>" required>

        <label>Option B</label>
        <input type="text" name="optionB"
               value="<%= mission[6] %>" required>

        <label>Option C</label>
        <input type="text" name="optionC"
               value="<%= mission[7] %>" required>

        <label>Option D</label>
        <input type="text" name="optionD"
               value="<%= mission[8] %>" required>

        <label>XP Reward</label>
        <input type="number" name="xpReward"
               value="<%= mission[9] %>" min="1" required>

        <label>Correct Answer</label>
        <select name="correctAnswer" required>
            <option value="A" <%= "A".equalsIgnoreCase(mission[10]) ? "selected" : "" %>>A</option>
            <option value="B" <%= "B".equalsIgnoreCase(mission[10]) ? "selected" : "" %>>B</option>
            <option value="C" <%= "C".equalsIgnoreCase(mission[10]) ? "selected" : "" %>>C</option>
            <option value="D" <%= "D".equalsIgnoreCase(mission[10]) ? "selected" : "" %>>D</option>
        </select>

        <button type="submit">Update Mission</button>

        <a class="back"
           href="<%= request.getContextPath() %>/manageMissions">
            Cancel
        </a>

    </form>

</div>

</body>
</html>
