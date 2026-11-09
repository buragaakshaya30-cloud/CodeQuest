
package com.codequest.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.codequest.util.DBConnection;

public class LeaderboardDAO {

    public List<String[]> getLeaderboard() {

        List<String[]> leaderboard = new ArrayList<>();

        String sql = "SELECT username, total_xp, player_level FROM users "
                   + "ORDER BY total_xp DESC, username ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                String[] student = new String[3];

                student[0] = rs.getString("username");
                student[1] = String.valueOf(rs.getInt("total_xp"));
                student[2] = String.valueOf(rs.getInt("player_level"));

                leaderboard.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return leaderboard;
    }
}
