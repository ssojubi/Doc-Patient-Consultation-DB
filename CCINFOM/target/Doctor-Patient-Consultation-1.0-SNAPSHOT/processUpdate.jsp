<%-- 
    Document   : processUpdate
    Created on : Nov 23, 2024, 3:05:01?AM
    Author     : Guiller Fam
--%>

<%@ page import="java.sql.*" %>
<%
    String patientID = request.getParameter("patientID");
    String lastName = request.getParameter("patientLastName");
    String firstName = request.getParameter("patientFirstName");
    String age = request.getParameter("age");
    String gender = request.getParameter("gender");
    String contactInformation = request.getParameter("contactInformation");
    String dateOfBirth = request.getParameter("dateOfBirth");
    String emergencyContact = request.getParameter("emergencyContact");

    String url = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
    String username = "root";
    String password = "chevyLUV0606??";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        String sql = "UPDATE patient SET patientLastName = ?, patientFirstName = ?, age = ?, gender = ?, contactInformation = ?, dateOfBirth = ?, emergencyContact = ? WHERE patientID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, lastName);
        stmt.setString(2, firstName);
        stmt.setInt(3, Integer.parseInt(age));
        stmt.setString(4, gender);
        stmt.setString(5, contactInformation);
        stmt.setString(6, dateOfBirth);
        stmt.setString(7, emergencyContact);
        stmt.setString(8, patientID);

        int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated > 0) {
            out.println("<p>Patient information updated successfully!</p>");
            out.println("<a href='updatePatient.html'>Update Another Patient</a>");
        } else {
            out.println("<p>Failed to update patient information.</p>");
            out.println("<a href='updatePatient.html'>Try Again</a>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<a href="updatePatient.html">Update Another Patient</a><br>
<a href="updatepatients.html">Go Back</a><br>
<a href="index.html">Go Back to Main Menu</a><br>
