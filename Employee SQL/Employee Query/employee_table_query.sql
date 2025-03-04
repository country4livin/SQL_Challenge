<<<<<<< HEAD:Employee SQL/Employee Query/employee_table_query.sql
CREATE TABLE Departments (
    Dept_ID VARCHAR(6) NOT NULL,
    Dept_Name VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (Dept_ID)
);

SELECT * from Departments;

CREATE TABLE DeptEmployee (
    Employee_ID INTEGER NOT NULL,
    Dept_ID VARCHAR(6) NOT NULL,
    CONSTRAINT pk_DeptEmployee PRIMARY KEY (Employee_ID, Dept_ID),
    CONSTRAINT fk_DeptEmployee_Dept_ID FOREIGN KEY (Dept_ID) REFERENCES Departments (Dept_ID)
);

SELECT * from DeptEmployee;

CREATE TABLE Managers (
    Dept_ID VARCHAR(6) NOT NULL,
	Manager_ID INTEGER NOT NULL,
    CONSTRAINT pk_Managers PRIMARY KEY (Manager_ID, Dept_ID),
    CONSTRAINT fk_Managers_Dept_ID FOREIGN KEY (Dept_ID) REFERENCES Departments (Dept_ID)
);

SELECT * from Managers;

CREATE TABLE Titles (
    Title_ID VARCHAR(20) NOT NULL,
    Title VARCHAR(30) NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (Title_ID)
);

SELECT * from Titles;

CREATE TABLE Employees (
    Employee_ID INTEGER NOT NULL,
    Employee_Title VARCHAR(50) NOT NULL,
    Birthdate DATE NOT NULL,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Sex CHAR(1) NOT NULL,
    Hire_Date DATE NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (Employee_ID),
    CONSTRAINT fk_Employees_Title FOREIGN KEY (Employee_Title) REFERENCES Titles (Title_ID)
);

SELECT * from Employees;

CREATE TABLE Salaries (
    Employee_ID INTEGER NOT NULL,
    Salary INTEGER NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (Employee_ID),
    CONSTRAINT fk_Salaries_Employee_ID FOREIGN KEY (Employee_ID) REFERENCES Employees (Employee_ID)
);

SELECT * from Salaries;

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT Employees.Employee_ID, Employees.Last_Name, Employees.First_Name, Employees.Sex, Salaries.Salary
FROM Employees
JOIN Salaries ON Employees.Employee_ID = Salaries.Employee_ID;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT Employees.Last_Name, Employees.First_Name, Employees.Hire_Date
FROM Employees
WHERE Hire_Date >= '1986-01-01' AND Hire_Date < '1987-01-01';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT Managers.Dept_ID, Departments.Dept_Name, Managers.Manager_ID, Employees.Last_Name, Employees.First_Name
FROM Managers
JOIN Departments ON Managers.Dept_ID = Departments.Dept_ID
JOIN Employees ON Managers.Manager_ID = Employees.Employee_ID;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT DeptEmployee.Dept_ID, Departments.Dept_Name, Employees.Employee_ID, Employees.Last_Name, Employees.First_Name
FROM DeptEmployee
JOIN Departments ON DeptEmployee.Dept_ID = Departments.Dept_ID
JOIN Employees ON Employees.Employee_ID = DeptEmployee.Employee_ID;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT Employees.Last_Name, Employees.First_Name, Employees.Sex
FROM Employees
WHERE Employees.First_Name = 'Hercules' AND Employees.Last_Name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT Employees.Employee_ID, Employees.Last_Name, Employees.First_Name, DeptEmployee.Dept_ID
FROM Employees
JOIN DeptEmployee ON DeptEmployee.Employee_ID = Employees.Employee_ID
JOIN Departments ON Departments.Dept_ID = DeptEmployee.Dept_ID
WHERE Departments.Dept_ID = 'd007';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT Employees.Employee_ID, Employees.Last_Name, Employees.First_Name, Departments.Dept_Name
FROM Employees
JOIN DeptEmployee ON Employees.Employee_ID = DeptEmployee.Employee_ID
JOIN Departments ON Departments.Dept_ID = DeptEmployee.Dept_ID
WHERE Departments.Dept_ID IN ('d007', 'd005');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT Employees.Last_Name, COUNT(Last_Name) as last_name_count
FROM Employees
GROUP BY Last_Name
ORDER BY last_name_count DESC;

