<%@ page import="java.sql.*" %>
<%
    String patientID = request.getParameter("patientID");

    // Database connection details
    String url = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
    String username = "root";
    String password = "chevyLUV0606??";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    float totalBalance = 0; // Initialize total balance

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        // SQL query to get all services for the patient
        String sql = "SELECT bs.billingID, bs.serviceName, bs.serviceAmount, bm.billingDate, bm.paymentStatus, " +
                     "p.patientID, p.patientFirstName, p.patientLastName " +
                     "FROM billed_services_table bs " +
                     "JOIN billed_record_management bm ON bm.billingID = bs.billingID " +
                     "JOIN patient p ON bm.patientID = p.patientID " +
                     "WHERE p.patientID = ?";

        stmt = conn.prepareStatement(sql);
        stmt.setString(1, patientID);
        rs = stmt.executeQuery();

        if (rs.next()) {
%>
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Patient Billing Statement</title>
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
                    table {
                        width: 50%;
                        border-collapse: collapse;
                    }
                    td, th {
                        padding: 10px;
                        text-align: left;
                    }
                    th {
                        background-color: #f2f2f2;
                    }
                </style>
            </head>
            <body>
                <!-- Billing Statement Header -->
                <div class="header">
                    Billing Statement
                </div>
                
                <!-- Patient Information -->
                <div class="section">
                    <table>
                        <tr>
                            <td>Billing ID:</td>
                            <td><%= rs.getInt("billingID") %></td>
                        </tr>
                        <tr>
                            <td>Patient ID:</td>
                            <td><%= rs.getInt("patientID") %></td>
                        </tr>
                        <tr>
                            <td>Patient Name:</td>
                            <td><%= rs.getString("patientLastName") %>, <%= rs.getString("patientFirstName") %></td>
                            
                        </tr>
                       
                    </table>
                </div>

                <!-- Billing Details Table -->
                <div class="section">
                    <table>
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Service</th>
                                <th>Amount (Php)</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
<%
            // Loop through all the result set rows to display each service and amount
            do {
                String paymentStatus = rs.getString("paymentStatus");
                float serviceAmount = rs.getFloat("serviceAmount");

                // Only add the service amount to total balance if paymentStatus is "Not Paid"
                if ("Not Paid".equals(paymentStatus)) {
                    totalBalance += serviceAmount;
                }
%>
                            <tr>
                                <td><%= rs.getDate("billingDate") %></td>
                                <td><%= rs.getString("serviceName") %></td>
                                <td><%= serviceAmount %></td>
                                <td><%= paymentStatus %></td>
                            </tr>
<%
            } while (rs.next());
%>
                        </tbody>
                    </table>
                </div>

                <!-- Total Balance -->
                <div class="section">
                    <p>Total Balance: Php <%= totalBalance %></p>
                </div>
                
            </body>
<%
        } else {
            out.println("<p>No billing records found for Patient ID: " + patientID + "</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<a href="generateBillRecord.html">Generate Another Bill Record</a><br>
<a href="updatepatients.html">Go Back</a><br>
<a href="index.html">Go Back to Main Menu</a><br>