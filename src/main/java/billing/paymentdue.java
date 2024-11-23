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

public class paymentdue {
    public String patientID;
    public java.sql.Date due;
    
    public String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
    public String dbuser = "root";
    public String dbpass = "chevyLUV0606??";
    
    public void setPatientID(String patientID){
        this.patientID = patientID;
    }
    
    public int viewDue(){
        String query = "SELECT b.billingDate, m.patientID\n"
                +" FROM billed_record_management b JOIN  medicalrecordsstorage m\n"
                +" ON b.billingID=m.billingID\n"
                +" WHERE m.patientID = ?";

        try (Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass); 
            PreparedStatement pt = conn.prepareStatement(query)) {
            // Set parameter for the query
            pt.setString(1, patientID);

            // Execute query
            ResultSet rs = pt.executeQuery();

            // Iterate through the result set
            if (rs.next()) {
                // Assign patientID (if needed) and add service names to the list
                patientID = rs.getString("patientID");
                due = rs.getDate("billingDate");
            }

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
        paymentdue test = new paymentdue();
        test.setPatientID("1001");

        int stat = test.viewDue();
        if (stat == 0) {
            System.out.println("ID: " + test.patientID);
            System.out.println("Date Due: " + test.due);
        } else {
            System.out.println("An error occurred while retrieving treatment plans.");
        }
    }
}
