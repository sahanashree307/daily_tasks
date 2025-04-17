
CREATE DATABASE hr_system;


USE hr_system;


CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(223),
    department VARCHAR(223),
    salary DECIMAL);

INSERT INTO employees VALUES 
    (1, 'Alice', 'Engineering', 75000.00),
    (2, 'Bob', 'Marketing', 65000.00),
    (3, 'Charlie', 'Engineering', 80000.00);



show tables; 
select*from employees;
UPDATE employees SET salary = 70000 WHERE id = 2;

select*from employees;
select*from employees where department='Engineering';
DELETE FROM employees WHERE id = 3;
select*from employees;

create table department_stats (
    department VARCHAR(100) PRIMARY KEY,
    avg_salary DECIMAL(10,2)
);
DELIMITER $$

create procedure CalculateAvgSalary(IN dept_name VARCHAR(100))
begin
    declare avg_sal decimal(10,2);

    
    select avg(salary) into avg_sal
    from employees
    where department = dept_name;

  
    insert into department_stats (department, avg_salary)
    value(dept_name, avg_sal)
    on duplicate key update avg_salary = avg_sal;
END$$

DELIMITER ;

call CalculateAvgSalary('Engineering');
select * from department_stats;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    amount DECIMAL(10,2)
);

INSERT INTO sales (sale_id, sale_date, amount) VALUES
(1, '2023-10-01', 100),
(2, '2023-10-02', 200),
(3, '2023-10-03', 150),
(4, '2023-10-04', 300);

WITH OctoberSales AS (
    SELECT * FROM sales
    WHERE sale_date BETWEEN '2023-10-01' AND '2023-10-31'
)
SELECT
    sale_date,
    amount,
    SUM(amount) OVER (ORDER BY sale_date) AS running_total
FROM OctoberSales;









