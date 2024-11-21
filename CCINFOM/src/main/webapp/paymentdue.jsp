<%-- 
    Document   : paymentdue
    Created on : Nov 20, 2024, 4:32:39 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, billing.paymentdue" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient's Due Date</title>
    </head>
    <body>
        <form action="index.html">
        <h1>Amount Due Date</h1>
           <jsp:useBean id="C" class="billing.paymentdue" scope="session"/>
           <% // INSERT JAVA HERE %>
           <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
