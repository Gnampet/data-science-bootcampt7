# Summary: 
- Create a restaurant database and generate an overview of the restaurant's performance using a subquery technique.
- Calculate the number of service days, total orders, total income, and average income per service day.
- Calculate an aggregated perspective of the cafe's operational performance

## Database Details
There are 5 tables in the restaurant database
1. Categories table consists of _categories_id_ and _categories_name._
2. Menu table consists of _menu_id, categories_id,  menu_name,_ and _menu_price._
3. Customer name table consists of customers_id, customers_name, and customers_type.
4. Service Type table consists of _service_id_ and _service_type._
5. Orders table shows the details of an order consisting of _order_id, order_date, menu_id, customers_id,_ and _service_id_

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
