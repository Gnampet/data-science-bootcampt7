
-- This is part of my homework in the boot camp to create a database of a restaurant.  
-- I have created a cafe database consisting of a drink and dessert menu with the name 'PP cafe'.
-- HW: Restaurant database
-- 5 tables
-- Write 3-5 queries
-- 1x WITH
-- 1x SUBQUERY
-- 1x Aggregate function

-- ====================================================================================================

.open pp_cafe.db;
--Categories menu
drop table categories;
create table categories (
  categories_id int,
  categories_name text
);
insert into categories values
  (1, 'Drinks'),
  (2, 'Desserts');
--select * from categories;

--Menus of pp cafe
drop table menu;
create table menu (
  menu_id int,
  categories_id int,
  menu_name text,
  menu_price real
);
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
/*select 
  menu_id as no,
  menu_name as name,
  menu_price as price
from menu;*/

--Customers name
drop table customers;
create table customers (
  customers_id int,
  customers_name text,
  customers_type text
);
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
--select * from customers;

--Service Type
drop table services;
create table services (
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
