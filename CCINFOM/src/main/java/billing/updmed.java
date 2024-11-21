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
public class updmed {
    public String patientID;
    public String diagnosis;
    public java.sql.Date newDate;
    
    
    public String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
    public String dbuser = "root";
    public String dbpass = "chevyLUV0606??";
    
    public void setPatientID(String patientID){
        this.patientID = patientID;
    }
    
    public void setDiagnosis(String diagnosis){
        this.diagnosis = diagnosis;
    }
    
    
    public int updMedRec(){
        String query = "UPDATE MedicalRecordsStorage\n"
                + " SET diagnosis = ?, \n"
                + "dateOfRecord = CURRENT_DATE\n"
                + " WHERE patientID = ?;";

        try (
                Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass); 
                PreparedStatement pt = conn.prepareStatement(query)) {
            // Set parameter for the query
            pt.setString(1, diagnosis);
            pt.setString(2, patientID);
            // Execute query

        int upd = pt.executeUpdate(); //1 something is updated, 0 if not
        
            // Close resources
            pt.close();
            return 0; // Success
        } catch (SQLException e) {
            // Print stack trace for debugging
            e.printStackTrace();
            return 1; // Failure
        }
    }
    
    public static void main(String[] args) {
        updmed test = new updmed();
        test.setPatientID("1002");
        test.setDiagnosis("Type 2 Diabetes");
        
        int stat = test.updMedRec();
        if (stat == 0) {
            System.out.println("Diagnosis updated to: "+test.diagnosis);
        } else {
            System.out.println("An error occurred while retrieving treatment plans.");
        }
    }
}
