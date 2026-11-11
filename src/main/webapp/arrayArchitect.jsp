
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Array Architect | CodeQuest</title>

<style>
*{box-sizing:border-box}
body{
    margin:0;
    font-family:Arial,sans-serif;
    color:white;
    background:#16091f;
}
.navbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:17px 5%;
    background:#210d2c;
    border-bottom:2px solid #eebc4b;
}
.logo{color:#ffd36b;font-size:27px;font-weight:bold}
.navbar a{color:white;text-decoration:none;margin-left:25px}
.hero{
    text-align:center;
    padding:28px 15px;
    background:linear-gradient(120deg,#351044,#54216a,#351044);
    border-bottom:2px solid #eebc4b;
}
.hero h1{color:#ffd36b;font-size:38px;margin:5px}
.hero p{margin:8px;color:#f4d9ff}
.page{
    display:grid;
    grid-template-columns:290px 1fr;
    gap:22px;
    padding:30px 4%;
}
.sidebar,.task-panel{
    background:#2b1136;
    border:2px solid #e8b94d;
    border-radius:20px;
}
.sidebar{padding:20px}
.sidebar h2{text-align:center;color:#ffd36b;margin-bottom:25px}
.task-link{
    display:block;
    width:100%;
    padding:15px;
    margin-bottom:12px;
    border:1px solid #b66bd1;
    border-radius:12px;
    background:#42204f;
    color:white;
    text-align:left;
    cursor:pointer;
    font-size:15px;
}
.task-link.active{
    border:2px solid #ffd36b;
    background:#63336f;
}
.reward{
    margin-top:25px;
    padding:18px;
    border:1px solid #e8b94d;
    border-radius:12px;
    color:#ffd36b;
    line-height:1.9;
    text-align:center;
}
.task-panel{overflow:hidden}
.task-header{
    padding:20px 28px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    border-bottom:1px solid #b66bd1;
    flex-wrap:wrap;
}
.task-header h1{font-size:25px;color:#ffd36b}
.xp{
    background:#ffc52e;
    color:#321900;
    padding:12px 22px;
    border-radius:12px;
    font-weight:bold;
}
.content{padding:25px}
.info-box{
    background:#482451;
    border:1px solid #a85fbd;
    border-radius:13px;
    padding:18px;
    margin-bottom:17px;
}
.info-box h3{color:#ffd36b;margin-top:0}
.info-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:18px;
}
.example{
    background:#24152d;
    padding:14px;
    border-radius:9px;
    white-space:pre-wrap;
    line-height:1.5;
}
textarea{
    width:100%;
    min-height:250px;
    background:#17151f;
    color:#b7f5a5;
    border:1px solid #a85fbd;
    border-radius:10px;
    padding:17px;
    font-family:monospace;
    font-size:15px;
    resize:vertical;
}
.editor-heading{
    display:flex;
    justify-content:space-between;
    color:#ffd36b;
    margin-bottom:12px;
}
.actions{
    display:flex;
    justify-content:center;
    gap:18px;
    margin-top:20px;
    flex-wrap:wrap;
}
.actions button{
    padding:14px 28px;
    border:none;
    border-radius:12px;
    font-size:16px;
    font-weight:bold;
    cursor:pointer;
}
.run{background:#9224d0;color:white}
.submit{background:#ffc52e;color:#281300}
.reset{background:#45364d;color:white}
#result{
    margin-top:15px;
    padding:15px;
    border-radius:8px;
    background:#24152d;
    display:none;
    white-space:pre-wrap;
}
@media(max-width:800px){
    .page{grid-template-columns:1fr}
    .info-grid{grid-template-columns:1fr}
    .navbar{flex-wrap:wrap;gap:15px}
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
        <a href="startQuest.jsp">Levels</a>
    </div>
</nav>

<section class="hero">
    <h1>🧊 ARRAY ARCHITECT</h1>
    <p>Build • Process • Optimize Arrays</p>
</section>

<div class="page">

<aside class="sidebar">
    <h2>🎯 Level Tasks</h2>

    <button class="task-link active" onclick="showTask(0,this)">
        ▶ Task 1<br>Rotate an Array
    </button>

    <button class="task-link" onclick="showTask(1,this)">
        🔒 Task 2<br>Two Sum
    </button>

    <button class="task-link" onclick="showTask(2,this)">
        🔒 Task 3<br>Count Frequency
    </button>

    <button class="task-link" onclick="showTask(3,this)">
        🔒 Task 4<br>Remove Duplicates
    </button>

    <div class="reward">
        🏆 LEVEL REWARD<br>
        <strong>+150 XP</strong><br>
        🥈 Silver Medal
    </div>
</aside>

<main class="task-panel">

    <div class="task-header">
        <h1>◇ Array Architect – <span id="taskNumber">Task 1</span></h1>
        <span class="xp" id="taskXP">30 XP</span>
    </div>

    <div class="content">

        <div class="info-box">
            <h3> Problem</h3>
            <p id="problem">
                Given an array of n integers and a value k, rotate the array
                to the right by k positions.
            </p>
        </div>

        <div class="info-grid">

            <div class="info-box">
                <h3>⌨ Example</h3>
                <div class="example" id="example">Input:
n = 5, k = 2
Array = [1, 2, 3, 4, 5]

Output:
[4, 5, 1, 2, 3]</div>
            </div>

            <div class="info-box">
                <h3>⚙ Constraints</h3>
                <p id="constraints">• 1 ≤ n ≤ 10⁵<br>
                • 0 ≤ k ≤ n<br>
                • -10⁶ ≤ arr[i] ≤ 10⁶</p>
            </div>

        </div>

        <div class="info-box">
            <div class="editor-heading">
                <h3>☑ Your Code</h3>
                <span>Java</span>
            </div>

            <textarea id="code" placeholder="// Write your Java code here...">import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int n = sc.nextInt();
        int k = sc.nextInt();

        int[] arr = new int[n];

        for(int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }

        // Write your array rotation logic here
    }
}</textarea>
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
    name:"Rotate an Array",
    xp:30,
    problem:"Given an array of n integers and a value k, rotate the array to the right by k positions.",
    example:"Input:\nn = 5, k = 2\nArray = [1, 2, 3, 4, 5]\n\nOutput:\n[4, 5, 1, 2, 3]",
    constraints:"1 ≤ n ≤ 10⁵\n0 ≤ k ≤ n\n-10⁶ ≤ arr[i] ≤ 10⁶",
    code:`import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int k = sc.nextInt();
        int[] arr = new int[n];

        for(int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }

        // Write your array rotation logic here
    }
}`
},
{
    name:"Two Sum",
    xp:35,
    problem:"Given an array and a target value, find two elements whose sum equals the target.",
    example:"Input:\nArray = [2, 7, 11, 15]\nTarget = 9\n\nOutput:\n[0, 1]",
    constraints:"2 ≤ n ≤ 10⁵\nEach element is an integer\nExactly one valid pair exists.",
    code:`import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];

        for(int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }

        int target = sc.nextInt();

        // Find the two indices here
    }
}`
},
{
    name:"Count Frequency",
    xp:40,
    problem:"Given an array, count how many times each element occurs.",
    example:"Input:\nArray = [1, 2, 2, 3, 1, 1]\n\nOutput:\n1 occurs 3 times\n2 occurs 2 times\n3 occurs 1 time",
    constraints:"1 ≤ n ≤ 10⁵\nArray elements are integers.",
    code:`import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];

        for(int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }

        // Count the frequency of each element
    }
}`
},
{
    name:"Remove Duplicates",
    xp:45,
    problem:"Given an array, remove duplicate elements and display only the unique elements.",
    example:"Input:\n[1, 2, 2, 3, 4, 4, 5]\n\nOutput:\n[1, 2, 3, 4, 5]",
    constraints:"1 ≤ n ≤ 10⁵\nArray elements are integers.",
    code:`import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int n = sc.nextInt();
        int[] arr = new int[n];

        for(int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }

        // Remove duplicate elements here
    }
}`
}
];

let currentTask = 0;

function showTask(index, button) {
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
        "• " + task.constraints.replace(/\n/g, "<br>• ");

    document.getElementById("code").value = task.code;

    document.getElementById("result").style.display = "none";

    document.querySelectorAll(".task-link").forEach(b =>
        b.classList.remove("active"));

    button.classList.add("active");
}

function runCode() {
    const result = document.getElementById("result");
    result.style.display = "block";
    result.textContent =
        "Java compiler is not connected yet. Your code is ready, but actual execution will be added later.";
}

function submitTask() {
    const code = document.getElementById("code").value.trim();

    if (!code) {
        alert("Please write your Java code first!");
        return;
    }

    const result = document.getElementById("result");
    result.style.display = "block";
    result.textContent =
        "Code received for " + tasks[currentTask].name +
        ". Task checking and XP saving are not connected yet.";
}

function resetCode() {
    document.getElementById("code").value = tasks[currentTask].code;
    document.getElementById("result").style.display = "none";
}

</script>

</body>
</html>
