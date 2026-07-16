CREATE DATABASE IF NOT EXISTS retail_db_raw;

USE retail_db_raw;

CREATE EXTERNAL TABLE IF NOT EXISTS categories
(category_id int,
category_department_id string,
category_name string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///raw/mysql/categories';


CREATE EXTERNAL TABLE IF NOT EXISTS customers
(customer_id int,
customer_fname string,
customer_lname string,
customer_email string,
customer_password string,
customer_street string,
customer_city string,
customer_state string,
customer_zipcode string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///raw/mysql/customers';


CREATE EXTERNAL TABLE IF NOT EXISTS departments
(department_id int,
department_name string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///raw/mysql/departments';


CREATE TABLE IF NOT EXISTS departments_test
(department_id int,
department_name string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///raw/mysql/departments_test';

CREATE EXTERNAL TABLE IF NOT EXISTS order_items
(order_item_id int,
order_item_order_id int,
order_item_product_id int, 
order_item_quantity int, 
order_item_subtotal float,
order_item_product_price float
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///raw/mysql/order_items';


CREATE EXTERNAL TABLE IF NOT EXISTS orders
(order_id int,
order_date string,
order_customer_id int,
order_status string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///raw/mysql/orders';


CREATE EXTERNAL TABLE IF NOT EXISTS products
(product_id int,
product_category_id int,
product_name string,
product_description string,
product_price float,
product_image string
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 'hdfs:///raw/mysql/products';


// CREATE EXTERNAL TABLE IF NOT EXISTS products
// (school STRING,
//     sex STRING,
//     age INT,
//     address STRING,
//     famsize STRING,
//     Pstatus STRING,
//     Medu INT,
//     Fedu INT,
//     Mjob STRING,
//     Fjob STRING,
//     reason STRING,
//     guardian STRING,
//     traveltime INT,
//     studytime INT,
//     failures INT,
//     schoolsup STRING,
//     famsup STRING,
//     paid STRING,
//     activities STRING,
//     nursery STRING,
//     higher STRING,
//     internet STRING,
//     romantic STRING,
//     famrel INT,
//     freetime INT,
//     goout INT,
//     Dalc INT,
//     Walc INT,
//     health INT,
//     absences INT,
//     G1 INT,
//     G2 INT,
//     G3 INT)
// ROW FORMAT DELIMITED
// FIELDS TERMINATED BY ','
// STORED AS TEXTFILE
// LOCATION 'hdfs:///user/raw/mysql/bd_vanessa/t_student_mat';
