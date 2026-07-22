-- 1. Use the HR database
USE hr_analytics;

-- 2. Create a working copy of raw employee data
CREATE TABLE employees AS
SELECT * FROM employees_raw;

-- 3. Inspect the data to understand its structure and content
SELECT * FROM employees;

-- 4. Fix the BOM / weird encoding issue in Age column
ALTER TABLE employees
CHANGE `ï»¿Age` Age INT;

-- 5. Convert Attrition column from text to numeric (Yes → 1, No → 0)
UPDATE employees
SET Attrition =
CASE
    WHEN Attrition = 'Yes' THEN 1
    ELSE 0
END;

-- 6. Replace NULLs in MonthlyIncome and TotalWorkingYears with 0
UPDATE employees
SET MonthlyIncome = IFNULL(MonthlyIncome, 0),
    TotalWorkingYears = IFNULL(TotalWorkingYears, 0);

-- 7. Check for remaining NULLs in critical columns
SELECT
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS null_income,
    SUM(CASE WHEN TotalWorkingYears IS NULL THEN 1 ELSE 0 END) AS null_exp
FROM employees;

-- 8. Check column names to ensure consistency
SHOW COLUMNS FROM employees;

-- 9. Check for duplicate EmployeeNumber values
SELECT EmployeeNumber, COUNT(*)
FROM employees
GROUP BY EmployeeNumber
HAVING COUNT(*) > 1;

-- 10. Check min and max of Age to validate range
SELECT MIN(Age) AS min_age, MAX(Age) AS max_age
FROM employees;

-- 11. Check min and max of MonthlyIncome to validate range
SELECT MIN(MonthlyIncome) AS min_income, MAX(MonthlyIncome) AS max_income
FROM employees;

-- 12. Count of employees by Attrition status (0 or 1)
SELECT Attrition, COUNT(*) AS count
FROM employees
GROUP BY Attrition;

-- 13. Check distinct values in Gender column for consistency
SELECT DISTINCT Gender
FROM employees;

-- 14. Check distinct values in Department column for consistency
SELECT DISTINCT Department
FROM employees;
