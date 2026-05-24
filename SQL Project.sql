-- Create Database
CREATE DATABASE OnlineBookstore;

-- Switch to the database
\c OnlineBookstore;

-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;




-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM books
WHERE genre = 'Fiction'



-- 2) Find books published after the year 1950:
SELECT * FROM books
WHERE books.published_year>1950;



-- 3) List all customers from the Canada:

SELECT * FROM customers
WHERE country = 'Canada';




-- 4) Show orders placed in November 2023:
SELECT * FROM Orders
WHERE order_date between '2023-11-01' and '2023-11-30';


-- 5) Retrieve the total stock of books available:
SELECT sum(stock) as tottal_book
from  books;


-- 6) Find the details of the most expensive book:

select * from books ORDER by price DESC limit 1;



-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM orders
WHERE quantity >1;



-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM orders
WHERE total_amount>20;




-- 9) List all genres available in the Books table:

select distinct  genre from books;



-- 10) Find the book with the lowest stock:

select * from books ORDER by stock limit 1;



-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as renenue from orders;


-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
SELECT b.genre, sum(o.quantity) as total_book_sold
from orders o
join books b on o.book_id = b.book_id
GROUP by	b.genre;






-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG (price) AS AVG_PRICE FROM books
WHERE genre ='Fantasy';




-- 3) List customers who have placed at least 2 orders:
SELECT CUSTOMER_ID, COUNT(order_id ) AS COUNT_ORDER
FROM ORDERS
GROUP BY CUSTOMER_ID
HAVING COUNT(ORDER_ID) >=2;

 


-- 4) Find the most frequently ordered book:

SELECT o.book_id, b.titel, count(o.order_id)as order_count
from orders O
JOIN BOOKS B ON O.book_id=B.BOOK_ID
GROUP BY  O.BOOK_ID ,B,TITEL 
ORDER BY ORDER_COUNT DESC LIMIT 1;





-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :



select * from books
WHERE genre='Fantasy'
order by price DESC limit 3








