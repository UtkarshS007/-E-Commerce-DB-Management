# QUERY 1
SELECT c.cust_id, COUNT(DISTINCT s.order_id) AS total_orders
FROM dma_project1.customer_details c
LEFT JOIN dma_project1.sales s ON s.customer_id = c.CUST_ID
GROUP BY c.cust_id
ORDER BY total_orders DESC;

# QUERY 2
SELECT DISTINCT 
	CONCAT(c.first_name, " ", c.last_name) AS customer_name, 
	ROUND(SUM((s.sales_price * (1 - (s.discount_applied/100)))),2) AS total_spending
FROM 
	dma_project1.customer_details c
RIGHT JOIN	
	dma_project1.sales s ON s.customer_id = c.CUST_ID
GROUP BY 
	s.customer_id, s.order_id
HAVING 
	total_spending > 75.00
ORDER BY 
	total_spending DESC;
    
    
# QUERY 3
SELECT 
	s.warehouse_id, p.brand_name, SUM(s.stock_quantity) AS total_quantity
FROM
	dma_project1.product_info p
RIGHT JOIN
	dma_project1.stock_details s ON s.product_id = p.product_id
GROUP BY
	s.warehouse_id, p.brand_name
ORDER BY
	s.warehouse_id;



# QUERY 4

SELECT 
	s.campaign_id,
    c.campaign_name,
	ROUND(SUM(s.sales_price * (1 - (s.discount_applied/100))),2) AS total_spending
FROM 
	dma_project1.sales s
LEFT JOIN
	dma_project1.campaign_details c ON c.campaign_id = s.campaign_id
WHERE
	c.campaign_id <> 1
GROUP BY
	campaign_id
ORDER BY 
	total_spending DESC
LIMIT 1;

    
# QUERY 5
WITH cal_total_order AS (
	SELECT  
		l.ship_partner_name,
		l.city,
		COUNT(l.ship_id) AS total_shipment_order,
        ship_partner_id
	FROM
		dma_project1.logistic_details l
	GROUP BY
		l.ship_partner_name, l.city),
	ranking AS(
    SELECT
		ship_partner_name,
        city,
        total_shipment_order,
        DENSE_RANK() OVER(PARTITION BY ship_partner_id ORDER BY total_shipment_order DESC) AS rnk
	FROM
		cal_total_order)
SELECT
    ship_partner_name,
    city,
    total_shipment_order
FROM
	ranking
WHERE
	rnk = 1;
    


# QUERY 6
WITH site_id_cal AS(
	SELECT 
		*,
		CASE WHEN email LIKE '%@husky.com%' THEN 'yes' ELSE 'no' END AS site_id
	FROM
		dma_project1.customer_details)

SELECT
	SUM(CASE WHEN site_id = 'yes' THEN 1 ELSE 0 END) AS no_of_customer_with_website_acount,
    SUM(CASE WHEN site_id = 'no' THEN 1 ELSE 0 END) AS no_of_customer_with_own_acount
FROM
	site_id_cal;
    
# QUERY 7
SELECT
	c2.campaign_name,
	COUNT(c1.cust_id) AS total_registered_users 
FROM
	dma_project1.customer_details c1
LEFT JOIN
	dma_project1.sales s ON s.customer_id = c1.cust_id
LEFT JOIN
	dma_project1.campaign_details c2 ON c2.campaign_id = s.campaign_id
WHERE
	c2.campaign_id = 2 AND c1.registered_date BETWEEN c2.c_start_date AND c2.c_end_date
UNION ALL
SELECT
	c2.campaign_name,
	COUNT(c1.cust_id) AS total_registered_users 
FROM
	dma_project1.customer_details c1
LEFT JOIN
	dma_project1.sales s ON s.customer_id = c1.cust_id
LEFT JOIN
	dma_project1.campaign_details c2 ON c2.campaign_id = s.campaign_id
WHERE
	c2.campaign_id = 3 AND c1.registered_date BETWEEN c2.c_start_date AND c2.c_end_date
UNION ALL
SELECT
	c2.campaign_name,
	COUNT(c1.cust_id) AS total_registered_users 
FROM
	dma_project1.customer_details c1
LEFT JOIN
	dma_project1.sales s ON s.customer_id = c1.cust_id
LEFT JOIN
	dma_project1.campaign_details c2 ON c2.campaign_id = s.campaign_id
WHERE
	c2.campaign_id = 4 AND c1.registered_date BETWEEN c2.c_start_date AND c2.c_end_date
UNION ALL
SELECT
	c2.campaign_name,
	COUNT(c1.cust_id) AS total_registered_users 
FROM
	dma_project1.customer_details c1
LEFT JOIN
	dma_project1.sales s ON s.customer_id = c1.cust_id
LEFT JOIN
	dma_project1.campaign_details c2 ON c2.campaign_id = s.campaign_id
WHERE
	c2.campaign_id = 5 AND c1.registered_date BETWEEN c2.c_start_date AND c2.c_end_date;
    
    






# QUERY 8
SELECT
	c.campaign_name,
    p.brand_name,
    COUNT(order_id) AS total_sold_promotional_item
FROM
	dma_project1.sales s
RIGHT JOIN
	dma_project1.campaign_details c ON c.campaign_id = s.campaign_id AND c.product_id = s.product_id
LEFT JOIN
	dma_project1.product_info p ON p.product_id = c.product_id
WHERE
	c.campaign_id <> 1
GROUP BY
	s.campaign_id
ORDER BY
	total_sold_promotional_item ASC;
    


# QUERY 9

SELECT
	p.product_category,
	COUNT(*) AS category_based_total_sales
FROM
	dma_project1.sales s
LEFT JOIN
	dma_project1.product_info p ON p.product_id = s.product_id
GROUP BY
	p.product_category
ORDER BY
	category_based_total_sales ASC;