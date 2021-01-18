--How much the salaries are paid by each sport department

SELECT first_name, s.name, 
SUM(salary) OVER(PARTITION BY s.name)
FROM employees e2
JOIN sports s ON e2.sport_id = s.sport_id
		   
--Running total of salaries via each hire within the company
SELECT first_name, hire_date, salary,
SUM(salary) OVER(ORDER BY hire_date RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM employees

--Salary bracket for employees within the company
SELECT first_name, email, sport_id, salary,
NTILE(5) OVER(PARTITION BY sport_id ORDER BY salary DESC) salary_bracket
FROM employees
			
--Using First Value for salary for each department
SELECT first_name, email, sport_id, salary,
RANK() OVER(PARTITION BY sport_id ORDER BY salary DESC)
FROM employees

--LEAD
SELECT first_name, last_name, salary,
LEAD(salary) OVER() next_salary
FROM employees

SELECT first_name, l.country AS sport_dept, salary,
LEAD(salary) OVER(PARTITION BY l.country ORDER BY salary DESC) next_high_salary
FROM employees e
JOIN locations l ON e.location_id = l.location_id


--LAG
SELECT first_name, last_name, salary,
LAG(salary) OVER() previous_salary
FROM employees
	
SELECT first_name, s.name AS sport_dept, salary,
LAG(salary) OVER(PARTITION BY s.name ORDER BY salary DESC) next_high_salary
FROM employees e
JOIN sports s ON e.sport_id = s.sport_id
