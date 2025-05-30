## Query 6
SELECT 
	dc.customer_code, 
    customer,
    CONCAT(ROUND(AVG(pre_invoice_discount_pct *100),2),'%') AS average_discount_percentage
FROM 
	dim_customer AS dc
JOIN 
	fact_pre_invoice_deductions AS fpid
		ON 
			dc.customer_code = fpid.customer_code
WHERE
	pre_invoice_discount_pct > (
    SELECT
		AVG(pre_invoice_discount_pct)
	FROM fact_pre_invoice_deductions
    ) 
    AND
	fiscal_year = 2021 and market = "India"
GROUP BY 
	dc.customer_code,
    customer
ORDER BY 
	average_discount_percentage DESC
LIMIT 
	5;
