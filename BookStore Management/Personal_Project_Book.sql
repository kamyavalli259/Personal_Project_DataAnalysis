

/*
📘 Bookstore Inventory & Sales Analysis (SQL Project)

This project simulates the operations of a small bookstore using a relational SQL database.

*/
-- BOOKS TABLE
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(6,2),
    stock INT
);

-- SALES TABLE
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    book_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


INSERT INTO Books (book_id, title, author, genre, price, stock) VALUES
(1, 'The Silent Forest', 'Laura Green', 'Fiction', 14.99, 120),
(2, 'Data Science 101', 'Sam Curtis', 'Education', 34.50, 60),
(3, 'Journey to Mars', 'Alan Peters', 'Sci-Fi', 19.75, 80),
(4, 'Mastering SQL', 'Janet Cole', 'Education', 29.99, 40),
(5, 'Healthy Living', 'Mia Stone', 'Lifestyle', 22.50, 100);


INSERT INTO Sales (sale_id, book_id, quantity, sale_date) VALUES
(1, 1, 3, '2025-01-03'),
(2, 2, 1, '2025-01-04'),
(3, 3, 4, '2025-01-04'),
(4, 1, 2, '2025-01-05'),
(5, 4, 1, '2025-01-06'),
(6, 3, 2, '2025-01-06'),
(7, 5, 5, '2025-01-07'),
(8, 2, 2, '2025-01-08');


/*Top revenue by Genre*/
SELECT b.genre,
       SUM(s.quantity * b.price) AS total_revenue
FROM Sales s
JOIN Books b ON s.book_id = b.book_id
GROUP BY b.genre
ORDER BY total_revenue DESC;


/*Best Selling Books*/
SELECT b.title,
       SUM(s.quantity) AS units_sold
FROM Sales s
JOIN Books b ON s.book_id = b.book_id
GROUP BY b.title
ORDER BY units_sold DESC;


/*Inventory Alert (Low stock)*/
SELECT title, stock
FROM Books
WHERE stock < 50;


/*Total revenue per book*/
SELECT b.title,
       SUM(s.quantity * b.price) AS revenue
FROM Sales s
JOIN Books b ON s.book_id = b.book_id
GROUP BY b.title
ORDER BY revenue DESC;


/*Daily sales summary*/
SELECT sale_date,
       SUM(quantity) AS total_books_sold
FROM Sales
GROUP BY sale_date
ORDER BY sale_date;


/*Books by revenue*/
SELECT title, revenue, 
       RANK() OVER (ORDER BY revenue DESC) AS ranking
FROM (
    SELECT b.title,
           SUM(s.quantity * b.price) AS revenue
    FROM Sales s
    JOIN Books b ON s.book_id = b.book_id
    GROUP BY b.title
) t;

