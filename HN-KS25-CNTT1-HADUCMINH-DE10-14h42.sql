CREATE DATABASE Movies_db;
use Movies_db;
CREATE TABLE Movies(
movie_id VARCHAR(5) PRIMARY KEY NOT NULL,
title VARCHAR(100) NOT NULL UNIQUE,
duration INT NOT NULL,
category VARCHAR(50) NOT NULL
);
CREATE TABLE Showtimes(
show_id VARCHAR(5) PRIMARY KEY NOT NULL,
movie_id VARCHAR(5) NOT NULL,
FOREIGN KEY(movie_id) REFERENCES Movies(movie_id),
room_name VARCHAR(50) NOT NULL,
start_time DATETIME NOT NULL,
ticket_price DECIMAL(10,2) NOT NULL
);
CREATE TABLE Customers(
customer_id VARCHAR(5) PRIMARY KEY NOT NULL,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
phone VARCHAR(15) NOT NULL UNIQUE
);
CREATE TABLE Tickets(
ticket_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
show_id VARCHAR(5) NOT NULL,
FOREIGN KEY(show_id) REFERENCES Showtimes(show_id),
customer_id VARCHAR(5) NOT NULL,
FOREIGN KEY(customer_id) REFERENCES Customers(customer_id),
seat_number VARCHAR(10) NOT NULL,
status VARCHAR(20) NOT NULL
);
INSERT INTO Movies(movie_id,title,duration,category)
VALUES
('M01','Avatar 2','190','Hành động'),
('M02','Joker','120','Tâm lý'),
('M03','Toy Story 4','100','Hoạt hình'),
('M04','Interstellar','169','Khoa học');

INSERT INTO Showtimes(show_id,movie_id,room_name,start_time,ticket_price)
VALUES
('S01','M01','Cinema 01','2025-10-01 19:00:00','120000.00'),
('S02','M02','Cinema 02','2025-10-01 20:00:00','90000.00'),
('S03','M03','Cinema 01','2025-10-02 09:00:00','80000.00'),
('S04','M04','Cinema 03','2025-10-02 14:00:00','150000.00');

INSERT INTO Customers(customer_id,full_name,email,phone)
VALUES
('C01','Nguyễn Văn An','an.nv@gmail.com','0911111111'),
('C02','Nguyễn Thị Mai','mai.nt@gmail.com','0922222222'),
('C03','Trần Quang Hải','ahai.tq@gmail.com','0933333333');

INSERT INTO Tickets(ticket_id,show_id,customer_id,seat_number,status)
VALUES
(1,'S01','C01','A01','Booked'),
(2,'S02','C02','B05','Booked'),
(3,'S01','C03','A02','Cancelled'),
(4,'S04','C01','C10','Booked'),
(5,'S03','C02','D01','Booked');

UPDATE Showtimes
SET ticket_price=ticket_price*1.1
WHERE show_id='S01';

UPDATE Customers
SET phone='0988888888'
WHERE full_name='Nguyễn Văn An';

SELECT* FROM Movies
WHERE duration>120; 

SELECT full_name,email FROM Customers
WHERE full_name LIKE '%Mai%';

SELECT show_id, room_name, start_time FROM Showtimes
ORDER BY start_time DESC;

SELECT * FROM Showtimes
ORDER BY ticket_price DESC 
LIMIT 3;

SELECT title,duration FROM Movies
LIMIT 2 OFFSET 1;

SELECT m.movie_id,m.title,m.duration,m.category,s.start_time FROM Movies m
JOIN Showtimes s ON m.movie_id=s.movie_id;

SELECT COUNT(ticket_id) AS Total_Tickets , status FROM Tickets
GROUP BY status;

SELECT COUNT(t.customer_id) AS so_luong_ve ,c.full_name FROM Tickets t
JOIN Customers c ON c.customer_id=t.customer_id
WHERE status NOT IN('CANCELLED')
GROUP BY c.full_name
HAVING COUNT(t.customer_id) >=2 ;

SELECT show_id, room_name, ticket_price FROM Showtimes
WHERE ticket_price<(SELECT AVG(ticket_price) FROM Showtimes);

SELECT full_name,phone FROM Customers
WHERE customer_id IN (SELECT customer_id FROM Tickets WHERE show_id='S01');
