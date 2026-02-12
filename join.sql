create database dhemp;
use dhemp;
create table employee(
Id int,
employee_name varchar(25),
department_id int 
);
#drop table employee;
create table employee(
Id int primary key,
employee_name varchar(25),
department_id int 
);
create table departments(
department_id int primary key,
department_name varchar(50)
);
select*from employee;
select* from departments;
insert into employee values
(1, 'Homer Simpson',4),
(2, 'Ned Flanders ',1),
(3, 'Barney Gamble','3'),
(4, 'clancy wiium',3),
(5, 'Moe Syzslax',null);
insert into departments values
('1','Sales'),
('2','Enginnering'),
('3','Human Resoure'),
('4','Customer Service'),
('5','Research and Department');
#inner join
select*from employee emp inner join 
departments dep on emp.department_id=dep.department_id;
select*from departments dep left join employee emp on emp.department_id=dep.department_id; 

select*from departments dep Right join employee emp on emp.department_id=dep.department_id; 
select*from departments dep Full join employee emp on emp.department_id=dep.department_id;
# cross join
select*from employee
cross join departments;
