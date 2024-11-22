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
            
            String v_patientid = request.getParameter("patientID");
            String start = request.getParameter("start"); 
            String end = request.getParameter("end"); 
            String dos = request.getParameter("dos"); 
            String med = request.getParameter("med"); 

            if (v_patientid != null && !v_patientid.isEmpty() &&
                start != null && !start.isEmpty() &&
                end != null && !end.isEmpty() &&
                dos != null && !dos.isEmpty() &&
                med != null && !med.isEmpty()) {
                try {
                    
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    
                    String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
                    String dbuser = "root";
                    String dbpass = "chevyLUV0606??";

                    
                    Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);

                    
                    String sql = "UPDATE medicationprescription "
                               + "SET medicationName = ?, dosage = ?, startDate = ?, endDate = ? "
                               + "WHERE patientID = ?";
                    PreparedStatement query = conn.prepareStatement(sql);
                    query.setString(1, med);  // medication name
                    query.setString(2, dos);  // dosage
                    query.setString(3, start);  // start date
                    query.setString(4, end);  // end date
                    query.setString(5, v_patientid);  // patient ID

                    
                    int upd = query.executeUpdate();

                    
                    query.close();
                    conn.close();

                    if (upd > 0) {
        %>
                        <h1 style="color: green;">Patient's Prescription Updated Successfully!</h1>
                        <p>Patient ID: <%= v_patientid %></p>
                        <p>New Medication Name: <%= med %></p>
                        <p>New Medication Dosage: <%= dos %></p>
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
                    <p>There was an issue updating the prescription details. Please ensure the information entered is valid.</p>
        <%
                }
            } else {
        %>
                <h1 style="color: orange;">Invalid Input</h1>
                <p>Please ensure all fields are filled out:</p>
                <ul>
                    <li>Patient ID</li>
                    <li>Start Date</li>
                    <li>End Date</li>
                    <li>Medication Name</li>
                    <li>Dosage</li>
                </ul>
        <%
            }
        %>
        <br>
        <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
