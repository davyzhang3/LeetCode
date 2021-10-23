-- Table: Salary

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | employee_id | int  |
-- | amount      | int  |
-- | pay_date    | date |
-- +-------------+------+
-- id is the primary key column for this table.
-- Each row of this table indicates the salary of an employee in one month.
-- employee_id is a foreign key from the Employee table.
--  

-- Table: Employee

-- +---------------+------+
-- | Column Name   | Type |
-- +---------------+------+
-- | employee_id   | int  |
-- | department_id | int  |
-- +---------------+------+
-- employee_id is the primary key column for this table.
-- Each row of this table indicates the department of an employee.
--  

-- Write an SQL query to report the comparison result (higher/lower/same) of the average salary of employees in a department to the company's average salary.

-- Return the result table in any order.

-- The query result format is in the following example.

--  

-- Example 1:

-- Input: 
-- Salary table:
-- +----+-------------+--------+------------+
-- | id | employee_id | amount | pay_date   |
-- +----+-------------+--------+------------+
-- | 1  | 1           | 9000   | 2017/03/31 |
-- | 2  | 2           | 6000   | 2017/03/31 |
-- | 3  | 3           | 10000  | 2017/03/31 |
-- | 4  | 1           | 7000   | 2017/02/28 |
-- | 5  | 2           | 6000   | 2017/02/28 |
-- | 6  | 3           | 8000   | 2017/02/28 |
-- +----+-------------+--------+------------+
-- Employee table:
-- +-------------+---------------+
-- | employee_id | department_id |
-- +-------------+---------------+
-- | 1           | 1             |
-- | 2           | 2             |
-- | 3           | 2             |
-- +-------------+---------------+
-- Output: 
-- +-----------+---------------+------------+
-- | pay_month | department_id | comparison |
-- +-----------+---------------+------------+
-- | 2017-02   | 1             | same       |
-- | 2017-03   | 1             | higher     |
-- | 2017-02   | 2             | same       |
-- | 2017-03   | 2             | lower      |
-- +-----------+---------------+------------+
-- Explanation: 
-- In March, the company's average salary is (9000+6000+10000)/3 = 8333.33...
-- The average salary for department '1' is 9000, which is the salary of employee_id '1' since there is only one employee in this department. So the comparison result is 'higher' since 9000 > 8333.33 obviously.
-- The average salary of department '2' is (6000 + 10000)/2 = 8000, which is the average of employee_id '2' and '3'. So the comparison result is 'lower' since 8000 < 8333.33.

-- With he same formula for the average salary comparison in February, the result is 'same' since both the department '1' and '2' have the same average salary with the company, which is 7000.

# Write your MySQL query statement below
with t1 as(
select avg(amount) as d_avg, date_format(pay_date, "%Y-%m") pay_month, department_id
from salary s
join employee e on s.employee_id = e. employee_id 
group by date_format(pay_date, "%Y-%m"), department_id),

t2 as(
select date_format(pay_date, "%Y-%m") as pay_month, avg(amount) as c_avg
from salary
group by date_format(pay_date, "%Y-%m"))

select t1.pay_month, department_id, case
when d_avg>c_avg then "higher"
when d_avg=c_avg then "same"
else "lower" end as "comparison"
from t1 
join t2 on t1.pay_month = t2.pay_month


