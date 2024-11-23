<%-- 
    Document   : recdates
    Created on : Nov 22, 2024, 11:23:55 PM
    Author     : Martina
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Prescription Start and End Dates</title>
    </head>
    <body>
        <h1>Update Prescription Start and End Dates</h1>
        <form action="index.html">
        <%
            // Retrieve input values from the form
            String v_patientid = request.getParameter("patientID");
            String start = request.getParameter("start"); 
            String end = request.getParameter("end"); 

            if (v_patientid != null && start != null && end != null && 
                !v_patientid.isEmpty() && !start.isEmpty() && !end.isEmpty()) {
                try {
                    // Load MySQL driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Database credentials
                    String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
                    String dbuser = "root";
                    String dbpass = "chevyLUV0606??";

                    // Establish database connection
                    Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);

                    // Prepare the SQL query
                    String sql = "UPDATE medicationprescription "
                               + "SET startDate = ?, endDate = ? "
                               + "WHERE patientID = ?";
                    PreparedStatement query = conn.prepareStatement(sql);
                    query.setString(1, start);
                    query.setString(2, end);
                    query.setString(3, v_patientid);

                    // Execute the update
                    int rowsUpdated = query.executeUpdate();

                    // Close resources
                    query.close();
                    conn.close();

                    if (rowsUpdated > 0) {
        %>
                        <h1 style="color: green;">Prescription Dates Updated Successfully!</h1>
                        <p>Patient ID: <%= v_patientid %></p>
                        <p>New Start Date: <%= start %></p>
                        <p>New End Date: <%= end %></p>
        <%
                    } else {
        %>
                        <h1 style="color: red;">No Changes Made</h1>
                        <p>We couldn't find a record for Patient ID: <%= v_patientid %>.</p>
                        <p>Please double-check the Patient ID and try again.</p>
        <%
                    }
                } catch (ClassNotFoundException e) {
        %>
                    <h1 style="color: red;">System Error</h1>
                    <p>We're experiencing technical difficulties. Please try again later.</p>
        <%
                } catch (SQLException e) {
        %>
                    <h1 style="color: red;">Database Error</h1>
                    <p>There was an issue updating the prescription dates. Please ensure the Patient ID exists and the dates are valid.</p>
        <%
                }
            } else {
        %>
                <h1 style="color: orange;">Invalid Input</h1>
                <p>Please fill out all fields: Patient ID, Start Date, and End Date.</p>
        <%
            }
        %>
        <br>
        <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
