#!/bin/bash

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table order_items \
--as-textfile \
--target-dir=/user/datapath/datasets/order_items \
--delete-target-dir > /tmp/log_order_items.log

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table products \
--as-textfile \
--target-dir=/user/datapath/datasets/products \
--delete-target-dir > /tmp/log_products.log

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table customers \
--as-textfile \
--target-dir=/user/datapath/datasets/customers \
--delete-target-dir > /tmp/log_customer.log

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table departments \
--as-textfile \
--target-dir=/user/datapath/datasets/departments \
--delete-target-dir > /tmp/log_departments.log

sqoop import \
--connect "jdbc:mysql:///mysql:3306/retail_db" \
--username=root \
--password=root \
--table categories \
--as-textfile \
--target-dir=/user/datapath/datasets/categories \
--delete-target-dir > /tmp/log_categories.log

sqoop import \
--connect "jdbc:mysql://mysql:3306/retail_db" \
--username=root \
--password=root \
--table orders \
--as-textfile \
--target-dir=/user/datapath/datasets/orders \
--delete-target-dir > /tmp/log_orders.log

# sqoop import \
# --connect "jdbc:mysql://mysql:3306/bd_vanessa" \
# --username=root \
# --password=root \
# --table student_mat \
# --split-by age \
# --as-textfile \
# --target-dir=/user/raw/mysql/bd_vanessa/t_student_mat \
# --delete-target-dir > /tmp/log_customer.log
