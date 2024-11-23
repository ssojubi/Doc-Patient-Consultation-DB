<%@ page import="java.sql.*" %>
<%
    String patientFirstName = request.getParameter("patientFirstName");
    String patientLastName = request.getParameter("patientLastName");
    String age = request.getParameter("age");
    String gender = request.getParameter("gender");
    String contactInformation = request.getParameter("contactInformation");
    String dateOfBirth = request.getParameter("dateOfBirth");
    String emergencyContact = request.getParameter("emergencyContact");

    String url = "jdbc:mysql://localhost:3306/hospitaldb";
    String username = "root";
    String password = "Kai0214<3";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        conn = DriverManager.getConnection(url, username, password);

        String getMaxID = "SELECT MAX(patientID) FROM patient";
        Statement maxIDStmt = conn.createStatement();
        ResultSet rs = maxIDStmt.executeQuery(getMaxID);
        int newPatientID = 1;
        if (rs.next() && rs.getInt(1) > 0) {
            newPatientID = rs.getInt(1) + 1;
        }

        String sql = "INSERT INTO patient (patientID, patientFirstName, patientLastName, age, gender, contactInformation, dateOfBirth, emergencyContact) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, newPatientID);
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
            out.println("<h2>Patient added successfully! Patient ID: " + newPatientID + "</h2>");
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
