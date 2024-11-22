<%-- 
    Document   : generateRecord
    Created on : Nov 22, 2024, 5:34:37?PM
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
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // Fetch the medical record from MedicalRecordsStorage based on patientID
        String sql = "SELECT p.patientID, p.patientFirstName, p.patientLastName, p.contactInformation, p.age, p.gender, p.dateOfBirth, p.emergencyContact, " +
                     "mr.recordID, mr.diagnosis, mr.dateOfRecord, d.doctorLastName, d.doctorFirstName, " +
                     "mp.medicationName, mp.dosage, mp.startDate, mp.endDate " +
                     "FROM MedicalRecordsStorage mr " +
                     "JOIN medicationprescription mp ON mp.patientID = mr.patientID " +
                     "JOIN patient p ON mr.patientID = p.patientID " +
                     "JOIN doctor d ON mr.doctorID = d.doctorID " +
                     "JOIN billed_record_management b ON mr.billingID = b.billingID " +
                     "WHERE mr.patientID = ?";


        stmt = conn.prepareStatement(sql);
        stmt.setString(1, patientID);
        rs = stmt.executeQuery();

        if (rs.next()) {
%>
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Patient Medical Record</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        margin: 20px;
                    }
                    .header, .section {
                        margin-bottom: 20px;
                    }
                    .header {
                        font-size: 18px;
                        font-weight: bold;
                        text-align: left;
                    }
                    .section-title {
                        font-size: 16px;
                        font-weight: bold;
                        margin-bottom: 10px;
                        text-decoration: underline;
                    }
                    table {
                        width: 50%;
                        border-collapse: collapse; /* Removes extra space between table borders */
                        margin-bottom: 10px;
                        border-spacing: 0; /* Ensures no spacing between cells */
                    }

                    td, th {
                        padding: 4px; /* Reduces padding inside cells */
                        text-align: left;
                    }

                    .general-history {
                        border: 1px solid #ddd;
                    }

                    .section {
                        margin-bottom: 10px; /* Reduces space between sections */
                    }
                </style>
            </head>
            <body>
                <!-- Header -->
                <div class="header">
                    Patient Medical Record
                </div>

                <!-- Patient Information -->
                <div class="section">
                    <table>
                        <tr>
                            <td>Patient ID:</td>
                            <td><%= rs.getInt("patientID") %></td>
                        </tr>
                        <tr>
                            <td>Patient Name:</td>
                            <td><%= rs.getString("patientLastName") %>, <%= rs.getString("patientFirstName") %></td>
                            <td style="margin-left: 20px;">Date of Birth:</td>
                            <td><%= rs.getDate("dateOfBirth") %></td>
                        </tr>
                        <tr>
                            <td>Contact Number:</td>
                            <td><%= rs.getString("contactInformation") %></td>
                            <td style="margin-left: 20px;">Gender:</td>
                            <td><%= rs.getString("gender") %></td>
                        </tr>
                    </table>
                </div>
                
                <!-- Emergency Contact -->
                <div class="section">
                    <div class="section-title">In Case Of Emergency</div>
                        <tr>
                            <td>Emergency Contact Number:</td>
                            <td><%= rs.getString("emergencyContact") %></td>
                        </tr>
                </div>

                    <!-- General Medical History -->
                    <div class="section">
                        <div class="section-title">General Medical History</div>
                        <table class="general-history">
                            <tr>
                                <th>Date of Record</th>
                                <td><%= rs.getDate("dateOfRecord") %></td>
                            </tr>
                            <tr>
                                <th>Diagnosis</th>
                                <td><%= rs.getString("diagnosis") %></td>
                            </tr>
                            <tr>
                                <th>Medication/Prescription</th>
                                <td><%= rs.getString("medicationName") %></td>
                            </tr>
                            <tr>
                                <th>Dosage (mg)</th>
                                <td><%= rs.getFloat("dosage") %></td>
                            </tr>
                            <tr>
                                <th>Start Date</th>
                                <td><%= rs.getDate("startDate") %></td>
                            </tr>
                            <tr>
                                <th>End Date</th>
                                <td><%= rs.getDate("endDate") %></td>
                            </tr>
                        </table>
                    </div>
                            
                    <!-- Doctor Information -->
                    <div class="section">
                        <th>Signed By: Dr.</th>
                        <td><%= rs.getString("doctorFirstName") %> <%= rs.getString("doctorLastName") %></td>
                    </div>
            </body>
            </html>  
            
<%
        } else {
            out.println("<p>No medical record found for Patient ID: " + patientID + "</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>

<a href="generateMedicalRecord.html">Generate Another Medical Record</a><br>
<a href="updatepatients.html">Go Back</a><br>
<a href="index.html">Go Back to Main Menu</a><br>

