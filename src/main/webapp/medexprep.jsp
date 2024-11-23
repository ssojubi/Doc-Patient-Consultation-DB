<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Medical Expenses Report</title>
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
            <h1 style="text-align: center;">Medical Expenses Report</h1>
            <%
                ArrayList<String> year = new ArrayList<>();
                ArrayList<String> month = new ArrayList<>();
                ArrayList<String> exp = new ArrayList<>();
                ArrayList<String> avg_exp = new ArrayList<>();
                String error = "";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String dbUrl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
                    String dbUser = "root";
                    String dbPassword = "chevyLUV0606??";
                    String query = "SELECT " +
                                   "YEAR(billingDate) AS Year, " +
                                   "MONTH(billingDate) AS Month, " +
                                   "SUM(amountDue) AS TotalExpenses, " +
                                   "AVG(amountDue) AS AverageExpensePerPatient " +
                                   "FROM billed_record_management " +
                                   "GROUP BY YEAR(billingDate), MONTH(billingDate) " +
                                   "ORDER BY Year, Month";

                    try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                         PreparedStatement pst = conn.prepareStatement(query);
                         ResultSet rs = pst.executeQuery()) {

                        while (rs.next()) {
                            year.add(rs.getString("Year"));
                            month.add(rs.getString("Month"));
                            exp.add(rs.getString("TotalExpenses"));
                            avg_exp.add(rs.getString("AverageExpensePerPatient"));
                        }
                    }
                } catch (ClassNotFoundException e) {
                    error = "Database driver not found.";
                    e.printStackTrace(); // Log error for debugging.
                } catch (SQLException e) {
                    error = "Database connection failed.";
                    e.printStackTrace(); // Log error for debugging.
                }
            %>

            <% if (!error.isEmpty()) { %>
                <p class="error"><%= error %></p>
            <% } else if (year.isEmpty()) { %>
                <p style="text-align: center;">No records found in the database.</p>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>Year</th>
                            <th>Month</th>
                            <th>Total Expenses</th>
                            <th>Average Expenses per Patient</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < year.size(); i++) { %>
                            <tr>
                                <td><%= year.get(i) %></td>
                                <td><%= month.get(i) %></td>
                                <td><%= exp.get(i) %></td>
                                <td><%= avg_exp.get(i) %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
            <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
