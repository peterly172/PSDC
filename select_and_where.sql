-- Employees who work in the Basketball department
SELECT * FROM employees
WHERE sport_id = 5

-- Employees who work in Canada
SELECT * FROM employees
WHERE location_id = 4

-- Employees who work in Athletics and are based in New Zealand
SELECT * FROM employees
WHERE location_id = 6
AND sport_id = 9

--Employees who are female and were hired before 2016
SELECT * FROM employees
WHERE gender = 'F'
AND hire_date < '2016-01-01'

--Employees who work in Cricket and Tennis and are based in Australia
SELECT * FROM employees
WHERE location_id = 3
AND (sport_id = 3 OR sport_id = 4)

