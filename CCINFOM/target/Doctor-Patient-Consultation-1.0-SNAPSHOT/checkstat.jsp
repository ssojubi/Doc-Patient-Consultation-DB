<%-- 
    Document   : checkstat
    Created on : Nov 20, 2024, 7:13:07 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Payment Status</title>
    </head>
    <body>
        <h1>Payment Status</h1>
        <form action="index.html">
            
            <%
            String billingID = request.getParameter("billingID");
            String status="", error="";
            

            if (billingID != null && !billingID.isEmpty()) {
        
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
            String dbuser = "root";
            String dbpass = "chevyLUV0606??";
            String query = "SELECT billingID, paymentStatus\n"
                    + " FROM billed_record_management\n"
                    + " WHERE paymentStatus = 'Paid' AND billingID = ?;";

                try (Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass); 
                 PreparedStatement pt = conn.prepareStatement(query)) {
                 // Set parameter for the query
                 pt.setString(1, billingID);

                 // Execute query
                 ResultSet rs = pt.executeQuery();

                 // Iterate through the result set
                 if (rs.next()) {
                     // Assign patientID (if needed) and add service names to the list
                     billingID = rs.getString("billingID");
                     status = rs.getString("paymentStatus");
                 }

                    rs.close();
                } catch (SQLException e) {
                   error = "Database error: " + e.getMessage();
                }
            }
            %>
            <%
                if (!status.isEmpty()) { %>
                    <p>Billing ID: <%= billingID%></p>
                    <p style="color: green;">Payment Status: Paid</p>
            <%
            } else if (!error.isEmpty()) {
            %> <p style="color: red;">Error: <%= error%></p>
            <% } else { %>
            <p style="color: orange;">Payment Status: Not Paid </p>
            <%} %>
            <br>
           <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
