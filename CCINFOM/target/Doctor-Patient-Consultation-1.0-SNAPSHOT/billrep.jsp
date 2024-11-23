<%-- 
    Document   : billrep
    Created on : Nov 21, 2024, 11:31:09 PM
    Author     : Martina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Billing and Payment Report</title>
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
        <h1 style="text-align: center;">Patient Billing and Payment Report</h1>
        <%
            ArrayList<String> MonthYear = new ArrayList<>(); 
            ArrayList<String> totalpatients = new ArrayList<>(); 
            ArrayList<String> totalpayments = new ArrayList<>(); 
            ArrayList<String> avgpayment = new ArrayList<>(); 
            String error = "";
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String dbUrl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
                String dbUser = "root";
                String dbPassword = "chevyLUV0606??";
                String query = "SELECT "
                             + "DATE_FORMAT(br.billingDate, '%Y-%m') AS MonthYear, "
                             + "COUNT(DISTINCT br.patientID) AS TotalNumOfPatients, "
                             + "SUM(bs.serviceAmount) AS TotalPayments, "
                             + "ROUND(AVG(bs.serviceAmount), 2) AS AvgPaymentPerPatient "
                             + "FROM billed_record_management br "
                             + "JOIN billed_services_table bs ON br.billingID = bs.billingID "
                             + "JOIN patient p ON br.patientID = p.patientID "
                             + "GROUP BY DATE_FORMAT(br.billingDate, '%Y-%m') "
                             + "ORDER BY DATE_FORMAT(br.billingDate, '%Y-%m')";

                try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                     PreparedStatement pst = conn.prepareStatement(query);
                     ResultSet rs = pst.executeQuery()) {
                    
                    while (rs.next()) {
                        MonthYear.add(rs.getString("MonthYear"));
                        totalpatients.add(rs.getString("TotalNumOfPatients"));
                        totalpayments.add(rs.getString("TotalPayments"));
                        avgpayment.add(rs.getString("AvgPaymentPerPatient"));
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
        <% } else if (MonthYear.isEmpty()) { %>
            <p>No records found in the database.</p>
        <% } else { %>
            <table>
                <thead>
                    <tr>
                        <th>Year - Month</th>
                        <th>Total Number of Patients</th>
                        <th>Total Payments</th>
                        <th>Average Payment per Patient</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (int i = 0; i < MonthYear.size(); i++) { %>
                        <tr>
                            <td><%= MonthYear.get(i) %></td>
                            <td><%= totalpatients.get(i) %></td>
                            <td><%= totalpayments.get(i) %></td>
                            <td><%= avgpayment.get(i) %></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>

        <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
