<%-- 
    Document   : updstatus
    Created on : Nov 20, 2024, 12:40:21 PM
    Author     : ADMIN
--%>


<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, billing.*" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Billing Records Management</title>
    </head>
    <body>
        <form action="index.html">
        <jsp:useBean id="A" class="billing.billings" scope="session"/> 

        <%
        String v_patientID = request.getParameter("patientID");
        
        if (v_patientID != null && !v_patientID.isEmpty()) {
            A.setPatientID(v_patientID);  // Set the patient ID in the billing bean
        
        int stat = A.updatePayStat();  // Call method to check payment status

        if (stat == 1) {
%>
            <h1>Payment Status</h1>
            <p>You have successfully paid.</p>
<%
        } else if (stat == 0) {
%>
            <h1>Payment Status</h1>
            <p>You have already paid.</p>
<%
        }
    } else {
%>
            <h1>Please enter a valid Patient ID.</h1>
<%
    }
%>          <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>

