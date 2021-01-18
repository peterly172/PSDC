COUNT

-- Number of males and females who work for the company
SELECT gender, COUNT(*)
FROM employees
GROUP BY gender

-- Number of hire dates starting 2015
SELECT hire_date, COUNT(*)
FROM employees WHERE hire_date > '31-12-2014'
GROUP BY hire_date

--  Number of employees in each department
SELECT sport_id, COUNT(*) AS num_of_employees
FROM employees 
GROUP BY sport_id
ORDER BY num_of_employees DESC

--Number of employees in each country
SELECT location_id, COUNT(*) AS num_of_employees
FROM employees 
GROUP BY location_id
ORDER BY num_of_employees DESC

SUM
-- Total amount spent on salaries from the company
SELECT SUM(salary) FROM employees

--  Sum of salaries from each country

SELECT country, SUM(salary) AS salary
FROM employees e, locations l
WHERE e.location_id = l.location_id
GROUP BY country
ORDER BY salary DESC

--Sum of salaries via each hire date
SELECT hire_date, SUM(salary) AS salary
FROM employees
GROUP BY hire_date
ORDER BY salary DESC

--Number of goals scored in each stadium capacity less than 40,000 capacity
SELECT venues.name, SUM(hometeam_goal + awayteam_goal) AS total_goals
FROM scores
JOIN venues
ON scores.venue_id = venues.id
WHERE capacity < 40000
GROUP BY venues.name 
ORDER BY total_goals DESC

--Sum of salaries via each sport department
SELECT hire_date, SUM(salary) AS salary
FROM employees
GROUP BY hire_date
ORDER BY salary DESC


MAX

-- Maximum salary by each gender
SELECT gender, MAX(salary) AS max_salary
FROM employees
GROUP BY gender
ORDER BY max_salary DESC

--Maximum salary via each continent
SELECT continent, MAX(salary) AS max_salary
FROM employees e, locations l
WHERE e.location_id = l.location_id
GROUP BY continent
ORDER BY max_salary DESC

--Maximum salary via each sport department
SELECT s.name AS sport_dept, MAX(salary) AS max_salary
FROM employees e, sports s
WHERE e.sport_id = s.sport_id
GROUP BY s.name
ORDER BY max_salary DESC
