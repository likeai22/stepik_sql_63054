UPDATE applicant a
    JOIN (
        SELECT enrollee_id,
            IF(SUM(bonus), SUM(bonus), 0) Бонус
        FROM enrollee
            LEFT JOIN enrollee_achievement USING(enrollee_id)
            LEFT JOIN achievement USING(achievement_id)
        GROUP BY enrollee_id
    ) q ON q.enrollee_id=a.enrollee_id
SET itog = a.itog + q.Бонус



-- с сайта
UPDATE applicant        
   SET itog = itog + (SELECT IFNULL(SUM(bonus), 0)
                        FROM enrollee_achievement
                             JOIN achievement USING(achievement_id)
                       WHERE enrollee_id = applicant.enrollee_id);
 
 SELECT * FROM applicant;

-- 2
WITH cte1 AS
(
SELECT 
    enrollee_id,
    IFNULL(SUM(bonus), 0) AS bonus
FROM achievement
    LEFT JOIN enrollee_achievement USING (achievement_id)
GROUP BY enrollee_id
)
UPDATE applicant AS a
    JOIN cte1 USING (enrollee_id)
SET itog = itog + bonus
WHERE a.enrollee_id = cte1.enrollee_id;
