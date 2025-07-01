1204. Last Person to Fit in the Bus

SELECT queue1.person_name
FROM queue queue1 join queue queue2
ON queue1.turn >= queue2.turn
GROUP BY queue1.turn HAVING sum(queue2.weight) <= 1000
ORDER BY sum(queue2.weight) desc
LIMIT 1;