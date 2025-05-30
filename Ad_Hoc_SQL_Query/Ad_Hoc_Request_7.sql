## Query 7 
SELECT 
	DATE_FORMAT(fsm.DATE,'%M')AS MONTH,
	(fsm.fiscal_year) AS Year ,
	CONCAT(ROUND(SUM(gross_price * sold_quantity)/1000000,2),'M') as Gross_Sales_Amount
FROM 
	fact_sales_monthly AS fsm
JOIN 
	fact_gross_price  AS fgp
		ON 
			fgp.product_code = fsm.product_code AND fgp.fiscal_year = fsm.fiscal_year
JOIN 
	dim_customer AS dc
		ON 
			dc.customer_code = fsm.customer_code 
WHERE customer = 'Atliq Exclusive'
GROUP BY 
	MONTH, 
    YEAR 
ORDER BY  
	YEAR ;