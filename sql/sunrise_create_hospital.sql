-- Department
CREATE TABLE Department (
    Dept_ID      SERIAL PRIMARY KEY,
    Dept_Name    VARCHAR(100) NOT NULL UNIQUE
);

-- Doctor
CREATE TABLE Doctor (
    Doctor_ID    SERIAL PRIMARY KEY,
    First_Name   VARCHAR(50)  NOT NULL,
    Last_Name    VARCHAR(50)  NOT NULL,
    Specialty    VARCHAR(100),
    Dept_ID      INT          NOT NULL,
    CONSTRAINT fk_doctor_dept
        FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

-- InsurancePlan
CREATE TABLE InsurancePlan (
    InsurancePlan_ID  SERIAL PRIMARY KEY,
    Plan_Name         VARCHAR(100) NOT NULL,
    Provider          VARCHAR(100),
    Policy_Number     VARCHAR(50) UNIQUE
);

-- Patient
CREATE TABLE Patient (
    Patient_ID        SERIAL PRIMARY KEY,
    First_Name        VARCHAR(50)  NOT NULL,
    Last_Name         VARCHAR(50)  NOT NULL,
    Date_Of_Birth     DATE         NOT NULL,
    Sex               CHAR(1)      NOT NULL,
    Phone             VARCHAR(20),
    Email             VARCHAR(255),
    InsurancePlan_ID  INT,
    CONSTRAINT chk_patient_sex
        CHECK (Sex IN ('F','M','O')),
    CONSTRAINT fk_patient_insurance
        FOREIGN KEY (InsurancePlan_ID)
        REFERENCES InsurancePlan(InsurancePlan_ID)
);

-- Diagnosis
CREATE TABLE Diagnosis (
    Diagnosis_Code  VARCHAR(10)  PRIMARY KEY,
    Description     VARCHAR(255) NOT NULL
);

-- Appointment
CREATE TABLE Appointment (
    Appt_ID      SERIAL PRIMARY KEY,
    Start_Time   TIMESTAMP   NOT NULL,
    Status       VARCHAR(12) NOT NULL,
    Duration_Min INT,
    Patient_ID   INT         NOT NULL,
    Doctor_ID    INT         NOT NULL,
    Dept_ID      INT         NOT NULL,
    CONSTRAINT chk_appt_status
        CHECK (Status IN ('Scheduled','Completed','No-Show','Cancelled')),
    CONSTRAINT fk_appt_patient
        FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    CONSTRAINT fk_appt_doctor
        FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    CONSTRAINT fk_appt_dept
        FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID)
);

-- Appointment_Diagnosis (link table)
CREATE TABLE Appointment_Diagnosis (
    Appt_ID        INT  NOT NULL,
    Diagnosis_Code VARCHAR(10) NOT NULL,
    CONSTRAINT pk_app_diag
        PRIMARY KEY (Appt_ID, Diagnosis_Code),
    CONSTRAINT fk_appdiag_appt
        FOREIGN KEY (Appt_ID) REFERENCES Appointment(Appt_ID),
    CONSTRAINT fk_appdiag_diag
        FOREIGN KEY (Diagnosis_Code) REFERENCES Diagnosis(Diagnosis_Code)
);

-- Billing
CREATE TABLE Billing (
    Billing_ID   SERIAL PRIMARY KEY,
    Total_Charge NUMERIC(10,2) NOT NULL,
    Amount_Paid  NUMERIC(10,2) NOT NULL,
    Payer        VARCHAR(100)  NOT NULL,
    Bill_Date    DATE          NOT NULL,
    Appt_ID      INT           NOT NULL UNIQUE,
    CONSTRAINT fk_billing_appt
        FOREIGN KEY (Appt_ID) REFERENCES Appointment(Appt_ID),
    CONSTRAINT chk_billing_amounts
        CHECK (Total_Charge >= 0 AND Amount_Paid >= 0)
);
