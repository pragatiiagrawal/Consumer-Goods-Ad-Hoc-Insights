##Query 9 
WITH 
	channel_sales_2021 as(
		SELECT 
			channel , 
			ROUND(SUM(gross_price * sold_quantity)/1000000,2) AS gross_sales_mln
		FROM 
			fact_sales_monthly AS fsm
		JOIN 
			fact_gross_price  AS fgp
				ON 
					fgp.product_code = fsm.product_code 
                    AND
                    fgp.fiscal_year = fsm.fiscal_year
		JOIN 
			dim_customer AS dc
				ON 
					dc.customer_code = fsm.customer_code 
		WHERE 
			fgp.fiscal_year = 2021
		GROUP BY 
			channel
		ORDER BY 
			gross_sales_mln DESC

	),
	total_sales_2021 AS (
		SELECT 
			SUM(gross_sales_mln) AS total_gross_sales
		FROM 
			channel_sales_2021
	)
SELECT 
	channel,
    CONCAT(gross_sales_mln, 'M') AS gross_sales_mln, 
	CONCAT(ROUND(((gross_sales_mln * 100)/total_gross_sales),2), '%') AS percentage
FROM 
	channel_sales_2021, 
    total_sales_2021;
