# SQL_Challenge

Background
It’s been two weeks since you were hired as a new data engineer at Pewlett Hackard (a fictional company). Your first major task is to do a research project about people whom the company employed during the 1980s and 1990s. All that remains of the employee database from that period are six CSV files.

For this project, you’ll design the tables to hold the data from the CSV files, import the CSV files into a SQL database, and then answer questions about the data. That is, you’ll perform data modeling, data engineering, and data analysis, respectively.

## Data Modeling
Inspect the CSV files, and then sketch an Entity Relationship Diagram of the tables. To create the sketch, feel free to use a tool like QuickDBDLinks to an external site..

## Data Engineering
Use the provided information to create a table schema for each of the six CSV files. Be sure to do the following:

Remember to specify the data types, primary keys, foreign keys, and other constraints.

For the primary keys, verify that the column is unique. Otherwise, create a composite keyLinks to an external site., which takes two primary keys to uniquely identify a row.

Be sure to create the tables in the correct order to handle the foreign keys.

Import each CSV file into its corresponding SQL table.

## Data Analysis
List the employee number, last name, first name, sex, and salary of each employee.

List the first name, last name, and hire date for the employees who were hired in 1986.

List the manager of each department along with their department number, department name, employee number, last name, and first name.

List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

List each employee in the Sales department, including their employee number, last name, and first name.

List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

## Table Schemas
CREATE TABLE Departments (
    Dept_ID VARCHAR NOT NULL,
    Dept_Name VARCHAR NOT NULL,
    CONSTRAINT pk_Departments PRIMARY KEY (Dept_ID)
);

CREATE TABLE DeptEmployee (
    Employee_ID INTEGER NOT NULL,
    Dept_ID VARCHAR NOT NULL,
    CONSTRAINT pk_DeptEmployee PRIMARY KEY (Employee_ID, Dept_ID),
    CONSTRAINT fk_DeptEmployee_Dept_ID FOREIGN KEY (Dept_ID) REFERENCES Departments (Dept_ID)
);

CREATE TABLE Managers (
    Dept_ID VARCHAR NOT NULL,
	Manager_ID INTEGER NOT NULL,
    CONSTRAINT pk_Managers PRIMARY KEY (Manager_ID),
    CONSTRAINT fk_Managers_Dept_ID FOREIGN KEY (Dept_ID) REFERENCES Departments (Dept_ID)
);


CREATE TABLE Titles (
    Title_ID VARCHAR NOT NULL,
    Title VARCHAR NOT NULL,
    CONSTRAINT pk_Titles PRIMARY KEY (Title_ID)
);


CREATE TABLE Employees (
    Employee_ID INTEGER NOT NULL,
    Employee_Title VARCHAR NOT NULL,
    Birthdate DATE NOT NULL,
    First_Name VARCHAR NOT NULL,
    Last_Name VARCHAR NOT NULL,
    Sex VARCHAR NOT NULL,
    Hire_Date DATE NOT NULL,
    CONSTRAINT pk_Employees PRIMARY KEY (Employee_ID),
    CONSTRAINT fk_Employees_Title FOREIGN KEY (Employee_Title) REFERENCES Titles (Title_ID)
);

CREATE TABLE Salaries (
    Employee_ID INTEGER NOT NULL,
    Salary INTEGER NOT NULL,
    CONSTRAINT pk_Salaries PRIMARY KEY (Employee_ID),
    CONSTRAINT fk_Salaries_Employee_ID FOREIGN KEY (Employee_ID) REFERENCES Employees (Employee_ID)
);

## ERD
![Screenshot 2025-02-25 092402](https://github.com/user-attachments/assets/ec0322bb-3bf9-4266-8453-bb2d96849013)

## Analysis Queries
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
WHERE Departments.Dept_ID = 'd007' OR Departments.Dept_ID = 'd005';

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT Employees.Last_Name, COUNT(Last_Name) as last_name_count
FROM Employees
GROUP BY Last_Name
ORDER BY Last_Name DESC;

