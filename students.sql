CREATE DATABASE testdb;
use testdb;
create table Student(
   StudentID int NOT NULL PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Address varchar(255),
    Age int,
    Email varchar(20),
    City varchar(255)
);
INSERT INTO Student (StudentID, LastName, FirstName, Address, Age,Email, City)
VALUES ('001', 'Shrestha', 'Supriya', 'Boudha', '18', 'supriyashrestha@gmail.com' 'Kathmandu'),
('002', 'thapa', 'Armita', 'sunakoti', '20', 'armitathapa@gmail.com', 'Kathmandu'),
('003', 'Maharjan', 'Shreya', 'lubhu', '18','shreyamaharjan@gmail.com' 'Kathmandu')
;
drop database testdb;
drop table student;
CREATE DATABASE testdb;
create table Student(
   StudentID int ,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    Age int,
    City varchar(255)
);
alter  table Student
add email varchar(255);
select* from Student;
alter table Student
modify column StudentID int NOT NULL PRIMARY KEY;
alter table Student
modify column Age int NOT NULL;
INSERT INTO Student (StudentID, LastName, FirstName, Address, Age, Email, City) 
VALUES (1, 'Shrestha', 'John', '123 Main St', 20, 'john@email.com', 'Kathmandu');
INSERT INTO Student (StudentID, LastName, FirstName, Address, Age, Email, City) 
VALUES 
(3, 'Tamang', 'Sita', 'Patan', 21, 'sita@mail.com', 'Lalitpur'),
(4, 'Gurung', 'Amir', 'Thamel', 23, 'amir@mail.com', 'Kathmandu'),
(5, 'Rai', 'Bina', 'Baneshwor', 19, 'bina@mail.com', 'Kathmandu');
Select*from Student;
SELECT * FROM Student 
WHERE Age > 20 AND City = 'Kathmandu';
SELECT * FROM Student 
WHERE LastName LIKE 'Shr%';
Create TABLE Grades (
    GradeID int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    StudentID int NOT NULL,
    Subject varchar(50),
    Score int,
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);
INSERT INTO Grades (StudentID, Subject, Score)
VALUES 
(1, 'Mathematics', 95),
(1, 'Physics', 88),
(3, 'Computer Science', 92),
(4, 'Mathematics', 78),
(5, 'Physics', 75);
SELECT 
    Student.FirstName, 
    Student.LastName, 
    Grades.Subject, 
    Grades.Score
FROM Student
INNER JOIN Grades ON Student.StudentID = Grades.StudentID;
SELECT 
    S.FirstName, 
    S.LastName, 
    G.Subject, 
    G.Score
FROM Student S
LEFT JOIN Grades G ON S.StudentID = G.StudentID;
SELECT 
    MIN(Age) AS YoungestAge, 
    MAX(Age) AS OldestAge 
FROM Student;



