create database Lion;
use Lion;
-- create table for department
CREATE TABLE department (
    deptid INT PRIMARY KEY,
    deptname VARCHAR(10)
);
-- inserting values into department
INSERT INTO department
VALUES (1,'Hr'), (2,'It'), (3,'Sales');
select * from department;
-- create table for emploee
CREATE TABLE employee (
    empid INT PRIMARY KEY,
    empname VARCHAR(10),
    deptid INT,
    salary INT,
    hiredate DATE,
    FOREIGN KEY (deptid) REFERENCES department(deptid)
);
-- insert values into employee
INSERT INTO employee
VALUES 
  (101,'John',1,50000,'2018-02-12'),
  (102,'Alice',2,60000,'2019-07-10'),
  (103,'Bob',1,55000,'2020-05-05'),
  (104,'Carol',3,45000,'2017-09-20');
  select * from employee;
  
  /*second assignment:
  /*Display employee whose names start with 'A'*/
  select * from employee where empname like '%A';
  /*Find employees whose salary is b/w 45000 and 60000*/
  select * from employee where salary between 45000 and 60000;
  /*show the department name of each employee*/
select e.empname, d.deptName
from employee e
join department d on e.deptid = d.deptid;
/*Find the no of employees in each department*/
select deptid, count(*) as total_count from employee group by deptid;
/*Display all employees including those without a department (left join)*/
select e.empid,e.empname,e.deptid,e.salary,e.hirhdate,d.deptname
from employee e
left join department d on e.deptid=d.deptid;

  
