<%@ page import="billing.patient" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Information</title>
    </head>
    <body>
        <form action="index.html">
<jsp:useBean id="A" class="billing.patient" scope="session"/>

<%
    // Get the patient ID from the request parameter
    String v_patientID = request.getParameter("patient");

    if (v_patientID != null && !v_patientID.isEmpty()) {
        // Set the patient ID in the bean
        A.setPatientID(Integer.parseInt(v_patientID));
        
        // Call the method to fetch patient data
        int result = A.readPatient();

        if (result == 0) { // Success
%>
            <h2>Patient Details</h2>
            <table border="1">
                <tr>
                    <td>Patient ID</td>
                    <td><%= A.getPatientID() %></td>
                </tr>
                <tr>
                    <td>Last Name</td>
                    <td><%= A.getLastName() %></td>
                </tr>
                <tr>
                    <td>First Name</td>
                    <td><%= A.getFirstName() %></td>
                </tr>
                <tr>
                    <td>Age</td>
                    <td><%= A.getAge() %></td>
                </tr>
                <tr>
                    <td>Gender</td>
                    <td><%= A.getGender() %></td>
                </tr>
                <tr>
                    <td>Contact Information</td>
                    <td><%= A.getCInfo() %></td>
                </tr>
                <tr>
                    <td>Date of Birth</td>
                    <td><%= A.getBday() %></td>
                </tr>
                <tr>
                    <td>Emergency Contact</td>
                    <td><%= A.getECont() %></td>
                </tr>
            </table>
<%
        } else { // No patient found or error
%>
            <h2>No Patient Found</h2>
            <p>The record for Patient ID <%= v_patientID %> could not be found.</p>
<%
        } // End of result check
    } else { // If no patient ID provided
%>
        <h2>Invalid Patient ID</h2>
        <p>Please provide a valid Patient ID.</p>
<%
    } // End of patient ID check
%>
 <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
