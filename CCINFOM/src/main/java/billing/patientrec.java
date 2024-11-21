package billing;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author ADMIN
 */
public class patientrec {
    public String patientID;
    public float amount;
    public String dburl="jdbc:mysql://localhost:3306/doctor-patient-consultation";
    public String dbuser="root";
    public String dbpass="chevyLUV0606??";
    
    public void setPatientID(String patientID){
        this.patientID = patientID;
    }
    
    public void setNewAmount(float amount){
        this.amount = amount;
    }
    
    public float getAmount(){
        return this.amount;
    }
     
    public int updateAmount() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);
            PreparedStatement query = conn.prepareStatement(
                "UPDATE billed_record_management\n"
                + "SET amountDue = ?\n"
                + "WHERE patientID = ?;"
            );
            query.setFloat(1,amount);
            query.setString(2, patientID);
            
            int upd = query.executeUpdate(); //1 something is updated, 0 if not
                
            query.close();
            conn.close();
            return 0;//determines if something was changed in the database
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
            }
    }
    /*
    public static void main(String[] args) {
        patientrec test = new patientrec();
        test.setPatientID("1002");
        test.setNewAmount(500.00F);
        int stat = test.updateAmount();
        if (stat == 0) {
            System.out.println("ID: " + test.patientID);
            System.out.println("New Amount: " + test.amount);
        } else if(stat==1){
            System.out.println("An error occurred while retrieving treatment plans.");
        }
    }*/
}
