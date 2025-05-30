## QUERY 2 
WITH unique_products_table_2020 AS(
	SELECT 
		COUNT(DISTINCT product_code) AS unique_products_2020
	FROM 
		fact_sales_monthly 
	WHERE 
		fiscal_year = 2020
	),
	unique_products_table_2021 AS (
	SELECT 
		COUNT(DISTINCT product_code) AS unique_products_2021
	FROM fact_sales_monthly 
	WHERE fiscal_year = 2021
    )
	SELECT 
    *, 
	CONCAT(ROUND(((unique_products_2021 - unique_products_2020)*100)/unique_products_2020,2),'%') as percentage_chg
    FROM 
		unique_products_table_2020,
		unique_products_table_2021;
