1045. Customers Who Bought All Products

SELECT customer_id 
FROM Customer 
GROUP BY customer_id
HAVING COUNT(distinct product_key) = (SELECT COUNT(product_key) FROM Product);