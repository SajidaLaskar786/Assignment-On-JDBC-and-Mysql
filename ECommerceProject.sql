create database ECommerce;
use ECommerce;
create table supplier(
supp_id int primary key,
supp_name varchar(50) not null,
supp_city varchar(50) not null,
supp_phone varchar(50) not null

);
insert into supplier
values(1, 'Rajesh Retails', 'Delhi', '1234567890'),
(2, 'Appario Ltd.', 'Mumbai', '2589631470'),
(3, 'Knome products', 'Banglore', '9785462315'),
(4, 'Bansal Retails', 'Kochi', '8975463285'),
(5, 'Rajesh Retails', 'Lucknow', '7898456532');


create table customer (
cus_id int primary key,
cus_name varchar(50) not null,
cus_phone varchar(50) not null, 
cus_city  varchar(50) not null, 
cus_gender char
);

insert into customer
values(1, 'AAKASH', '9999999999', 'DELHI', 'M'),
(2, 'AMAN', '9785463215', 'NOIDA', 'M'),
(3, 'NEHA', '9999999999', 'MUMBAI', 'F'),
(4, 'MEGHA', '9994562399', 'KOLKATA', 'F'),
(5, 'PULKIT', '7895999999', 'LUCKNOW', 'M');


create table category(
cat_id int primary key,
cat_name varchar(20) not null
);

insert into category
values(1, 'Books'),
(2, 'GAMES'),
(3, 'GROCERIES'),
(4, 'ELECTRONICS'),
(5, 'CLOTHS');


create table product(
pro_id int primary key,
pro_name varchar(20) not null default 'Dummy',
pro_desc varchar(60),
cat_id int,
constraint foreign key fkey1 (cat_id) references category(cat_id)
);
insert into product
values(1, 'GTA V', 'Windows 7 and above with i5 processor and 8GB RAM', 2),
(2, 'TSHIRT', 'SIZE-L with Black, Blue and White variations', 5),
(3, 'ROG LAPTOP', ' Windows 10 with 15inch screen, i7 processor, 1TB SSD', 4),
(4, 'OATS', 'Highly Nutritious from Nestle', 3),
(5, 'HARRY POTTER', ' Best Collection of all time by J.K Rowling', 1),
(6, 'MILK', '1L Toned MIlk', 3),
(7, 'Boat Earphones', '1.5Meter long Dolby Atmos', 4),
(8, 'Jeans', 'Stretchable Denim Jeans with various sizes and color', 5),
(9, 'Project IGI', 'compatible with windows 7 and above', 2),
(10, 'Hoodie', 'Black GUCCI for 13 yrs and above', 5),
(11, 'Rich Dad Poor Dad', 'Written by RObert Kiyosaki', 1),
(12, 'Train Your Brain', 'By Shireen Stephen', 1);


create table supplier_pricing(
pricing_id int primary key,
pro_id int,
supp_id int,
constraint foreign key fkey2 (pro_id) references  product(pro_id),
constraint foreign key fkey3 (supp_id) references  supplier(supp_id),
supp_price int default 0
);
insert into supplier_pricing
values(1, 1, 2, 1500),
(2, 3, 2, 30000),
(3, 5, 5, 3000),
(4, 2, 1, 2500),
(5, 4, 3, 1000),
(6, 12, 1, 780),
(7, 12, 2, 789),
(8, 3, 4, 31000),
(9, 1, 1, 1450),
(10, 4, 5, 999),
(11, 7, 2, 549),
(12, 7, 3, 529),
(13, 6, 4, 105),
(14, 6, 2, 99),
(15, 2, 1, 2999),
(16, 1, 5, 2999);


create table orders(
ord_id int primary key,
ord_amt int not null,
ord_date Date not null,
cus_id int,
pricing_id int,
constraint foreign key fkey4 (cus_id) references  customer(cus_id),
constraint foreign key fkey5 (pricing_id) references  supplier_pricing(pricing_id)
);
insert into orders
values (101, 1500, '2021-10-06', 2, 1),
(102, 1000, '2021-10-12', 3, 5),
(103, 30000, '2021-09-16', 5, 2),
(104, 1500, '2021-10-05', 1, 1),
(105, 3000, '2021-08-16', 4, 3),
(106, 1450, '2021-08-18', 1, 9),
(107, 789, '2021-09-01', 3, 7),
(108, 780, '2021-09-07', 5, 6),
(109, 3000, '2021-09-06', 5, 3),
(110, 2500, '2021-09-10', 2, 4),
(111, 1000, '2021-09-15', 4, 5),
(112, 789, '2021-09-16', 4, 7),
(113, 31000, '2021-09-16', 1, 8),
(114, 1000, '2021-09-16', 3, 5),
(115, 3000, '2021-09-16', 5, 3),
(116, 99, '2021-09-17', 2, 14);


