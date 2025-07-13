ALTER TABLE book DROP COLUMN author;
ALTER TABLE book ADD author_id INT NOT NULL;
ALTER TABLE book ADD genre_id INT NOT NULL;

-- Для genre_id ограничение о недопустимости пустых значений не задавать. 
ALTER TABLE book MODIFY genre_id INT;

TRUNCATE TABLE book;
TRUNCATE TABLE author;

CREATE TABLE IF NOT EXISTS genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
);

ALTER TABLE book
ADD FOREIGN KEY (author_id) REFERENCES author(author_id);
ALTER TABLE book
ADD FOREIGN KEY (genre_id) REFERENCES genre(genre_id);


-- решение!
-- Можно посмотреть какие строки получаются при создании таблицы: 
SHOW COLUMNS FROM book;

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL, 
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id) REFERENCES author (author_id),
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id)
);
