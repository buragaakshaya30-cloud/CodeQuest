
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Logic Starter | CodeQuest</title>
<link rel="stylesheet" href="css/style.css">

<style>
* { box-sizing: border-box; }

body {
    margin: 0;
    font-family: Arial, sans-serif;
    color: white;
    background: #16091f;
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 17px 5%;
    background: #210d2c;
    border-bottom: 2px solid #eebc4b;
}

.logo {
    color: #ffd36b;
    font-size: 27px;
    font-weight: bold;
}

.navbar a {
    color: white;
    text-decoration: none;
    margin-left: 25px;
}

.page {
    display: grid;
    grid-template-columns: 290px 1fr;
    gap: 22px;
    padding: 35px 4%;
}

.sidebar, .task-panel {
    background: rgba(43, 17, 54, .96);
    border: 2px solid #e8b94d;
    border-radius: 20px;
}

.sidebar { padding: 20px; }

.sidebar h2 {
    text-align: center;
    color: #ffd36b;
    margin-bottom: 25px;
}

.task-link {
    display: block;
    width: 100%;
    padding: 15px;
    margin-bottom: 12px;
    border: 1px solid #b66bd1;
    border-radius: 12px;
    background: #42204f;
    color: white;
    text-align: left;
    cursor: pointer;
}

.task-link.active {
    border: 2px solid #ffd36b;
    background: #63336f;
}

.reward {
    margin-top: 25px;
    padding: 18px;
    border: 1px solid #e8b94d;
    border-radius: 12px;
    color: #ffd36b;
    line-height: 1.8;
}

.task-panel { overflow: hidden; }

.task-header {
    padding: 20px 28px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #b66bd1;
}

.task-header h1 {
    font-size: 27px;
    color: #ffd36b;
}

.xp {
    background: #ffc52e;
    color: #321900;
    padding: 12px 22px;
    border-radius: 12px;
    font-weight: bold;
}

.content { padding: 25px; }

.info-box {
    background: #482451;
    border: 1px solid #a85fbd;
    border-radius: 13px;
    padding: 18px;
    margin-bottom: 17px;
}

.info-box h3 {
    color: #ffd36b;
    margin-top: 0;
}

.info-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 18px;
}

.example {
    background: #24152d;
    padding: 14px;
    border-radius: 9px;
    white-space: pre-wrap;
}

textarea {
    width: 100%;
    min-height: 210px;
    background: #17151f;
    color: #b7f5a5;
    border: 1px solid #a85fbd;
    border-radius: 10px;
    padding: 17px;
    font-family: monospace;
    font-size: 15px;
    resize: vertical;
}

.editor-heading {
    display: flex;
    justify-content: space-between;
    color: #ffd36b;
    margin-bottom: 12px;
}

.actions {
    display: flex;
    justify-content: center;
    gap: 18px;
    margin-top: 20px;
    flex-wrap: wrap;
}

