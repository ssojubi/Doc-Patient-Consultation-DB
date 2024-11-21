<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <title>Payment Due Date</title>
</head>
<body>

    <%
        String patientID = request.getParameter("patientID");
        String dueDate = "";
        String error = "";

        if (patientID != null && !patientID.isEmpty()) {
        
            Class.forName("com.mysql.cj.jdbc.Driver");
            String dbUrl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
            String dbUser = "root";
            String dbPassword = "chevyLUV0606??";
            String query = "SELECT b.billingDate FROM billed_record_management b "
                    + "JOIN medicalrecordsstorage m ON b.billingID = m.billingID "
                    + "WHERE m.patientID = ?";

            try {
                // Establish connection
                Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                PreparedStatement pst = conn.prepareStatement(query);
                pst.setString(1, patientID);

                // Execute query
                ResultSet rs = pst.executeQuery();

                if (rs.next()) {
                    dueDate = rs.getString("billingDate");
                } else {
                    error = "No due date found for patient ID: " + patientID;
                }

                // Close connections
                rs.close();
                pst.close();
                conn.close();
            } catch (SQLException e) {
                error = "Database error: " + e.getMessage();
            }
        } else {
            error = "Patient ID cannot be empty.";
        }
    %>

    <% if (!dueDate.isEmpty()) { %>
        <p>Your Due Date is: <%= dueDate %></p>
    <% } else if (!error.isEmpty()) { %>
        <p style="color: red;">Error: <%= error %></p>
    <% } %>
</body>
</html>
