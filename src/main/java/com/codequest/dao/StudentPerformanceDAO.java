package com.codequest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.codequest.util.DBConnection;

public class StudentPerformanceDAO {

    public List<String[]> getStudentPerformance() {

        List<String[]> students = new ArrayList<>();

        String sql = "SELECT u.username, u.email, u.total_xp, u.player_level, " +
                     "COUNT(ms.id) AS completed_missions " +
                     "FROM users u " +
                     "LEFT JOIN mission_submissions ms " +
                     "ON u.id = ms.user_id AND ms.is_correct = 1 " +
                     "GROUP BY u.id, u.username, u.email, " +
                     "u.total_xp, u.player_level " +
                     "ORDER BY u.total_xp DESC, u.username ASC";

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                System.out.println("Database connection is null!");
                return students;
            }

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    String[] student = new String[5];

                    student[0] = rs.getString("username");
                    student[1] = rs.getString("email");
                    student[2] = String.valueOf(rs.getInt("total_xp"));
                    student[3] = String.valueOf(rs.getInt("player_level"));
                    student[4] = String.valueOf(
                        rs.getInt("completed_missions")
                    );

                    students.add(student);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }
}
