1731. The Number of Employees Which Report to Each Employee

SELECT e1.employee_id, e1.name, count(e2.employee_id) 
AS reports_count, round(avg(e2.age)) as average_age
FROM employees e1 
JOIN employees e2 
ON e1.employee_id = e2.reports_to
GROUP BY e1.employee_id, e1.name
ORDER BY e1.employee_id;