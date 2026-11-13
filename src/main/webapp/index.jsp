<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String context = request.getContextPath();

    response.setHeader("Cache-Control",
        "no-cache, no-store, must-revalidate, private");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>CodeQuest | Choose Your Path</title>

    <link href="https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@700;900&family=Playfair+Display:wght@700;800;900&family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            font-family: 'Poppins', sans-serif;
            color: #fff5e8;

            background-image:
                linear-gradient(
                    rgba(12, 2, 27, 0.12),
                    rgba(12, 2, 27, 0.20)
                ),
                url("<%= context %>/images/home.png");

            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;

            overflow-x: hidden;
        }

        /* Animated purple cloud-like glow */
        .cloud-glow {
            position: fixed;
            width: 420px;
            height: 180px;
            border-radius: 50%;
            background: rgba(147, 45, 255, 0.23);
            filter: blur(75px);
            pointer-events: none;
            z-index: 0;
            animation: cloudMove 16s ease-in-out infinite alternate;
        }

        .cloud-left {
            left: -170px;
            top: 25%;
        }

        .cloud-right {
            right: -170px;
            top: 55%;
            animation-delay: 5s;
        }

        @keyframes cloudMove {
            from {
                transform: translate(0, 0);
            }
            to {
                transform: translate(100px, 35px);
            }
        }

        /* Main page */
        .page {
            position: relative;
            z-index: 1;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header */
        .navbar {
            min-height: 115px;
            padding: 20px 7%;
            display: flex;
            justify-content: space-between;
            align-items: center;

            border-bottom: 2px solid rgba(255, 190, 50, 0.85);

            box-shadow:
                0 3px 18px rgba(255, 180, 30, 0.30),
                0 0 30px rgba(255, 180, 30, 0.12);

            background: rgba(15, 3, 29, 0.30);
        }

        /* Golden CODEQUEST logo */
        .logo {
            position: relative;
            display: inline-block;

            font-family: 'Cinzel Decorative', Georgia, serif;
            font-size: clamp(25px, 3vw, 39px);
            font-weight: 900;
            letter-spacing: 2px;

            color: #FFD76A;
            text-decoration: none;

            background: linear-gradient(
                110deg,
                #FFF5BD,
                #FFD166,
                #FF9F1C,
                #FFF0A0,
                #D98B16
            );

            background-size: 250% auto;
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;

            filter: drop-shadow(0 0 8px rgba(255, 185, 40, 0.9));

            animation: goldShine 4s linear infinite;
        }

        .logo::before {
            content: "♛";
            position: absolute;
            top: -27px;
            left: 48%;
            font-size: 23px;
            color: #FFD166;
            -webkit-text-fill-color: #FFD166;
            filter: drop-shadow(0 0 8px #FFB000);
        }

        .logo::after {
            content: "✦";
            position: absolute;
            top: 0;
            right: -27px;
            color: #FFF0A0;
            -webkit-text-fill-color: #FFF0A0;
            font-size: 18px;
            animation: sparkle 1.5s ease-in-out infinite alternate;
        }

        @keyframes goldShine {
            to {
                background-position: 250% center;
            }
        }

        @keyframes sparkle {
            from {
                opacity: 0.35;
                transform: scale(0.7) rotate(0deg);
            }
            to {
                opacity: 1;
                transform: scale(1.3) rotate(35deg);
            }
        }

        .logo span {
            color: inherit;
        }

        .nav-note {
            color: #FFE8B0;
            font-size: 15px;
            font-style: italic;
            text-shadow: 0 0 12px rgba(255, 190, 50, 0.65);
        }

        /* Main content */
        .main {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;

            padding: 55px 20px 45px;
            text-align: center;
        }

        .eyebrow {
            color: #FFD166;
            letter-spacing: 5px;
            font-size: 13px;
            font-weight: 800;
            margin-bottom: 20px;

            text-shadow:
                0 0 8px #FFB000,
                0 0 20px rgba(255, 170, 20, 0.75);
        }

        /* Main heading */
        h1 {
            font-family: 'Playfair Display', Georgia, serif;
            font-size: clamp(42px, 6vw, 76px);
            font-weight: 900;
            margin-bottom: 14px;
            color: #FFF8F2;

            text-shadow:
                0 0 10px rgba(255, 255, 255, 0.35),
                0 0 25px rgba(180, 110, 255, 0.30);
        }

      h1 span {
    color: #FFF8F2;
    text-shadow:
        0 0 10px rgba(255, 255, 255, 0.35),
        0 0 25px rgba(180, 110, 255, 0.30);

    display: inline-block;
    animation: none;
}
        @keyframes pathGlow {
            from {
                filter: brightness(0.9);
            }
            to {
                filter: brightness(1.4);
            }
        }

        .subtitle {
            color: #F4E8FF;
            font-size: 17px;
            line-height: 1.8;
            margin-bottom: 48px;
            text-shadow: 0 2px 8px #18052D;
        }

        /* Login cards layout */
        .login-options {
            width: 100%;
            max-width: 1000px;

            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 32px;
        }

        /* Common card design */
        .login-card {
            position: relative;
            overflow: hidden;

            background: linear-gradient(
                145deg,
                rgba(38, 10, 55, 0.96),
                rgba(15, 5, 30, 0.97)
            );

            border: 2px solid #FFD166;
            border-radius: 25px;

            padding: 36px 30px;
            text-align: center;

            box-shadow:
                0 0 12px rgba(255, 190, 50, 0.65),
                0 0 28px rgba(255, 155, 20, 0.22),
                inset 0 0 25px rgba(255, 190, 50, 0.07);

            transition: transform 0.35s ease,
                        box-shadow 0.35s ease,
                        border-color 0.35s ease;
        }

        .login-card::before {
            content: "";
            position: absolute;
            inset: 0;
            background: radial-gradient(
                circle at 50% 0%,
                rgba(255, 190, 50, 0.13),
                transparent 65%
            );
            pointer-events: none;
        }

        .login-card:hover {
            transform: translateY(-9px) scale(1.015);

            border-color: #FFF2A8;

            box-shadow:
                0 0 20px #FFD166,
                0 0 42px rgba(255, 175, 25, 0.55),
                inset 0 0 25px rgba(255, 190, 50, 0.13);
        }

        /* Student card */
        .student-card {
            border-color: #FFD166;
        }

        .student-card .login-icon {
            filter: drop-shadow(0 0 12px #FFD166);
        }

        /* Admin card */
        .admin-card {
            border-color: #FFD166;
        }

        .admin-card .login-icon {
            filter: drop-shadow(0 0 15px #FFB000);
        }

        .login-icon {
            font-size: 55px;
            margin-bottom: 18px;
            position: relative;
        }

        .login-card h2 {
            position: relative;
            font-family: 'Playfair Display', Georgia, serif;
            font-size: clamp(23px, 2.5vw, 31px);
            font-weight: 800;

            color: #FFE6A3;
            margin-bottom: 14px;

            text-shadow:
                0 0 8px rgba(255, 195, 70, 0.75),
                0 0 18px rgba(255, 160, 20, 0.35);
        }

        .login-card p {
            position: relative;
            color: #F5EAFB;
            line-height: 1.75;
            min-height: 58px;
            margin-bottom: 27px;
            font-size: 15px;
        }

        /* Student button */
        .login-btn {
            position: relative;
            display: inline-block;

            padding: 15px 30px;
            min-width: 245px;

            border-radius: 35px;
            text-decoration: none;
            font-size: 16px;
            font-weight: 800;

            color: white;

            background: linear-gradient(
                110deg,
                #BD35FF,
                #8515D5,
                #5C16A5
            );

            border: 2px solid #F0B0FF;

            box-shadow:
                0 0 12px rgba(190, 65, 255, 0.8),
                0 0 25px rgba(160, 45, 255, 0.35);

            transition: all 0.3s ease;
        }

        .student-card .login-btn:hover {
            transform: scale(1.06);

            box-shadow:
                0 0 18px #D45AFF,
                0 0 35px rgba(190, 65, 255, 0.75);
        }

        /* Admin button */
        .admin-card .login-btn {
            background: linear-gradient(
                110deg,
                #FFF0A0,
                #FFD166,
                #E68A00
            );

            color: #351600;
            border: 2px solid #FFF5B5;

            box-shadow:
                0 0 15px rgba(255, 190, 30, 0.85),
                0 0 28px rgba(255, 160, 0, 0.4);
        }

        .admin-card .login-btn:hover {
            transform: scale(1.06);

            background: linear-gradient(
                110deg,
                #FFF8C5,
                #FFD166,
                #FFB000
            );

            box-shadow:
                0 0 20px #FFD166,
                0 0 38px rgba(255, 180, 20, 0.75);
        }

        /* Registration */
        .register-note {
            margin-top: 35px;
            color: #FFF0D0;
            font-size: 16px;
            text-shadow: 0 2px 8px #170529;
        }

        .register-note a {
            color: #FFD166;
            text-decoration: underline;
            font-weight: 800;
            margin-left: 8px;

            text-shadow:
                0 0 8px #FFB000,
                0 0 18px rgba(255, 180, 20, 0.65);

            transition: 0.3s ease;
        }

        .register-note a:hover {
            color: #FFF3B0;
            text-shadow: 0 0 22px #FFD166;
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 18px;
            color: #FFE1A0;
            font-size: 13px;

            border-top: 1px solid rgba(255, 190, 50, 0.45);
            background: rgba(15, 3, 29, 0.35);
        }

        /* Responsive layout */
        @media (max-width: 700px) {
            .navbar {
                min-height: 90px;
                padding: 20px;
            }

            .nav-note {
                display: none;
            }

            .logo {
                font-size: 27px;
            }

            .main {
                padding: 45px 18px;
            }

            .eyebrow {
                letter-spacing: 2px;
                font-size: 11px;
            }

            .subtitle {
                font-size: 14px;
                margin-bottom: 30px;
            }

            .login-options {
                grid-template-columns: 1fr;
                max-width: 430px;
                gap: 22px;
            }

            .login-card {
                padding: 30px 20px;
            }

            .login-card p {
                min-height: auto;
            }

            .login-btn {
                min-width: 210px;
                font-size: 14px;
            }
        }

        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                transition-duration: 0.01ms !important;
            }
        }
        
/* Header tagline and creator name */
.header-right {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
}

.creator-name {
    color: #E8B7FF;
    font-family: 'Cinzel Decorative', Georgia, serif;
    font-size: 16px;
    font-weight: 700;
    letter-spacing: 1.5px;
    padding: 7px 24px;
    border: 1px solid #C65AFF;
    border-radius: 30px;
    background: rgba(75, 15, 110, 0.45);
    box-shadow:
        0 0 10px #A900FF,
        0 0 22px rgba(180, 50, 255, 0.6);
    text-shadow: 0 0 10px #D78AFF;
    animation: creatorGlow 2s ease-in-out infinite alternate;
}

@keyframes creatorGlow {
    from {
        box-shadow: 0 0 8px #A900FF;
    }
    to {
        box-shadow: 0 0 18px #D45AFF, 0 0 30px #8A20FF;
    }
}

/* Path in purple */
h1 span {
    color: #C66AFF !important;
    text-shadow:
        0 0 8px #C66AFF,
        0 0 20px #A020F0,
        0 0 35px rgba(170, 50, 255, 0.8) !important;
    animation: pathPurpleGlow 2s ease-in-out infinite alternate;
}

@keyframes pathPurpleGlow {
    from {
        filter: brightness(0.9);
    }
    to {
        filter: brightness(1.4);
    }
}

/* Student card: purple glow */
.student-card {
    border: 2px solid #C45AFF !important;
    box-shadow:
        0 0 14px rgba(190, 65, 255, 0.8),
        0 0 30px rgba(160, 40, 255, 0.35),
        inset 0 0 22px rgba(170, 50, 255, 0.12) !important;
}

.student-card:hover {
    border-color: #E5A0FF !important;
    box-shadow:
        0 0 22px #C45AFF,
        0 0 42px rgba(180, 50, 255, 0.65) !important;
}

/* Admin card remains golden */
.admin-card {
    border: 2px solid #FFD166 !important;
}

/* NAME: GOLD WITH A SOFT GLOW */
.creator-name {
    color: #FFD166 !important;
    border: 1px solid #DDAA42 !important;
    background: rgba(45, 25, 10, 0.45) !important;
    text-shadow: 0 0 5px rgba(255, 209, 102, 0.45) !important;
    box-shadow: 0 0 6px rgba(255, 190, 60, 0.2) !important;
    animation: none !important;
    font-family: 'Cinzel Decorative', Georgia, serif;
    letter-spacing: 1.5px;
}

/* PATH: PURPLE, NO GLOW */
h1 span {
    color: #C66AFF !important;
    text-shadow: none !important;
    animation: none !important;
    filter: none !important;
}

/* STUDENT LOGIN HEADING: PURPLE, NO GLOW */
.student-card h2 {
    color: #C66AFF !important;
    text-shadow: none !important;
}

/* STUDENT CARD: PURPLE BORDER, NO GLOW */
.student-card {
    border: 2px solid #A83BE8 !important;
    box-shadow: none !important;
}

/* ADMIN CARD: GOLD BORDER, NO GLOW */
.admin-card {
    border: 2px solid #FFD166 !important;
    box-shadow: none !important;
}

/* REMOVE CARD HOVER GLOW */
.login-card:hover {
    transform: translateY(-4px);
    box-shadow: none !important;
}

/* REMOVE BUTTON GLOW */
.login-btn,
.student-card .login-btn,
.admin-card .login-btn {
    box-shadow: none !important;
}

/* NO GLOW ON LOGIN ICONS */
.login-icon {
    filter: none !important;
}

/* NO GLOW ON ADMIN HEADING */
.admin-card h2 {
    text-shadow: none !important;
}

/* NO EXTRA GLOW ON REGISTRATION */
.register-note a {
    text-shadow: none !important;
}
.eyebrow {
    color: #FFD166 !important;
    text-shadow: none !important;
    filter: none !important;
    animation: none !important;
}
        
    </style>
</head>

<body>

    <div class="cloud-glow cloud-left"></div>
    <div class="cloud-glow cloud-right"></div>

    <div class="page">

        <nav class="navbar">

            <a class="logo" href="<%= context %>/index.jsp">
                CODEQUEST
            </a>

           <div class="header-right">
    <span class="nav-note">
        Your journey. Your challenge. Your victory.
    </span>

    <div class="creator-name">
        ✦ Created by Buraga Akshaya ✦
    </div>
</div>

        </nav>

        <main class="main">

            <div class="eyebrow">
                ✦ ENTER THE WORLD OF CODEQUEST ✦
            </div>

            <h1>
                Choose Your <span>Path</span>
            </h1>

            <p class="subtitle">
                Learn programming, complete challenges and earn experience points.
                <br>
                Choose how you want to enter your quest.
            </p>

            <div class="login-options">

                <!-- Student Login -->
                <div class="login-card student-card">

                    <div class="login-icon">🎓</div>

                    <h2>Student Login</h2>

                    <p>
                        Enter your learning space, solve programming missions,
                        earn XP and climb the leaderboard.
                    </p>

                    <a class="login-btn"
                       href="<%= context %>/login.jsp">
                        ENTER AS STUDENT →
                    </a>

                </div>

                <!-- Admin Login -->
                <div class="login-card admin-card">

                    <div class="login-icon">👑</div>

                    <h2>Admin Login</h2>

                    <p>
                        Manage programming missions, add challenges
                        and monitor student performance.
                    </p>

                    <a class="login-btn"
                       href="<%= context %>/adminLogin.jsp">
                        ENTER AS ADMIN →
                    </a>

                </div>

            </div>

            <p class="register-note">
                New student?
                <a href="<%= context %>/register.jsp">
                    Create an account
                </a>
            </p>

        </main>

        <footer class="footer">
            CODEQUEST · Learn by playing. Level up by learning.
        </footer>

    </div>
<script>
window.addEventListener("pageshow", function(event) {
    if (event.persisted) {
        window.location.reload();
    }
});
</script>
</body>
</html>
