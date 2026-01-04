-- =========================================
-- HOSPITAL MANAGEMENT SYSTEM - SQL PROJECT
-- =========================================

-- STEP 1: Create Database
CREATE DATABASE IF NOT EXISTS hospital_management;
USE hospital_management;

-- =========================================
-- STEP 2: Create Tables
-- =========================================

-- Doctor Table
CREATE TABLE doctor (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(50),
    phone VARCHAR(15)
);

-- Patient Table
CREATE TABLE patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    phone VARCHAR(15)
);

-- Appointment Table
CREATE TABLE appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id)
);

-- Treatment Table
CREATE TABLE treatment (
    treatment_id INT PRIMARY KEY,
    appointment_id INT,
    diagnosis VARCHAR(100),
    fees DECIMAL(10,2),
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
);

-- =========================================
-- STEP 3: Insert Sample Data
-- =========================================

-- Insert Doctors
INSERT INTO doctor VALUES
(1, 'Dr. Arun', 'Cardiology', '9876543210'),
(2, 'Dr. Meena', 'Dermatology', '9123456780'),
(3, 'Dr. Kumar', 'Orthopedics', '9988776655');

-- Insert Patients
INSERT INTO patient VALUES
(101, 'Ravi Kumar', 35, 'Male', '9000011111'),
(102, 'Anita Sharma', 28, 'Female', '9000022222'),
(103, 'Suresh Raj', 45, 'Male', '9000033333');

-- Insert Appointments
INSERT INTO appointment VALUES
(1001, 101, 1, '2024-01-10', 'Completed'),
(1002, 102, 2, '2024-01-12', 'Pending'),
(1003, 103, 3, '2024-01-15', 'Completed');

-- Insert Treatments
INSERT INTO treatment VALUES
(5001, 1001, 'Heart Checkup', 1500.00),
(5002, 1002, 'Skin Allergy', 800.00),
(5003, 1003, 'Knee Pain', 1200.00);

-- =========================================
-- STEP 4: BASIC QUERIES
-- =========================================

-- View all doctors
SELECT * FROM doctor;

-- View all patients
SELECT * FROM patient;

-- =========================================
-- STEP 5: JOINS
-- =========================================

-- Doctor-wise appointments
SELECT 
    d.doctor_name,
    p.patient_name,
    a.appointment_date,
    a.status
FROM appointment a
JOIN doctor d ON a.doctor_id = d.doctor_id
JOIN patient p ON a.patient_id = p.patient_id;

-- =========================================
-- STEP 6: AGGREGATE FUNCTIONS
-- =========================================

-- Total treatment fees collected
SELECT SUM(fees) AS total_fees_collected
FROM treatment;

-- Average treatment fee
SELECT AVG(fees) AS average_fee
FROM treatment;

-- =========================================
-- STEP 7: SUBQUERY
-- =========================================

-- Treatments with fees above average
SELECT diagnosis, fees
FROM treatment
WHERE fees > (SELECT AVG(fees) FROM treatment);

-- =========================================
-- STEP 8: FILTERING
-- =========================================

-- Patients with pending appointments
SELECT p.patient_name
FROM patient p
JOIN appointment a ON p.patient_id = a.patient_id
WHERE a.status = 'Pending';

-- =========================================
-- STEP 9: CREATE VIEW
-- =========================================

CREATE VIEW hospital_report AS
SELECT 
    p.patient_name,
    d.doctor_name,
    d.specialization,
    t.diagnosis,
    t.fees
FROM treatment t
JOIN appointment a ON t.appointment_id = a.appointment_id
JOIN patient p ON a.patient_id = p.patient_id
JOIN doctor d ON a.doctor_id = d.doctor_id;

-- View report
SELECT * FROM hospital_report;

-- =========================================
-- STEP 10: CREATE INDEX
-- =========================================

CREATE INDEX idx_treatment_fees ON treatment(fees);

-- =========================================
-- END OF PROJECT
-- =========================================
