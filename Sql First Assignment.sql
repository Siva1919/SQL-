create database Tiger;
use Tiger;
-- create table for department
CREATE TABLE department (
    deptid INT PRIMARY KEY,
    deptname VARCHAR(10)
);
-- inserting values into department
INSERT INTO department
VALUES (1, 'hr'), (2, 'it'), (3, 'sales');
select * from department;
-- create table for emploee
CREATE TABLE employee (
    empid INT PRIMARY KEY,
    empname VARCHAR(10),
    deptid INT,
    salary INT,
    hiredate DATE,
    FOREIGN KEY (deptid) REFERENCES departments(deptid)
);
-- insert values into employee
INSERT INTO employee
VALUES 
  (101, 'john', 1, 50000, '2018-02-12'),
  (102, 'alice', 2, 60000, '2019-07-10'),
  (103, 'bob', 1, 55000, '2020-05-05'),
  (104, 'carol', 3, 45000, '2017-09-20');
select * from employee;
-- first assignment:
/*display all records from the employee table*/
select * from employee;
/* display only empname and salary of all employees*/
select empname,salary from employee;
/*find all employees who belong to it department*/
SELECT * from employee JOIN department ON employees.deptid = department.deptid WHERE departments.deptname = 'it';
/*list employees whose salary greater than 50000*/
select * from employee where salary>50000;
/*find employees hired before 2020-01-01*/
select * from employee where hiredate < '2020-01-01';
/* display employees in desc order of salary*/
select * from employee order by salary desc;
/* counnt total number of employees*/
select count(*) from employee;
/* find average salary from employees*/
select avg(salary) from employee;
/* find the maximum salary in each department*/
SELECT deptname,max(salary) from employee JOIN departments ON employees.deptid = departments.deptid  group by deptname ;
/*find departments having more than 1 employee*/
SELECT deptname from employees JOIN department ON employees.deptid = departments.deptid  group by deptname having count(employees.empname)>1;




