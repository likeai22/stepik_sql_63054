-- 

-- SELECT * FROM supply;
-- SELECT * FROM book;

CREATE TABLE ordering as
    SELECT author, title, (
        SELECT ROUND(AVG(amount)) FROM book
    ) AS amount
FROM book
WHERE amount < (
    SELECT ROUND(AVG(amount)) FROM book
);

-- решения с сайта 
CREATE TABLE ordering AS
SELECT author,title,amount 
FROM book
WHERE amount < (SELECT AVG(amount) FROM book);
UPDATE ordering SET amount = (SELECT AVG(amount) FROM book)


CREATE TABLE ordering AS
SELECT author, title,  @AVG as amount
FROM book
WHERE amount < (@AVG := (SELECT ROUND(AVG(amount)) FROM book));
SELECT * FROM ordering;

CREATE TABLE ordering AS
       SELECT author, 
              title, 
              (SELECT round(AVG(amount)) FROM book) AS amount
               FROM book
               WHERE amount < (SELECT round(AVG(amount)) FROM book
               );

SELECT * FROM ordering;