create table rating(
rat_id int primary key,
ord_id int,
constraint foreign key fkey6 (ord_id) references  orders(ord_id),
rat_ratStars int not null
);
insert into rating
values(1, 101, 4),
(2, 102, 3),
(3, 103, 1),
(4, 104, 2),
(5, 105, 4),
(6, 106, 3),
(7, 107, 4),
(8, 108, 4),
(9, 109, 5),
(10, 110,3),
(11, 111,4),
(12, 112, 2),
(13, 113, 4),
(14, 114, 1),
(15, 115, 1),
(16, 116, 0);

select * from supplier;
select * from customer;
select * from category;
select * from product;
select * from supplier_pricing;
select * from orders;
select * from rating;

#Query to display the total number of customers based on gender who have placed individual orders of worth at least Rs.3000
SELECT c.cus_gender, COUNT(DISTINCT c.cus_id) AS totalCustomers
FROM customer c
JOIN supplier_pricing sp ON c.c.cus_id = sp.pro_id
WHERE sp.supp_price >= 3000
GROUP BY c.cus_gender
HAVING COUNT(DISTINCT c.cus_id) > 0;

#Query to display all the orders along with product name ordered by a customer having Customer_Id=2
SELECT o.ord_id, p.pro_name, o.Ord_amt, o.ord_date 
FROM Orders o
JOIN product p ON o.pricing_id = p.pro_id
WHERE o.cus_id = 2;

#query to display the Supplier details who can supply more than one product.
SELECT s.supp_id, s.supp_name, s.supp_city, s.supp_phone
FROM supplier s
JOIN supplier_pricing sp ON s.supp_id = sp.supp_id
GROUP BY s.supp_id, s.supp_name, s.supp_city, s.supp_phone
HAVING COUNT(DISTINCT sp.pro_id) > 1;

#Query to create a view as lowest_expensive_product and display the least expensive product from each category and print the table
#with category id, name, product name and price of the product.
CREATE VIEW lowest_expensive_product AS
SELECT c.cat_id, c.cat_name, p.PRO_NAME, sp.SUPP_PRICE
FROM category c
JOIN product p ON c.cat_id = p.cat_id
JOIN supplier_pricing sp ON p.pro_id = sp.pro_id
WHERE sp.supp_price = (
  SELECT MIN(supp_price)
  FROM supplier_pricing
  WHERE pro_id = p.pro_id
)
ORDER BY c.cat_id;
select*from lowest_expensive_product;

#Query to display the Id and Name of the Product ordered after “2021-10-05”
SELECT p.pro_id , p.pro_name
FROM product p
JOIN supplier_pricing sp ON p.pro_id  = sp.pro_id 
JOIN orders o ON sp.pricing_id = o.pricing_id
WHERE o.ord_date  > '2021-10-05';

--  Display customer name and gender whose names start or end with character 'A'.
select cus_name,cus_gender from customer where cus_name like 'A%';
select cus_name,cus_gender from customer where cus_name like '%A';

#Query to create a stored procedure to display supplier id, name, Rating(Average rating of all the products sold by every customer) and
#Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print
#“Average Service” else print “Poor Service”. Note that there should be one rating per supplier;

delimiter $$
use ECommerce $$
CREATE PROCEDURE display_supplier_ratings()
BEGIN
    SELECT s.supp_id, s.supp_name, AVG(r.rat_ratStars) AS Rating,
        CASE 
            WHEN AVG(r.rat_ratStars) = 5 THEN 'Excellent Service'
            WHEN AVG(r.rat_ratStars) > 4 THEN 'Good Service'
            WHEN AVG(r.rat_ratStars) > 2 THEN 'Average Service'
            ELSE 'Poor Service'
        END AS Type_of_Service
    FROM supplier s
    JOIN supplier_pricing sp ON s.supp_id = sp.supp_id
    JOIN orders o ON sp.pricing_id = o.pricing_id
    JOIN rating r ON o.ord_id = r.ord_id
    GROUP BY s.supp_id;
END;
call display_supplier_ratings;


