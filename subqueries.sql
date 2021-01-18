--Number of employees who earn more than 90,000 
SELECT a.employee_name, a.yearly_salary FROM 
(SELECT first_name employee_name, salary yearly_salary FROM employees WHERE salary > 90000) a

--Employees who work in the Golf department
SELECT * FROM employees 
WHERE sport_id IN (SELECT sport_id FROM sports WHERE name = 'Golf')

--Employees who work in Canada or Asia and earn more than 50,000
SELECT * FROM employees 
WHERE salary > 50000 
AND location_id IN (SELECT location_id FROM locations WHERE country = 'Canada'
					  OR continent = 'Asia')

--Employees who work in USA or India and earn more than 65,000
SELECT * FROM employees 
WHERE salary > 65000 
AND location_id IN (SELECT location_id FROM locations WHERE country IN ('United States', 'India'))

¬--Employees salary difference to maximum salary who work in North America and Europe
SELECT first_name, last_name, sport_id, salary, (SELECT MAX(salary) FROM employees) AS max_salary,
(SELECT MAX(salary) FROM employees) - salary AS diff_salary
FROM employees
WHERE location_id IN (SELECT location_id FROM locations WHERE continent IN ('North America', 'Europe'))

--Employees who work in the football department and their hire date is later than the hire dates for employees who work in the Snooker department
SELECT * FROM employees
WHERE sport_id = ANY (SELECT sport_id FROM sports WHERE name = 'Football')
AND hire_date > ALL (SELECT hire_date FROM employees 
				   WHERE sport_id IN (SELECT sport_id FROM sports WHERE sports.name = 'Snooker'))

--Most frequent salaries
SELECT salary FROM (SELECT salary, COUNT(*)
FROM employees
GROUP BY salary
ORDER BY COUNT(*) DESC
LIMIT 1
) a

SELECT salary 
FROM employees
GROUP BY salary
HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM employees
					  GROUP BY salary)


--Average salaries not including Max and Min salary
SELECT ROUND(AVG(salary)) 
FROM employees
WHERE salary NOT IN (
	(SELECT MAX(salary) FROM employees),
	(SELECT MIN(salary) FROM employees)
	)

--Salaries that are more than the average based on locations
SELECT first_name,salary
FROM employees e1
WHERE salary > (SELECT ROUND(AVG(salary)) FROM employees e2 
				WHERE e1.location_id = e2.location_id)

SELECT first_name, salary,
(SELECT ROUND(AVG(salary)) FROM employees e2 
				WHERE e1.location_id = e2.location_id) AS avg_salary
				FROM employees e1
				ORDER BY avg_salary

--Salaries that are more than the average based on sport departments
SELECT first_name,salary
FROM employees e1
WHERE salary > (SELECT ROUND(AVG(salary)) FROM employees e2 
				WHERE e1.sport_id = e2.sport_id)
				ORDER BY salary

--Sport Departments that have more than 25 employees
SELECT name 
FROM sports s
WHERE 25 < (SELECT COUNT(*)
		   FROM employees e
		   WHERE e.sport_id = s.sport_id)



--Maximum Salaries from each department
SELECT name, (SELECT MAX(salary) FROM employees WHERE sport_id = s.sport_id) 
FROM sports s

-- Maximum Salaries from each country
SELECT country, (SELECT MAX(salary) FROM employees WHERE location_id = l.location_id) 
FROM locations l

--Minimum Salaries from each department
SELECT name, (SELECT MIN(salary) FROM employees WHERE sport_id = s.sport_id) 
FROM sports s

--Employees that make the highest and lowest salary from each Sports Department
SELECT s.name AS sport_department, first_name, salary, 
CASE WHEN salary = department_max THEN 'Highest Salary'
WHEN salary = department_min THEN 'Lowest Salary'
END AS salary_outcome_department
FROM (
SELECT sport_id, first_name, salary,
		(SELECT MAX(salary) FROM employees e2
		 WHERE e1.sport_id = e2.sport_id) AS department_max,
		 (SELECT MIN(salary) FROM employees e2
		 WHERE e1.sport_id = e2.sport_id) AS department_min
FROM employees e1
	) a
	JOIN sports s ON a.sport_id = s.sport_id
WHERE salary = department_max OR salary = department_min
ORDER BY sport_department, salary DESC

--Employees that make the highest and lowest salary from each country
SELECT l.country AS country, first_name, salary, 
CASE WHEN salary = country_max THEN 'Highest Salary'
WHEN salary = country_min THEN 'Lowest Salary'
END AS salary_outcome_location
FROM (
SELECT location_id, first_name, salary,
		(SELECT MAX(salary) FROM employees e2
		 WHERE e1.location_id = e2.location_id) AS country_max,
		 (SELECT MIN(salary) FROM employees e2
		 WHERE e1.location_id = e2.location_id) AS country_min
FROM employees e1
	) a
	JOIN locations l ON a.location_id = l.location_id
WHERE salary = country_max OR salary = country_min
ORDER BY country, salary DESC

--First and last employee hired in the company 

SELECT first_name, s.name AS sport_department, hire_date, l.country FROM
(SELECT first_name, sport_id, hire_date, e.location_id,
(SELECT MIN (hire_date) FROM employees) AS first_hire,
(SELECT MAX(hire_date) FROM employees) AS last_hire
FROM employees e, locations l
WHERE e.location_id = l.location_id) a
JOIN sports s ON a.sport_id = s.sport_id
JOIN locations l On a.location_id = l.location_id
WHERE hire_date = first_hire OR hire_date = last_hire

SELECT first_name, s.name, hire_date, country
FROM employees e JOIN sports s
ON e.sport_id = s.sport_id
JOIN locations l ON e.location_id = l.location_id
WHERE hire_date = (SELECT MIN(hire_date) FROM employees e2)
UNION
SELECT first_name, s.name, hire_date, country
FROM employees e JOIN sports s
ON e.sport_id = s.sport_id
JOIN locations l ON e.location_id = l.location_id
WHERE hire_date = (SELECT MAX(hire_date) FROM employees e2)
