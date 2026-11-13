
package com.codequest.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {

        String URL = System.getenv("DB_URL");
        String USERNAME = System.getenv("DB_USERNAME");
        String PASSWORD = System.getenv("DB_PASSWORD");

        try {
            if (URL == null || USERNAME == null || PASSWORD == null) {
                throw new IllegalStateException(
                    "Database environment variables are missing. Check Railway Variables."
                );
            }

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection connection = DriverManager.getConnection(
                URL, USERNAME, PASSWORD
            );

            System.out.println("Database connected successfully!");
            return connection;

        } catch (Exception e) {
            System.out.println("DATABASE CONNECTION ERROR:");
            e.printStackTrace();
            throw new RuntimeException("Unable to connect to database", e);
        }
    }
}
