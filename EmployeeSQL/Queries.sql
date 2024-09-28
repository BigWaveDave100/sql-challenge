SELECT employees.emp_no, employees.lastname, employees.firstname, employees.gender, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;


SELECT firstname, lastname, hiredate
FROM employees
WHERE hiredate BETWEEN '1/1/1986' AND '12/31/1986'
ORDER BY hiredate;

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.lastname, employees.firstname
FROM departments
JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
JOIN employees
ON employees.emp_no = dept_manager.emp_no;

SELECT dept_emp.dept_no, dept_emp.emp_no, employees.lastname, employees.firstname, departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

SELECT employees.firstname, employees.lastname, employees.gender
FROM employees
WHERE firstname = 'Hercules'
AND lastname LIKE 'B%';

SELECT departments.dept_name, employees.emp_no, employees.lastname, employees.firstname
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales';

SELECT departments.dept_name, employees.emp_no, employees.lastname, employees.firstname
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
OR departments.dept_name = 'Development';

SELECT employees.lastname, COUNT(employees.lastname) AS Frequency
FROM employees
GROUP BY lastname
ORDER BY COUNT(lastname) DESC;