.actions button {
    padding: 14px 28px;
    border: none;
    border-radius: 12px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.run { background: #9224d0; color: white; }
.submit { background: #ffc52e; color: #281300; }
.reset { background: #45364d; color: white; }

#result {
    margin-top: 15px;
    padding: 12px;
    border-radius: 8px;
    background: #24152d;
    display: none;
}

@media(max-width: 800px) {
    .page { grid-template-columns: 1fr; }
    .info-grid { grid-template-columns: 1fr; }
    .navbar { flex-wrap: wrap; gap: 15px; }
}
</style>
</head>

<body>

<nav class="navbar">
    <div class="logo">👑 CODEQUEST</div>
    <div>
        <a href="studentHome.jsp">Home</a>
        <a href="missions">Missions</a>
        <a href="leaderboard.jsp">Leaderboard</a>
        <a href="startQuest.jsp">Medals</a>
    </div>
</nav>

<div class="page">

    <aside class="sidebar">
        <h2>◇ Logic Starter</h2>

        <button class="task-link active" onclick="showTask(0,this)">
            ✓ Task 1<br>Even or Odd
        </button>

        <button class="task-link" onclick="showTask(1,this)">
            🔒 Task 2<br>Largest of Three
        </button>

        <button class="task-link" onclick="showTask(2,this)">
            🔒 Task 3<br>Prime Number
        </button>

        <button class="task-link" onclick="showTask(3,this)">
            🔒 Task 4<br>Reverse a Number
        </button>

        <div class="reward">
            🏆 LEVEL REWARD<br>
            +100 XP<br>
            🥉 Bronze Medal
        </div>
    </aside>

    <main class="task-panel">

        <div class="task-header">
            <h1>◇ Logic Starter – <span id="taskNumber">Task 1</span></h1>
            <span class="xp" id="taskXP">20 XP</span>
        </div>

        <div class="content">

            <div class="info-box">
                <h3> Problem</h3>
                <p id="problem">
                    Write a program to check whether a given number is even or odd.
                </p>
            </div>

            <div class="info-grid">
                <div class="info-box">
                    <h3>⌨ Example</h3>
                    <div class="example" id="example">Input: 12
Output: Even

Input: 7
Output: Odd</div>
                </div>

                <div class="info-box">
                    <h3>⚙ Constraints</h3>
                    <p id="constraints">• The input is an integer.<br>• -10⁶ ≤ n ≤ 10⁶</p>
                </div>
            </div>

            <div class="info-box">
                <div class="editor-heading">
                    <h3>☑ Your Code</h3>
                    <span>Java</span>
                </div>

                <textarea id="code" placeholder="// Write your Java code here..."></textarea>
            </div>

            <div class="actions">
                <button class="run" onclick="runCode()">▶ Run Code</button>
                <button class="submit" onclick="submitTask()">✓ Submit Task</button>
                <button class="reset" onclick="resetCode()">↻ Reset</button>
            </div>

            <div id="result"></div>

        </div>
    </main>
</div>

<script>
const tasks = [
    {
        name: "Even or Odd",
        xp: 20,
        problem: "Write a Java program to check whether a number is even or odd.",
        example: "Input: 12\nOutput: Even",
        constraints: "Input must be an integer."
    },
    {
        name: "Largest of Three",
        xp: 25,
        problem: "Write a Java program to find the largest among three numbers.",
        example: "Input: 10 25 15\nOutput: 25",
        constraints: "Enter three integer values."
    },
    {
        name: "Prime Number",
        xp: 25,
        problem: "Write a Java program to check whether a number is prime.",
        example: "Input: 7\nOutput: Prime",
        constraints: "Input must be a positive integer."
    },
    {
        name: "Reverse a Number",
        xp: 30,
        problem: "Write a Java program to reverse the digits of a number.",
        example: "Input: 1234\nOutput: 4321",
        constraints: "Input must be an integer."
    }
];

let currentTask = 0;
let completed = [];

function showTask(index, button) {
    if (index > 0 && !completed.includes(index - 1)) {
        alert("Complete the previous task first!");
        return;
    }

    currentTask = index;
    const task = tasks[index];

    document.getElementById("taskNumber").textContent =
        "Task " + (index + 1);
    document.getElementById("taskXP").textContent =
        task.xp + " XP";
    document.getElementById("problem").textContent =
        task.problem;
    document.getElementById("example").textContent =
        task.example;
    document.getElementById("constraints").innerHTML =
        task.constraints.replaceAll("\n", "<br>");
    document.getElementById("code").value = "";
    document.getElementById("result").style.display = "none";

    document.querySelectorAll(".task-link").forEach(b =>
        b.classList.remove("active"));
    button.classList.add("active");
}

function runCode() {
    const result = document.getElementById("result");
    result.style.display = "block";
    result.textContent =
        "Code editor ready. Connect the Java compiler backend to run your program.";
}

function submitTask() {
    const code = document.getElementById("code").value.trim();

    if (!code) {
        alert("Please write your code first!");
        return;
    }

    document.getElementById("result").style.display = "block";
    document.getElementById("result").textContent =
        "Your code has been entered. Actual answer checking and XP saving will be connected through the Java backend.";
}

function resetCode() {
    document.getElementById("code").value = "";
    document.getElementById("result").style.display = "none";
}
</script>

</body>
</html>
