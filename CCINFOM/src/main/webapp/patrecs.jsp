
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Information</title>
    </head>
    <body>
        <form action="index.html">

<%
    // Get the patient ID from the request parameter
    String v_patientID = request.getParameter("patientID");
    String id = "", age = "", bday = "", pLast = "", pFirst = "", gender = "", cInfo = "", eInfo = ""; // initialize to empty strings
    String error = "";
    if (v_patientID != null && !v_patientID.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
            String dbUser = "root";
            String dbPassword = "chevyLUV0606??";
            String query = "SELECT * FROM patient WHERE patientID = ?";

            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, v_patientID);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                id = rs.getString("patientID");
                pLast = rs.getString("patientLastName");
                pFirst = rs.getString("patientFirstName");
                age = rs.getString("age");
                gender = rs.getString("gender");
                cInfo = rs.getString("contactInformation");
                bday = rs.getString("dateOfBirth");
                eInfo = rs.getString("emergencyContact");
            } else {
                error = "No patient found for patient ID: " + v_patientID;
            }

            // Close connections
            rs.close();
            pst.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            error = "Database error: " + e.getMessage();
        }
    }

     
      if(!pLast.isEmpty()){ %>
            <h2>Patient Details</h2>
            <table border="1">
                <tr>
                    <td>Patient ID</td>
                    <td><%= id %></td>
                </tr>
                <tr>
                    <td>Last Name</td>
                    <td><%= pLast %></td>
                </tr>
                <tr>
                    <td>First Name</td>
                    <td><%= pFirst %></td>
                </tr>
                <tr>
                    <td>Age</td>
                    <td><%= age %></td>
                </tr>
                <tr>
                    <td>Gender</td>
                    <td><%= gender %></td>
                </tr>
                <tr>
                    <td>Contact Information</td>
                    <td><%= cInfo %></td>
                </tr>
                <tr>
                    <td>Date of Birth</td>
                    <td><%= bday %></td>
                </tr>
                <tr>
                    <td>Emergency Contact</td>
                    <td><%= eInfo %></td>
                </tr>
            </table>
    <% } else if (!error.isEmpty()) { %>
            <p style="color: red;">Error: <%= error %></p>
        <% } %>
        <br>
     <input type="submit" value="Return to Menu">
            </form>
       </body>
</html>
