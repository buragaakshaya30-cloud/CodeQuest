
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Algorithm Master | CodeQuest</title>

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
    min-height:260px;
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
    <h1>⚔ ALGORITHM MASTER</h1>
    <p>Think • Analyze • Optimize Algorithms</p>
</section>

<div class="page">

<aside class="sidebar">
    <h2>🎯 Level Tasks</h2>

    <button class="task-link active" onclick="showTask(0,this)">
        ▶ Task 1<br>Binary Search
    </button>

    <button class="task-link" onclick="showTask(1,this)">
        🔒 Task 2<br>Merge Sort
    </button>

    <button class="task-link" onclick="showTask(2,this)">
        🔒 Task 3<br>Shortest Path
    </button>

    <button class="task-link" onclick="showTask(3,this)">
        🔒 Task 4<br>Generate Permutations
    </button>

    <div class="reward">
        🏆 LEVEL REWARD<br>
        <strong>+250 XP</strong><br>
        🥇 Gold Medal
    </div>
</aside>

<main class="task-panel">

    <div class="task-header">
        <h1>⚔ Algorithm Master – <span id="taskNumber">Task 1</span></h1>
        <span class="xp" id="taskXP">50 XP</span>
    </div>

    <div class="content">

        <div class="info-box">
            <h3>📘 Problem</h3>
            <p id="problem">
                Implement Binary Search to find the position of a target
                element in a sorted array.
            </p>
        </div>

        <div class="info-grid">

            <div class="info-box">
                <h3>⌨ Example</h3>
                <div class="example" id="example">Input:
n = 5
Array = [2, 4, 6, 8, 10]
Target = 8

Output:
3</div>
            </div>

            <div class="info-box">
                <h3>⚙ Constraints</h3>
                <p id="constraints">• 1 ≤ n ≤ 10⁵<br>
                • Array is sorted<br>
                • Elements are integers</p>
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
        int[] arr = new int[n];

        for(int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }

        int target = sc.nextInt();

        // Implement Binary Search here
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
    name:"Binary Search",
    xp:50,
    problem:"Given a sorted array and a target element, implement Binary Search to find the index of the target. Return -1 if the element is not found.",
    example:"Input:\nn = 5\nArray = [2, 4, 6, 8, 10]\nTarget = 8\n\nOutput:\n3",
    constraints:"1 ≤ n ≤ 10⁵\nArray must be sorted in ascending order.\nElements are integers.",
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

        // Implement Binary Search here
    }
}`
},

{
    name:"Merge Sort",
    xp:60,
    problem:"Given an array of integers, sort the elements in ascending order using the Merge Sort algorithm.",
    example:"Input:\nn = 6\nArray = [38, 27, 43, 3, 9, 82]\n\nOutput:\n[3, 9, 27, 38, 43, 82]",
    constraints:"1 ≤ n ≤ 10⁵\nArray elements are integers.\nUse the Merge Sort algorithm.",
    code:`import java.util.*;

public class Main {

    static void mergeSort(int[] arr, int left, int right) {
        // Implement Merge Sort here
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int n = sc.nextInt();
        int[] arr = new int[n];

        for(int i = 0; i < n; i++) {
            arr[i] = sc.nextInt();
        }

        mergeSort(arr, 0, n - 1);

        System.out.println(Arrays.toString(arr));
    }
}`
},

{
    name:"Shortest Path - Dijkstra",
    xp:65,
    problem:"Given a weighted graph and a source vertex, find the shortest distance from the source to every other vertex using Dijkstra's Algorithm.",
    example:"Input:\nVertices = 5\nEdges = 6\n0 1 4\n0 2 1\n2 1 2\n1 3 1\n2 3 5\n3 4 3\nSource = 0\n\nOutput:\n[0, 3, 1, 4, 7]",
    constraints:"1 ≤ V ≤ 1000\nEdge weights must be non-negative.\nGraph is undirected.",
    code:`import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        int v = sc.nextInt();
        int e = sc.nextInt();

        // Create graph and add weighted edges

        int source = sc.nextInt();

        // Implement Dijkstra's Algorithm here
    }
}`
},

{
    name:"Generate Permutations",
    xp:75,
    problem:"Given a string of distinct characters, generate and display all possible permutations using recursion.",
    example:"Input:\nABC\n\nOutput:\nABC\nACB\nBAC\nBCA\nCAB\nCBA",
    constraints:"1 ≤ string length ≤ 8\nAll characters are distinct.\nUse recursion and backtracking.",
    code:`import java.util.*;

public class Main {

    static void permute(String str, int index) {
        // Implement recursion here
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        String str = sc.next();

        permute(str, 0);
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
