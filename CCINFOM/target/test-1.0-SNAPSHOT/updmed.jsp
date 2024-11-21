<%-- 
    Document   : updmed
    Created on : Nov 20, 2024, 7:48:34 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, billing.updmed" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Patient Record</title>
    </head>
    <body>
        <h1>Patient Record Update</h1>
        <form action="index.html">
           <jsp:useBean id="B" class="billing.updmed" scope="session"/>
           <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
