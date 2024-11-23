package billing;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author ADMIN
 */

import java.util.*;
import java.sql.*;

public class IEpatient {

    public int patientID, age;
    public java.sql.Date bday;
    public String pLast, pFirst, gender, cInfo, eInfo, id;
    public String dburl = "jdbc:mysql://localhost:3306/doctor-patient-consultation";
    public String dbuser = "root";
    public String dbpass = "chevyLUV0606??";

    public int getPatientID() {
        return patientID;
    }

    public void setPatientID(int patientID) {
        this.patientID = patientID;
    }

    public String getLastName() {
        return pLast;
    }

    public void setLastName(String lastName) {
        this.pLast = lastName;
    }

    public String getFirstName() {
        return pFirst;
    }

    public void setFirstName(String firstName) {
        this.pFirst = firstName;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getCInfo() {
        return cInfo;
    }

    public void setCInfo(String contactInformation) {
        this.cInfo = contactInformation;
    }

    public java.sql.Date getBday() {
        return bday;
    }

    public void setBday(java.sql.Date dateOfBirth) {
        this.bday = dateOfBirth;
    }

    public String getECont() {
        return eInfo;
    }

    public void setECont(String emergencyContact) {
        this.eInfo = emergencyContact;
    }

    public int readPatient() {
        String query = "SELECT * FROM patient WHERE patientID = ?";
        try (Connection conn = DriverManager.getConnection(dburl, dbuser, dbpass);
                PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, patientID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    setLastName(rs.getString("patientLastName"));
                    setFirstName(rs.getString("patientFirstName"));
                    setAge(rs.getInt("age"));
                    setGender(rs.getString("gender"));
                    setCInfo(rs.getString("contactInformation"));
                    setBday(rs.getDate("dateOfBirth"));
                    setECont(rs.getString("emergencyContact"));
                    
                    return 0; // Success
                } else {
                    System.out.println("No record found for Patient ID: " + patientID);
                    return 1; // No patient found
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return 1; // Error occurred while fetching data
        }
    }
}

   /*
    public static void main(String[] args) {
        patient test = new patient();
        test.setPatientID("1001");
        test.readPatient();
        
        System.out.println(test.patientID);
        System.out.println(test.pLast);
        System.out.println(test.pFirst);
        System.out.println(test.age);
        System.out.println(test.cInfo);
        System.out.println(test.bday);
        System.out.println(test.eInfo);
        
    }
}





                patientID = rs.getInt("patientID");
                pLast = rs.getString("patientLastName");
                pFirst = rs.getString("patientFirstName");
                age = rs.getInt("age");
                gender = rs.getString("gender");
                cInfo = rs.getString("contactInformation");
                bday = rs.getDate("dateOfBirth");
                eInfo = rs.getString("emergencyContact");


//          setPatientID(rs.getInt("patientID"));
            setLastName(rs.getString("patientLastName"));
            setFirstName(rs.getString("patientFirstName"));
            setAge(rs.getInt("age"));
            setGender(rs.getString("gender"));
            setCInfo(rs.getString("contactInformation"));
            setBday(rs.getDate("dateOfBirth"));
            setECont(rs.getString("emergencyContact"));
*/