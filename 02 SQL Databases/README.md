# Summary: 
- Create a restaurant database and generate an overview of the restaurant's performance using a subquery technique.
- Calculate the number of service days, total orders, total income, and average income per service day.
- Calculate an aggregated perspective of the cafe's operational performance

## Database Details
There are 5 tables in the restaurant database
-  Categories table consists of categories_id and categories_name.
-  Menu table consists of menu_id, categories_id,  menu_name, and menu_price.
-  Customer name table consists of customers_id, customers_name, and customers_type.
-  Service Type table consists of service_id and service_type.
-  Orders table shows the details of an order consisting of order_id, order_date, menu_id, customers_id, and service_id

## SQL Statements
- CREATE TABLE: Create a new table in a database.
- DROP TABLE: Remove an existing table in a database.
- VALUES: Command specifies the values of an INSERT INTO statement.
- INSERT INTO: Insert new records in a table.
- SELECT: Select data from the database.
- FROM: Select the table name.
- WHERE: Filter records by specified condition.
- GROUP BY: Groups rows that have the same values into summary rows
- JOIN: Combine rows from two or more tables
- ORDER BY: Sort data
- DESC: Sort the records in descending order use with ORDER BY.
- COUNT(): The function returns the number of rows that matches a specified criterion.
- SUM(): The function returns the total sum of a numeric column.
- (distinct): Return only distinct different values
