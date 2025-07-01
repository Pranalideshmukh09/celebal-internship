1321. Restaurant Growth

SELECT visited_on,
sum(sum(amount)) over (rows between 6 preceding and current row) AS amount,
round(avg(sum(amount)) OVER (rows between 6 preceding and current row),2) AS average_amount
FROM Customer
GROUP BY visited_on
ORDER BY visited_on 
LIMIT 999999 offset 6;