-- Table: Numbers

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | number      | int  |
-- | frequency   | int  |
-- +-------------+------+
-- number is the primary key for this table.
-- Each row of this table shows the frequency of a number in the database.
--  

-- The median is the value separating the higher half from the lower half of a data sample.

-- Write an SQL query to report the median of all the numbers in the database after decompressing the Numbers table. Round the median to one decimal point.

-- The query result format is in the following example.

--  

-- Example 1:

-- Input: 
-- Numbers table:
-- +--------+-----------+
-- | Number | Frequency |
-- +--------+-----------+
-- | 0      | 7         |
-- | 1      | 1         |
-- | 2      | 3         |
-- | 3      | 1         |
-- +--------+-----------+
-- Output: 
-- +--------+
-- | median |
-- +--------+
-- | 0.0    |
-- +--------+
-- Explanation: 
-- If we decompress the Numbers table, we will get [0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3], so the median is (0 + 0) / 2 = 0.

select avg(number) as median
from
(select number, sum(frequency) over(order by number asc) as asc_amount, 
                sum(frequency) over(order by number desc) as desc_amount,
                sum(frequency) over() as total_num
from numbers) a
where asc_amount >= total_num/2 and desc_amount >= total_num / 2 