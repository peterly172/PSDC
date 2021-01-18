JOINS

-- List of employees in full with their department name and country
SELECT employee_id, first_name, last_name, email, hire_date, s.name AS sport_dept, gender, salary, l.country AS country
FROM employees e
JOIN sports s ON e.sport_id = s.sport_id
JOIN locations l ON e.location_id = l.location_id

--List of employees and what continent they work in
SELECT first_name, email, continent
FROM employees e, locations l
WHERE e.location_id = l.location_id
AND email IS NOT NULL

--List of employees and what department and country they work in
SELECT first_name, email, name AS sport_dept, country
FROM employees e, locations l, sports s
WHERE e.location_id = l.location_id
AND e.sport_id = s.sport_id
AND email IS NOT NULL 



UNION
--Union joining departments, first names and countries
SELECT DISTINCT name AS sport_dept, first_name
FROM employees e, sports s
WHERE e.sport_id = s.sport_id
UNION ALL
SELECT name, country
FROM sports s, employees e, locations l
WHERE e.sport_id = s.sport_id
AND e.location_id = l.location_id

--Total number of employees
SELECT country, COUNT(*)
FROM employees e, locations l
WHERE e.location_id = l.location_id
GROUP BY country
UNION ALL
SELECT 'TOTAL', COUNT(*)
FROM employees
