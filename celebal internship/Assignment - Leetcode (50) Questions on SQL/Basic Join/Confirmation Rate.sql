1934. Confirmation Rate

SELECT s.user_id, round(avg(if(c.action="confirmed",1,0)),2)
AS confirmation_rate
FROM Signups AS s 
LEFT JOIN Confirmations AS c 
ON s.user_id= c.user_id 
GROUP BY user_id;