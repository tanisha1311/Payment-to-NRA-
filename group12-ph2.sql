-- DDL STATEMENTS

CREATE DATABASE NonResidentAlienPaymentSystem;
USE NonResidentAlienPaymentSystem;
 
BEGIN;
 
-- Table: Department
CREATE TABLE Department (
    Dept_Id INT PRIMARY KEY,
    Dept_Name VARCHAR(100),
    Dept_Location VARCHAR(100)
);
 
-- Table: DepartmentAdmin
CREATE TABLE DepartmentAdmin (
    Admin_Id INT PRIMARY KEY,
    Admin_Name VARCHAR(100),
    Dept_Id INT,
    FOREIGN KEY (Dept_Id) REFERENCES Department (Dept_Id)
);
 
-- Table: TaxTreaty
CREATE TABLE TaxTreaty (
    Tax_Treaty_Id INT PRIMARY KEY,
    Country_of_Treaty VARCHAR(100),
    Visa_Type VARCHAR(50),
    Withholding_Rate DECIMAL(4, 2),
    Form_8233_Required BOOLEAN
);
 
-- Table: NonResidentAlien
CREATE TABLE NonResidentAlien (
    NRA_Id INT PRIMARY KEY,
    SSN VARCHAR(20) UNIQUE,
    is_SSN_Temp BOOLEAN,
    Tax_Treaty_Id INT,
    First_Name VARCHAR(100) NOT NULL,
    Middle_Name VARCHAR(100),
    Last_Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    Birthdate DATE,
    Passport_No VARCHAR(50),
    I_94_Status VARCHAR(50),
    Visa_Number VARCHAR(50) UNIQUE,
    Visa_Type VARCHAR(50),
    Visa_Expiration_date DATE,
    Nationality VARCHAR(50),
    FOREIGN KEY (Tax_Treaty_Id) REFERENCES TaxTreaty (Tax_Treaty_Id)
);
 
-- Table: Payment
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Payee_Id INT,
    Approver_Id INT,
    Payment_Date DATE,
    Gross_Pay DECIMAL(10, 2),
    Net_Pay DECIMAL(10, 2),
    Deductions DECIMAL(10, 2),
    Payment_Type VARCHAR(50),
    Account_No VARCHAR(50),
    Routing_No VARCHAR(50),
    FOREIGN KEY (Payee_Id) REFERENCES NonResidentAlien (NRA_Id),
    FOREIGN KEY (Approver_Id) REFERENCES DepartmentAdmin (Admin_Id)
);
 
 -- Table: Document
CREATE TABLE Document (
    Document_Number INT,
    NRA_Id INT,
    Document_Type VARCHAR(100),
    `Description` TEXT,
    Issue_Date DATE,
	PRIMARY KEY (Document_Number, Document_Type),
    FOREIGN KEY (NRA_Id) REFERENCES NonResidentAlien (NRA_Id)
);
 
-- Table: TaxDocument
CREATE TABLE TaxDocument (
    Document_Number INT,
    Payment_ID INT,
    Document_Type VARCHAR(100),
    `Description` TEXT,
    Issue_Date DATE,
    PRIMARY KEY (Document_Number, Document_Type),
    FOREIGN KEY (Payment_ID) REFERENCES Payment (Payment_ID)
);
 
-- Many to Many Relationship
CREATE TABLE PartOf (
    NRA_ID INT,
    Dept_ID INT,
    PRIMARY KEY (NRA_ID , Dept_ID),
    FOREIGN KEY (NRA_ID) REFERENCES NonResidentAlien (NRA_ID),
    FOREIGN KEY (Dept_ID) REFERENCES Department (Dept_ID)
);


-- DML STATEMENTS
 
-- Insert data into Department table
INSERT INTO Department (Dept_ID, Dept_Name, Dept_Location) VALUES 
	(1, 'Human Resources', 'Building A'),
	(2, 'Finance', 'Building B'),
	(3, 'Research', 'Building C'),
	(4, 'IT', 'Building D'),
	(5, 'Administration', 'Building E');
 
