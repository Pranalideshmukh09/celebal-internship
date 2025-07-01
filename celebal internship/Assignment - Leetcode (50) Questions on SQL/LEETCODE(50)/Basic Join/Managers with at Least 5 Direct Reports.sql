570. Managers with at Least 5 Direct Reports

SELECT a.name 
FROM Employee a 
JOIN Employee b 
ON a.id = b.managerId 
GROUP BY b.managerId 
HAVING COUNT(*) >= 5