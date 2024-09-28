# sql-challenge
It’s been two weeks since you were hired as a new data engineer at Pewlett Hackard (a fictional company). Your first major task is to do a research project about people whom the company employed during the 1980s and 1990s. All that remains of the employee database from that period are six CSV files.

For this project, you’ll design the tables to hold the data from the CSV files, import the CSV files into a SQL database, and then answer questions about the data. That is, you’ll perform data modeling, data engineering, and data analysis, respectively.

# Data Modeling
--ERD--
![alt text](<EmployeeSQL/Image 9-28-24 at 2.05 PM.png>)

# Data Engineering

--Created schema for tables and set primary and corresponding foreign keys--

CREATE table employees(
	emp_no INT PRIMARY KEY NOT NULL,
	DOB DATE NOT NULL,
	firstName VARCHAR(30) NOT NULL,
	lastName VARCHAR(30) NOT NULL,
	gender VARCHAR(1) NOT NULL,
	hireDate DATE NOT NULL
);

CREATE table departments(
	dept_no VARCHAR(10) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(50) NOT NULL
);

CREATE table dept_emp(
		emp_no INT NOT NULL,
		dept_no VARCHAR(10) NOT NULL,
		fromDate DATE NOT NULL,
		toDate DATE NOT NULL,
	FOREIGN KEY (emp_no) references employees (emp_no),
	FOREIGN KEY (dept_no) references departments (dept_no)
);

CREATE table titles(
		emp_no INT NOT NULL,
		title VARCHAR(50) NOT NULL,
		fromDate DATE NOT NULL,
		toDate DATE NOT NULL,
	FOREIGN KEY (emp_no) references employees (emp_no)
	
);

CREATE table salaries(
		emp_no INT NOT NULL,
		salary INT NOT NULL,
		fromDate DATE NOT NULL,
		toDate DATE NOT NULL,
	FOREIGN KEY (emp_no) references employees (emp_no)
);

CREATE table dept_manager(
	dept_no VARCHAR(10) NOT NULL,
	emp_no INT NOT NULL,
	fromDate DATE NOT NULL,
	toDate DATE NOT NULL,
	FOREIGN KEY (emp_no) references employees (emp_no),
	FOREIGN KEY (dept_no) references departments (dept_no)
);

UPDATE dept_manager
SET toDate = CURRENT_DATE
WHERE extract(year from toDate) = 9999;

UPDATE dept_emp
SET toDate = CURRENT_DATE
WHERE extract(year from toDate) = 9999;

UPDATE titles
SET toDate = CURRENT_DATE
WHERE extract(year from toDate) = 9999;

1. List the employee number, last name, first name, sex, and salary of each employee.

SELECT employees.emp_no, employees.lastname, employees.firstname, employees.gender, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

2. List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT firstname, lastname, hiredate
FROM employees
WHERE hiredate BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hiredate;

3. List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.lastname, employees.firstname
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON employees.emp_no = dept_manager.emp_no;

4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT dept_emp.dept_no, dept_emp.emp_no, employees.lastname, employees.firstname, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT employees.firstname, employees.lastname, employees.gender
FROM employees
WHERE firstname = 'Hercules'
AND lastname LIKE 'B%';

6. List each employee in the Sales department, including their employee number, last name, and first name.

SELECT departments.dept_name, employees.emp_no, employees.lastname, employees.firstname
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT departments.dept_name, employees.emp_no, employees.lastname, employees.firstname
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development';

8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT employees.lastname, COUNT(employees.lastname) AS Frequency
FROM employees
GROUP BY lastname
ORDER BY COUNT(lastname) DESC;