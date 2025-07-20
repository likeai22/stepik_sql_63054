SELECT name_enrollee, IF(SUM(bonus), SUM(bonus), 0) Бонус
FROM enrollee
    LEFT JOIN enrollee_achievement USING(enrollee_id)
    LEFT JOIN achievement USING(achievement_id)
GROUP BY name_enrollee
ORDER BY 1;

-- с сайта