-- Insert data into DepartmentAdmin table
INSERT INTO DepartmentAdmin (Admin_Id, Admin_Name, Dept_Id) VALUES 
	(1, 'Alice Johnson', 1),
	(2, 'Bob Smith', 2),
	(3, 'Catherine Green', 3),
	(4, 'Daniel Brown', 4),
	(5, 'Eva White', 5),
	(6, 'Adam Smith', 5);
 
-- Insert data into TaxTreaty table
INSERT INTO TaxTreaty (Tax_Treaty_Id, Country_of_Treaty, Visa_Type, Withholding_Rate, Form_8233_Required) VALUES 
	(1, 'Canada', 'J-1', 10.00, TRUE),
	(2, 'India', 'F-1', 15.00, TRUE),
	(3, 'China', 'H-1B', 20.00, FALSE),
	(4, 'Germany', 'O-1', 12.50, TRUE),
	(5, 'Australia', 'L-1', 18.00, FALSE);
 
-- Insert data into NonResidentAlien table
INSERT INTO NonResidentAlien (NRA_Id, SSN, is_SSN_Temp, Tax_Treaty_Id, First_Name, Middle_Name, Last_Name, Gender, Birthdate, Passport_No, I_94_Status, Visa_Number, Visa_Type, Visa_Expiration_date, Nationality) VALUES 
	(1, '123-45-6789', FALSE, 1, 'John', 'A', 'Doe', 'Male', '1985-05-15', 'P1234567', 'Valid', 'V12345', 'J-1', '2025-05-15', 'Canadian'),
	(2, '234-56-7890', TRUE, 2, 'Priya', 'K', 'Sharma', 'Female', '1990-08-10', 'P2345678', 'Valid', 'V23456', 'F-1', '2026-08-10', 'Indian'),
	(3, '345-67-8901', FALSE, 3, 'Wei', NULL, 'Zhang', 'Male', '1992-09-21', 'P3456789', 'Valid', 'V34567', 'H-1B', '2024-09-21', 'Chinese'),
	(4, '456-78-9012', TRUE, 4, 'Hans', NULL, 'Muller', 'Male', '1988-01-02', 'P4567890', 'Expired', 'V45678', 'O-1', '2023-01-02', 'German'),
	(5, '567-89-0123', FALSE, 5, 'Emily', 'R', 'Taylor', 'Female', '1995-12-12', 'P5678901', 'Valid', 'V56789', 'L-1', '2027-12-12', 'Australian'),
	(6, '678-90-1234', FALSE, 1, 'Michael', 'L', 'Brown', 'Male', '1990-03-05', 'P6789012', 'Valid', 'V67890', 'J-1', '2025-03-05', 'Canadian'),
	(7, '789-01-2345', TRUE, 2, 'Sunita', NULL, 'Patel', 'Female', '1991-04-10', 'P7890123', 'Valid', 'V78901', 'F-1', '2026-04-10', 'Indian'),
	(8, '890-12-3456', FALSE, 3, 'Li', 'X', 'Wang', 'Male', '1989-07-22', 'P8901234', 'Valid', 'V89012', 'H-1B', '2024-07-22', 'Chinese'),
	(9, '901-23-4567', TRUE, 4, 'Alex', 'B', 'Schmidt', 'Male', '1987-11-13', 'P9012345', 'Valid', 'V91123', 'O-1', '2023-11-13', 'German'),
	(10, '012-34-5678', FALSE, 5, 'Olivia', NULL, 'Martinez', 'Female', '1992-09-15', 'P0123456', 'Valid', 'V01134', 'L-1', '2027-09-15', 'Australian'),
	(11, '123-45-6780', TRUE, 1, 'David', 'J', 'O\'Connor', 'Male', '1990-02-18', 'P2345671', 'Valid', 'V84567', 'J-1', '2025-02-18', 'Canadian'),
	(12, '234-56-7891', FALSE, 2, 'Sophia', NULL, 'Li', 'Female', '1995-04-20', 'P6789013', 'Valid', 'V75678', 'F-1', '2026-04-20', 'Chinese'),
	(13, '345-67-8902', FALSE, NULL, 'Carlos', 'R', 'Garcia', 'Male', '1994-12-10', 'P7890124', 'Valid', 'V96789', 'H-1B', '2024-12-10', 'Mexican'),
	(14, '456-78-9013', TRUE, NULL, 'Lisa', 'M', 'Kim', 'Female', '1993-01-25', 'P8901235', 'Valid', 'V66890', 'O-1', '2023-01-25', 'South Korean'),
	(15, '567-89-0124', FALSE, 5, 'Anthony', NULL, 'Jones', 'Male', '1996-08-30', 'P9012346', 'Valid', 'V71901', 'L-1', '2027-08-30', 'Australian'),
	(16, '678-90-1235', TRUE, NULL, 'Rachel', 'A', 'Nguyen', 'Female', '1989-06-15', 'P0123457', 'Expired', 'V89212', 'J-1', '2022-06-15', 'Vietnamese'),
	(17, '789-01-2346', FALSE, NULL, 'Eric', 'H', 'Smith', 'Male', '1988-10-02', 'P1234568', 'Valid', 'V90523', 'F-1', '2026-10-02', 'British'),
	(18, '890-12-3457', TRUE, NULL, 'Ananya', NULL, 'Desai', 'Female', '1995-11-17', 'P2345679', 'Valid', 'V01276', 'H-1B', '2025-11-17', 'Indian'),
	(19, '901-23-4568', FALSE, NULL, 'Jorge', 'L', 'Hernandez', 'Male', '1991-07-19', 'P3456780', 'Valid', 'V12447', 'O-1', '2024-07-19', 'Colombian'),
	(20, '012-34-5679', TRUE, NULL, 'Emma', 'T', 'Lee', 'Female', '1993-09-03', 'P4567891', 'Valid', 'V24459', 'L-1', '2027-09-03', 'New Zealander');

