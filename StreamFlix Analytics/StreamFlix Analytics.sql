/*
Project Overview
This project simulates a movie streaming platform. Users watch movies, rate them, and the platform tracks subscriptions and viewing history. The goal is to analyze user behavior, revenue, and movie performance using SQL.

Key Features to Showcase:
-Relational database design with multiple tables (Users, Movies, Views, Ratings, Subscriptions).
-SQL queries to calculate:
    Most-watched movies
    Average ratings per genre
    User retention metrics
    Top Users by watch time
*/



CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    signup_date DATE
);

CREATE TABLE Movies (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    release_year INT,
    duration_min INT
);

CREATE TABLE Views (
    view_id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    view_date DATE,
    duration_watched INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

CREATE TABLE Ratings (
    rating_id INT PRIMARY KEY,
    user_id INT,
    movie_id INT,
    rating INT,
    rating_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id INT,
    start_date DATE,
    end_date DATE,
    price DECIMAL(6,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


INSERT INTO Users VALUES
(1, 'Alice', 'alice@example.com', '2025-01-01'),
(2, 'Bob', 'bob@example.com', '2025-02-10'),
(3, 'Charlie', 'charlie@example.com', '2025-03-15');

INSERT INTO Movies VALUES
(1, 'Space Odyssey', 'Sci-Fi', 2020, 150),
(2, 'Romantic Escape', 'Romance', 2021, 120),
(3, 'Data Analytics 101', 'Education', 2022, 90);

INSERT INTO Views VALUES
(1, 1, 1, '2025-04-01', 150),
(2, 1, 2, '2025-04-02', 120),
(3, 2, 3, '2025-04-05', 90);

INSERT INTO Ratings VALUES
(1, 1, 1, 5, '2025-04-01'),
(2, 1, 2, 4, '2025-04-02'),
(3, 2, 3, 5, '2025-04-05');

INSERT INTO Subscriptions VALUES
(1, 1, '2025-01-01', '2025-12-31', 99.99),
(2, 2, '2025-02-10', '2025-08-10', 49.99),
(3, 3, '2025-03-15', '2025-09-15', 49.99);


/*Top three most watched movies*/
SELECT TOP 3 m.title, COUNT(v.view_id) AS views
FROM Views v
JOIN Movies m ON v.movie_id = m.movie_id
GROUP BY m.title
ORDER BY views DESC


/*Average Rating by Genre*/
SELECT m.genre, AVG(r.rating) AS avg_rating
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.genre;

/*Top Users by Total Watch Time*/
SELECT u.name, SUM(v.duration_watched) AS total_minutes
FROM Views v
JOIN Users u ON v.user_id = u.user_id
GROUP BY u.name
ORDER BY total_minutes DESC;

