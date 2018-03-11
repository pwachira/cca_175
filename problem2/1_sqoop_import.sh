#!/bin/bash
cd /home/cloudera
sqoop import \
--connect jdbc:mysql://localhost:3306/retail_db \
--username retail_dba \
--password cloudera \
--table products \
--as-textfile \
--target-dir products \
--fields-terminated-by '|'

hdfs dfs -mkdir -p problem2/products
hdfs dfs -mv products problem2/products

hdfs dfs -chmod 765 problem2/products

