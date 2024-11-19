-- CREATION OF RELATIONS

CREATE TABLE patient (
    patientID INT(4) NOT NULL,
    patientLastName VARCHAR(20) NOT NULL,
    patientFirstName VARCHAR(20) NOT NULL,
    age INT(3) NOT NULL,
    gender VARCHAR(6) NOT NULL,
    contactInformation VARCHAR(8) NOT NULL,
    dateOfBirth DATE NOT NULL,
    emergencyContact VARCHAR(8) NOT NULL,
    PRIMARY KEY (patientID)
);

CREATE TABLE doctor (
    doctorID INT(4) NOT NULL,
    doctorLastName VARCHAR(20) NOT NULL,
    doctorFirstName VARCHAR(20) NOT NULL,
    age INT(3) NOT NULL,
    gender VARCHAR(6) NOT NULL,
    consultationFee DECIMAL(6,2) NOT NULL,
	PRIMARY KEY (doctorID)
);

CREATE TABLE DoctorSpecializations (
    doctorID INT,
    specializationName VARCHAR(150) NOT NULL,
    PRIMARY KEY (doctorID, specializationName),   -- Composite primary key
    FOREIGN KEY (doctorID) REFERENCES doctor(doctorID)
);

CREATE TABLE MedicalRecordsStorage (
    recordID INT AUTO_INCREMENT PRIMARY KEY,
    patientID INT NOT NULL,
    doctorID INT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    treatmentPlan TEXT NOT NULL,
    dateOfRecord DATE NOT NULL,
	FOREIGN KEY (patientID) REFERENCES patient(patientID),
    FOREIGN KEY (doctorID) REFERENCES doctor(doctorID)
);

CREATE TABLE MedicationPrescription (
    prescriptionID INT AUTO_INCREMENT PRIMARY KEY, 
    patientID INT,
    doctorID INT,
    medicationName VARCHAR(255) NOT NULL, 
    dosage DECIMAL(10, 2) NOT NULL, 
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    FOREIGN KEY (patientID) REFERENCES patient(patientID),
    FOREIGN KEY (doctorID) REFERENCES doctor(doctorID)
);


CREATE TABLE Billed_Record_Management(
	billingID INT(3) PRIMARY KEY AUTO_INCREMENT NOT NULL,
	patientID INT,
	amountDue DECIMAL(10,2) NOT NULL,
	paymentStatus VARCHAR(10) NOT NULL,
	billingDate DATE NOT NULL,
	FOREIGN KEY (patientID) REFERENCES patient(patientID) 
    );

CREATE TABLE Billed_Services_Table (
    serviceID INT(1) PRIMARY KEY AUTO_INCREMENT NOT NULL,
    billingID INT,
    serviceName VARCHAR(50) NOT NULL,
    serviceAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (billingID) REFERENCES Billed_Record_Management(billingID)
);




-- INSERTING OF VALUES 

INSERT INTO patient (patientID, patientLastName, patientFirstName, age, gender, contactInformation, dateOfBirth, emergencyContact) VALUES
(1001,'Kim','Jong-In',30,'Male','09636691','1994-01-14','09853238'),
(1002,'Pascual','Harana',26,'Female','09548544','1998-03-15','09593816'),
(1003,'Garcia','Rafael',27,'Male','09633325','1997-07-09','09773416'),
(1004,'Aguilar','Sofia',15,'Female','09412553','2009-12-21','09491242'),
(1005,'Navarro','Emilio',63,'Male','09874521','1961-05-04','09588363'),
(1006,'Santos','Mateo',45,'Male','09632581','1979-11-18','09561097'),
(1007,'Magsaysay','Ramon',52,'Male','09636666','1972-02-27','09432580'),
(1008,'Ramon','Isabel',12,'Female','09855421','2012-08-13','09850162'),
(1009,'Dantes','Dingdong',42,'Male','09663524','1982-10-06','09132100'),
(1010,'Alonzo','Miguel',25,'Male','09324514','1999-04-22','09292882');

INSERT INTO doctor (doctorID, doctorLastName, doctorFirstName, age, gender, consultationFee) VALUES
(9901,'Ferrer','Lucia',46,'Female',1000.00),
(9902,'Vergara','Andres',45,'Male',800.00),
(9903,'Richards','Alden',36,'Male',700.00),
(9904,'Yulo','Carlos',34,'Male',700.00),
(9905,'Reyes','Inigo',50,'Male',800.00),
(9906,'Ong','Willie',65,'Male',1500.00),
(9907,'Tan','Diego',54,'Male', 900.00),
(9908,'Salazar','Elizabeth',54,'Female', 800.00),
(9909,'Gokongwei','John',73,'Male',1500.00),
(9910,'Gonzales','Andrea',68,'Female',1000.00);

