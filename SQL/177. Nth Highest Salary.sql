-- <!-- Table: Employee

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | Id          | int  |
-- | Salary      | int  |
-- +-------------+------+
-- Id is the primary key column for this table.
-- Each row of this table contains information about the salary of an employee.
--  

-- Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

-- The query result format is in the following example.

--  

-- Example 1:

-- Input: 
-- Employee table:
-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+
-- Example 2:

-- Input: 
-- Employee table:
-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- n = 2
-- Output: 
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | Null                   |
-- +------------------------+ -->

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
set N:=N-1;
  RETURN (
      # Write your MySQL query statement below.
      SELECT 
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET N)
  );
END