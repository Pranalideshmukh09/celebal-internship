1633. Percentage of Users Attended a Contest

SELECT contest_id, round(count(distinct user_id) * 100 /(select count(user_id) from Users) ,2) AS percentage
FROM  Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id;