create database OnlineBookStore;
use OnlineBookStore;

-- create tables

drop table if exists Books;
create table Books(
Book_id int auto_increment primary key,
Title varchar(100),
Author varchar(100),
Genre varchar(50),
Published_year int,
Price numeric(10,2),
Stock int
);
ALTER TABLE books MODIFY Genre VARCHAR(50);

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID int auto_increment  PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID int auto_increment   primary key,
    Customer_id int references customers(customer_id),
    Book_id int references books(book_id),
    Order_Date date,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

select * from Books;
select * from Customers;
select  * from orders;

-- import data from book table
-- table data import wizard se imprt ki file
SELECT * FROM books;

 --  import data from customer and order table by import wizard method
SELECT * FROM customers;
SELECT * FROM orders;

-- 1) Retrieve all books in the "Fiction" genre:
select * from books
where genre='fiction';

-- 2) Find books published after the year 1950:
select * from books
where published_year>1950;

-- 3) List all customers from the Canada:
select * from customers
where country='canada';

-- 4) Show orders placed in November 2023:
select * from orders
where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as Total_Stocks from books;

-- 6) Find the details of the most expensive book:
select * from Books
order by price desc
limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select * from orders
where quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from orders
where total_amount>20;

-- 9) List all genres available in the Books table:
select distinct genre from books;

-- 10) Find the book with the lowest stock:
SELECT * FROM books 
WHERE stock =(select min(stock) from books);

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as Total_Revenue from orders;

-- 1) Retrieve the total number of books sold for each genre:
select b.genre, sum(quantity) as total_books from orders as o
join books as b on b.book_id=o.book_id
group by b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select genre,avg(price) as Average_price from books
where genre='fantasy';


-- 3) List customers who have placed at least 2 orders:
select c.name,o.order_id, c.customer_id,count(order_id) as total_books from orders as o
join customers as c on c.customer_id=o.customer_id
group by name,customer_id
having count(order_id)>=2;

-- 4) Find the most frequently ordered book:
select count(o.order_id)as most_ordered_book ,b.book_id,b.title from orders as o
JOIN books as b on b.book_id=o.book_id
group by b.title,b.book_id
order by most_ordered_book desc
limit 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books
where genre='fantasy'
order by price desc 
limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select b.Author,sum(o.quantity) as total_Quantity  from  books as b
join orders as o on b.book_id=o.book_id
group by b.author
order by total_quantity desc;



-- 7) List the cities where customers who spent over $30 are located:
select c.city,c.name,sum(o.total_amount) as Total_Amount from orders as o
join customers as c on c.customer_id=o.customer_id
group by c.city, c.name  
having  Total_Amount>30
order by Total_Amount desc;

-- 8) Find the customer who spent the most on orders:
select c.name,c.customer_id,sum(o.total_amount) as TA  from orders as o
join customers as c on c.customer_id=o.customer_id
group by c.name, c.customer_id
order by TA desc
limit 1;

-- 9) Calculate the stock remaining after fulfilling all orders:
select b.stock,b.title,coalesce(sum(o.quantity),0) as quantity  ,b.stock-coalesce(sum(o.quantity),0)as remaining_stock from orders as o
right join books as b on b.book_id=o.book_id
group by b.title,b.stock,b.book_id
order by b.stock desc;