-- INSERT doctorSpecializations

INSERT MedicalRecordsStorage (recordID, patientID, doctorID, diagnosis, treatmentPlan, dateOfRecord) VALUES
(1, 1001, 9901, 'Hypertension', 'Consultation, Blood Test, Chest X-Ray', '2024-09-24'),
(2, 1002, 9902, 'Type 2 Diabetes', 'General Health Checkup, Basic Laboratory Tests', '2024-10-11'),
(3, 1003, 9901, 'Migraine', 'Brain MRI Scan, Specialist Consultation', '2024-11-23'),
(4, 1004, 9903, 'Chronic Kidney Disease', 'Abdominal Ultrasound, Kidney Function Test, Follow-Up Consultation', '2024-08-15'),
(5, 1005, 9904, 'Musculoskeletal Pain', 'Physiotherapy Session, Prescription Medication, Therapy Follow-up Session', '2024-11-30'),
(6, 1006, 9905, 'COVID-19', 'COVID-19 Vaccination', '2024-08-16'),
(7, 1007, 9905, 'End-Stage Liver Disease', 'Liver Transplantation, Anesthesia Services, Post-Operative Monitoring', '2024-12-31'),
(8, 1008, 9902, 'Dental Issues', 'Dental Cleaning, Oral X-Ray', '2024-05-26'),
(9, 1009, 9907, 'Coronary Artery Disease', 'Cardiology Consultation, Electrocardiogram (ECG) Test, Comprehensive Blood Analysis', '2024-10-29'),
(10, 1010, 9908, 'Heart Failure', 'Heart Surgery, ICU Charges, Post-Surgical Follow-up Consultation', '2024-11-10');

-- INSERT medical prescriptions

INSERT INTO Billed_Record_Management
VALUES 
(101, 1001, 1300.50, 'Paid','2024-09-24'),
(NULL, 1002, 500, 'Not Paid','2024-010-11'),
(NULL, 1003, 1500, 'Not Paid','2024-11-23'),
(NULL, 1004, 1500.00, 'Paid', '2024-08-15'),
(NULL, 1005, 1200.75, 'Not Paid', '2024-11-30'),
(NULL, 1006, 200.00, 'Paid', '2024-10-05'),
(NULL, 1007, 10000.50, 'Not Paid', '2024-12-31'),
(NULL, 1008, 650.00, 'Paid', '2024-11-10'),
(NULL, 1009, 5000.00, 'Not Paid', '2024-11-01'),
(NULL, 1010, 15000.00, 'Paid', '2024-11-10');

INSERT INTO billed_services_table (serviceID, billingID, serviceName, serviceAmount)
VALUES
(1, 101, 'Consultation', 500.00),
(NULL, 101, 'Blood Test', 300.50),
(NULL, 101, 'Chest X-Ray', 500.00),
(NULL, 102, 'General Health Checkup', 300.00),
(NULL, 102, 'Basic Laboratory Tests', 200.00),
(NULL, 103, 'Brain MRI Scan', 1000.00),
(NULL, 103, 'Specialist Consultation', 500.00),
(NULL, 104, 'Abdominal Ultrasound', 750.00),
(NULL, 104, 'Kidney Function Test', 500.00),
(NULL, 104, 'Follow-up Consultation', 250.00),
(NULL, 105, 'Physiotherapy Session', 600.75),
(NULL, 105, 'Prescription Medication', 300.00),
(NULL, 105, 'Therapy Follow-up Session', 300.00),
(NULL, 106, 'COVID-19 Vaccination', 200.00),
(NULL, 107, 'Liver Transplantation', 8000.00),
(NULL, 107, 'Anesthesia Services', 1500.50),
(NULL, 107, 'Post-Operative Monitoring', 500.00),
(NULL, 108, 'Dental Cleaning', 400.00),
(NULL, 108, 'Oral X-Ray', 250.00),
(NULL, 109, 'Cardiology Consultation', 2000.00),
(NULL, 109, 'Electrocardiogram (ECG) Test', 1000.00),
(NULL, 109, 'Comprehensive Blood Analysis', 500.00),
(NULL, 109, 'Chronic Condition Medication', 1500.00),
(NULL, 110, 'Heart Surgery', 12000.00),
(NULL, 110, 'ICU Charges', 2000.00),
(NULL, 110, 'Post-Surgical Follow-up Consultation', 1000.00);