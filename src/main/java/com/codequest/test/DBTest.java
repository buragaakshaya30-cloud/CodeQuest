
package com.codequest.test;

import java.sql.Connection;
import com.codequest.util.DBConnection;

public class DBTest {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {
            System.out.println("CodeQuest database is ready!");

            try {
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            System.out.println("Connection not established.");
        }
    }
}
