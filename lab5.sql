create database dhemp;
use dhemp;
create table Employees(
Fname varchar(30),
Lname varchar(25),
SSN int,
Address varchar(30),
Sex char,
Salary int,
Superssn int,
Dno int 
);
create table department(
Dno int,
Dname varchar(20),
Mgrstartdate DATE,
MgrSSN int
);
INSERT INTO Employees (Fname, Lname, SSN, Address, Sex, Salary, Superssn, Dno) VALUES
('James', 'Borg', 888665555, '450 Stone, Houston, TX', 'M', 55000, NULL, 1),
('Jennifer', 'Wallace', 987654321, '291 Berry, Bellaire, TX', 'F', 43000, 888665555, 4),
('Franklin', 'Wong', 333445555, '638 Voss, Houston, TX', 'M', 40000, 888665555, 5),
('Alicia', 'Zelaya', 999887777, '3321 Castle, Spring, TX', 'F', 25000, 987654321, 4),
('Ramesh', 'Narayan', 666884444, '975 Fire Oak, Humble, TX', 'M', 38000, 333445555, 5),
('Joyce', 'English', 453453453, '5631 Rice, Houston, TX', 'F', 25000, 333445555, 5);
INSERT INTO department (Dno, Dname, Mgrstartdate, MgrSSN) VALUES
(1, 'Headquarters', '1981-06-19', 888665555),
(4, 'Administration', '1995-01-01', 987654321),
(5, 'Research', '1988-05-22', 333445555);
select E.Fname, E.Lname,
E.Salary*1.10 as increased_salary
from EMPLOYEES E Join
Department D on 
E.dno =D.Dno
where D.Dname ='Research';
select SUM(E.Salary) as total_salary,
max(E.Salary) as max_Salary,
min(E.Salary) as min_Salary,
avg(E.Salary) as avg_Salary
from Employees employees
join
Department D on E.Dno = D.no
where D.Dname ="Administration";