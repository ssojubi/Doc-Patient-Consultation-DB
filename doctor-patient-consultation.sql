-- CREATION OF RELATIONS

CREATE TABLE patient (
    patientID INT NOT NULL,
    patientLastName VARCHAR(20) NOT NULL,
    patientFirstName VARCHAR(20) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(6) NOT NULL,
    contactInformation VARCHAR(8) NOT NULL,
    dateOfBirth DATE NOT NULL,
    emergencyContact VARCHAR(8) NOT NULL,
    PRIMARY KEY (patientID)
);

CREATE TABLE doctor (
    doctorID INT NOT NULL,
    doctorLastName VARCHAR(20) NOT NULL,
    doctorFirstName VARCHAR(20) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(6) NOT NULL,
    consultationFee DECIMAL(6,2) NOT NULL,
    PRIMARY KEY (doctorID)
);

CREATE TABLE DoctorSpecializations (
    doctorID INT,
    specializationName VARCHAR(150) NOT NULL,
    PRIMARY KEY (doctorID, specializationName) ,   -- Composite primary key
    FOREIGN KEY (doctorID) REFERENCES doctor(doctorID) ON DELETE CASCADE
);


CREATE TABLE MedicationPrescription (
    prescriptionID INT AUTO_INCREMENT PRIMARY KEY, 
    patientID INT,
    doctorID INT,
    medicationName VARCHAR(255) NOT NULL, 
    dosage DECIMAL(10, 2) NOT NULL, 
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    FOREIGN KEY (patientID) REFERENCES patient(patientID)ON DELETE CASCADE,
    FOREIGN KEY (doctorID) REFERENCES doctor(doctorID) ON DELETE CASCADE
);


CREATE TABLE Billed_Record_Management(
	billingID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	patientID INT,
	amountDue DECIMAL(10,2) NOT NULL,
	paymentStatus VARCHAR(10) NOT NULL,
	billingDate DATE NOT NULL,
	FOREIGN KEY (patientID) REFERENCES patient(patientID) ON DELETE CASCADE
    );

CREATE TABLE Billed_Services_Table (
    serviceID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    billingID INT,
    serviceName VARCHAR(50) NOT NULL,
    serviceAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (billingID) REFERENCES Billed_Record_Management(billingID) ON DELETE CASCADE
);


CREATE TABLE MedicalRecordsStorage (
    recordID INT AUTO_INCREMENT PRIMARY KEY,
    patientID INT NOT NULL,
    doctorID INT NOT NULL,
    billingID INT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    dateOfRecord DATE NOT NULL,
    FOREIGN KEY (patientID) REFERENCES patient(patientID) ON DELETE CASCADE,
    FOREIGN KEY (doctorID) REFERENCES doctor(doctorID) ON DELETE CASCADE,
    FOREIGN KEY (billingID) REFERENCES billed_record_management(billingID) ON DELETE CASCADE
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

INSERT INTO DoctorSpecializations(doctorID, specializationName) VALUES 
(9901,'Pediatrics'),
(9902,'General Surgery'),
(9903,'Cardiology'),
(9904,'Radiation Oncology'),
(9905,'Gastroenterology'),
(9906,'Internal Medicine'),
(9906,'Endocrinology'),
(9907,'Psychiatry'),
(9908,'Neurology'),
(9909,'Cardiology'),
(9909,'Internal Medicine'),
(9910,'Dermatology'),
(9910,'Family Medicine');


INSERT INTO MedicationPrescription (patientID, doctorID, medicationName, dosage, startDate, endDate) VALUES
(1001, 9901, 'Lisinopril', 10.00, '2024-09-24', '2024-12-24'),
(1002, 9902, 'Metformin', 500.00, '2024-10-11', '2025-10-11'),
(1003, 9901, 'Sumatriptan', 50.00, '2024-11-23', '2024-12-23'),
(1004, 9903, 'Erythropoietin', 300.00,  '2024-08-15', '2025-08-15'),
(1005, 9904, 'Ibuprofen', 400.00, '2024-11-30', '2025-01-30'),
(1006, 9905, 'Paracetamol', 500.00, '2024-08-16', '2024-09-16'),
(1007, 9905, 'Sofosbuvir', 400.00, '2024-12-31', '2025-12-31'),
(1008, 9902, 'Amoxycillin', 500.00, '2024-05-26', '2024-06-26'),
(1009, 9907, 'Aspirin', 100.00, '2024-10-29', '2025-10-29'),
(1010, 9908, 'Furosemide', 40.00, '2024-11-10', '2025-11-10');

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

INSERT INTO billed_services_table (serviceID, billingID, serviceName, serviceAmount) VALUES
(1, 101, 'Consultation', 500.00),
(2, 101, 'Blood Test', 400.25),
(3, 101, 'Chest X-Ray', 400.25),
(4, 102, 'General Health Checkup', 300.00),
(5, 102, 'Basic Laboratory Tests', 200.00),
(6, 103, 'Brain MRI Scan', 1200.00),
(7, 103, 'Specialist Consultation', 300.00),
(8, 104, 'Abdominal Ultrasound', 600.00),
(9, 104, 'Kidney Function Test', 500.00),
(10, 104, 'Follow-Up Consultation', 400.00),
(11, 105, 'Physiotherapy Session', 500.25),
(12, 105, 'Prescription Medication', 350.25),
(13, 105, 'Therapy Follow-up Session', 350.25),
(14, 106, 'COVID-19 Vaccination', 200.00),
(15, 107, 'Liver Transplantation', 8000.00),
(16, 107, 'Anesthesia Services', 1500.25),
(17, 107, 'Post-Operative Monitoring', 500.25),
(18, 108, 'Dental Cleaning', 300.00),
(19, 108, 'Oral X-Ray', 350.00),
(20, 109, 'Cardiology Consultation', 2000.00),
(21, 109, 'Electrocardiogram (ECG) Test', 1500.00),
(22, 109, 'Comprehensive Blood Analysis', 1500.00),
(23, 110, 'Heart Surgery', 12000.00),
(24, 110, 'ICU Charges', 2000.00),
(25, 110, 'Post-Surgical Follow-up Consultation', 1000.00);

INSERT MedicalRecordsStorage (recordID, patientID, doctorID, diagnosis, dateOfRecord, billingID) VALUES
(1, 1001, 9901, 'Hypertension', '2024-09-24', 101),
(2, 1002, 9902, 'Type 2 Diabetes', '2024-10-11', 102),
(3, 1003, 9901, 'Migraine', '2024-11-23', 103),
(4, 1004, 9903, 'Chronic Kidney Disease', '2024-08-15', 104),
(5, 1005, 9904, 'Musculoskeletal Pain',  '2024-11-30', 105),
(6, 1006, 9905, 'COVID-19', '2024-08-16', 106),
(7, 1007, 9905, 'End-Stage Liver Disease', '2024-12-31', 107),
(8, 1008, 9902, 'Dental Issues', '2024-05-26', 108),
(9, 1009, 9907, 'Coronary Artery Disease', '2024-10-29', 109),
(10, 1010, 9908, 'Heart Failure', '2024-11-10', 110);





