-- Challenge Data Analysis Instructions

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
-- 3. List the manager of each department along with their department number, department name, 
-- employee number, last name, and first name.
-- 4. List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name.
-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose
-- last name begins with the letter B.
-- 6. List each employee in the Sales department, including their employee number, 
-- last name, and first name.
-- 7. List each employee in the Sales and Development departments, including their employee number,
-- last name, first name, and department name.
-- 8. List the frequency counts, in descending order, of all 
-- the employee last names (that is, how many employees share each last name).

------------------------------------------
-- quick look at the created tables-- 
SELECT *
FROM employees
LIMIT (2);

SELECT *
FROM departments
LIMIT (2);

SELECT *
FROM departments_employees
LIMIT (2);

SELECT *
FROM managers
LIMIT (2);

SELECT *
FROM salaries
LIMIT (2);

SELECT *
FROM titles
LIMIT (2);

------------------------------------------------------
-- 1. List details for each employee:

--employee number, last name, first name, sex (from employees)
--salary (from salaries)
SELECT employees.emp_no, employees.last_name, employees.first_name,employees.sex, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
LIMIT (2);

------------------------------------------------------------
-- 2. List details for each employee who were hired in 1986.
--first name, last name,  hire date (from employees)
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees
WHERE employees.hire_date >= '1986-1-1'::date AND employees.hire_date <= '1987-1-1'::date
LIMIT (2);

---------------------------------------------------------------
-- 3. List the manager of each department along with:

--department number(managers), department name(departments), employee number(managers), last name first name (employees)

SELECT managers.dept_no, departments.dept_name, managers.emp_no, employees.last_name, employees.first_name
FROM managers
JOIN departments ON managers.dept_no = departments.dept_no
JOIN employees ON managers.emp_no = employees.emp_no
LIMIT (2);

--------------------------------------------------------------------
-- 4. List the department number for each employee
--along with that employee’s employee number, last name, first name, and department name.
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN departments_employees ON employees.emp_no = departments_employees.emp_no
JOIN departments ON departments_employees.dept_no = departments.dept_no
LIMIT (2);

----------------------------------------------------------------------
-- 5. List first name, last name, and sex of each employee whose first name 
--is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

------------------------------------------------------------------------
-- 6. List each employee in the Sales department, including their employee number, 
-- last name, and first name.

SELECT departments.dept_name, departments.dept_no
FROM departments
WHERE departments.dept_name= 'Sales';
-- Sales department is d007

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN departments_employees ON employees.emp_no = departments_employees.emp_no
JOIN departments ON departments_employees.dept_no = departments.dept_no
WHERE departments.dept_no = 'd007'
LIMIT (10);

------------------------------------------------------
-- 7. List each employee in the Sales and Development departments, 
--including their employee number,last name, first name, and department name.

SELECT departments.dept_name, departments.dept_no
FROM departments
WHERE departments.dept_name= 'Sales' OR departments.dept_name= 'Development';
-- department numbers of Sales and Development departments are d007 and d005

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN departments_employees ON employees.emp_no = departments_employees.emp_no
JOIN departments ON departments_employees.dept_no = departments.dept_no
WHERE departments.dept_no = 'd005' or departments.dept_no = 'd007'
LIMIT (10);

--------------------------------------------------------
-- 8. List the frequency counts, in descending order, of all 
-- the employee last names (that is, how many employees share each last name).
SELECT employees.last_name, COUNT(last_name) AS "Frequency"
FROM employees
GROUP BY employees.last_name
ORDER BY "Frequency" DESC;

