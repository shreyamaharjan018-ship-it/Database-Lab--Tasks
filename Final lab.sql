#create a database named techsolutionDb and switch to it
#create the following tables with appropriate data type and contraints
create database TechSolutionDB ;
use TechSolutionDB;
create table Department(
DeptId int PRIMARY KEY,
DeptName varchar(20),
Location varchar(25)
);
create table Employee(
 EmpId int primary key,
 FirstName varchar(20),
 LastName varchar(20),
 gender char(1),
 salary int not null,
 hiredate date,
 DeptId int,
 FOREIGN KEY (DeptId) REFERENCES Department(DeptId)
);
ALTER TABLE Employee
MODIFY salary DECIMAL(19,0);
create table Project(
ProjectID int,
ProjectName varchar(20),
Startdate date,
EndDate date,
Budget decimal(19, 0)
);
ALTER TABLE Project
ADD PRIMARY KEY (ProjectID);
create table Works_on(
 EmpID int,
 ProjectId int,
 HoursWorked int,
 primary key(EmpID,ProjectId),
 FOREIGN KEY (ProjectId) REFERENCES Project(ProjectId),
 FOREIGN KEY (EmpId) REFERENCES Employee(EmpId)
);
INSERT INTO Department VALUES
(1,'HR','New York'),
(2,'IT','Chicago'),
(3,'Finance','Boston'),
(4,'Marketing','Los Angeles'),
(5,'Sales','Dallas');
INSERT INTO Employee VALUES
(101,'John','Smith','M',55000.50,'2022-03-15',2),
(102,'Emma','Brown','F',62000.75,'2021-06-10',1),
(103,'Michael','Johnson','M',48000.00,'2023-01-20',3),
(104,'Sophia','Davis','F',71000.25,'2020-09-05',4),
(105,'Daniel','Wilson','M',53000.80,'2022-11-18',5);
INSERT INTO Project VALUES
(201,'WebsiteDev','2024-01-01','2024-06-30',100000),
(202,'MobileApp','2024-02-15','2024-08-20',150000),
(203,'CloudMigration','2024-03-10','2024-12-15',200000),
(204,'MarketingCampaign','2024-04-01','2024-09-01',80000),
(205,'SalesAutomation','2024-05-05','2024-11-30',120000);
INSERT INTO Works_on VALUES
(101,201,40),
(102,202,35),
(103,203,50),
(104,204,30),
(105,205,45);
#partA
UPDATE Employee
SET salary = salary * 1.10
WHERE EmpID = 102;
DELETE FROM Project
WHERE ProjectID = 5;
DELETE FROM Works_on
WHERE ProjectID = 5;
#partb
-- 1. Display all employees who earn more than 50000
SELECT *
FROM Employee
WHERE salary > 50000;

-- 2. Display FirstName, LastName and Salary sorted by salary in descending order
SELECT FirstName, LastName, salary
FROM Employee
ORDER BY salary DESC;

-- 3. Display employees who belong to IT department (nested query)
SELECT *
FROM Employee
WHERE DeptId = (
    SELECT DeptId
    FROM Department
    WHERE DeptName = 'IT'
);

-- 4. Show total number of employees in each department (nested query)
SELECT DeptName,
(
    SELECT COUNT(*)
    FROM Employee
    WHERE Employee.DeptId = Department.DeptId
) AS TotalEmployees
FROM Department;

-- 5. Display employees who were hired after January 1, 2022
SELECT *
FROM Employee
WHERE hiredate > '2022-01-01';
#partD
SELECT FirstName, LastName,
(
    SELECT DeptName
    FROM Department
    WHERE Department.DeptId = Employee.DeptId
) AS DepartmentName

#2 
FROM Employee;
SELECT e.FirstName, e.LastName, p.ProjectName
FROM Employee e
JOIN Works_on w ON e.EmpId = w.EmpId
JOIN Project p ON w.ProjectId = p.ProjectId;
#3
SELECT p.ProjectName, SUM(w.HoursWorked) AS TotalHours
FROM Project p
JOIN Works_on w ON p.ProjectId = w.ProjectId
GROUP BY p.ProjectName;
 #Part E
 SELECT d.DeptName, AVG(e.salary) AS AverageSalary
FROM Department d
JOIN Employee e ON d.DeptId = e.DeptId
GROUP BY d.DeptName;
#2
SELECT d.DeptName, COUNT(e.EmpId) AS TotalEmployees
FROM Department d
JOIN Employee e ON d.DeptId = e.DeptId
GROUP BY d.DeptName
ORDER BY TotalEmployees DESC
LIMIT 1;

#3
SELECT *
FROM Employee
WHERE salary > (
    SELECT AVG(salary)
    FROM Employee
);
#part f
#1
CREATE VIEW HighSalaryEmployee AS
SELECT *
FROM Employee
WHERE salary > 60000;
#2
CREATE INDEX idx_lastname
ON Employee(LastName);