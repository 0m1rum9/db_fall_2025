-- Name - Seiilkhan Almansur
-- StudentID - 24B031099


                            -- Part 1

-- Task 1.1
CREATE TABLE employees (
 employee_id SERIAL PRIMARY KEY,
 first_name TEXT,
 last_name TEXT,
 age INT CHECK (age BETWEEN 18 AND 65),
 salary NUMERIC CHECK(salary > 0)
);

-- Task 1.2
CREATE TABLE products_catalog(
 product_id INT,
 product_name TEXT,
 regular_price NUMERIC,
 discount_price NUMERIC,
 CONSTRAINT valid_discount
 CHECK(regular_price > 0
     AND discount_price > 0
     AND discount_price < regular_price)
);

-- Task 1.3
CREATE TABLE bookings(
 booking_id SERIAL PRIMARY KEY,
 check_in_date DATE,
 check_out_date DATE CHECK(check_out_date > check_in_date),
 num_guests INT CHECK(num_guests BETWEEN 1 AND 10)
);

-- Task 1.4

-- 1.
-- employees table
INSERT INTO employees(
 age,
 salary
 )
 VALUES(
 25,
 10
);
INSERT INTO employees(
 age,
 salary
 )
 VALUES(
 19,
 1
);
-- products_catalog table
INSERT INTO products_catalog(
 regular_price,
 discount_price
 )
 VALUES(
 2,
 1
);
INSERT INTO products_catalog(
 regular_price,
 discount_price
 )
 VALUES(
 3,
 2
);
-- bookings table
INSERT INTO bookings(
 num_guests,
 check_in_date,
 check_out_date
 )
 VALUES(
 3,
 '1999-10-01',
 '2000-10-01'
);
INSERT INTO bookings(
 num_guests,
 check_in_date,
 check_out_date
 )
 VALUES(
 3,
 '1994-10-01',
 '2004-12-31'
);

-- 2 and 3
-- INSERT INTO employees(
--  age,
--  salary
--  )
--  VALUES(
--  3,
--  1
-- );
-- this violates constraint of (age BETWEEN 18 and 65)
-- INSERT INTO products_catalog(
--  regular_price,
--  discount_price
--  )
--  VALUES(
--  1,
--  2
-- );
-- this violeates constraint of (discount_price < regular_price)
-- INSERT INTO bookings(
--  num_guests,
--  check_in_date,
--  check_out_date
--  )
--  VALUES(
--  11234,
--  '2004-12-31',
--  '2002-12-31'
-- );
-- this violates constraint of (num_guests BETWEEN 1 AND 10) AND (check_in_date before check_out_date)



                            -- Part 2

-- Task 2.1
CREATE TABLE customers(
 customer_id INT NOT NULL,
 email TEXT NOT NULL,
 phone TEXT NULL,
 registration_date DATE NOT NULL
);

-- Task 2.2
CREATE TABLE inventory(
 item_id INT NOT NULL,
 item_name TEXT NOT NULL,
 quantity INT NOT NULL CHECK (quantity >= 0),
 unit_price NUMERIC NOT NULL CHECK (unit_price > 0),
 last_updated TIMESTAMP NOT NULL
);

-- Task 2.3

-- 1
INSERT INTO customers
 VALUES(
 1,
 'ifejfkweoi@gmail.com',
 '+777542413',
 '2020-12-31'
);
INSERT INTO inventory
 VALUES(
 1,
 'Dooodo',
 23,
 3,
 '2020-12-31'
);

-- 2
INSERT INTO customers(phone) VALUES('+4398');
INSERT INTO inventory(quantity) VALUES(1);

-- 3
INSERT INTO customers
  VALUES(
  1,
  'ifejfkweoi@gmail.com',
  NULL,
  '2020-12-31'
);



                            -- Part 3

-- Task 3.1
CREATE TABLE users(
 user_id INT,
 username TEXT UNIQUE,
 email TEXT UNIQUE,
 created_at TIMESTAMP
);
-- Task 3.2
CREATE TABLE course_enrollment(
 enrollment_id INT,
 student_id INT,
 course_code TEXT,
 semester TEXT,
 UNIQUE(student_id, course_code, semester)
);
-- Task 3.3

-- 1
ALTER TABLE users
 ADD CONSTRAINT unique_username UNIQUE (username);

-- 2
ALTER TABLE users
 ADD CONSTRAINT unique_email UNIQUE (email);

-- 3
INSERT INTO users(email, username)
 VALUES(
 'dog@yahoo.com',
 'animade'
 ),
 (
 'dog@yahoo.com',
 'animadd'
);



                            -- Part 4
-- Task 4.1
CREATE TABLE departments(
 dept_id INT PRIMARY KEY,
 dept_name TEXT NOT NULL,
 location TEXT
);
-- 1
INSERT INTO departments(dept_id, dept_name)
 VALUES(
 3,
 'freoij'
 ),
 (
 3,
 'regoijge'
);

-- 2
INSERT INTO departments(dept_id, dept_name)
 VALUES(
 NULL,
 'IEORGJ'
);

-- Task 4.2
CREATE TABLE student_courses(
 student_id INT,
 course_id INT,
 enrollment_date DATE,
 grade TEXT,
 PRIMARY KEY(student_id, course_id)
);
 
