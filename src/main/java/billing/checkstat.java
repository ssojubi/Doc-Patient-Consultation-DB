package billing;
import java.util.*;
import java.sql.*; 

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author ADMIN
 */
public class checkstat {
    public String billingID;
    public String status;
    
    public String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
    public String dbuser = "root";
    public String dbpass = "chevyLUV0606??";
    
    public void setBillingID(String billingID){
        this.billingID = billingID;
    }
    
    public int check(){
        String query = "SELECT billingID, paymentStatus\n"
                + " FROM billed_record_management\n"
                + " WHERE paymentStatus = 'Paid' AND billingID = ?;";

        try (Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass); 
            PreparedStatement pt = conn.prepareStatement(query)) {
            // Set parameter for the query
            pt.setString(1, billingID);

            // Execute query
            ResultSet rs = pt.executeQuery();

            // Iterate through the result set
            if (rs.next()) {
                // Assign patientID (if needed) and add service names to the list
                billingID = rs.getString("billingID");
                status = rs.getString("paymentStatus");
            }
                System.out.println("Billing ID :"+ billingID);
                System.out.println("Status :"+ status);
            // Close resources
            rs.close();
            return 0; // Success
        } catch (SQLException e) {
            // Print stack trace for debugging
            e.printStackTrace();
            return 1; // Failure
        }
    }
    
    public static void main(String[] args) {
        checkstat test = new checkstat();
        test.setBillingID("101");
            
        int stat = test.check();
        if (test.status.equals("Paid")) {
            System.out.println("Billing ID "+test.billingID+"'s status is "+test.status);
        } else {
            System.out.println("An error occurred while retrieving check .");
        }
    }
           
}

