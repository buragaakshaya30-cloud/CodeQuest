
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String adminUsername =
        (String) session.getAttribute("adminUsername");

    if (adminUsername == null) {
        response.sendRedirect(
            request.getContextPath() + "/adminLogin.jsp");
        return;
    }

    String ctx = request.getContextPath();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Add Mission | CodeQuest</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&family=Playfair+Display:wght@600;700;800&display=swap"
rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    min-height: 100vh;
    font-family: 'Poppins', sans-serif;
    background:
        radial-gradient(circle at 15% 10%, rgba(112,52,139,.25), transparent 35%),
        radial-gradient(circle at 90% 90%, rgba(191,143,65,.12), transparent 35%),
        #170d20;
    color: #f9f2e9;
}

/* NAVBAR */

.navbar {
    height: 76px;
    padding: 0 7%;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: #21142b;
    border-bottom: 1px solid rgba(218,177,95,.55);
}

.logo {
    font-family: 'Playfair Display', serif;
    font-size: 27px;
    font-weight: 800;
    color: #fff7eb;
}

.logo span {
    color: #e4b958;
}

.nav-link {
    color: #f0d18a;
    text-decoration: none;
    font-size: 13px;
    font-weight: 600;
    padding: 10px 19px;
    border: 1px solid #b99149;
    border-radius: 25px;
    transition: .3s;
}

.nav-link:hover {
    background: #dfb653;
    color: #291632;
}

/* MAIN */

.page-container {
    width: 92%;
    max-width: 850px;
    margin: 42px auto;
}

.page-heading {
    text-align: center;
    margin-bottom: 27px;
}

.page-heading h1 {
    font-family: 'Playfair Display', serif;
    font-size: clamp(30px, 4vw, 40px);
    color: #f1d28d;
}

.page-heading p {
    margin-top: 9px;
    color: #cdbed3;
    font-size: 13px;
}

/* FORM PANEL */

.mission-form {
    background: linear-gradient(145deg, #fffaf1, #f4e7d5);
    color: #392342;
    border: 1px solid #d7ae61;
    border-radius: 20px;
    padding: 35px 42px;
    box-shadow: 0 18px 45px rgba(0,0,0,.3);
}

.form-top {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 12px;
    margin-bottom: 25px;
    padding-bottom: 18px;
    border-bottom: 1px solid #e5d2b5;
}

.form-top h2 {
    font-family: 'Playfair Display', serif;
    font-size: 23px;
    color: #48204f;
}

.form-tag {
    font-size: 10px;
    font-weight: 700;
    color: #785d31;
    background: #f7e9c9;
    border: 1px solid #dfc17e;
    padding: 7px 11px;
    border-radius: 20px;
    white-space: nowrap;
}

/* FORM FIELDS */

.form-group {
    margin-bottom: 19px;
}

label {
    display: block;
    margin-bottom: 8px;
    color: #492d50;
    font-size: 13px;
    font-weight: 600;
}

input,
textarea,
select {
    width: 100%;
    padding: 13px 15px;
    font-family: 'Poppins', sans-serif;
    font-size: 13px;
    color: #392342;
    background: #fffdf9;
    border: 1px solid #d9c9b5;
    border-radius: 9px;
    outline: none;
    transition: .25s;
}

input::placeholder,
textarea::placeholder {
    color: #a99aa8;
}

input:focus,
textarea:focus,
select:focus {
    border-color: #9864a6;
    box-shadow: 0 0 0 3px rgba(130,77,148,.12);
}

textarea {
    min-height: 145px;
    resize: vertical;
    line-height: 1.7;
}

select {
    cursor: pointer;
}

select option {
    background: #fffdf9;
    color: #392342;
}

/* TWO COLUMN OPTIONS */

.options-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0 20px;
}

.section-label {
    color: #6e4a73;
    font-size: 12px;
    font-weight: 700;
    letter-spacing: .8px;
    text-transform: uppercase;
    margin: 27px 0 17px;
    padding-bottom: 10px;
    border-bottom: 1px solid #e5d2b5;
}

/* MESSAGES */

.message {
    padding: 12px 15px;
    margin-bottom: 20px;
    border-radius: 8px;
    font-size: 13px;
    text-align: center;
    font-weight: 600;
}

.success {
    color: #23613d;
    background: #e1f3e6;
    border: 1px solid #a8d4b3;
}

.error {
    color: #963e3e;
    background: #fbe7e4;
    border: 1px solid #e6b5ad;
}

/* BUTTONS */