-- Insert data into Payments table
INSERT INTO Payment (Payment_ID, Payee_Id, Approver_Id, Payment_Date, Gross_Pay, Net_Pay, Deductions, Payment_Type, Account_No, Routing_No) VALUES
	(1, 1, 1, '2023-06-15', 5000.00, 4500.00, 500.00, 'Service', 'ACC12345', 'ROUT1234'),
	(2, 2, 2, '2023-07-20', 3000.00, 2500.00, 500.00, 'Non-Service', 'ACC23456', 'ROUT2345'),
	(3, 3, 3, '2023-08-12', 2000.00, 1700.00, 300.00, 'Awards', 'ACC34567', 'ROUT3456'),
	(4, 4, 4, '2023-09-05', 4500.00, 4000.00, 500.00, 'Guest Expenses', 'ACC45678', 'ROUT4567'),
	(5, 5, 5, '2023-09-15', 2800.00, 2400.00, 400.00, 'Service', 'ACC56789', 'ROUT5678'),
	(6, 6, 1, '2023-10-10', 3200.00, 2900.00, 300.00, 'Non-Service', 'ACC67890', 'ROUT6789'),
	(7, 7, 2, '2023-11-01', 2200.00, 2000.00, 200.00, 'Awards', 'ACC78901', 'ROUT7890'),
	(8, 8, 3, '2023-11-22', 4100.00, 3800.00, 300.00, 'Guest Expenses', 'ACC89012', 'ROUT8901'),
	(9, 9, 4, '2023-12-05', 1900.00, 1600.00, 300.00, 'Service', 'ACC90123', 'ROUT9012'),
	(10, 10, 5, '2023-01-10', 3400.00, 3000.00, 400.00, 'Non-Service', 'ACC01234', 'ROUT0123'),
	(11, 1, 2, '2023-02-14', 4600.00, 4100.00, 500.00, 'Awards', 'ACC12346', 'ROUT1235'),
	(12, 2, 3, '2023-02-25', 2600.00, 2300.00, 300.00, 'Guest Expenses', 'ACC23457', 'ROUT2346'),
	(13, 3, 4, '2023-03-12', 2900.00, 2500.00, 400.00, 'Service', 'ACC34568', 'ROUT3457'),
	(14, 4, 5, '2023-03-25', 3700.00, 3300.00, 400.00, 'Non-Service', 'ACC45679', 'ROUT4568'),
	(15, 5, 1, '2023-04-05', 3300.00, 3000.00, 300.00, 'Awards', 'ACC56780', 'ROUT5679'),
	(16, 6, 2, '2023-04-22', 2800.00, 2400.00, 400.00, 'Guest Expenses', 'ACC67881', 'ROUT6780'),
	(17, 7, 3, '2023-05-10', 3200.00, 2900.00, 300.00, 'Service', 'ACC78982', 'ROUT7891'),
	(18, 8, 4, '2023-05-25', 3700.00, 3400.00, 300.00, 'Non-Service', 'ACC89083', 'ROUT8902'),
	(19, 9, 5, '2023-06-05', 4300.00, 3900.00, 400.00, 'Awards', 'ACC90184', 'ROUT9013'),
	(20, 10, 1, '2023-06-15', 2700.00, 2400.00, 300.00, 'Guest Expenses', 'ACC01235', 'ROUT0124'),
	(21, 1, 3, '2023-06-25', 2500.00, 2200.00, 300.00, 'Service', 'ACC12347', 'ROUT1236'),
	(22, 2, 4, '2023-07-10', 4000.00, 3600.00, 400.00, 'Non-Service', 'ACC23458', 'ROUT2347'),
	(23, 3, 5, '2023-07-20', 3000.00, 2700.00, 300.00, 'Awards', 'ACC34569', 'ROUT3458'),
	(24, 4, 1, '2023-08-05', 3700.00, 3400.00, 300.00, 'Guest Expenses', 'ACC45680', 'ROUT4569'),
	(25, 5, 2, '2023-08-15', 2200.00, 2000.00, 200.00, 'Service', 'ACC56781', 'ROUT5670'),
	(26, 6, 3, '2023-08-22', 2800.00, 2500.00, 300.00, 'Non-Service', 'ACC67882', 'ROUT6781'),
	(27, 7, 4, '2023-09-05', 3200.00, 2900.00, 300.00, 'Awards', 'ACC78983', 'ROUT7892'),
	(28, 8, 5, '2023-09-15', 4200.00, 3800.00, 400.00, 'Guest Expenses', 'ACC89084', 'ROUT8903'),
	(29, 9, 1, '2023-09-25', 3300.00, 3000.00, 300.00, 'Service', 'ACC90185', 'ROUT9014'),
	(30, 10, 2, '2023-10-05', 3100.00, 2800.00, 300.00, 'Non-Service', 'ACC01236', 'ROUT0125'),
	(31, 1, 3, '2023-10-15', 2900.00, 2600.00, 300.00, 'Awards', 'ACC12348', 'ROUT1237'),
	(32, 2, 4, '2023-10-25', 2500.00, 2200.00, 300.00, 'Guest Expenses', 'ACC23459', 'ROUT2348'),
	(33, 3, 5, '2023-11-05', 2800.00, 2500.00, 300.00, 'Service', 'ACC34570', 'ROUT3459'),
	(34, 4, 1, '2023-11-15', 2700.00, 2400.00, 300.00, 'Non-Service', 'ACC45681', 'ROUT4560'),
	(35, 5, 2, '2023-11-25', 2300.00, 2000.00, 300.00, 'Awards', 'ACC56782', 'ROUT5671'),
	(36, 6, 3, '2023-12-05', 3800.00, 3400.00, 400.00, 'Guest Expenses', 'ACC67883', 'ROUT6782'),
	(37, 7, 4, '2023-12-15', 3300.00, 3000.00, 300.00, 'Service', 'ACC78984', 'ROUT7893'),
	(38, 8, 5, '2023-01-05', 4100.00, 3700.00, 400.00, 'Non-Service', 'ACC89085', 'ROUT8904'),
	(39, 9, 1, '2023-01-15', 3600.00, 3200.00, 400.00, 'Awards', 'ACC90186', 'ROUT9015'),
	(40, 10, 2, '2023-01-25', 2800.00, 2500.00, 300.00, 'Guest Expenses', 'ACC01237', 'ROUT0126'),
	(41, 1, 3, '2023-02-05', 3300.00, 3000.00, 300.00, 'Service', 'ACC12349', 'ROUT1238'),
	(42, 2, 4, '2023-02-15', 3500.00, 3200.00, 300.00, 'Non-Service', 'ACC23460', 'ROUT2349'),
	(43, 3, 5, '2023-02-25', 3900.00, 3600.00, 300.00, 'Awards', 'ACC34571', 'ROUT3450'),
	(44, 4, 1, '2023-03-05', 2500.00, 2200.00, 300.00, 'Guest Expenses', 'ACC45682', 'ROUT4561'),
	(45, 5, 2, '2023-03-15', 3200.00, 2900.00, 300.00, 'Service', 'ACC56783', 'ROUT5672'),
	(46, 6, 3, '2023-03-25', 4100.00, 3700.00, 400.00, 'Non-Service', 'ACC67884', 'ROUT6783'),
	(47, 7, 4, '2023-04-05', 3300.00, 3000.00, 300.00, 'Awards', 'ACC78985', 'ROUT7894'),
	(48, 8, 5, '2023-04-15', 4300.00, 3900.00, 400.00, 'Guest Expenses', 'ACC89086', 'ROUT8905'),
	(49, 9, 1, '2023-04-25', 3800.00, 3400.00, 400.00, 'Service', 'ACC90187', 'ROUT9016'),
	(50, 10, 2, '2023-05-05', 2900.00, 2600.00, 300.00, 'Service', 'ACC01238', 'ROUT0127');

