<%-- 
    Document   : updateField
    Created on : Nov 23, 2024, 3:04:30?AM
    Author     : Guiller Fam
--%>

<%@ page import="java.sql.*" %>
<%
    // Retrieve patientID from the request
    String patientID = request.getParameter("patientID");

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
    String username = "root";
    String password = "chevyLUV0606??";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // Fetch the patient details
        String sql = "SELECT * FROM patient WHERE patientID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, patientID);
        rs = stmt.executeQuery();

        if (rs.next()) {
%>
            <h1>Update Patient Information</h1>
            <form action="processUpdate.jsp" method="post">
                <input type="hidden" name="patientID" value="<%= patientID %>">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="patientLastName" value="<%= rs.getString("patientLastName") %>"><br><br>

                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="patientFirstName" value="<%= rs.getString("patientFirstName") %>"><br><br>

                <label for="age">Age:</label>
                <input type="number" id="age" name="age" value="<%= rs.getInt("age") %>"><br><br>

                <label for="gender">Gender:</label>
                <input type="text" id="gender" name="gender" value="<%= rs.getString("gender") %>"><br><br>

                <label for="contactInfo">Contact Information:</label>
                <input type="text" id="contactInfo" name="contactInformation" value="<%= rs.getString("contactInformation") %>"><br><br>

                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dateOfBirth" value="<%= rs.getString("dateOfBirth") %>"><br><br>

                <label for="emergencyContact">Emergency Contact:</label>
                <input type="text" id="emergencyContact" name="emergencyContact" value="<%= rs.getString("emergencyContact") %>"><br><br>

                <button type="submit">Update</button>
            </form>
<%
        } else {
            out.println("<p>No patient found with ID: " + patientID + "</p>");
            out.println("<a href='updatePatient.html'>Try Again</a>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

