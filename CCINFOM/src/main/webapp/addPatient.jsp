<%-- 
    Document   : addPatient
    Created on : Nov 22, 2024, 4:48:15?PM
    Author     : Guiller Fam
--%>

<%@ page import="java.sql.*" %>
<%
    // Retrieve form data
    String patientID = request.getParameter("patientID");
    String patientFirstName = request.getParameter("patientFirstName");
    String patientLastName = request.getParameter("patientLastName");
    String age = request.getParameter("age");
    String gender = request.getParameter("gender");
    String contactInformation = request.getParameter("contactInformation");
    String dateOfBirth = request.getParameter("dateOfBirth");
    String emergencyContact = request.getParameter("emergencyContact");

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/hospitaldb";
    String username = "root";
    String password = "Kai0214<3";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Load MySQL JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        conn = DriverManager.getConnection(url, username, password);

        // SQL query to insert the patient
        String sql = "INSERT INTO patient (patientID, patientFirstName, patientLastName, age, gender, contactInformation, dateOfBirth, emergencyContact) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, Integer.parseInt(patientID));
        stmt.setString(2, patientFirstName);
        stmt.setString(3, patientLastName);
        stmt.setInt(4, Integer.parseInt(age));
        stmt.setString(5, gender);
        stmt.setString(6, contactInformation);
        stmt.setDate(7, Date.valueOf(dateOfBirth));
        stmt.setString(8, emergencyContact);

        // Execute the query
        int rowsInserted = stmt.executeUpdate();

        if (rowsInserted > 0) {
            out.println("<h2>Patient added successfully!</h2>");
        } else {
            out.println("<h2>Failed to add patient. Please try again.</h2>");
        }
    } catch (Exception e) {
        out.println("<h2>Error: " + e.getMessage() + "</h2>");
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<a href="addPatient.html">Add Another Patient</a><br>
<a href="updatepatients.html">Go Back</a><br>
<a href="index.html">Go Back to Main Menu</a><br>