=======
CREATE TABLE Departments (
    Dept_ID VARCHAR(6) NOT NULL,
    Dept_Name VARCHAR(20) NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (Dept_ID)
);

SELECT * from Departments;

CREATE TABLE DeptEmployee (
    Employee_ID INTEGER NOT NULL,
    Dept_ID VARCHAR(6) NOT NULL,
    CONSTRAINT pk_DeptEmployee PRIMARY KEY (Employee_ID, Dept_ID),
    CONSTRAINT fk_DeptEmployee_Dept_ID FOREIGN KEY (Dept_ID) REFERENCES Departments (Dept_ID)
);

SELECT * from DeptEmployee;

CREATE TABLE Managers (
    Dept_ID VARCHAR(6) NOT NULL,
	Manager_ID INTEGER NOT NULL,
    CONSTRAINT pk_Managers PRIMARY KEY (Manager_ID, Dept_ID),
    CONSTRAINT fk_Managers_Dept_ID FOREIGN KEY (Dept_ID) REFERENCES Departments (Dept_ID)
);

SELECT * from Managers;

CREATE TABLE Titles (
    Title_ID VARCHAR(20) NOT NULL,
    Title VARCHAR(30) NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (Title_ID)
);

SELECT * from Titles;

CREATE TABLE Employees (
    Employee_ID INTEGER NOT NULL,
    Employee_Title VARCHAR(50) NOT NULL,
    Birthdate DATE NOT NULL,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Sex VARCHAR(1) NOT NULL,
    Hire_Date DATE NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (Employee_ID),
    CONSTRAINT fk_Employees_Title FOREIGN KEY (Employee_Title) REFERENCES Titles (Title_ID)
);

SELECT * from Employees;

CREATE TABLE Salaries (
    Employee_ID INTEGER NOT NULL,
    Salary INTEGER NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (Employee_ID),
    CONSTRAINT fk_Salaries_Employee_ID FOREIGN KEY (Employee_ID) REFERENCES Employees (Employee_ID)
);

SELECT * from Salaries;

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT Employees.Employee_ID, Employees.Last_Name, Employees.First_Name, Employees.Sex, Salaries.Salary
FROM Employees
JOIN Salaries ON Employees.Employee_ID = Salaries.Employee_ID;

--List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT Employees.Last_Name, Employees.First_Name, Employees.Hire_Date
FROM Employees
WHERE Hire_Date >= '1986-01-01' AND Hire_Date < '1987-01-01';

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT Managers.Dept_ID, Departments.Dept_Name, Managers.Manager_ID, Employees.Last_Name, Employees.First_Name
FROM Managers
JOIN Departments ON Managers.Dept_ID = Departments.Dept_ID
JOIN Employees ON Managers.Manager_ID = Employees.Employee_ID;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT DeptEmployee.Dept_ID, Departments.Dept_Name, Employees.Employee_ID, Employees.Last_Name, Employees.First_Name
FROM DeptEmployee
JOIN Departments ON DeptEmployee.Dept_ID = Departments.Dept_ID
JOIN Employees ON Employees.Employee_ID = DeptEmployee.Employee_ID;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT Employees.Last_Name, Employees.First_Name, Employees.Sex
FROM Employees
WHERE Employees.First_Name = 'Hercules' AND Employees.Last_Name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT Employees.Employee_ID, Employees.Last_Name, Employees.First_Name, DeptEmployee.Dept_ID
FROM Employees
JOIN DeptEmployee ON DeptEmployee.Employee_ID = Employees.Employee_ID
JOIN Departments ON Departments.Dept_ID = DeptEmployee.Dept_ID
WHERE Departments.Dept_ID = 'd007';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT Employees.Employee_ID, Employees.Last_Name, Employees.First_Name, Departments.Dept_Name
FROM Employees
JOIN DeptEmployee ON Employees.Employee_ID = DeptEmployee.Employee_ID
JOIN Departments ON Departments.Dept_ID = DeptEmployee.Dept_ID
WHERE Departments.Dept_ID IN ('d007', 'd005');

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT Employees.Last_Name, COUNT(Last_Name) as last_name_count
FROM Employees
GROUP BY Last_Name
ORDER BY last_name_count DESC;

>>>>>>> 0933ec8486353953afab2c41acb8a8a6904fdb78:Employee SQL/employee_table_query.sql
