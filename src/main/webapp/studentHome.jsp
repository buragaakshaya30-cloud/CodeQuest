<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    boolean studentLoggedIn =
        session.getAttribute("userEmail") != null;

    String missionTarget = studentLoggedIn
        ? "missions" : "login.jsp";

    String questTarget = studentLoggedIn
        ? "missions" : "register.jsp";
%>
<%
response.setHeader("Cache-Control",
    "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeQuest | Play. Learn. Level Up.</title>
    <link rel="stylesheet" href="css/style.css">


    <style>
        /* Dashboard and Logout navigation buttons */
        .nav-actions {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .nav-actions .login-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;

            min-width: 130px;
            min-height: 48px;
            padding: 12px 24px;

            font-size: 17px;
            font-weight: 800;
            letter-spacing: 0.5px;

            color: #FFD166;
            background: linear-gradient(
                135deg,
                rgba(65, 25, 85, 0.95),
                rgba(25, 8, 40, 0.98)
            );

            border: 2px solid #FFD166;
            border-radius: 30px;
            text-decoration: none;

            box-shadow:
                0 0 8px rgba(255, 190, 50, 0.5),
                0 0 18px rgba(255, 170, 30, 0.2);

            transition: all 0.3s ease;
        }

        .nav-actions .login-btn:hover {
            color: #24102D;
            background: linear-gradient(
                135deg,
                #FFF0A0,
                #FFD166,
                #EFA72F
            );

            transform: translateY(-3px);
            box-shadow:
                0 0 15px #FFD166,
                0 0 30px rgba(255, 190, 50, 0.65);
        }

        /* Dashboard button */
        .nav-actions .dashboard-btn {
            min-width: 145px;
        }

        /* Logout button */
        .nav-actions .logout-btn {
            min-width: 115px;
        }

        /* Responsive navigation */
        @media (max-width: 900px) {
            .nav-actions {
                gap: 10px;
            }

            .nav-actions .login-btn {
                min-width: auto;
                min-height: 42px;
                padding: 10px 17px;
                font-size: 15px;
            }
        }

        @media (max-width: 600px) {
            .nav-actions {
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>

<!-- NAVIGATION -->
<nav class="navbar">

    <a href="index.jsp" class="brand">
        <span class="brand-crown">♛</span>
        <span class="brand-name">CODE<span>QUEST</span></span>
        <span class="brand-tagline">LEARN · CODE · PLAY · LEVEL UP</span>
    </a>

    <div class="nav-links">
        <a href="index.jsp" class="active">Home</a>
        <a href="#missions">Missions</a>
        <a href="<%= request.getContextPath() %>/leaderboard">Leaderboard</a>
        <a href="#about">About</a>
    </div>


<div class="nav-actions">

    <a href="<%= request.getContextPath() %>/studentDashboard.jsp"
       class="login-btn dashboard-btn">
        Dashboard
    </a>

    <a href="<%= request.getContextPath() %>/logout"
       class="login-btn logout-btn">
        Logout
    </a>

</div>


</nav>


<!-- HERO SECTION -->
<section class="hero">

    <!-- Actual castle image -->
    <div class="hero-art"></div>
    <div class="hero-overlay"></div>

    <div class="hero-copy">

        <p class="eyebrow">THE PROGRAMMING ADVENTURE</p>

        <h1>
            PLAY. LEARN.<br>
            <span>LEVEL UP.</span>
        </h1>

        <p class="hero-description">
            Complete coding missions, earn experience points
            and unlock achievements. Turn your learning
            journey into an epic adventure.
        </p>

        <a href="<%= request.getContextPath() %>/missions"
   class="start-btn">START YOUR QUEST </a>
            <span></span>
        </a>

    </div>

    <div class="hero-bottom-glow"></div>

</section>


<!-- MISSIONS SECTION -->
<section class="missions-section" id="missions">

    <div class="section-heading">
        <span class="heading-line"></span>
        <h2>CHOOSE YOUR MISSION</h2>
        <span class="heading-line"></span>
       <a href="<%= missionTarget %>" class="view-all">VIEW ALL </a>
    </div>

    <div class="heading-diamond">◇</div>

    <div class="mission-grid">

        <!-- BEGINNER -->
        <div class="mission-card beginner">

            <div class="mission-art">
                <svg class="cube-art" viewBox="0 0 120 120"
                     xmlns="http://www.w3.org/2000/svg">
                    <g fill="none" stroke="#35E8D6"
                       stroke-width="2.5" stroke-linejoin="round">
                        <path d="M60 10 L105 35 L60 60 L15 35 Z"/>
                        <path d="M15 35 V85 L60 110 V60"/>
                        <path d="M105 35 V85 L60 110"/>
                        <path d="M60 10 V60"/>
                    </g>
                    <circle cx="60" cy="60" r="3" fill="#35E8D6"/>
                </svg>
            </div>

            <div class="mission-info">
                <span class="level beginner-level">BEGINNER</span>
                <h3>Logic Starter</h3>
                <p>Build your problem-solving foundation.</p>
            </div>

            <div class="mission-footer">
                <strong><span class="trophy">🏆</span> +100 XP</strong>
   
   <a href="<%=request.getContextPath()%>/missions?difficulty=LogicStarter" class="play-btn">
    PLAY NOW 
</a>
            </div>

        </div>


        <!-- INTERMEDIATE -->
        <div class="mission-card intermediate">

            <div class="mission-art">
                <svg class="stack-art" viewBox="0 0 120 120"
                     xmlns="http://www.w3.org/2000/svg">
                    <g fill="#7132A5" fill-opacity="0.25"
                       stroke="#C18AFF" stroke-width="2.5"
                       stroke-linejoin="round">
                        <path d="M60 8 L87 23 L60 38 L33 23 Z"/>
                        <path d="M33 23 V53 L60 68 V38"/>
                        <path d="M87 23 V53 L60 68"/>
                        <path d="M27 48 L54 63 L27 78 L0 63 Z"/>
                        <path d="M0 63 V93 L27 108 V78"/>
                        <path d="M54 63 V93 L27 108"/>
                        <path d="M93 48 L120 63 L93 78 L66 63 Z"/>
                        <path d="M66 63 V93 L93 108 V78"/>
                        <path d="M120 63 V93 L93 108"/>
                    </g>
                </svg>
            </div>

            <div class="mission-info">
                <span class="level intermediate-level">INTERMEDIATE</span>
                <h3>Array Architect</h3>
                <p>Explore data and sharpen your logic.</p>
            </div>

            <div class="mission-footer">
                <strong><span class="trophy">🏆</span> +150 XP</strong>
                <a href="<%= request.getContextPath() %>/missions?difficulty=Medium"
   class="play-btn">PLAY NOW </a>
            </div>

        </div>


        <!-- ADVANCED -->
        <div class="mission-card advanced">

            <div class="mission-art">
               
<svg class="chest-art" viewBox="0 0 140 130"
     xmlns="http://www.w3.org/2000/svg">

  <defs>
    <linearGradient id="goldBody" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#FFE69A"/>
      <stop offset=".35" stop-color="#EFA72F"/>
      <stop offset=".7" stop-color="#9B5410"/>
      <stop offset="1" stop-color="#FFD66B"/>
    </linearGradient>

    <linearGradient id="goldLid" x1="0" y1="0" x2="0" y2="1">
      <stop offset="0" stop-color="#FFF0B0"/>
      <stop offset=".45" stop-color="#E9A42C"/>
      <stop offset="1" stop-color="#8D480E"/>
    </linearGradient>

    <linearGradient id="purpleGem" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#F3C4FF"/>
      <stop offset=".5" stop-color="#A13BFF"/>
      <stop offset="1" stop-color="#481078"/>
    </linearGradient>

    <filter id="chestGlow">
      <feGaussianBlur stdDeviation="5" result="blur"/>
      <feMerge>
        <feMergeNode in="blur"/>
        <feMergeNode in="SourceGraphic"/>
      </feMerge>
    </filter>
  </defs>

  <!-- Golden treasure glow -->
  <ellipse cx="70" cy="112" rx="57" ry="10"
           fill="#FFB52E" opacity=".22" filter="url(#chestGlow)"/>

  <!-- Open lid -->
  <path d="M20 49 L27 15 Q70 -2 113 15 L120 49 Z"
        fill="url(#goldLid)" stroke="#FFD66B" stroke-width="3"/>

  <path d="M27 17 Q70 -3 113 17"
        fill="none" stroke="#FFF0BA" stroke-width="4"/>

  <path d="M29 25 L111 25"
        stroke="#9A570E" stroke-width="3"/>

  <!-- Lid metal bands -->
  <path d="M36 13 L42 47 M104 13 L98 47"
        stroke="#FFE7A0" stroke-width="5"/>

  <!-- Main chest body -->
  <path d="M18 48 L122 48 L116 111 L24 111 Z"
        fill="url(#goldBody)" stroke="#FFD36B" stroke-width="3"/>

  <!-- Front panels -->
  <path d="M29 55 L70 55 L70 105 L29 105 Z"
        fill="#A85E16" stroke="#FFD36B" stroke-width="2"/>

  <path d="M70 55 L111 55 L111 105 L70 105 Z"
        fill="#C47B20" stroke="#FFD36B" stroke-width="2"/>

  <!-- Metal reinforcement -->
  <path d="M18 48 L24 111 M122 48 L116 111"
        stroke="#FFF0A5" stroke-width="6"/>

  <path d="M18 65 H122 M22 105 H118"
        stroke="#F9D77D" stroke-width="4"/>

  <!-- Central lock -->
  <path d="M58 52 H82 V78 H58 Z"
        fill="#FFD66B" stroke="#FFF0A5" stroke-width="2"/>

  <circle cx="70" cy="64" r="6" fill="#74400D"/>
  <circle cx="70" cy="64" r="2" fill="#FFE7A0"/>

  <!-- Purple gemstones -->
  <path d="M43 72 L50 78 L43 91 L36 78 Z"
        fill="url(#purpleGem)" stroke="#E7B4FF" stroke-width="2"/>

  <path d="M97 72 L104 78 L97 91 L90 78 Z"
        fill="url(#purpleGem)" stroke="#E7B4FF" stroke-width="2"/>

  <!-- Gold highlights -->
  <path d="M31 53 L31 101 M109 53 L109 101"
        stroke="#FFF0B0" stroke-width="2" opacity=".8"/>

  <circle cx="26" cy="57" r="2" fill="#FFF0B0"/>
  <circle cx="114" cy="57" r="2" fill="#FFF0B0"/>

</svg>

            </div>

            <div class="mission-info">
                <span class="level advanced-level">ADVANCED</span>
                <h3>Algorithm Master</h3>
                <p>Tackle real-world challenges and level up.</p>
            </div>

            <div class="mission-footer">
                <strong><span class="trophy">🏆</span> +250 XP</strong>
                <a href="<%= request.getContextPath() %>/missions?difficulty=Hard"
   class="play-btn">PLAY NOW </a>
            </div>

        </div>

    </div>


    
<div class="stats-bar" id="leaderboard">

    <div class="stat-item">
        <div class="stat-icon">🎮</div>
        <div class="stat-info">
            <h3>10+</h3>
            <p>MISSIONS</p>
        </div>
    </div>

    <div class="stat-item">
        <div class="stat-icon levels-icon">
            <svg viewBox="0 0 64 64" aria-hidden="true">
                <rect x="7" y="34" width="12" height="23" rx="3"/>
                <rect x="26" y="20" width="12" height="37" rx="3"/>
                <rect x="45" y="6" width="12" height="51" rx="3"/>
            </svg>
        </div>
        <div class="stat-info">
            <h3>3</h3>
            <p>LEVELS</p>
        </div>
    </div>

    <div class="stat-item">
        <div class="stat-icon star-icon">★</div>
        <div class="stat-info">
            <h3>250+</h3>
            <p>TOTAL XP</p>
        </div>
    </div>

    <div class="stat-item">
        <div class="stat-icon learners-icon">
            <svg viewBox="0 0 64 56" aria-hidden="true">
                <circle cx="22" cy="13" r="9"/>
                <circle cx="44" cy="16" r="8"/>
                <path d="M3 52c0-13 7-20 19-20s19 7 19 20z"/>
                <path d="M37 33c12-4 24 3 24 19H41"/>
            </svg>
        </div>
        <div class="stat-info">
            <h3>100+</h3>
            <p>LEARNERS</p>
        </div>
    </div>

</div>


</section>


<!-- ABOUT -->
<section class="about-section" id="about">

    <p class="eyebrow">YOUR JOURNEY STARTS HERE</p>

    <h2>
        Learn by playing.<br>
        <span>Grow by solving.</span>
    </h2>

    <p>
        CodeQuest makes programming practice exciting.
        Complete missions, test your knowledge, earn XP
        and improve your programming skills step by step.
    </p>

</section>


<!-- FOOTER -->
<footer class="footer">

    <div class="footer-logo">CODE<span>QUEST</span></div>

    <p>LEARN · CODE · PLAY · LEVEL UP</p>

    <p class="credit">Created by Buraga Akshaya</p>

    <small>© 2026 CodeQuest. All rights reserved.</small>

</footer>

<script>
window.addEventListener("pageshow", function(event) {
    if (event.persisted) {
        window.location.reload();
    }
});
</script>


</body>
</html>
