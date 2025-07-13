DROP TABLE IF EXISTS city;
CREATE TABLE city
(
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    name_city VARCHAR(30)
);

INSERT INTO city (name_city) VALUES ("Москва"), ("Санкт-Петербург"), ("Владивосток");

-- решение
SELECT name_city, name_author, DATE_ADD('2020-01-01', INTERVAL FLOOR(RAND() * 360) DAY) as Дата
FROM city, author
ORDER BY name_city, Дата DESC; 


SELECT name_city,
       name_author,
       DATE_ADD( '2020-01-01' , INTERVAL FLOOR(RAND() * 365) DAY) AS Дата
  FROM city
       CROSS JOIN author
 ORDER BY 1, 3 DESC;