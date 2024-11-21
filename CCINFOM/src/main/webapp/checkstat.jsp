<%-- 
    Document   : checkstat
    Created on : Nov 20, 2024, 7:13:07 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, billing.checkstat" %>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Payment Status</title>
    </head>
    <body>
        <h1>Payment Status</h1>
        <form action="index.html">
           <jsp:useBean id="B" class="billing.checkstat" scope="session"/>
           <input type="submit" value="Return to Menu">
        </form>
    </body>
</html>
