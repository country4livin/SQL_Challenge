-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "Departments" (
    "Dept_ID" INTEGER   NOT NULL,
    "Dept_Name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "Dept_ID"
     )
);

CREATE TABLE "DeptEmployee" (
    "Employee_ID" INTEGER   NOT NULL,
    "Dept_ID" INTEGER   NOT NULL,
    CONSTRAINT "pk_DeptEmployee" PRIMARY KEY (
        "Employee_ID","Dept_ID"
     )
);

CREATE TABLE "Managers" (
    "Manager_ID" INTEGER   NOT NULL,
    "Dept_ID" INTEGER   NOT NULL,
    CONSTRAINT "pk_Managers" PRIMARY KEY (
        "Manager_ID"
     )
);

CREATE TABLE "Titles" (
    "Title_ID" VARCHAR   NOT NULL,
    "Title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "Title_ID"
     )
);

CREATE TABLE "Employees" (
    "Employee_ID" INTEGER   NOT NULL,
    "Employee_Title" INTEGER   NOT NULL,
    "Birthdate" INTEGER   NOT NULL,
    "First_Name" VARCHAR   NOT NULL,
    "Last_Name" VARCHAR   NOT NULL,
    "Sex" VARCHAR   NOT NULL,
    "Hire_Date" INTEGER   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "Employee_ID"
     )
);

CREATE TABLE "Salaries" (
    "Employee_ID" INTEGER   NOT NULL,
    "Salary" INTEGER   NOT NULL,
    CONSTRAINT "pk_Salaries" PRIMARY KEY (
        "Employee_ID"
     )
);

ALTER TABLE "Departments" ADD CONSTRAINT "fk_Departments_Dept_ID" FOREIGN KEY("Dept_ID")
REFERENCES "DeptEmployee" ("Dept_ID");

ALTER TABLE "Managers" ADD CONSTRAINT "fk_Managers_Manager_ID" FOREIGN KEY("Manager_ID")
REFERENCES "Employees" ("Employee_ID");

ALTER TABLE "Managers" ADD CONSTRAINT "fk_Managers_Dept_ID" FOREIGN KEY("Dept_ID")
REFERENCES "Departments" ("Dept_ID");

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_Title_ID" FOREIGN KEY("Title_ID")
REFERENCES "Employees" ("Employee_Title");

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_Employee_ID" FOREIGN KEY("Employee_ID")
REFERENCES "DeptEmployee" ("Employee_ID");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_Employee_ID" FOREIGN KEY("Employee_ID")
REFERENCES "Employees" ("Employee_ID");

