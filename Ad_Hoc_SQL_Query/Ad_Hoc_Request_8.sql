##Query 8 
## This is a function written in comment
-- CREATE DEFINER=`root`@`localhost` FUNCTION `get_fiscal_quarter`(
-- 		calender_date DATE
-- ) RETURNS CHAR(2) CHARSET utf8mb4
--     DETERMINISTIC
-- BEGIN
-- 	DECLARE m TINYINT;
-- 	DECLARE qtr CHAR(2);
-- 	SET m = MONTH(calender_date);
-- CASE
-- 	WHEN m in (9,10,11) THEN SET qtr = "Q1";
--     WHEN m in (12,1,2) THEN SET qtr = "Q2";
--     WHEN m in (3,4,5) THEN SET qtr = "Q3";
--     WHEN m in (6,7,8) THEN SET qtr = "Q4";
-- END CASE ;
-- 	RETURN qtr;
-- END
## Part 1 (Month-Wise)
SELECT 
	DATE_FORMAT (f.date,'%M')AS MONTH,
	get_fiscal_quarter (date) AS Quarter ,
	CONCAT(ROUND(SUM(sold_quantity)/1000000,2),'M') AS total_sold_quantity 
FROM 
	fact_sales_monthly AS f
WHERE 
	fiscal_year = 2020
GROUP BY 
	MONTH,
    Quarter
ORDER BY 
	Quarter ;
    
## Part 2 (Quarter-Wise)  
SELECT 
	get_fiscal_quarter (date) as Quarter ,
	CONCAT(ROUND(SUM(sold_quantity)/1000000,2),'M') AS total_sold_quantity 
FROM 
	fact_sales_monthly AS f
WHERE 
	fiscal_year = 2020
GROUP BY 
	Quarter
ORDER BY 
	total_sold_quantity DESC;

