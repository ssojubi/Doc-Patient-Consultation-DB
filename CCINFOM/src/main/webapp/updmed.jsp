<%-- 
    Document   : updmed.jsp
    Purpose    : Process and update patient medical records
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, billing.updmed" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Process Update</title>
    </head>
    <body>
        <h1>Processing Update</h1>
        <jsp:useBean id="A" class="billing.updmed" scope="session" />
        <%
            // Retrieve input values from the form
            String v_patientid = request.getParameter("patientID");
            String new_diag = request.getParameter("diagnosis");

            if (v_patientid != null && new_diag != null) {
                v_patientid = v_patientid.trim();
                new_diag = new_diag.trim();

                if (!v_patientid.isEmpty() && !new_diag.isEmpty()) {
                    // Set values in the bean
                    A.setPatientID(v_patientid);
                    A.setDiagnosis(new_diag);

                    try {
                        int stat = A.updMedRec();

                        if (stat == 1) {
                            // Successful update
        %>
                            <h1 style="color: green;">Diagnosis Updated Successfully!</h1>
                            <p>Patient ID: <%= v_patientid %></p>
                            <p>New Diagnosis: <%= new_diag %></p>
        <%
                        } else {
                            // Update failed
        %>
                            <h1 style="color: red;">Failed to Update Diagnosis</h1>
                            <p>There was an issue updating the diagnosis for Patient ID: <%= v_patientid %>.</p>
        <%
                        }
                    } catch (Exception e) {
        %>
                        <h1 style="color: red;">Error Occurred</h1>
                        <p>Error Details: <%= e.getMessage() %></p>
        <%
                    }
                } else {
        %>
                    <h1 style="color: orange;">Invalid Input</h1>
                    <p>Please provide both a valid Patient ID and a new Diagnosis.</p>
        <%
                }
            } else {
        %>
                <h1 style="color: orange;">No Input Provided</h1>
                <p>Please return to the form and provide valid inputs.</p>
        <%
            }
        %>
        <br>
        <a href="index.html">Return to Form</a>
    </body>
</html>
