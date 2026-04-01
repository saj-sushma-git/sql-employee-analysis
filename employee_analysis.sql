------------------------------------------------------------------------
-- TABLE CREATION
-- Drop tables if exist
-- Create employees table
-- Create departments table
-------------------------------------------------------------------------

DROP TABLE IF EXISTS employees; 

CREATE TABLE employees (	-- create the table employees
	emp_id INT,
  	emp_name VARCHAR(50),
  	department_id INT,
  	salary INT
);

DROP TABLE if EXISTS departments; -- drop the table departments if exists

CREATE TABLE departments (	-- create the table departments
	department_id INT,
  	department_name VARCHAR(50)
);

-----------------------------------------------------------------
-- DATA INSERTION 
-- Insert data into employees
-- Insert data into departments
-----------------------------------------------------------------

INSERT into employees VALUES 
(1, 'Amit', 10, 50000),
(2, 'Sara', 20, 60000),
(3, 'John', 10, 55000),
(4, 'Priya', 30, 45000),
(5, 'David', 20, 70000),
(6,'Anu', 30, 48000);

------------------------------------------

INSERT into departments VALUES
(10, 'HR'),
(20, 'IT'),
(30, 'Finance');

---------------------------------------------------
-- BASIC QUERIES
-- SELECT ALL
-- SELECT WITH WHERE
-- ORDER BY examples
---------------------------------------------------

SELECT *
FROM employees;

SELECT * 
FROM departments;

-----------------------------------------------------------------------------------------------------
/* This query is used in SQLite to retrieve the list of all tables from the database. 
The sqlite_master table stores metadata about database objects, and filtering with type = ' table'
returns only table names. */
-----------------------------------------------------------------------------------------------------

SELECT name FROM sqlite_master
WHERE type = 'table';

SELECT * FROM employees
where department_id = 20
AND salary > 60000;

SELECT emp_name, salary
FROM employees
ORDER BY salary;

SELECT emp_name, salary
FROM employees
ORDER BY salary DESC;

------------------------------------------
-- GROUP BY, HAVING
------------------------------------------

--------------------------------------
-- AGGREGATE FUNCTIONS
-- COUNT(), SUM(), AVG(), MIN(), MAX()
--------------------------------------

SELECT COUNT(*) -- It counts number of rows in employee table
FROM employees;

SELECT COUNT(department_id) -- It counts number of rows in a specific column
FROM employees;

SELECT SUM(salary)	-- SUM()
FROM employees;

-- SUM GROUP BY
SELECT department_id, SUM(salary)
FROM employees
GROUP BY department_id;

--AVG
SELECT AVG(salary)
FROM employees;

--AVG GROUP BY
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

--MIN, MAX
SELECT MIN(salary), MAX(salary)
FROM employees;

-- MIN, MAX using GROUP BY
SELECT department_id, MIN(salary), MAX(salary)
FROM employees
GROUP BY department_id; 

SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_id, COUNT(*) as total_employees
FROM employees
GROUP by department_id
ORDER by total_employees DESC;

-----------------------------------------------------
-- Insert employee with no matching department
-----------------------------------------------------
INSERT INTO employees VALUES
(7, 'Rachel', 40, 52000);

-- Department with no employees
INSERT INTO departments VALUES
(50, 'Marketing');

-----------------------------------------------------
-- JOINS
-- Inner join, Left join, Right join, Full join
-----------------------------------------------------

---- INNER JOIN (Only matching rows between the tables)
SELECT emp_name, department_name	
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

-- LEFT JOIN (all employees from left + dept info if available)
SELECT emp_name, department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;

--RIGHT JOIN (all departments + employees info if available)
SELECT emp_name, department_name
FROM employees e
RIGHT JOIN departments d
on e.department_id = d.department_id;

--FULL OUTER JOIN / FULL JOIN = all employees and all departments even if no match
SELECT emp_name, department_name
FROM employees e
FULL JOIN departments d
ON e.department_id = d.department_id;

-- find all employees with salary >55000 and show their department name:
SELECT emp_name, department_name, salary
FROM employees e
JOIN departments d
on e.department_id = d.department_id
WHERE salary > 55000;

-- count the number of employees in each department using Group by:
SELECT d.department_name, COUNT(e.emp_id) as emp_count
FROM employees e
RIGHT JOIN departments d
on e.department_id = d.department_id
GROUP BY d.department_name;

-- list all departments even if employees are not there
SELECT d.department_name
FROM departments d;

-- list all departments with employee names if present

SELECT department_name, emp_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

--------------------------------------------------------
-- DISTINCT
--------------------------------------------------------

SELECT DISTINCT(department_id)
FROM departments;

SELECT DISTINCT(department_name)
FROM departments;

--------------------------------------------------------
-- ANALYSIS QUERIES
--------------------------------------------------------

-- Find employee with highest salary
SELECT emp_name, salary
FROM employees
ORDER by salary DESC
limit 1;


-- Find top 3 highest paid employees
SELECT * 
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Count employees in each department
SELECT department_id, count(*) as total_employees
FROM employees
GROUP by department_id;


-- Find department with highest average salary
SELECT department_name, AVG(e.salary) AS Average_Salary
FROM employees e
JOIN departments d
ON e.department_id = d.department_id
GROUP by department_name
ORDER BY Average_Salary DESC;


-- Find the employees earning above overall average salary
SELECT emp_name, salary
FROM employees
WHERE salary > (
  	SELECT AVG(salary)
  	FROM employees
		);











