CREATE TABLE sports (
    sport_id SERIAL PRIMARY KEY,
    name varchar(100)
);

CREATE TABLE locations (
location_id SERIAL PRIMARY KEY,
country VARCHAR(50),
continent VARCHAR(50)
);

CREATE TABLE employees (
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	hire_date DATE,
	sport_id INT,
	gender VARCHAR(1),
	salary INT,
	location_id INT
);
