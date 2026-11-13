
package com.codequest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.codequest.util.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

public class AdminDAO {

    // Validate admin login
    public boolean validateAdmin(String username, String password) {

        String sql = "SELECT id, password FROM admins WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            int adminId;
            String storedPassword;

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    return false;
                }

                adminId = rs.getInt("id");
                storedPassword = rs.getString("password");
            }

            boolean passwordMatches;

            // Check BCrypt password
            if (storedPassword.startsWith("$2a$") ||
                storedPassword.startsWith("$2b$") ||
                storedPassword.startsWith("$2y$")) {

                passwordMatches =
                    BCrypt.checkpw(password, storedPassword);

            } else {

                // Support existing plain-text admin password
                passwordMatches = storedPassword.equals(password);

                // Convert old password to BCrypt after successful login
                if (passwordMatches) {

                    String hashedPassword =
                        BCrypt.hashpw(password, BCrypt.gensalt(12));

                    String updateSQL =
                        "UPDATE admins SET password = ? WHERE id = ?";

                    try (PreparedStatement update =
                             con.prepareStatement(updateSQL)) {

                        update.setString(1, hashedPassword);
                        update.setInt(2, adminId);
                        update.executeUpdate();
                    }
                }
            }

            return passwordMatches;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // Get admin ID using username
    public int getAdminId(String username) {

        String sql = "SELECT id FROM admins WHERE username = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

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
}
