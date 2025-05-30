## Query 4
WITH 
	count_2020 AS(
    SELECT 
		dp.segment ,
		COUNT(DISTINCT dp.product_code) AS product_count_2020
	FROM 
		dim_product AS dp
	JOIN 
		fact_sales_monthly AS fsm
			ON 
				dp.product_code = fsm.product_code
	WHERE fiscal_year =2020
	GROUP BY 
		dp.segment
	),
	count_2021 AS(
    SELECT 
		dp.segment,
		COUNT(DISTINCT dp.product_code) AS product_count_2021
	FROM 
		dim_product AS dp
	JOIN 
		fact_sales_monthly AS fsm
			ON 
				dp.product_code = fsm.product_code
	WHERE fiscal_year =2021
	GROUP BY 
		dp.segment
	)
SELECT 
	c20.segment,
	product_count_2020,
    product_count_2021,
	(product_count_2021 - product_count_2020) AS difference
FROM 
	count_2020 as c20
JOIN 
	count_2021 as c21
		ON 
			c20.segment = c21.segment
ORDER BY 
	difference DESC;
