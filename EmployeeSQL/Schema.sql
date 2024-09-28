CREATE table titles(
		title_id VARCHAR(10) PRIMARY KEY NOT NULL,
		title VARCHAR(50) NOT NULL
	
);

CREATE table employees(
		emp_no INT PRIMARY KEY NOT NULL,
		title_id VARCHAR(10) NOT NULL,
		DOB DATE NOT NULL,
		firstName VARCHAR(30) NOT NULL,
		lastName VARCHAR(30) NOT NULL,
		gender VARCHAR(1) NOT NULL,
		hireDate DATE NOT NULL,
	FOREIGN KEY (title_id) references titles (title_id)
);

CREATE table departments(
	dept_no VARCHAR(10) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(50) NOT NULL
);

CREATE table dept_emp(
		emp_no INT NOT NULL,
		dept_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (emp_no) references employees (emp_no),
	FOREIGN KEY (dept_no) references departments (dept_no)
);


CREATE table salaries(
		emp_no INT NOT NULL,
		salary INT NOT NULL,
	FOREIGN KEY (emp_no) references employees (emp_no)
);

CREATE table dept_manager(
	dept_no VARCHAR(10) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) references employees (emp_no),
	FOREIGN KEY (dept_no) references departments (dept_no)
);

