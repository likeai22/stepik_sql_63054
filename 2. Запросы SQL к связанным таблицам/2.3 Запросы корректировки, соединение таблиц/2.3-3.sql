SELECT a.name_author, s.author
FROM supply s
LEFT JOIN author a ON s.author = a.name_author
WHERE a.name_author IS NULL;

INSERT INTO author (name_author) 
    SELECT s.author
    FROM supply s
    LEFT JOIN author a ON s.author = a.name_author
    WHERE a.name_author IS NULL;

SELECT * FROM author;