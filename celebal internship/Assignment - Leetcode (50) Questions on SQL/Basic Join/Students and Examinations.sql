1280. Students and Examinations

SELECT s.student_id, s.student_name, sub.subject_name , count(e.student_id) 
AS attended_exams 
FROM students s
CROSS JOIN subjects sub
LEFT JOIN examinations e 
ON s.student_id = e.student_id 
AND sub.subject_name = e.subject_name
GROUP BY 1,2,3
ORDER BY 1,3