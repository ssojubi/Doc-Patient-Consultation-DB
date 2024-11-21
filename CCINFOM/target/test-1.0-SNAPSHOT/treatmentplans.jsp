<%-- 
    Document   : treatmentplans
    Created on : Nov 20, 2024, 3:56:49 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, billing.treatmentplans" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Treatment Plans</title>
    </head>
    <body>
         <form action="index.html">
           <jsp:useBean id="B" class="billing.treatmentplans" scope="session"/>
           <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
