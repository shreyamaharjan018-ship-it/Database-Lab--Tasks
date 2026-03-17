create database BankDB;
use BankDB;
create table accounts(
account_id int primary key,
account_holder varchar(100),
balance decimal(10,9)
);
ALTER TABLE accounts 
MODIFY COLUMN balance DECIMAL(15,2);
#2 Insert
insert into accounts values
(1, 'shreya','50000'),
(2, 'aasna','40000'),
(3, 'ram','20000');
select * from  accounts;
# write a transaction that transfer rs 5000 from ram acc to shreta account
start transaction;
update accounts set balannce =balance -5000
where account_id = 1;
update accounts set balance = balance +5000
where account_id =2;
commit ;
#4 write a transcation that transfer rs 10000 from aasna accounts and demonstrate the use of rollback
start transaction;
update accounts set balance = balance -10000
where account_id = 2;
update accounts set balance = balance +10000
where account_id = 3;
rollback ;
#5 write a transaction that demonstrate the use of save ponit
#while updating account balance
start transaction;
update accounts set balance = balance - 2000
where account_id = 1;
update accunts set balance = balance = balance +2000
where account_id =2 ;
rollback to sp1;
commit;
# trigger
#1create a table employees with the field:emp_id,name,salary
create table employees(
emp_id int primary key,
name varchar(100),
salary decimal(10,2)
);
# 2 create salary_log table to record employee salary changes with fields log_id emp_id
create table salary_log(
log_id int auto_increment primary key,
emp_id int,
old_salary decimal(10,2),
new_salary decimal(10.2),
update_at timestamp default current_timestamp
);
#3 create a before inset trigger on employees that prevents inserting employees whose salary is less than 10000
delimiter $$  
create trigger  check_salary
before insert on employees
for each row 
begin
if new.salary <10000 then
signal sqlstate '45000'
set message_text ='salary must be at least 10000';
end if;
end
$$
delimiter ;

delimiter $$  
create trigger log_salary_update
after update on employees
for each row 
begin
insert into salary_log(emp_id,old_salary,new_salary)
values(old.emp_id,old.salary,new.salary);
end
$$
delimiter ;
#stored procedure
#1 create a stored procedure that retrives all the records from the employees table.
delimiter $$  
create procedure getEmployees()
begin
select*from employees;
end
$$
delimiter ;
call getEmployees();
#2 create a stored procedure that inserts a new employee into the employees table using parameters
delimiter $$  
create procedure sumEmployee(
in p_id int, in p_name varchar(100),in p_salary decimal(10,2)
)
begin
insert into employees values(p_id,p_name,p_salary);
end
$$
delimiter ;
call sumEmployee(4,'hari','20000');
#3 create a stored procedure that updatethe salary of an employee based on employee Id.
delimiter $$  
create procedure updateSalary(
in p_id int, in new_salary decimal(10,2)
)
begin
update employees
set salary = new_salary
where emp_id = p_id;
end
$$
delimiter ;
call updateSalary(1,30000);
#4 create a stored procedure that transfer money between two accounts using a transcation.
USE BankDB;
DELIMITER $$
CREATE PROCEDURE transfermoney(
    IN from_account INT,
    IN to_account INT,
    IN amount DECIMAL(15,2)
)
BEGIN
    START TRANSACTION;
    UPDATE accounts 
    SET balance = balance - amount 
    WHERE account_id = from_account;
    UPDATE accounts 
    SET balance = balance + amount 
    WHERE account_id = to_account;
    COMMIT;
END $$
DELIMITER ;
CALL transfermoney(1, 2, 5000);