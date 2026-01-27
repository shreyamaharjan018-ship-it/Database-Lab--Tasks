#1.	Create a database named dbemp and switch to it.
create database dbemp;
use dbemp;
#2.	Create an employee table with appropriate data types 
#and constraints for employee details.
use dbemp;
create table Employee(
		EmployeeID varchar(20) NOT NULL PRIMARY KEY,
        FirstName varchar(20),
        LastName varchar(20),
        Gender char(1),
        DateofBirth DATE,
        Designation varchar(50),
        DepartmentName varchar(20),
        ManagerId varchar(20),
        JoinedDate DATE,
        Salary decimal(10,0)
);
#3.	Insert at least two employee records into the employee table.
insert into employee (
EmployeeID,FirstName,LastName,Gender,DateofBirth,Designation,
DepartmentName,ManagerId,JoinedDate,Salary)
values (
'0009','Season','Maharjan','M','1996-04-02','Engineer',
'Software Engineering', '0005','2022-04-02','5000000'
),(
'0010','Ramesh','Rai','M','2000-04-02','Manager',
'Software Engineering', '0003','2022-04-02','1000000'
);
select * from employee;
UPDATE employee
SET Gender='F'
WHERE EmployeeID='0009';
#5.Display the first name, current date, date of birth, and age of employees who are older then 25 years.
SELECT FirstName,current_date() as CurrentDate,DateofBirth,
timestampdiff(Year, DateofBirth,CURDATE()) as Age 
FROM Employee where 
timestampdiff(Year,DateofBirth,CURDATE()) >25;
#6 Write a query to findthe oldest employee.
select *from employee
order by DateofBirth desc
Limit 1;
#8 display the maximim salary department-wise.
select DepartmentName, max(salary) as max_salary
from employee
group by DepartmentName;
#List the employee who act as a managers.
select* from employee
where EmployeeID  in (select distinct  ManagerID from employee);
# 10 disploay the details of the most recently joined employee.
select*from employee where
JoinedDate =(select max(JoinedDate) from employee);
