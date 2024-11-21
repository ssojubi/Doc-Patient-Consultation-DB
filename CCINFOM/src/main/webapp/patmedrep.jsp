<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Medication Report</title>
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
            <h1 style="text-align: center;">Patient Medication Report</h1>
            <%
                List<Map<String, String>> reportData = new ArrayList<>();
                String error = "";

                try {
                    // Load MySQL driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Connection parameters
                    String dbUrl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
                    String dbUser = "root";
                    String dbPassword = "chevyLUV0606??";

                    // Query to fetch report data
                    String query = "SELECT "
                                    + "YEAR(startDate) AS Year, "
                                    + "MONTH(startDate) AS Month, "
                                    + "COUNT(prescriptionID) AS TotalPrescriptions, "
                                    + "COUNT(prescriptionID) / COUNT(DISTINCT patientID) AS AvgPrescriptionsPerPatient "
                                    + "FROM medicationprescription "
                                    + "GROUP BY YEAR(startDate), MONTH(startDate) "
                                    + "ORDER BY Year, Month";

                    try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                         PreparedStatement pst = conn.prepareStatement(query);
                         ResultSet rs = pst.executeQuery()) {

                        // Store result in a list of maps
                        while (rs.next()) {
                            Map<String, String> row = new HashMap<>();
                            row.put("Year", rs.getString("Year"));
                            row.put("Month", rs.getString("Month"));
                            row.put("TotalPrescriptions", rs.getString("TotalPrescriptions"));
                            row.put("AvgPrescriptionsPerPatient", rs.getString("AvgPrescriptionsPerPatient"));
                            reportData.add(row);
                        }
                    }
                } catch (ClassNotFoundException e) {
                    error = "Database driver not found.";
                    e.printStackTrace(); // Log error for debugging.
                } catch (SQLException e) {
                    error = "Database connection failed. Please try again later.";
                    e.printStackTrace(); // Log error for debugging.
                }
            %>

            <% if (!error.isEmpty()) { %>
                <p class="error"><%= error %></p>
            <% } else if (reportData.isEmpty()) { %>
                <p class="center">No records found in the database.</p>
            <% } else { %>
                <table>
                    <thead>
                        <tr>
                            <th>Year</th>
                            <th>Month</th>
                            <th>Total Prescriptions</th>
                            <th>Average Prescriptions per Patient</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Map<String, String> row : reportData) { %>
                            <tr>
                                <td><%= row.get("Year") %></td>
                                <td><%= row.get("Month") %></td>
                                <td><%= row.get("TotalPrescriptions") %></td>
                                <td><%= row.get("AvgPrescriptionsPerPatient") %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
            <div class="center">
                <input type="submit" value="Return to Menu">
            </div>
        </form>
    </body>
</html>
