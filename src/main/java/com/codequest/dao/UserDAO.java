
package com.codequest.dao;




import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import org.mindrot.jbcrypt.BCrypt;

import com.codequest.util.DBConnection;

public class UserDAO {

    // Check whether username already exists
    public boolean usernameExists(String username) {
        String sql = "SELECT id FROM users WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Check whether email already exists
    public boolean emailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Register a new student

public boolean registerUser(String username, String email, String password) {

    String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";

    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt(12));

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, username);
        ps.setString(2, email);
        ps.setString(3, hashedPassword);

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return false;
}


    // Validate student login

public boolean validateUser(String email, String password) {

    String sql = "SELECT id, password FROM users WHERE email = ?";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setString(1, email);

        try (ResultSet rs = ps.executeQuery()) {

            if (!rs.next()) {
                return false;
            }

            int userId = rs.getInt("id");
            String storedPassword = rs.getString("password");

            boolean isBCrypt =
                storedPassword.startsWith("$2a$") ||
                storedPassword.startsWith("$2b$") ||
                storedPassword.startsWith("$2y$");

            boolean valid = isBCrypt
                ? BCrypt.checkpw(password, storedPassword)
                : storedPassword.equals(password);

            if (valid && !isBCrypt) {

                String hashedPassword =
                    BCrypt.hashpw(password, BCrypt.gensalt(12));

                String updateSQL =
                    "UPDATE users SET password = ? WHERE id = ?";

                try (PreparedStatement update =
                         con.prepareStatement(updateSQL)) {

                    update.setString(1, hashedPassword);
                    update.setInt(2, userId);
                    update.executeUpdate();
                }
            }

            return valid;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return false;
}


    // Get student username using email
    public String getUsername(String email) {
        String sql = "SELECT username FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("username");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get student ID using email
    public int getUserId(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Get student's total XP
    public int getTotalXP(String email) {
        String sql = "SELECT total_xp FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total_xp");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get student's current level
    public int getLevel(String email) {
        String sql = "SELECT player_level FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("player_level");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1;
    }

    // Count completed missions (correct submissions only)
    public int getCompletedMissions(int userId) {
        String sql = "SELECT COUNT(*) AS completed " +
                     "FROM mission_submissions " +
                     "WHERE user_id = ? AND is_correct = TRUE";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("completed");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Get total missions
    public int getTotalMissions() {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM missions";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    // Get completed mission details
    public List<String[]> getCompletedMissionDetails(int userId) {

        List<String[]> completed = new ArrayList<>();

        String sql = "SELECT m.title, m.category, m.difficulty, " +
                     "ms.answer, m.xp_reward " +
                     "FROM mission_submissions ms " +
                     "JOIN missions m ON ms.mission_id = m.id " +
                     "WHERE ms.user_id = ? AND ms.is_correct = TRUE " +
                     "ORDER BY ms.completed_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    String[] mission = {
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("difficulty"),
                        rs.getString("answer"),
                        String.valueOf(rs.getInt("xp_reward"))
                    };

                    completed.add(mission);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return completed;
    }
}
