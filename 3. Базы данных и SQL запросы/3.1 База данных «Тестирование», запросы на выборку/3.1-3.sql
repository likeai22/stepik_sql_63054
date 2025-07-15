SELECT s.name_subject, COUNT(a.subject_id) Количество, ROUND(AVG(a.result),2) Среднее
FROM subject s
LEFT JOIN attempt a ON a.subject_id=s.subject_id
GROUP BY 1
ORDER BY 3 DESC;
