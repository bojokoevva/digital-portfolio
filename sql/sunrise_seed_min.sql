INSERT INTO Department (Dept_ID, Dept_Name) VALUES
(1, 'Cardiology'),
(2, 'Radiology');
TRUNCATE TABLE Department RESTART IDENTITY CASCADE;
-- Departments
INSERT INTO Department (Dept_ID, Dept_Name) VALUES
(1, 'Cardiology'),
(2, 'Radiology');

-- Doctors
INSERT INTO Doctor (Doctor_ID, First_Name, Last_Name, Specialty, Dept_ID) VALUES
(1, 'Alice', 'Brown', 'Cardiologist', 1),
(2, 'Bob',   'Smith',  'Radiologist', 2);

-- Insurance plans
INSERT INTO InsurancePlan (InsurancePlan_ID, Plan_Name, Provider, Policy_Number) VALUES
(1, 'Basic Health', 'Sunrise Insurance', 'POL123'),
(2, 'Premium Plus', 'Sunrise Insurance', 'POL456');

-- Patients
INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Date_Of_Birth, Sex,
                     Phone, Email, InsurancePlan_ID)
VALUES
(1, 'Emma', 'Jones', '1990-05-10', 'F',
    '555-1111', 'emma@example.com', 1),
(2, 'Liam', 'Garcia', '1985-02-20', 'M',
    '555-2222', 'liam@example.com', NULL);

-- Diagnoses
INSERT INTO Diagnosis (Diagnosis_Code, Description) VALUES
('I10', 'Hypertension'),
('J20', 'Acute bronchitis');

-- Appointments
INSERT INTO Appointment (Appt_ID, Start_Time, Status, Duration_Min,
                         Patient_ID, Doctor_ID, Dept_ID)
VALUES
(1, '2025-01-10 09:00', 'Completed', 30, 1, 1, 1),
(2, '2025-01-11 10:00', 'Scheduled', NULL, 2, 2, 2);

-- Billing (только для завершённого приёма №1)
INSERT INTO Billing (Billing_ID, Total_Charge, Amount_Paid, Payer, Bill_Date, Appt_ID)
VALUES
(1, 200.00, 150.00, 'Insurance', '2025-01-15', 1);

-- Appointment_Diagnosis
INSERT INTO Appointment_Diagnosis (Appt_ID, Diagnosis_Code) VALUES
(1, 'I10'),
(1, 'J20');