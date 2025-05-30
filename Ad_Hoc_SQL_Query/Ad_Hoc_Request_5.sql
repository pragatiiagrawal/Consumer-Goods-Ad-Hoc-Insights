## Query 5 
SELECT 
	dp.product_code, 
    product, 
    ROUND(manufacturing_cost,2) As manufacturing_cost
FROM 
	dim_product dp
JOIN 
	fact_manufacturing_cost fmc
		ON 
			dp.product_code = fmc.product_code
WHERE manufacturing_cost IN
	(
		SELECT 
			MIN(manufacturing_cost)
		FROM 
			fact_manufacturing_cost
		UNION
		SELECT 
			MAX(manufacturing_cost)
		FROM 
			fact_manufacturing_cost
	)
ORDER BY fmc.manufacturing_cost DESC;