-- Insert data into Document table
INSERT INTO Document (Document_Number, NRA_Id, Document_Type, Description, Issue_Date) VALUES
    (1, 1, 'Visa', 'Visa document issued for study purposes', '2018-03-15'),
    (2, 2, 'Passport', 'Passport for international travel', '2017-08-22'),
    (3, 3, 'i_94', 'Arrival/Departure record for border entry', '2019-05-11'),
    (4, 4, 'i20', 'Certificate of eligibility for student status', '2020-06-18'),
    (5, 5, 'Visa', 'Visa document for research work', '2021-02-27'),
    (6, 6, 'Passport', 'Passport for long-term residence', '2019-11-30'),
    (7, 7, 'i_94', 'i_94 issued at U.S. border', '2017-07-04'),
    (8, 8, 'i20', 'i20 form for F-1 student', '2018-12-01'),
    (9, 9, 'Visa', 'Student visa for educational purposes', '2020-01-09'),
    (10, 10, 'Passport', 'Passport for identification', '2019-10-14'),
    (11, 11, 'i_94', 'Arrival record for international student', '2020-03-19'),
    (12, 12, 'i20', 'Certificate for study eligibility', '2021-05-25'),
    (13, 13, 'Visa', 'Work visa for internship program', '2018-09-23'),
    (14, 14, 'Passport', 'Passport for personal identification', '2017-02-15'),
    (15, 15, 'i_94', 'i_94 arrival document', '2021-07-16'),
    (16, 16, 'i20', 'Form for student status verification', '2019-09-04'),
    (17, 17, 'Visa', 'Visa issued for professional conference', '2017-11-18'),
    (18, 18, 'Passport', 'Official passport for academic purposes', '2020-08-12'),
    (19, 19, 'i_94', 'Arrival and departure record', '2018-04-25'),
    (20, 20, 'i20', 'Certificate for study and research status', '2021-06-29');
    
