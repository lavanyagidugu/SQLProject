show databases;
SELECT * FROM Lavanya_Gidugu.employee_demographics;
SELECT * FROM Lavanya_Gidugu.employee_salary;
SELECT * FROM Lavanya_Gidugu.parks_departments;
SELECT 
    table_name,
    table_rows
FROM information_schema.tables
WHERE table_schema = 'Lavanya_Gidugu';

select * from Lavanya_Gidugu.employee_demographics 
where age>40 and gender='Female';

select * from Lavanya_Gidugu.employee_demographics 
where (age>40 and gender='Female') or first_name='Leslie';

select * from Lavanya_Gidugu.employee_demographics
where (age>40 and gender='Female') and first_name='Leslie';

##Employees earning 75k–120k in Nurse, City Manager
SELECT first_name, last_name, occupation, salary
FROM Lavanya_Gidugu.employee_salary
WHERE salary BETWEEN 55000 AND 120000
  AND occupation IN ('Nurse', 'City Manager');
  
SELECT *
FROM Lavanya_Gidugu.employee_salary
WHERE occupation NOT IN ('Nurse', 'City Manager');
## give gmailid's without number
SELECT *
FROM Lavanya_Gidugu.employee_salary
WHERE employee_email NOT REGEXP '[0-9]';

SELECT first_name, last_name
FROM Lavanya_Gidugu.employee_salary
WHERE first_name LIKE CONCAT(LEFT(first_name,1), '%', LEFT(first_name,1));


select * from Lavanya_Gidugu.employee_demographics 
where first_name like 'A__';

select * from Lavanya_Gidugu.employee_demographics 
where first_name like 'A%' and gender='female';


