package billing;
import java.util.*;
import java.sql.*; 
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Martina
 */
public class updmed {
    public String patientID;
    public String diagnosis;
    public String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
    public String dbuser = "root";
    public String dbpass = "chevyLUV0606??";
    

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public int updMedRec() {
        
        try {
        Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);
        PreparedStatement query = conn.prepareStatement(
                     "UPDATE medicalrecordsstorage "
                     + " SET diagnosis = ?, "
                     + " dateOfRecord = CURRENT_DATE "
                     + " WHERE patientID = ?");
        
            query.setString(1, diagnosis);
            query.setString(2, patientID);
            int upd = query.executeUpdate(); // 1 if updated, 0 if not
            
            query.close();
            return upd; 
        } catch (SQLException e) {
            e.printStackTrace();
            return 0; // Failure
        }
    }
}