-- Insert data into TaxDocument table
INSERT INTO TaxDocument (Document_Number, Payment_ID, Document_Type, Description, Issue_Date) VALUES
    (1, 1, 'Form 1042-S', 'Annual tax document for foreign income', '2019-03-15'),
    (2, 3, 'Form W-8BEN', 'Certificate of Foreign Status of Beneficial Owner for U.S. Tax Withholding', '2020-04-20'),
    (3, 5, 'Form 1099', 'Miscellaneous income for non-residents', '2021-02-25'),
    (4, 7, 'Form 1040NR', 'U.S. Nonresident Alien Income Tax Return', '2018-07-10'),
    (5, 9, 'Form 1042-S', 'Annual tax form for reporting foreign income', '2021-05-13'),
    (6, 11, 'Form W-8BEN', 'Foreign status certification for tax purposes', '2019-09-22'),
    (7, 13, 'Form 1099', 'Report of miscellaneous income', '2020-06-18'),
    (8, 15, 'Form 1040NR', 'Tax return for non-resident aliens', '2018-12-05'),
    (9, 17, 'Form 1042-S', 'Document for reporting income tax withheld', '2017-08-09'),
    (10, 19, 'Form W-8BEN', 'Foreign owner tax withholding certificate', '2020-10-14'),
    (11, 21, 'Form 1099', 'Non-resident miscellaneous income document', '2019-11-30'),
    (12, 23, 'Form 1040NR', 'Tax return for U.S. source income', '2017-04-22'),
    (13, 25, 'Form 1042-S', 'Foreign income tax reporting form', '2018-01-19'),
    (14, 27, 'Form W-8BEN', 'Certificate of Foreign Status for tax withholding', '2021-03-11'),
    (15, 29, 'Form 1099', 'Miscellaneous income tax document', '2020-07-27'),
    (16, 31, 'Form 1040NR', 'U.S. tax return for non-resident individuals', '2019-08-30'),
    (17, 33, 'Form 1042-S', 'Form for reporting foreign source income', '2021-06-02'),
    (18, 35, 'Form W-8BEN', 'Certification of foreign owner status', '2019-05-21'),
    (19, 37, 'Form 1099', 'Report for miscellaneous income for non-residents', '2018-09-09'),
    (20, 39, 'Form 1040NR', 'Tax return for nonresident alien income', '2017-10-25'),
    (21, 41, 'Form 1042-S', 'Foreign income tax withheld report', '2018-03-14'),
    (22, 43, 'Form W-8BEN', 'Certificate of Foreign Status', '2021-04-16'),
    (23, 45, 'Form 1099', 'Non-resident miscellaneous income statement', '2020-05-23'),
    (24, 47, 'Form 1040NR', 'Income tax return for non-residents', '2019-09-30'),
    (25, 49, 'Form 1042-S', 'Foreign sourced income form', '2017-11-21');
    