-- Task 4.3
-- 1. The main difference between UNIQUE and PRIMARY KEY constraints is that PRIMARY KEY is used for referencing whilst UNIQUE is not.
-- 2. When we cannot identify a row in a table by just one single-column we need to use composite PRIMARY KEY.
-- For example: in our student_courses TABLE each student can have multiple courses and multiple courses can have multiple students
-- therefore we cannot identify row by just student_id or course_id and hence, we use composite PRIMARY KEY.
-- 3. Because PRIMARY KEY identifies each row and used for referencing



                            -- Part 5
-- Task 5.1
CREATE TABLE employees_dept(
 emp_id INT PRIMARY KEY,
 emp_name TEXT NOT NULL,
 dept_id INT,
 hire_date DATE,
 FOREIGN KEY (dept_id) REFERENCES departments(dept_id));

-- 1
INSERT INTO employees_dept(emp_id, emp_name, dept_id)
 VALUES(
 1,
 'rgeioj',
 2
);
INSERT INTO employees_dept(emp_id, emp_name, dept_id)
 VALUES(
 1,
 'rgeioj',
 1234
);

-- Task 5.2
CREATE TABLE authors(
 author_id INT PRIMARY KEY,
 author_name TEXT NOT NULL,
 country TEXT
);
CREATE TABLE books(
 book_id INT PRIMARY KEY,
 title TEXT NOT NULL,
 author_id INT REFERENCES authors(author_id),
 publisher_id INT REFERENCES publishers(publisher_id),
 publication_year INT,
 isbn TEXT UNIQUE
);
-- INSERT operations
INSERT INTO authors
 VALUES(
 1,
 'john',
 'USA'
);
INSERT INTO publishers
 VALUES(
 1,
 'snow',
 'UK'
);
INSERT INTO books
 VALUES(
 1,
 'Targaryen son',
 1,
 1,
 2001,
 'someISBN'
);

-- Task 5.3
-- 
CREATE TABLE categories(
 category_id INT PRIMARY KEY,
 category_name TEXT NOT NULL);
CREATE TABLE products_fk(
 product_id INT PRIMARY KEY,
 product_name TEXT NOT NULL,
 category_id INT REFERENCES categories(category_id) ON DELETE RESTRICT
 );
CREATE TABLE orders(
 order_id INT PRIMARY KEY,
 order_date DATE NOT NULL
 );
CREATE TABLE order_items(
 item_id INT PRIMARY KEY,
 order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
 product_id INT REFERENCES products_fk(product_id),
 quantity INT CHECK(quantity > 0)
);

-- 1
-- Assuming we have some row in category with id=1 and in products_fk with category_id=1
-- DELETE FROM categories
-- WHERE category_id = 1;
-- It will fail because we have product with category_id=1 and we have added constraint ON DELETE RESTRICT

-- 2
-- Assuming we have some row in orders with id=1 and in order_items with order_id=1
DELETE FROM orders
 WHERE order_id = 1;
-- This will delete all rows from order_items with order_id=1 because we deleted from orders order_id=1 and added CASCADE ON DELETE



                            -- Part 6
-- Task 6.1
CREATE TABLE customers(
 customer_id SERIAL PRIMARY KEY,
 customer_name TEXT,
 email TEXT UNIQUE,
 phone TEXT NULL UNIQUE,
 registration_date DATE NOT NULL
);
CREATE TABLE products(
 product_id SERIAL PRIMARY KEY,
 product_name TEXT NOT NULL,
 description TEXT NULL,
 price DECIMAL CHECK(price > 0),
 stock_quantity INT CHECK(stock_quantity > 0)
);
CREATE TABLE orders(
 order_id SERIAL PRIMARY KEY,
 customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
 order_date DATE NOT NULL,
 total_amount INT NULL,
 status TEXT CHECK(status = 'processing' OR status = 'shipped' OR status = 'delivered' OR status = 'cancelled')
);
CREATE TABLE order_details(
 order_detail_id SERIAL PRIMARY KEY,
 order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
 product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
 quantity INT CHECK(quantity > 0),
 unit_price NUMERIC NOT NULL CHECK (unit_price > 0)
);

-- Insertion
INSERT INTO customers (customer_name, email, phone, registration_date)
 VALUES
 ('john', 'a@', '+7', '2021-12-02'),
 ('alan', 'b@', '+8', '2021-12-01'),
 ('bob', 'c@', '+9', '2021-12-03'),
 ('sam', 'd@', '+10', '2021-12-04'),
 ('dean', 'e@', '+11', '2021-12-05');
INSERT INTO products(product_name, description, price, stock_quantity)
 VALUES
 ('tomato', 'juicy', 123, 3),
 ('potato', 'crunchy', 321, 4),
 ('pizza', 'italian', 33, 5),
 ('meat', 'bolgarian', 44, 55),
 ('water', 'kazakh', 4444, 54);
INSERT INTO orders(customer_id, order_date, total_amount, status)
 VALUES
 (1, '2020-10-01', 3, 'cancelled'),
 (2, '2021-10-01', 44, 'processing'),
 (3, '2022-10-01', 45, 'delivered'),
 (4, '2000-10-10', 4, 'cancelled'),
 (4, '2020-10-10', 1, 'processing');
INSERT INTO order_details(order_id, product_id, quantity, unit_price)
 VALUES
 (1, 3, 33, 123),
 (1, 4, 344, 54),
 (2, 3, 44, 4),
 (5, 3, 33, 4),
 (4, 5, 34, 5);
-- 3
DELETE FROM products WHERE product_id = 3;
DELETE FROM orders WHERE order_id=1;

