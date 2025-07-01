1164. Product Price at a Given Date

SELECT product_id ,10 AS price 
FROM products GROUP BY product_id HAVING min(change_date) > '2019-08-16'
UNION ALL
SELECT product_id , new_price AS price FROM products
WHERE( product_id , change_date) IN (SELECT product_id , max(change_date) 
AS price FROM products WHERE change_date <=  '2019-08-16' GROUP BY product_id);