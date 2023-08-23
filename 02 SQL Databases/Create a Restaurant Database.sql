
--Summary: 
-- Create a restaurant database and generate an overview of the restaurant's performance using a subquery technique.
-- Calculate the number of service days, total orders, total income, and average income per service day.
-- Calculate an aggregated perspective of the cafe's operational performance

-- HW: Restaurant database
-- 5 tables
-- Write 3-5 queries
-- 1x WITH
-- 1x SUBQUERY
-- 1x Aggregate function

-- ====================================================================================================

--DATABASE CREATION PART
-------------------------------------------------------------------------------------------------------
--Create Database
.open pp_cafe.db;

--Create a Categories table
drop table categories;
create table categories (
  categories_id int,
  categories_name text
);
--Insert values into Categories Table
insert into categories values
  (1, 'Drinks'),
  (2, 'Desserts');

--Create a Menu table
drop table menu;
create table menu (
  menu_id int,
  categories_id int,
  menu_name text,
  menu_price real
);
--Insert values into the Menu table
insert into menu values
  (1, 1, 'Americano', 50),
  (2, 1, 'Mocca', 55),
  (3, 1, 'Espresso', 55),
  (4, 1, 'Latte', 55),
  (5, 1, 'Americano Honey Lemon', 55),
  (6, 1, 'Thai Tea', 45),
  (7, 1, 'Macha Tea', 55),
  (8, 1, 'Chocolate Premium', 65),
  (9, 1, 'Lemon Tea', 50),
  (10, 2, 'Strawberry Mochi', 30),
  (11, 2, 'Banoffee Pie', 75 ),
  (12, 2, 'Chocolate Mousse Cake', 95),
  (13, 2, 'Croissant Almond', 75),
  (14, 2, 'Mini Waffle with Honey', 45),
  (15, 2, 'Apple Crumble Cake', 85);

--Create a Customer name table
drop table customers;
create table customers (
  customers_id int,
  customers_name text,
  customers_type text
);
--Insert values into the Customer name table
insert into customers values
  (1, 'BayRiffer', 'Member'),
  (2, 'Heart Rocker', 'Member'),
  (3, 'Nampetch', ''),
  (4, 'Arthur Gssspotted', 'Member'),
  (5, 'Cloud Strife', 'Member'),
  (6, 'Kla CigaretteS', ''),
  (7, 'Tiffa Lockhart', 'Member'),
  (8, 'AdToy', 'Member'),
  (9, 'Mr.Pasit', ''),
  (10, 'Leon S Kennedy', '');

--Create a Service Type table
drop table services;
create table services (
  service_id int,
  service_type text
);
--Insert values into the Service Type table
insert into services values  
  (1, 'At Cafe'),
  (2, 'Take Away'),
  (3, 'Lineman'),
  (4, 'Grab');

--Create Orders table 
--Order ID, date, menu, customer, and service type are all kept in the Create Orders table.
drop table orders;
create table orders (
  order_id int,
  order_date TEXT,
  menu_id int,
  customers_id int,
  service_id int
);
--Insert values into the Orders table
insert into orders values
  (1, '2023-06-01', 1, 1, 1),
  (2, '2023-06-02', 2, 3, 2),
  (3, '2023-06-03', 1, 5, 1),
  (4, '2023-06-06', 1, 6, 1),
  (5, '2023-06-06', 15, 6, 1),
  (6, '2023-06-12', 6, 2, 3),
  (7, '2023-06-12', 12, 2, 3),
  (8, '2023-06-18', 9, 8, 4),
  (9, '2023-06-18', 11, 8, 4),
  (10, '2023-06-19', 11, 9, 1),
  (11, '2023-06-20', 1, 10, 1),
  (12, '2023-06-23', 1, 9, 4),
  (13, '2023-06-23', 14, 9, 4),
  (14, '2023-06-23', 7, 7, 1),
  (15, '2023-06-23', 12, 7, 1),
  (16, '2023-06-25', 1, 5, 1),
  (17, '2023-06-25', 5, 7, 1),
  (18, '2023-06-25', 13, 7, 1),
  (19, '2023-06-25', 1, 3, 1),
  (20, '2023-06-25', 6, 9, 1),
  (21, '2023-06-25', 10, 9, 1),
  (22, '2023-06-26', 4, 4, 2),
  (23, '2023-06-26', 10, 4, 2),
  (24, '2023-06-26', 3, 5, 1),
  (25, '2023-06-26', 8, 7, 1),
  (26, '2023-06-26', 13, 9, 3),
  (27, '2023-06-27', 1, 4, 1),
  (28, '2023-06-27', 5, 5, 1),
  (29, '2023-06-27', 10, 6, 2),
  (30, '2023-06-28', 1, 1, 4),
  (31, '2023-06-28', 2, 1, 4),
  (32, '2023-06-28', 6, 4, 1),
  (33, '2023-06-28', 8, 7, 2),
  (34, '2023-06-28', 15, 10, 1),
  (35, '2023-06-29', 1, 6, 4),
  (36, '2023-06-30', 1, 1, 1),
  (37, '2023-06-30', 5, 7, 2),
  (38, '2023-06-30', 12, 9, 1),
  (39, '2023-06-30', 12, 3, 1),
  (40, '2023-06-30', 7, 4, 1),
  (41, '2023-06-30', 12, 4, 1),
  (42, '2023-06-30', 11, 2, 1),
  (43, '2023-06-30', 15, 10, 1),
  (44, '2023-06-30', 1, 3, 3),
  (45, '2023-06-30', 1, 8, 3);
