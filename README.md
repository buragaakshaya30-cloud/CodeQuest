# CodeQuest – Gamified Programming Learning Platform

## About the Project

CodeQuest is a web-based gamified programming learning platform designed to help students improve their programming skills through interactive coding missions, quizzes and rewards.

It provides separate Student and Admin modules to manage programming missions, track student progress and encourage learning through XP points and leaderboards.

## Author

**Buraga Akshaya**

B.Tech – Computer Science and Engineering

## Technologies Used

- Frontend: HTML, CSS, JSP
- Backend: Java, Servlets
- Database: MySQL
- Database Connectivity: JDBC
- IDE: Eclipse
- Server: Apache Tomcat 10.1
- Build Tool: Maven

## Features

### Student Module

- Student registration and login
- Student dashboard
- View programming missions
- Multiple-choice questions
- Submit answers
- Earn XP points
- Track levels and completed missions
- View leaderboard rankings

### Admin Module

- Admin login
- Admin dashboard
- Add programming missions
- Edit existing missions
- Delete missions
- Manage questions and answers
- View student performance

## Mission Categories

- Python
- Java
- Data Structures
- Algorithms
- Database
- Web Development

## Difficulty Levels

- Easy – Beginner level
- Medium – Intermediate level
- Hard – Advanced level

## Database Setup

1. Install MySQL.
2. Create a database named `codequest_db`.
3. Import the database schema and sample data.
4. Configure the following environment variables:

   - `DB_URL`
   - `DB_USERNAME`
   - `DB_PASSWORD`

5. Make sure the MySQL server is running.

## How to Run the Project

1. Clone or download this repository.
2. Import the project into Eclipse as an existing Maven project.
3. Configure MySQL database credentials using environment variables.
4. Update Maven dependencies if required.
5. Configure Apache Tomcat 10.1.
6. Run the project on the Tomcat server.
7. Open the following URL in your browser:

   `http://localhost:8080/CodeQuest/`

## Project Objective

The main objective of CodeQuest is to make programming education more interactive and engaging through gamification, mission-based learning, XP rewards and performance tracking.

## Future Enhancements

- Add more programming challenges.
- Introduce coding-based questions.
- Add detailed student analytics.
- Improve the leaderboard system.
- Add more learning categories.

## Note

This project is developed for academic purposes. Use demo credentials for demonstration. Configure your own database credentials before running the application. Do not commit personal passwords or real student data to the public repository.