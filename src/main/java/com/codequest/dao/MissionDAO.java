
package com.codequest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import com.codequest.util.DBConnection;

public class MissionDAO {

    // Add a new mission
    public boolean addMission(String title, String description,
            String category, String difficulty,
            String optionA, String optionB,
            String optionC, String optionD,
            String correctAnswer, int xpReward, int adminId) {

        String sql = "INSERT INTO missions "
                + "(title, description, category, difficulty, "
                + "option_a, option_b, option_c, option_d, "
                + "correct_answer, xp_reward, created_by) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, category);
            ps.setString(4, difficulty);
            ps.setString(5, optionA);
            ps.setString(6, optionB);
            ps.setString(7, optionC);
            ps.setString(8, optionD);
            ps.setString(9, correctAnswer);
            ps.setInt(10, xpReward);
            ps.setInt(11, adminId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all missions
    public List<String[]> getAllMissions() {

        List<String[]> missions = new ArrayList<>();

        String sql = "SELECT id, title, description, "
                + "category, difficulty, option_a, option_b, "
                + "option_c, option_d, xp_reward FROM missions";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                String[] mission = {
                    String.valueOf(rs.getInt("id")),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("category"),
                    rs.getString("difficulty"),
                    rs.getString("option_a"),
                    rs.getString("option_b"),
                    rs.getString("option_c"),
                    rs.getString("option_d"),
                    String.valueOf(rs.getInt("xp_reward"))
                };

                missions.add(mission);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return missions;
    }

    // Get one mission using its ID
    public String[] getMissionById(int missionId) {

        String sql = "SELECT * FROM missions WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, missionId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    String optionA = rs.getString("option_a");
                    String optionB = rs.getString("option_b");
                    String optionC = rs.getString("option_c");
                    String optionD = rs.getString("option_d");
                    String correctText = rs.getString("correct_answer");

                    // Convert answer text back to A/B/C/D for edit page
                    String correctLetter = "";

                    if (correctText.equals(optionA)) {
                        correctLetter = "A";
                    } else if (correctText.equals(optionB)) {
                        correctLetter = "B";
                    } else if (correctText.equals(optionC)) {
                        correctLetter = "C";
                    } else if (correctText.equals(optionD)) {
                        correctLetter = "D";
                    }

                    return new String[] {
                        String.valueOf(rs.getInt("id")),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("category"),
                        rs.getString("difficulty"),
                        optionA,
                        optionB,
                        optionC,
                        optionD,
                        String.valueOf(rs.getInt("xp_reward")),
                        correctLetter
                    };
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Update an existing mission
    public boolean updateMission(int missionId, String title,
            String description, String category, String difficulty,
            String optionA, String optionB, String optionC,
            String optionD, String correctAnswer, int xpReward) {

        String correctAnswerText;

        switch (correctAnswer) {
            case "A":
                correctAnswerText = optionA;
                break;
            case "B":
                correctAnswerText = optionB;
                break;
            case "C":
                correctAnswerText = optionC;
                break;
            case "D":
                correctAnswerText = optionD;
                break;
            default:
                return false;
        }

        String sql = "UPDATE missions SET title=?, description=?, "
                + "category=?, difficulty=?, option_a=?, option_b=?, "
                + "option_c=?, option_d=?, correct_answer=?, xp_reward=? "
                + "WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, category);
            ps.setString(4, difficulty);
            ps.setString(5, optionA);
            ps.setString(6, optionB);
            ps.setString(7, optionC);
            ps.setString(8, optionD);
            ps.setString(9, correctAnswerText);
            ps.setInt(10, xpReward);
            ps.setInt(11, missionId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a mission
    public boolean deleteMission(int missionId) {

        String sql = "DELETE FROM missions WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, missionId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println(
                "Mission could not be deleted. It may have student submissions."
            );
            e.printStackTrace();
            return false;
        }
    }

    // Submit and evaluate student answer
    public int submitAnswer(int userId, int missionId, String selectedAnswer) {

        String checkSql = "SELECT correct_answer, option_a, option_b, "
                + "option_c, option_d, xp_reward "
                + "FROM missions WHERE id = ?";

        String insertSql = "INSERT INTO mission_submissions "
                + "(user_id, mission_id, answer, is_correct) "
                + "VALUES (?, ?, ?, ?)";

        String updateSql = "UPDATE users SET "
                + "player_level = FLOOR((total_xp + ?) / 100) + 1, "
                + "total_xp = total_xp + ? WHERE id = ?";

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false);

            try {
                String correctAnswer;
                String selectedAnswerText;
                int xpReward;

                try (PreparedStatement ps = con.prepareStatement(checkSql)) {

                    ps.setInt(1, missionId);

                    try (ResultSet rs = ps.executeQuery()) {

                        if (!rs.next()) {
                            con.rollback();
                            return -2;
                        }

                        correctAnswer = rs.getString("correct_answer");
                        xpReward = rs.getInt("xp_reward");

                        switch (selectedAnswer.toUpperCase()) {
                            case "A":
                                selectedAnswerText = rs.getString("option_a");
                                break;
                            case "B":
                                selectedAnswerText = rs.getString("option_b");
                                break;
                            case "C":
                                selectedAnswerText = rs.getString("option_c");
                                break;
                            case "D":
                                selectedAnswerText = rs.getString("option_d");
                                break;
                            default:
                                con.rollback();
                                return -2;
                        }
                    }
                }

                boolean isCorrect =
                        selectedAnswerText.equals(correctAnswer);

                try (PreparedStatement ps = con.prepareStatement(insertSql)) {

                    ps.setInt(1, userId);
                    ps.setInt(2, missionId);
                    ps.setString(3, selectedAnswerText);
                    ps.setBoolean(4, isCorrect);

                    ps.executeUpdate();
                }

                if (isCorrect) {

                    try (PreparedStatement ps =
                            con.prepareStatement(updateSql)) {

                        ps.setInt(1, xpReward);
                        ps.setInt(2, xpReward);
                        ps.setInt(3, userId);

                        ps.executeUpdate();
                    }
                }

                con.commit();

                return isCorrect ? 1 : 0;

            } catch (SQLException e) {
                con.rollback();

                e.printStackTrace();

                if ("23000".equals(e.getSQLState())) {
                    System.out.println("Integrity constraint error: " + e.getMessage());
                    return -1;
                }

                throw e;
            } finally {
                con.setAutoCommit(true);
            }

        } catch (Exception e) {
            e.printStackTrace();
            return -2;
        }
    }
}
