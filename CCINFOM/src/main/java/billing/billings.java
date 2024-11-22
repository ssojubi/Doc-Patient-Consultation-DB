package billing;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/***
 * @author Martina
 */
import java.util.*;
import java.sql.*;
 
public class billings {
    //add variables for billing
    public int patientID;
    public String dburl="jdbc:mysql://localhost:3306/doctor-patient-consultation";
    public String dbuser="root";
    public String dbpass="chevyLUV0606??";
    
    public void setPatientID(String patientID){
        this.patientID = Integer.parseInt(patientID);
    }
   public int updatePayStat() {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);
        PreparedStatement query = conn.prepareStatement(
            "UPDATE billed_record_management " +
            "SET paymentStatus = 'Not Paid' " +
            "WHERE patientID = ? AND paymentStatus = 'Paid';"
        );
        query.setInt(1, patientID);
        int upd = query.executeUpdate(); //1 something is updated, 0 if not
        
        query.close();
        conn.close();
        return upd;//determines if something was changed in the database
    } catch (Exception e) {
        e.printStackTrace();
        return 0;
        }
    }
}