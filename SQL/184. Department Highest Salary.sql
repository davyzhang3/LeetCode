-- Table: Employee

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | Id           | int     |
-- | Name         | varchar |
-- | Salary       | int     |
-- | DepartmentId | int     |
-- +--------------+---------+
-- Id is the primary key column for this table.
-- DepartmentId is a foreign key of the ID from the Department table.
-- Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
--  

-- Table: Department

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | Id          | int     |
-- | Name        | varchar |
-- +-------------+---------+
-- Id is the primary key column for this table.
-- Each row of this table indicates the ID of a department and its name.
--  

-- Write an SQL query to find employees who have the highest salary in each of the departments.

-- Return the result table in any order.

-- The query result format is in the following example.

--  

-- Example 1:

-- Input: 
-- Employee table:
-- +----+-------+--------+--------------+
-- | Id | Name  | Salary | DepartmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 70000  | 1            |
-- | 2  | Jim   | 90000  | 1            |
-- | 3  | Henry | 80000  | 2            |
-- | 4  | Sam   | 60000  | 2            |
-- | 5  | Max   | 90000  | 1            |
-- +----+-------+--------+--------------+
-- Department table:
-- +----+-------+
-- | Id | Name  |
-- +----+-------+
-- | 1  | IT    |
-- | 2  | Sales |
-- +----+-------+
-- Output: 
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Jim      | 90000  |
-- | Sales      | Henry    | 80000  |
-- | IT         | Max      | 90000  |
-- +------------+----------+--------+
-- Explanation: Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.

-- create view doesn't work in leetcode
select departmentid, max(salary) as max_salary
from employee 
group by departmentid;

create view sub2 as 
select e.*
from employee e, sub 
where e.salary = sub.max_salary and e.departmentid = sub.departmentid;

select sub2.name as Employee, d.name as Department, sub2.salary
from sub2 
join department d on d.id=sub2.departmentid;



-- solution2
select  d.name as Department, sub2.name as Employee, sub2.salary
from (select e.*
from employee e, (select departmentid, max(salary) as max_salary
from employee 
group by departmentid) as sub 
where e.salary = sub.max_salary and e.departmentid = sub.departmentid ) as sub2
join department d on d.id=sub2.departmentid;

-- solution3
SELECT
	Department.NAME AS Department,
	Employee.NAME AS Employee,
	Salary 
FROM
	Employee,
	Department 
WHERE
	Employee.DepartmentId = Department.Id 
	AND ( Employee.DepartmentId, Salary ) 
    IN (SELECT DepartmentId, max( Salary ) 
        FROM Employee 
        GROUP BY DepartmentId )
