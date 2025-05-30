##Query 10

WITH 
	division_sales_2021 AS(
		SELECT 
			division,
			dp.product_code,
			CONCAT(dp.product,' (', dp.variant,')') AS product,
			CONCAT(ROUND(SUM(sold_quantity)/1000,2),'K') AS total_sold_quantity
		FROM 
			dim_product AS dp
		JOIN 
			fact_sales_monthly AS fsm
				ON dp.product_code = fsm.product_code
		WHERE 
			fiscal_year = 2021
		GROUP BY 
			division,
			dp.product_code, 
			CONCAT(dp.product, ' (', dp.variant, ')') 
	),
	sales_rank_2021 AS (
		SELECT 
			*, 
			DENSE_RANK() OVER(PARTITION BY division ORDER BY total_sold_quantity DESC) AS rank_order
		FROM division_sales_2021
	)
SELECT 
	*
FROM 
	sales_rank_2021
WHERE 
	rank_order <= 3;