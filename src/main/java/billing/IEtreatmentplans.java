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
public class IEtreatmentplans {
    public String patientID;
    public ArrayList<String> serviceName = new ArrayList<>();
    
    public String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
    public String dbuser = "root";
    public String dbpass = "chevyLUV0606??";
    
    public void setPatientID(String patientID){
        this.patientID = patientID;
    }
    
    public int viewPlans() {
        String query = "SELECT p.patientID, b.serviceName"
                +" FROM medicalrecordsstorage p"
                +" JOIN billed_record_management r ON p.billingID = r.billingID"
                +" JOIN billed_services_table b ON r.billingID = b.billingID"
                +" WHERE p.patientID = ?";

        try (
                Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass); 
                PreparedStatement pt = conn.prepareStatement(query)) {
            // Set parameter for the query
            pt.setString(1, patientID);

            // Execute query
            ResultSet rs = pt.executeQuery();

            // Clear the list before populating it with new data
            serviceName.clear();

            // Iterate through the result set
            while (rs.next()) {
                // Assign patientID (if needed) and add service names to the list
                patientID = rs.getString("patientID");
                String service = rs.getString("serviceName");
                serviceName.add(service);
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
        IEtreatmentplans test = new IEtreatmentplans();
        test.setPatientID("1001");

        int stat = test.viewPlans();
        if (stat == 0) {
            System.out.println("ID: " + test.patientID);
            for (String service : test.serviceName) {
                System.out.println("Service Name: " + service);
            }
        } else {
            System.out.println("An error occurred while retrieving treatment plans.");
        }
    }
}


