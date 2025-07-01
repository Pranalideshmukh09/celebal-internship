1978. Employees Whose Manager Left the Company

SELECT DISTINCT e2.employee_id 
FROM Employees e1, Employees e2 
WHERE e2.SALARY<30000 AND
e2.manager_id NOT IN(SELECT employee_id FROM Employees) ORDER BY employee_id;