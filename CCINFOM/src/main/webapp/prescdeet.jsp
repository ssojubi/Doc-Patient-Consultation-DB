<%-- 
    Document   : prescdeet
    Created on : Nov 21, 2024, 10:51:50 PM
    Author     : Martina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Prescription Details</title>
    </head>
    <body>
        <form action="index.html">
        <%
            String id = request.getParameter("patientID");
            String presID ="", docID="",medName="",dosage="",sDate="",eDate="";
            
            String error = "";
    if (id != null && !id.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
            String dbUser = "root";
            String dbPassword = "chevyLUV0606??";
            String query = "SELECT * FROM medicationprescription WHERE patientID = ?";

            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, id);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                presID = rs.getString("prescriptionID");
                docID = rs.getString("doctorID");
                medName = rs.getString("medicationName");
                dosage = rs.getString("dosage");
                sDate = rs.getString("startDate");
                eDate = rs.getString("endDate");
            } else {
                error = "No patient found for patient ID: " + id;
            }

            // Close connections
            rs.close();
            pst.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            error = "Database error: " + e.getMessage();
        }
    }
            
         if(!presID.isEmpty()){ %>
            <h2>Patient Details</h2>
            <p> Patient ID: <%= id%>
            <table border="1">
                <tr>
                    <td>Prescription ID</td>
                    <td><%= presID %></td>
                </tr>
                <tr>
                    <td>Doctor ID</td>
                    <td><%= docID %></td>
                </tr>
                <tr>
                    <td>Medication Name</td>
                    <td><%= medName %></td>
                </tr>
                <tr>
                    <td>Medication Dosage</td>
                    <td><%= dosage %></td>
                </tr>
                <tr>
                    <td>Start Date</td>
                    <td><%= sDate %></td>
                </tr>
                <tr>
                    <td>End Date</td>
                    <td><%= eDate %></td>
                </tr>
            </table>
    <% } else if (!error.isEmpty()) { %>
            <p style="color: red;">Error: <%= error %></p>
        <% } %>
        <br>
        <input type="submit" value="Return to Menu">
            </form>
    </body>
</html>
