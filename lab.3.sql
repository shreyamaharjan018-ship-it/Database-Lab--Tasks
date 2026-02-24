create database dhemp;
use dhemp;
create table Dept(
Deptno int,
Dname varchar(25),
LOC int 
);
RENAME table Dept to Department;
alter table Department
add PINCODE int NOT NULL;
alter table Department
rename Column Dname to DEPT_NAME;
alter table Department
modify LOC char(20);
drop table Department;