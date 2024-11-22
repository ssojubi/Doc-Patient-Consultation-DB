<%@ page import="java.sql.*" %>
<%
    // Retrieve patientID and action parameter
    String patientID = request.getParameter("patientID");
    String action = request.getParameter("action"); // "generateRecord", "updatePatient", "deletePatient", etc.

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/hospitaldb";
    String username = "root";
    String password = "Kai0214<3";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // Validate if the patient ID exists
        String sql = "SELECT * FROM patient WHERE patientID = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, patientID);
        rs = stmt.executeQuery();

        if (rs.next()) {
            // Patient exists
            if ("updatePatient".equalsIgnoreCase(action)) {
                // Redirect to the patient update page
                response.sendRedirect("updateField.jsp?patientID=" + patientID);
            } else if ("generateRecord".equalsIgnoreCase(action)) {
                // Redirect to the record generation page
                response.sendRedirect("generateRecord.jsp?patientID=" + patientID);
            } else if ("deletePatient".equalsIgnoreCase(action)) {
                // Redirect to the patient deletion page
                response.sendRedirect("deletePatient.jsp?patientID=" + patientID);
            } else if ("generateBill".equalsIgnoreCase(action)) {
                // Redirect to the bill record generation page
                response.sendRedirect("generateBill.jsp?patientID=" + patientID);
            } else {
                out.println("<p>Invalid action specified.</p>");
                out.println("<a href='validatePatient.jsp'>Try Again</a>");
            }
        } else {
            // Patient does not exist
            out.println("<p>No patient found with ID: " + patientID + "</p>");
            out.println("<a href='generateMedicalRecord.html'>Try Again</a>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