.submit-btn {
    width: 100%;
    margin-top: 10px;
    padding: 14px;
    border: 1px solid #d8ae55;
    border-radius: 9px;
    background: linear-gradient(100deg, #492052, #702b7e);
    color: #ffe6a6;
    font-family: 'Poppins', sans-serif;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    transition: .3s;
}

.submit-btn:hover {
    background: #e2b651;
    color: #35183f;
    transform: translateY(-2px);
    box-shadow: 0 7px 17px rgba(80,39,86,.2);
}

.back-link {
    display: block;
    margin-top: 22px;
    text-align: center;
    color: #70447a;
    font-size: 13px;
    font-weight: 600;
    text-decoration: none;
}

.back-link:hover {
    color: #a36aaf;
}

footer {
    padding: 12px 10px 25px;
    text-align: center;
    color: #b9a8c2;
    font-size: 11px;
    letter-spacing: .5px;
}

/* RESPONSIVE */

@media(max-width: 600px) {
    .navbar {
        padding: 0 5%;
    }

    .logo {
        font-size: 22px;
    }

    .page-container {
        width: 94%;
        margin: 28px auto;
    }

    .mission-form {
        padding: 25px 20px;
    }

    .options-grid {
        grid-template-columns: 1fr;
        gap: 0;
    }

    .form-top h2 {
        font-size: 19px;
    }
}
</style>
</head>

<body>

<nav class="navbar">
    <div class="logo">CODE<span>QUEST</span></div>

    <a href="<%= ctx %>/adminDashboard.jsp" class="nav-link">
        ← Admin Dashboard
    </a>
</nav>

<main class="page-container">

    <header class="page-heading">
        <h1>Add Programming Mission</h1>
        <p>Create a new programming challenge for students</p>
    </header>

    <section class="mission-form">

        <div class="form-top">
            <h2>Mission Details</h2>
            <span class="form-tag">ADMIN CONTROL</span>
        </div>

        <% if ("true".equals(request.getParameter("success"))) { %>
            <div class="message success">
                Mission added successfully!
            </div>
        <% } else if (request.getParameter("error") != null) { %>
            <div class="message error">
                Failed to add mission. Please check your details.
            </div>
        <% } %>

        <form action="<%= ctx %>/addMission" method="post">

            <div class="form-group">
                <label for="title">Mission Title</label>
                <input type="text"
                       id="title"
                       name="title"
                       placeholder="Enter mission title"
                       required>
            </div>

            <div class="form-group">
                <label for="description">Programming Question</label>
                <textarea id="description"
                          name="description"
                          placeholder="Write the programming question here..."
                          required></textarea>
            </div>

            <div class="options-grid">

                <div class="form-group">
                    <label for="category">Category</label>
                    <input type="text"
                           id="category"
                           name="category"
                           placeholder="Java, Python, C..."
                           required>
                </div>

                <div class="form-group">
                    <label for="difficulty">Difficulty</label>
                    <select id="difficulty" name="difficulty" required>
                        <option value="">Select Difficulty</option>
                        <option value="Easy">Easy</option>
                        <option value="Medium">Medium</option>
                        <option value="Hard">Hard</option>
                    </select>
                </div>

            </div>

            <div class="section-label">Answer Options</div>

            <div class="options-grid">

                <div class="form-group">
                    <label for="optionA">Option A</label>
                    <input type="text"
                           id="optionA"
                           name="optionA"
                           placeholder="Enter option A"
                           required>
                </div>

                <div class="form-group">
                    <label for="optionB">Option B</label>
                    <input type="text"
                           id="optionB"
                           name="optionB"
                           placeholder="Enter option B"
                           required>
                </div>

                <div class="form-group">
                    <label for="optionC">Option C</label>
                    <input type="text"
                           id="optionC"
                           name="optionC"
                           placeholder="Enter option C"
                           required>
                </div>

                <div class="form-group">
                    <label for="optionD">Option D</label>
                    <input type="text"
                           id="optionD"
                           name="optionD"
                           placeholder="Enter option D"
                           required>
                </div>

            </div>

            <div class="section-label">Correct Answer & Reward</div>

            <div class="options-grid">

                <div class="form-group">
                    <label for="correctAnswer">Correct Answer</label>
                    <select id="correctAnswer"
                            name="correctAnswer"
                            required>
                        <option value="">Select Correct Answer</option>
                        <option value="A">Option A</option>
                        <option value="B">Option B</option>
                        <option value="C">Option C</option>
                        <option value="D">Option D</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="xpReward">XP Reward</label>
                    <input type="number"
                           id="xpReward"
                           name="xpReward"
                           min="1"
                           placeholder="Enter XP points"
                           required>
                </div>

            </div>

            <button type="submit" class="submit-btn">
                Add Mission
            </button>

        </form>

        <a href="<%= ctx %>/adminDashboard.jsp" class="back-link">
            ← Back to Admin Dashboard
        </a>

    </section>

</main>

<footer>
    Created by Buraga Akshaya · CodeQuest © 2026
</footer>

</body>
</html>
