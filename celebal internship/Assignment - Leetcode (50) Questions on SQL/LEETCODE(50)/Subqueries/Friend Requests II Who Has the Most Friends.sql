602. Friend Requests II: Who Has the Most Friends

WITH base AS(SELECT requester_id id FROM RequestAccepted
UNION ALL
SELECT accepter_id id FROM RequestAccepted)

SELECT id, count(*) num  FROM base GROUP BY 1 ORDER BY 2 DESC LIMIT 1;