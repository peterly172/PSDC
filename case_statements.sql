--Employee Salaries
SELECT first_name, salary,
CASE
	WHEN salary < 70000 THEN 'UNDER PAID'
	WHEN salary > 70000 AND salary < 100000 THEN 'PAID WELL'
	ELSE 'CORPORATE'
	END AS salary_outcome
	FROM employees
	ORDER BY salary DESC

--Category count on Underpaid, paid well and Corporate
SELECT a.category, COUNT(*) FROM
(SELECT first_name, salary, location_id,
CASE
	WHEN salary < 50000 THEN 'UNDER PAID'
	WHEN salary > 50000 AND salary < 100000 THEN 'PAID WELL'
	ELSE 'CORPORATE'
	END AS category
	FROM employees
	ORDER BY salary DESC) a
GROUP BY a.category

SELECT 
SUM(CASE WHEN salary < 50000 THEN 1 ELSE 0 END) AS under_paid,
SUM(CASE WHEN salary BETWEEN 50000 AND 100000 THEN 1 ELSE 0 END) AS paid_well,
SUM(CASE WHEN salary > 100000 THEN 1 ELSE 0 END) AS corporate
	FROM employees

--Transposing number of employees from each sport department
SELECT
SUM(CASE WHEN s.name = 'Rugby' THEN 1 ELSE 0 END) AS Rugby_Employees,
SUM(CASE WHEN s.name = 'Tennis' THEN 1 ELSE 0 END) AS Tennis_Employees,
SUM(CASE WHEN s.name = 'Snooker' THEN 1 ELSE 0 END) AS Snooker_Employees,
SUM(CASE WHEN s.name = 'Cricket' THEN 1 ELSE 0 END) AS Cricket_Employees
FROM employees e
JOIN sports s
ON e.sport_id = s.sport_id

--Employees work in which locations via Case Statements
SELECT first_name,
(CASE WHEN location_id = 1 THEN (SELECT country FROM locations WHERE location_id = 1) END) AS location_1,
(CASE WHEN location_id = 2 THEN (SELECT country FROM locations WHERE location_id = 2) END) AS location_2,
(CASE WHEN location_id = 3 THEN (SELECT country FROM locations WHERE location_id = 3) END) AS location_3,
(CASE WHEN location_id = 4 THEN (SELECT country FROM locations WHERE location_id = 4) END) AS location_4,
(CASE WHEN location_id = 5 THEN (SELECT country FROM locations WHERE location_id = 5) END) AS location_5,
(CASE WHEN location_id = 6 THEN (SELECT country FROM locations WHERE location_id = 6) END) AS location_6,
(CASE WHEN location_id = 7 THEN (SELECT country FROM locations WHERE location_id = 7) END) AS location_7,
(CASE WHEN location_id = 8 THEN (SELECT country FROM locations WHERE location_id = 8) END) AS location_8,
(CASE WHEN location_id = 9 THEN (SELECT country FROM locations WHERE location_id = 9) END) AS location_9,
(CASE WHEN location_id = 10 THEN (SELECT country FROM locations WHERE location_id = 10) END) AS location_10
FROM employees

--Number of Employees who work in North America, Oceania and Asia
SELECT COUNT(a.location_2) + COUNT(a.location_4) AS North_America,
COUNT(a.location_3) + COUNT(a.location_6) AS Oceania,
COUNT(a.location_7) + COUNT(a.location_8) AS Asia 
FROM (
SELECT first_name,
(CASE WHEN location_id = 1 THEN (SELECT country FROM locations WHERE location_id = 1) END) AS location_1,
(CASE WHEN location_id = 2 THEN (SELECT country FROM locations WHERE location_id = 2) END) AS location_2,
(CASE WHEN location_id = 3 THEN (SELECT country FROM locations WHERE location_id = 3) END) AS location_3,
(CASE WHEN location_id = 4 THEN (SELECT country FROM locations WHERE location_id = 4) END) AS location_4,
(CASE WHEN location_id = 5 THEN (SELECT country FROM locations WHERE location_id = 5) END) AS location_5,
(CASE WHEN location_id = 6 THEN (SELECT country FROM locations WHERE location_id = 6) END) AS location_6,
(CASE WHEN location_id = 7 THEN (SELECT country FROM locations WHERE location_id = 7) END) AS location_7,
(CASE WHEN location_id = 8 THEN (SELECT country FROM locations WHERE location_id = 8) END) AS location_8,
(CASE WHEN location_id = 9 THEN (SELECT country FROM locations WHERE location_id = 9) END) AS location_9,
(CASE WHEN location_id = 10 THEN (SELECT country FROM locations WHERE location_id = 10) END) AS location_10
FROM employees 
	) a

Total: 

SELECT b.North_America + b.Oceania + b.Asia AS total
FROM (
SELECT COUNT(a.location_2) + COUNT(a.location_4) AS North_America,
COUNT(a.location_3) + COUNT(a.location_6) AS Oceania,
COUNT(a.location_7) + COUNT(a.location_8) AS Asia 
FROM (
SELECT first_name,
(CASE WHEN location_id = 1 THEN (SELECT country FROM locations WHERE location_id = 1) END) AS location_1,
(CASE WHEN location_id = 2 THEN (SELECT country FROM locations WHERE location_id = 2) END) AS location_2,
(CASE WHEN location_id = 3 THEN (SELECT country FROM locations WHERE location_id = 3) END) AS location_3,
(CASE WHEN location_id = 4 THEN (SELECT country FROM locations WHERE location_id = 4) END) AS location_4,
(CASE WHEN location_id = 5 THEN (SELECT country FROM locations WHERE location_id = 5) END) AS location_5,
(CASE WHEN location_id = 6 THEN (SELECT country FROM locations WHERE location_id = 6) END) AS location_6,
(CASE WHEN location_id = 7 THEN (SELECT country FROM locations WHERE location_id = 7) END) AS location_7,
(CASE WHEN location_id = 8 THEN (SELECT country FROM locations WHERE location_id = 8) END) AS location_8,
(CASE WHEN location_id = 9 THEN (SELECT country FROM locations WHERE location_id = 9) END) AS location_9,
(CASE WHEN location_id = 10 THEN (SELECT country FROM locations WHERE location_id = 10) END) AS location_10
FROM employees 
	) a
	) b
