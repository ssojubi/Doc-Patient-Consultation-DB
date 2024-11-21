<%-- 
    Document   : patientrec
    Created on : Nov 20, 2024, 4:54:04 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, billing.patientrec" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Amount Due</title>
    </head>
    <body>
        <form action="index.html">
        <jsp:useBean id="D" class="billing.patientrec" scope="session"/> 

        <%
            String v_patientID = request.getParameter("patientID"); //gets the input from user in HTML
            String v_newAmount = request.getParameter("amount");
            float f_newAmount = Float.parseFloat(v_newAmount);
            int stat;
            
            if (v_patientID != null && !v_patientID.isEmpty() || (v_newAmount != null && !v_newAmount.isEmpty())) {
                D.setPatientID(v_patientID);  // Set the patient ID in the billing bean
                D.setNewAmount(f_newAmount);
                
                stat = D.updateAmount();  // call method to change amount due

                if (stat == 0) {
        %>
            <h1>Amount Updated</h1>
            <p>You have successfully changed the value to <%= D.getAmount() %>.</p>
        <%
        } else if (stat == 1) {%>
        
            <h1>Payment Status</h1>
            <p>You have already paid.</p>
        <%
        }
            } else {
        %>
            <h1>Please enter a valid Patient ID.</h1>
        <%
            }
        %>          
            <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
