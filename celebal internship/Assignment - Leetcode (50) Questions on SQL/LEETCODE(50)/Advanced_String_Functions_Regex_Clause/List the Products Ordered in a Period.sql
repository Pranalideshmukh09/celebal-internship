1327. List the Products Ordered in a Period

SELECT p.product_name, sum(o.unit) AS unit 
FROM Products p 
JOIN Orders o 
ON p.product_id=o.product_id 
WHERE o.order_date>='2020-02-01' AND o.order_date<='2020-02-29'
GROUP BY o.product_id HAVING unit>=100 ;