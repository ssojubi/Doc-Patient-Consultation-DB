<%-- 
    Document   : updmed.jsp
    Purpose    : Process and update patient medical records
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Medical Diagnosis</title>
    </head>
    <body>
        <h1>Processing Update</h1>
        <form action="index.html">
        <%
            
            String v_patientid = request.getParameter("patientID");
            String new_diag = request.getParameter("diagnosis"); 
            String error = "";

            if (v_patientid != null && new_diag != null && !v_patientid.isEmpty() && !new_diag.isEmpty()) {
                try {
                    
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
                    String dbuser = "root";
                    String dbpass = "chevyLUV0606??";

                    
                    Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);

                    
                    String sql = "UPDATE medicalrecordsstorage "
                               + "SET diagnosis = ?, dateOfRecord = CURRENT_DATE "
                               + "WHERE patientID = ?";
                    PreparedStatement query = conn.prepareStatement(sql);
                    query.setString(1, new_diag);
                    query.setString(2, v_patientid);

                    // Execute the update
                    int upd = query.executeUpdate();

                    // Close resources
                    query.close();
                    conn.close();

                    if (upd > 0) {
        %>
                        <h1 style="color: green;">Diagnosis Updated Successfully!</h1>
                        <p>Patient ID: <%= v_patientid %></p>
                        <p>New Diagnosis: <%= new_diag %></p>
        <%
                    } else {
        %>
                        <h1 style="color: red;">Failed to Update Diagnosis</h1>
                        <p>No record found for Patient ID: <%= v_patientid %>.</p>
        <%
                    }
                } catch (ClassNotFoundException e) {
        %>
                    <h1 style="color: red;">Error Occurred</h1>
                    <p>Driver Error: <%= e.getMessage() %></p>
        <%
                } catch (SQLException e) {
        %>
                    <h1 style="color: red;">Database Error</h1>
                    <p>Error Details: <%= e.getMessage() %></p>
        <%
                }
            } else {
        %>
                <h1 style="color: orange;">Invalid Input</h1>
                <p>Please provide both a valid Patient ID and a new Diagnosis.</p>
        <%
            }
        %>
        <br>
        <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
