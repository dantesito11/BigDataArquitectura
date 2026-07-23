#!/bin/bash

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table order_items \
--columns order_item_id,order_item_order_id,order_item_product_id,order_item_quantity,order_item_subtotal,order_item_product_price \
--as-textfile \
--target-dir=/raw/mysql/order_items \
--delete-target-dir > /tmp/log_order_items.log

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table products \
--columns product_id,product_category_id,product_name,product_description,product_price,product_image \
--as-textfile \
--target-dir=/raw/mysql/products \
--delete-target-dir > /tmp/log_products.log

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table customers \
--as-textfile \
--target-dir=/raw/mysql/customers \
--delete-target-dir > /tmp/log_customer.log

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table departments \
--as-textfile \
--target-dir=/raw/mysql/departments \
--delete-target-dir > /tmp/log_departments.log

sqoop import \
--connect "jdbc:mysql:///mysql:3306/retail_db" \
--username=root \
--password=root \
--table categories \
--as-textfile \
--target-dir=/raw/mysql/categories \
--delete-target-dir > /tmp/log_categories.log

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table orders \
--as-textfile \
--target-dir=/raw/mysql/orders \
--delete-target-dir > /tmp/log_orders.log
