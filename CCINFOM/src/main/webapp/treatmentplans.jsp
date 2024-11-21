<%-- 
    Document   : treatmentplans
    Created on : Nov 20, 2024, 3:56:49 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, billing.treatmentplans" %>  
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Treatment Plans</title>
    </head>
    <body>
         <form action="index.html">
           <% 
            String patientID = request.getParameter("patientID");;
            ArrayList<String> serviceName = new ArrayList<>();   
            String error="";
           
            if (patientID != null && !patientID.isEmpty()) {
        
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
            String dbuser = "root";
            String dbpass = "chevyLUV0606??";
            String query = "SELECT p.patientID, b.serviceName"
                    + " FROM medicalrecordsstorage p"
                    + " JOIN billed_record_management r ON p.billingID = r.billingID"
                    + " JOIN billed_services_table b ON r.billingID = b.billingID"
                    + " WHERE p.patientID = ?";

            try (
                Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass); 
                PreparedStatement pt = conn.prepareStatement(query)) {
            // Set parameter for the query
                    pt.setString(1, patientID);

                    // Execute query
                    ResultSet rs = pt.executeQuery();

                    // Clear the list before populating it with new data
                    serviceName.clear();

                    // Iterate through the result set
                    while (rs.next()) {
                        // Assign patientID (if needed) and add service names to the list
                        patientID = rs.getString("patientID");
                        String service = rs.getString("serviceName");
                        serviceName.add(service);
                    }

                    rs.close();
                } catch (SQLException e) {
                   error = "Database error: " + e.getMessage();
                }
            }
           
             if (!serviceName.isEmpty()) { %>
            <p>Patient ID: <%= patientID %></p>
            <p>Your Treatment Plans:</p>
            <ul>
                <% for (String service : serviceName) { %>
                    <li><%= service %></li>
                <% } %>
            </ul>
        <% } else if (!error.isEmpty()) { %>
            <p style="color: red;">Error: <%= error %></p>
        <% } else { %>
            <p>No treatment plans found for Patient ID: <%= patientID %>.</p>
        <% } %>

           <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
