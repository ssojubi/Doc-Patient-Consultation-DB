<%-- 
    Document   : deletePatient
    Created on : Nov 22, 2024, 5:10:55?PM
    Author     : Guiller Fam
--%>

<%@ page import="java.sql.*" %>
<%
    String patientID = request.getParameter("patientID");

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/hospitaldb";
    String username = "root";
    String password = "Kai0214<3";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // Delete the patient
        String sql = "DELETE FROM patient WHERE patientID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, patientID);

        int rowsDeleted = stmt.executeUpdate();
        if (rowsDeleted > 0) {
            out.println("<p>Patient ID: " + patientID + " has been successfully deleted.</p>");
        } else {
            out.println("<p>Failed to delete the patient. Please try again.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<a href="deletePatient.html">Delete Another Patient</a><br>
<a href="updatepatients.html">Go Back</a><br>
<a href="index.html">Go Back to Main Menu</a><br>

