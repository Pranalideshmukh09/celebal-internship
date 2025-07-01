1075. Project Employees I


SELECT project_id, round(sum(experience_years)/count(project_id), 2) average_years
FROM Project P
LEFT JOIN Employee E 
ON P.employee_id = E.employee_id
GROUP BY project_id;