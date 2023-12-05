-- Challenge tasks:

-- 1. Drop the table if it exists
-- 2. Create the table and its columns and primary key and other constraints
-- 3. Create the foreign key (FK) if necessary
-- 4. Drop the column if FK is compose and the column it is not necessary

--------------------------------------

--Create Employee Table--

-- Remove table if it exists
DROP TABLE IF EXISTS employees CASCADE;

-- Create the table
CREATE TABLE employees(
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(5) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no, emp_title_id)
);

--view created table 
SELECT *
FROM
	employees
;

----------------------------------------------------------------
--Create Departments Table--

-- Remove table if it exists
DROP TABLE IF EXISTS departments CASCADE;

-- Create the table
CREATE TABLE departments(
	dept_no VARCHAR(5) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(50) NOT NULL
);

--view created table 
SELECT *
FROM
	departments
;

------------------------------------------------------

--Create departments_employees Table--

-- Remove table if it exists
DROP TABLE IF EXISTS departments_employees;


-- Create the table
CREATE TABLE departments_employees(
	emp_no INT NOT NULL,
	dept_no VARCHAR(5) NOT NULL REFERENCES departments(dept_no),
	emp_title_id VARCHAR(5) NOT NULL,
	FOREIGN KEY (emp_no, emp_title_id) REFERENCES employees(emp_no, emp_title_id),
	PRIMARY KEY(emp_no, dept_no)
);

-- Drop the Composed Primary Key to only allow the correct number of columns
ALTER TABLE departments_employees DROP column emp_title_id;

--view created table 
SELECT *
FROM
	departments_employees
;

--------------------------------------------------------
-- Create managers Table--

-- Remove table if it exists
DROP TABLE IF EXISTS managers;

-- Create the table
CREATE TABLE managers (
	dept_no VARCHAR(5) NOT NULL REFERENCES departments(dept_no),
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(5) NOT NULL,
	FOREIGN KEY (emp_no, emp_title_id) REFERENCES employees(emp_no, emp_title_id),
	PRIMARY KEY(dept_no, emp_no)
);

-- Drop the Composed Primary Key to only allow the correct number of columns
ALTER TABLE managers DROP column emp_title_id;

--view created table 
SELECT *
FROM
	managers
;
---------------------------------------------------------

--Create salaries table 

-- Remove table if it exists
DROP TABLE IF EXISTS salaries;

-- Create the table
CREATE TABLE salaries(
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(5) NOT NULL,
	FOREIGN KEY (emp_no, emp_title_id) REFERENCES employees(emp_no, emp_title_id),
	salary INT
);

-- Drop the Composed Primary Key to only allow the correct number of columns
ALTER TABLE salaries DROP column emp_title_id;

--view created table 
SELECT *
FROM
	salaries
;

-------------------------------------------------------
-- Create titles Table:


-- Remove table if it exists
DROP TABLE IF EXISTS titles;

-- Create the table
CREATE TABLE titles(
	emp_title_id VARCHAR(5) NOT NULL,
	title VARCHAR(30) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no,emp_title_id) REFERENCES employees(emp_no,emp_title_id),
	PRIMARY KEY (emp_title_id, title)
);

-- Drop the Composed Primary Key to only allow the correct number of columns
ALTER TABLE titles DROP column emp_no;

--view created table 
SELECT *
FROM
	titles
;