-- Insert data into PartOf table
INSERT INTO PartOf (NRA_ID, Dept_ID) VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (3, 2),
    (5, 4),
    (5, 1),
    (6, 2),
    (8, 4),
    (8, 5),
    (9, 1),
    (10, 2),
    (10, 3),
    (12, 4),
    (13, 1),
    (13, 5),
    (15, 3),
    (16, 1),
    (17, 5),
    (19, 2),
    (20, 3);

COMMIT;


-- SQL Queries

-- Q1. How many payments were made to each Nonresident Alien (NRA) individual?
SELECT na.NRA_Id AS NRA_Id, COUNT(p.Payment_ID) AS payment_count
FROM Payment p
JOIN NonResidentAlien na ON p.Payee_Id = na.NRA_Id
GROUP BY na.NRA_Id;

-- Q2. What is the total amount of payments made to Nonresident Alien individuals based on their country of origin?
SELECT na.Nationality AS Nationality, SUM(p.Gross_Pay) AS Total_Gross_Pay, SUM(p.Net_Pay) AS Total_Net_Pay
FROM Payment p 
JOIN NonResidentAlien na ON p.Payee_Id = na.NRA_Id 
GROUP BY na.Nationality;

-- Q3. What types of payments (Guest Expenses, services, non-service, Awards) have been issued to Nonresident Aliens, and how frequently?
SELECT p.Payment_Type, COUNT(p.Payment_ID) AS frequency
FROM Payment p
JOIN NonResidentAlien na ON p.Payee_Id = na.NRA_Id
GROUP BY p.Payment_Type;

