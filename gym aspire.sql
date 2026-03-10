CREATE DATABASE AspireFitness;
USE AspireFitness;
CREATE TABLE Member (
    MembershipNo INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Address VARCHAR(255),
    Telephone INT,
    Email VARCHAR(255),
    DOB DATE,
    MedicalCondition VARCHAR(255),
    WeeklySubscriptionFee INT
);

CREATE TABLE FitnessStaff (
    StaffNumber INT PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Role VARCHAR(255),
    ContactNo INT
);
ALTER TABLE FitnessStaff MODIFY ContactNo VARCHAR(20);
CREATE TABLE Class (
    ClassCode INT PRIMARY KEY,
    ClassName VARCHAR(255),
    Day VARCHAR(255),
    StartTime TIME,
    EndTime TIME,
    MaxClassSize INT,
    StaffNumber INT,
    FOREIGN KEY (StaffNumber) REFERENCES FitnessStaff(StaffNumber)
);

CREATE TABLE ClassAttendance (
    AttendanceId INT PRIMARY KEY AUTO_INCREMENT,
    AttendanceDate DATE,
    WeekNumber INT,
    Status VARCHAR(255),
    AdditionalFeePaid INT,
    MembershipNo INT,
    ClassCode INT,
    FOREIGN KEY (MembershipNo) REFERENCES Member(MembershipNo),
    FOREIGN KEY (ClassCode) REFERENCES Class(ClassCode)
);
INSERT INTO FitnessStaff (StaffNumber, FirstName, LastName, Role, ContactNo) VALUES
(101, 'Alice', 'Shrestha', 'Yoga Instructor','9841233200'),
(102, 'Bob', 'Joshi', 'Personal Trainer','984713320'),
(103, 'Charlie', 'Bista', 'Zumba Instructor','9874563210');
INSERT INTO Member (MembershipNo, FirstName, LastName, Address, Telephone, Email, DOB, MedicalCondition, WeeklySubscriptionFee) VALUES
(501, 'Aarav', 'Sharma', 'New Baneshwor, Kathmandu', 98412345, 'aaravsharma@email.com', '1990-05-15', 'None', 10),
(502, 'Binita', 'Thapa', 'Jhamsikhel, Lalitpur', 98510678, 'binitathapa@email.com', '1985-11-20', 'Asthma', 10),
(503, 'Siddharth', 'Gurung', 'Lakeside, Pokhara', 98034569, 'sidgurung@email.com', '1992-02-10', 'None', 10),
(504, 'Priya', 'Adhikari', 'Balkhu, Kathmandu', 98415700, 'priyaa@email.com', '1988-07-30', 'Knee Injury', 10),
(505, 'Rohan', 'Shrestha', 'Kupondole, Lalitpur', 98123456, 'rohan@email.com', '1995-12-12', 'None', 10),
(506, 'Anjali', 'Karki', 'Siddharthanagar, Bhairahawa', 98678912, 'anjali@email.com', '1991-03-25', 'None', 10),
(507, 'Deepak', 'Rai', 'Dharan-12, Sunsari', 98012233, 'deepakrai@email.com', '1983-09-05', 'High BP', 10),
(508, 'Ishani', 'Lama', 'Bouddha, Kathmandu', 98495566, 'ishanilama@email.com', '1998-01-18', 'None', 10),
(509, 'Kushal', 'Poudel', 'Bharatpur, Chitwan', 98550123, 'kushalp@email.com', '1987-06-22', 'None', 10),
(510, 'Sajani', 'Maharjan', 'Mangal Bazaar, Patan', 98417788, 'sajani@email.com', '1994-10-08', 'None', 10);

INSERT INTO Class (ClassCode, ClassName, Day, StartTime, EndTime, MaxClassSize, StaffNumber) VALUES
(2001, 'Yoga for Beginners', 'Monday', '07:00:00', '08:00:00', 20, 101),
(2002, 'Advanced HIIT', 'Tuesday', '18:00:00', '19:00:00', 15, 102),
(2003, 'Zumba Dance', 'Wednesday', '19:30:00', '20:30:00', 25, 103),
(2004, 'Evening Tai Chi', 'Thursday', '17:00:00', '18:00:00', 12, 101);

INSERT INTO ClassAttendance (AttendanceDate, WeekNumber, Status, AdditionalFeePaid, MembershipNo, ClassCode) VALUES
('2026-03-02', 10, 'Attended', 0, 501, 2001),
('2026-03-03', 10, 'Attended', 0, 501, 2002),
('2026-03-04', 10, 'Attended', 0, 501, 2003),
('2026-03-05', 10, 'Attended', 0, 501, 2001),
('2026-03-06', 10, 'Attended', 0, 501, 2002),
('2026-03-07', 10, 'Attended', 5, 501, 2003),
('2026-03-02', 10, 'Attended', 0, 502, 2001),
('2026-03-04', 10, 'Attended', 0, 502, 2002),
('2026-03-06', 10, 'Attended', 0, 502, 2003),
('2026-03-03', 10, 'Attended', 0, 503, 2002);
INSERT INTO Member (MembershipNo, FirstName, LastName, Address, Telephone, Email, DOB, MedicalCondition, WeeklySubscriptionFee) 
VALUES (500, 'Sandeep', 'Lamicchane', 'Gairidhara, Kathmandu', '984199', 'sandeep@email.com', '2000-08-02', 'None', 10);
INSERT INTO Class (ClassCode, ClassName, Day, StartTime, EndTime, MaxClassSize, StaffNumber) 
VALUES (3001, 'Power Lifting', 'Friday', '16:00:00', '17:30:00', 10, 101);
INSERT INTO ClassAttendance (AttendanceDate, WeekNumber, Status, AdditionalFeePaid, MembershipNo, ClassCode) 
VALUES ('2026-03-06', 10, 'Attended', 0, 500, 3001);
#Calculate Revenue (Base Fee + Extra Classes)
SELECT 
    Member.FirstName, 
    Member.LastName, 
    (Member.WeeklySubscriptionFee + SUM(ClassAttendance.AdditionalFeePaid)) AS TotalBill
FROM Member
JOIN ClassAttendance ON Member.MembershipNo = ClassAttendance.MembershipNo
WHERE ClassAttendance.WeekNumber = 10
GROUP BY Member.MembershipNo;

#Active member
SELECT Member.FirstName, Member.LastName, COUNT(ClassAttendance.AttendanceId) AS TotalAttendances
FROM ClassAttendance
JOIN Member ON ClassAttendance.MembershipNo = Member.MembershipNo
GROUP BY Member.MembershipNo
ORDER BY TotalAttendances DESC;

#member weekly activity
SELECT Member.FirstName, Member.LastName, Class.ClassName, ClassAttendance.WeekNumber
FROM ClassAttendance
JOIN Member ON ClassAttendance.MembershipNo = Member.MembershipNo
JOIN Class ON ClassAttendance.ClassCode = Class.ClassCode
WHERE Member.MembershipNo = 500 AND ClassAttendance.WeekNumber = 10;

#search classes by instructor
SELECT Class.ClassName, Class.Day, Class.StartTime, FitnessStaff.FirstName
FROM Class
INNER JOIN FitnessStaff ON Class.StaffNumber = FitnessStaff.StaffNumber
WHERE FitnessStaff.StaffNumber = 101;