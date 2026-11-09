<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String adminUsername = (String) session.getAttribute("adminUsername");

    if (adminUsername == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Mission | CodeQuest</title>

    <link rel="stylesheet" href="css/style.css">

    <style>
        body {
            margin: 0;
            padding: 35px 7%;
            background: #100817;
            color: #f8f2ff;
            font-family: Arial, sans-serif;
        }

        .mission-form {
            max-width: 650px;
            margin: 40px auto;
            padding: 35px;
            background: #21152d;
            border: 1px solid #493052;
            border-radius: 15px;
        }

        h1 {
            color: #bd7aff;
            text-align: center;
        }

        label {
            display: block;
            margin-top: 18px;
            margin-bottom: 8px;
        }

        input, textarea, select {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            border-radius: 7px;
            border: 1px solid #493052;
            background: #100817;
            color: white;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 14px;
            background: #bd7aff;
            color: #100817;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #bd7aff;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="mission-form">

    <h1>Add Programming Mission</h1>
    <%
    if ("true".equals(request.getParameter("success"))) {
%>
    <p style="color:#7CFC98; text-align:center;">
        Mission added successfully!
    </p>
<%
    } else if (request.getParameter("error") != null) {
%>
    <p style="color:#ff7777; text-align:center;">
        Failed to add mission. Please check your details.
    </p>
<%
    }
%>

    <form action="addMission" method="post">

        <label>Mission Title</label>
        <input type="text" name="title" required>

        <label>Description</label>
        <textarea name="description" required></textarea>

        <label>Category</label>
        <input type="text" name="category" placeholder="Java, Python, C..." required>

        <label>Difficulty</label>
        <select name="difficulty" required>
            <option value="">Select Difficulty</option>
            <option value="Easy">Easy</option>
            <option value="Medium">Medium</option>
            <option value="Hard">Hard</option>
        </select>

        <label>Option A</label>
        <input type="text" name="optionA" required>

        <label>Option B</label>
        <input type="text" name="optionB" required>

        <label>Option C</label>
        <input type="text" name="optionC" required>

        <label>Option D</label>
        <input type="text" name="optionD" required>

        <label>Correct Answer</label>
        <select name="correctAnswer" required>
            <option value="">Select Correct Answer</option>
            <option value="A">Option A</option>
            <option value="B">Option B</option>
            <option value="C">Option C</option>
            <option value="D">Option D</option>
        </select>

        <label>XP Reward</label>
        <input type="number" name="xpReward" min="1" required>

        <button type="submit">Add Mission</button>

    </form>

    <a href="adminDashboard.jsp" class="back-link">
        Back to Admin Dashboard
    </a>

</div>

</body>
</html>