.mode table
.header on
-- ====================================================================================================

-- QEARY DATA PART
-------------------------------------------------------------------------------------------------------
--Utilize the JOIN table and the Subquery technique.
--Summary order view of service day, number of orders, total income, and average income per service day.
.print 'Overview'
with sub_order as (
select 
  orders.order_id,
  orders.order_date as date,
  menu.menu_name as menu,
  menu.menu_price as price,
  customers.customers_name as customer,
  customers.customers_type as member,
  services.service_type  as service
from orders
Join menu on orders.menu_id = menu.menu_id
join customers on orders.customers_id = customers.customers_id
join services on orders.service_id = services.service_id
)
select 
  count(distinct date) as service_day,
  count(*) as total_order,
  sum(price) as total_income,
  sum(price) / count(distinct date ) as avg_income
from sub_order;

--Query the Top 5 menus of this restaurant.
.print 'Top 5 menu'
with sub_order as (
select 
  orders.order_id,
  orders.order_date as date,
  menu.menu_name as menu,
  menu.menu_price as price,
  customers.customers_name as customer,
  customers.customers_type as member,
  services.service_type  as service
from orders
Join menu on orders.menu_id = menu.menu_id
join customers on orders.customers_id = customers.customers_id
join services on orders.service_id = services.service_id
)
select 
  menu
from sub_order
group by menu
order by count(menu) desc limit 5 ;

--Query top spending. customer based on condition If the customer spends more than 300 baht, they will receive a free 1 menu.
--Making a condition using CASE WHEN 
.print 'Top spending customers who spent over 300 then get free an apple crumble cake'
with sub_order as (
select 
  orders.order_id,
  orders.order_date as date,
  menu.menu_name as menu,
  menu.menu_price as price,
  customers.customers_name as customer,
  customers.customers_type as member,
  services.service_type  as service
from orders
Join menu on orders.menu_id = menu.menu_id
join customers on orders.customers_id = customers.customers_id
join services on orders.service_id = services.service_id
)
select 
  customer as name,
  case when sum(price) >= 300 then 'Free apple Crumble Cake' 
  else ' '
  end 'Spending over 300'
from sub_order
group by 1 order by count( date) desc limit 3;

--Query the top services that customers prefer.
.print 'Top services'
with sub_order as (
select 
  orders.order_id,
  orders.order_date as date,
  menu.menu_name as menu,
  menu.menu_price as price,
  customers.customers_name as customer,
  customers.customers_type as member,
  services.service_type  as service
from orders
Join menu on orders.menu_id = menu.menu_id
join customers on orders.customers_id = customers.customers_id
join services on orders.service_id = services.service_id
)
select 
  service
from sub_order
group by service
order by  count(service) desc limit 1;

--Query the month's highest sales date.
.print 'Top sales date'
with sub_order as (
select 
  orders.order_id,
  orders.order_date as date,
  menu.menu_name as menu,
  menu.menu_price as price,
  customers.customers_name as customer,
  customers.customers_type as member,
  services.service_type  as service
from orders
Join menu on orders.menu_id = menu.menu_id
join customers on orders.customers_id = customers.customers_id
join services on orders.service_id = services.service_id
)
select 
  date
from sub_order
group by 1
order by  sum(price) desc limit 1;

--Query the sales of each menu on the month's highest sales date.
.print 'Sales of each menu at the date of the top sales'
with sub_order as (
select 
  orders.order_id,
  orders.order_date as date,
  menu.menu_name as menu,
  menu.menu_price as price,
  customers.customers_name as customer,
  customers.customers_type as member,
  services.service_type  as service
from orders
Join menu on orders.menu_id = menu.menu_id
join customers on orders.customers_id = customers.customers_id
join services on orders.service_id = services.service_id
), sales_0630 as(
select 
  *
from sub_order
  where cast(strftime('%Y%m%d',date) as int) = 20230630
)
select 
  menu,
  sum(price) as amount
from sales_0630
group by 1 order by 2 desc;

