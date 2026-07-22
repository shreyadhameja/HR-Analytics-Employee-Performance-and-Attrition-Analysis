# Summary Statistics

-- Average, Minimum, Maximum for Age
SELECT AVG(Age) AS avg_age, MIN(Age) AS min_age, MAX(Age) AS max_age FROM employees;

-- Average, Minimum, Maximum for MonthlyIncome
SELECT AVG(MonthlyIncome) AS avg_income, MIN(MonthlyIncome) AS min_income, MAX(MonthlyIncome) AS max_income FROM employees;

-- Average, Minimum, Maximum for TotalWorkingYears
SELECT AVG(TotalWorkingYears) AS avg_experience, MIN(TotalWorkingYears) AS min_experience, MAX(TotalWorkingYears) AS max_experience
FROM employees;

-- Average YearsAtCompany
SELECT AVG(YearsAtCompany) AS avg_years_at_company, MIN(YearsAtCompany) AS min_years_at_company, MAX(YearsAtCompany) AS max_years_at_company
FROM employees;

# Distribution of Categorical Columns

-- Count of employees by Gender
SELECT Gender, COUNT(*) AS count_gender
FROM employees
GROUP BY Gender;

-- Count of employees by Department
SELECT Department, COUNT(*) AS count_department
FROM employees
GROUP BY Department;

-- Count of employees by JobRole
SELECT JobRole, COUNT(*) AS count_jobrole
FROM employees
GROUP BY JobRole;

-- Count of employees by MaritalStatus
SELECT MaritalStatus, COUNT(*) AS count_marital_status
FROM employees
GROUP BY MaritalStatus;

-- Count of employees by EducationField
SELECT EducationField, COUNT(*) AS count_education_field
FROM employees
GROUP BY EducationField;

# Attrition Analysis

-- Overall attrition count and rate
SELECT SUM(Attrition) AS total_left, COUNT(*) AS total_employees,
       (SUM(Attrition)/COUNT(*))*100 AS attrition_rate_percentage
FROM employees;

-- Attrition by Department
SELECT Department, COUNT(*) AS total_employees,
       SUM(Attrition) AS left_employees,
       (SUM(Attrition)/COUNT(*))*100 AS attrition_rate
FROM employees
GROUP BY Department;

-- Attrition by JobRole
SELECT JobRole, COUNT(*) AS total_employees,
       SUM(Attrition) AS left_employees,
       (SUM(Attrition)/COUNT(*))*100 AS attrition_rate
FROM employees
GROUP BY JobRole;

-- Attrition by Gender
SELECT Gender, COUNT(*) AS total_employees,
       SUM(Attrition) AS left_employees,
       (SUM(Attrition)/COUNT(*))*100 AS attrition_rate
FROM employees
GROUP BY Gender;

# Numeric Insights by Category

-- Average MonthlyIncome by Department
SELECT Department, AVG(MonthlyIncome) AS avg_income
FROM employees
GROUP BY Department;

-- Average TotalWorkingYears by JobRole
SELECT JobRole, AVG(TotalWorkingYears) AS avg_experience
FROM employees
GROUP BY JobRole;

-- Average MonthlyIncome by Attrition
SELECT Attrition, AVG(MonthlyIncome) AS avg_income
FROM employees
GROUP BY Attrition;

-- Average YearsAtCompany by Attrition
SELECT Attrition, AVG(YearsAtCompany) AS avg_years
FROM employees
GROUP BY Attrition;

# Feature Engineering in SQL

-- Create Tenure Category based on YearsAtCompany
ALTER TABLE employees ADD COLUMN TenureCategory VARCHAR(10);

UPDATE employees
SET TenureCategory = CASE
    WHEN YearsAtCompany <= 2 THEN 'Short'
    WHEN YearsAtCompany <= 5 THEN 'Medium'
    ELSE 'Long'
END;

-- Create Income Bracket based on MonthlyIncome
ALTER TABLE employees ADD COLUMN IncomeBracket VARCHAR(10);

UPDATE employees
SET IncomeBracket = CASE
    WHEN MonthlyIncome < 3000 THEN 'Low'
    WHEN MonthlyIncome <= 7000 THEN 'Medium'
    ELSE 'High'
END;

-- Check counts for each category
SELECT TenureCategory, COUNT(*) AS count_by_tenure
FROM employees
GROUP BY TenureCategory;

SELECT IncomeBracket, COUNT(*) AS count_by_income
FROM employees
GROUP BY IncomeBracket;

# Correlation Checks (Aggregated Insights)

-- Average Age by Attrition
SELECT Attrition, AVG(Age) AS avg_age
FROM employees
GROUP BY Attrition;

-- Average MonthlyIncome by JobRole and Attrition
SELECT JobRole, Attrition, AVG(MonthlyIncome) AS avg_income
FROM employees
GROUP BY JobRole, Attrition;

-- Average TotalWorkingYears by Department and Attrition
SELECT Department, Attrition, AVG(TotalWorkingYears) AS avg_experience
FROM employees
GROUP BY Department, Attrition;

