1378. Replace Employee ID With The Unique Identifier

SELECT Enu.unique_id AS unique_id, E.name AS name
FROM Employees E
LEFT JOIN EmployeeUNI Enu
ON E.id = Enu.id;