-- Q4. Which Nonresident Aliens received payments  between 1st dec 2023 to 31st dec 2023 ?
SELECT na.NRA_Id, na.First_Name, p.Payment_ID, p.Payment_Date
FROM Payment p
JOIN NonResidentAlien na ON p.Payee_Id = na.NRA_Id
WHERE p.Payment_Date BETWEEN '2023-12-01' AND '2023-12-31';

-- Q5. How many Nonresident Aliens are covered under specific tax treaties?
SELECT na.Tax_Treaty_Id, COUNT(na.NRA_Id) AS num_nras
FROM NonResidentAlien na
WHERE na.Tax_Treaty_Id IS NOT NULL
GROUP BY na.Tax_Treaty_Id;

-- Q6. What is the list of Nonresident Aliens who are employed by a Department and their corresponding unique payment types?
SELECT DISTINCT NRA.First_Name, NRA.Last_Name, Dept.Dept_Name, P.Payment_Type
FROM NonResidentAlien NRA
JOIN PartOf POf ON NRA.NRA_Id = POf.NRA_ID
JOIN Department Dept ON POf.Dept_ID = Dept.Dept_Id
JOIN Payment P ON NRA.NRA_Id = P.Payee_Id;

-- Q7. Which Nonresident Alien received the highest payment in Jan month?
SELECT nra.First_Name, p.Gross_Pay, p.Payment_Date
FROM NonResidentAlien nra
JOIN Payment p ON nra.NRA_Id = p.Payee_Id
WHERE MONTH(p.Payment_Date) = 1
ORDER BY p.Gross_Pay DESC
LIMIT 1;

-- Q8. How much total payment has been made to nra whose first name is Priya?
SELECT SUM(p.Gross_Pay) AS Total_Payment
FROM NonResidentAlien na
JOIN Payment p ON na.NRA_Id = p.Payee_Id
WHERE na.First_Name = 'Priya';

-- Q9. What payments were made to non-residents from China and India?
SELECT p.Payment_ID, p.Payment_Date, p.Gross_Pay, p.Payment_Type
FROM NonResidentAlien na
JOIN Payment p ON na.NRA_Id = p.Payee_Id
WHERE na.Nationality IN ('Chinese', 'Indian'); 

-- Q10. What tax treaties apply to non-resident aliens from China and India?
SELECT na.NRA_Id, na.First_Name, na.Nationality, tt.Country_of_Treaty, tt.Visa_Type, tt.Withholding_Rate, tt.Form_8233_Required
FROM NonResidentAlien na
JOIN TaxTreaty tt ON na.Tax_Treaty_Id = tt.Tax_Treaty_Id
WHERE tt.Country_of_Treaty IN ('China', 'India');

-- Q11. Which non-resident aliens have service-related payments, and how much was paid to each?
SELECT n.First_Name, n.Last_Name, SUM(p.Gross_Pay) AS Total_Paid, p.Payment_Type
FROM NonResidentAlien n
JOIN Payment p ON n.NRA_Id = p.Payee_Id
WHERE p.Payment_Type = 'Service'
GROUP BY n.First_Name , n.Last_Name , p.Payment_Type;

-- Q12. How many payments have been made to non-residents for everything other than service-related expenses?
SELECT COUNT(*) AS NonServiceRelatedPayments 
FROM Payment p 
JOIN NonResidentAlien n ON p.Payee_Id = n.NRA_Id 
WHERE p.Payment_Type != 'Service';

-- Q13. Which non-resident aliens received payments for guest expenses, and what were the amounts?
SELECT n.First_Name, n.Last_Name, p.Gross_Pay, p.Payment_Type
FROM Payment p
JOIN NonResidentAlien n ON p.Payee_Id = n.NRA_Id
WHERE p.Payment_Type = 'Guest Expenses'
ORDER BY n.First_Name;

-- Q14. What is the total amount of payments audited from Daniel Brown in the month of December?
SELECT SUM(p.Gross_Pay) AS Total_Audited_Amount
FROM  Payment p
JOIN  DepartmentAdmin a ON p.Approver_Id = a.Admin_Id
WHERE a.Admin_Name = 'Daniel Brown' AND MONTH(p.Payment_Date) = 12;
