2356. Number of Unique Subjects Taught by Each Teacher


SELECT teacher_id , count(DISTINCT subject_id)  
AS cnt 
FROM teacher
GROUP BY teacher_id;