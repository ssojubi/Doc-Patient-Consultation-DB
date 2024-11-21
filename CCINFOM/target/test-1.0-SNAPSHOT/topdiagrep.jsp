<%-- 
    Document   : topdiagrep
    Created on : Nov 21, 2024, 11:18:35 PM
    Author     : Martina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Top Diagnosed Diseases Report</title>
        <style>
            table {
                width: 50%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            table, th, td {
                border: 1px solid black;
            }
            th, td {
                padding: 10px;
                text-align: left;
            }
            .error {
                color: red;
            }
        </style>
    </head>
    <body>
        <form action="index.html">
        <h1 style="text-align: center;">Top Diagnosed Diseases Report</h1>
        <%  
            ArrayList<String> diagnosis = new ArrayList<>(); 
            ArrayList<String> freq = new ArrayList<>(); 
            String error = "";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String dbUrl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
                String dbUser = "root";
                String dbPassword = "chevyLUV0606??";
                String query = "SELECT diagnosis, COUNT(*) AS frequency "
                             + "FROM MedicalRecordsStorage "
                             + "GROUP BY diagnosis ORDER BY frequency DESC";

                try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                     PreparedStatement pst = conn.prepareStatement(query);
                     ResultSet rs = pst.executeQuery()) {
                    
                    while (rs.next()) {
                        diagnosis.add(rs.getString("diagnosis"));
                        freq.add(rs.getString("frequency"));
                    }
                }
            } catch (ClassNotFoundException e) {
                error = "Database driver not found: " + e.getMessage();
            } catch (SQLException e) {
                error = "Database error: " + e.getMessage();
            }
        %>

        <% if (!error.isEmpty()) { %>
            <p class="error"><%= error %></p>
        <% } else if (diagnosis.isEmpty()) { %>
            <p>No records found in the database.</p>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Diagnosis</th>
                        <th>Frequency</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < diagnosis.size(); i++) { %>
                        <tr>
                            <td><%= diagnosis.get(i) %></td>
                            <td><%= freq.get(i) %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
