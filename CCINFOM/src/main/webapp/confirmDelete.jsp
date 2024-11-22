<%-- 
    Document   : confirmDelete
    Created on : Nov 22, 2024, 5:10:11?PM
    Author     : Guiller Fam
--%>

<%@ page import="java.sql.*" %>
<%
    String patientID = (String) request.getAttribute("patientID");
    String patientName = (String) request.getAttribute("patientName");
%>
    <h2>Delete Patient</h2>
    <p>Are you sure you want to delete the following patient?</p>
    <p>Patient ID: <%= patientID %></p>
    <p>Patient Name: <%= patientName %></p>
    <form action="deletePatient.jsp" method="post">
        <input type="hidden" name="patientID" value="<%= patientID %>">
        <button type="submit">Confirm Delete</button>
        <a href="deletePatient.html">Cancel</a>
    </form>

