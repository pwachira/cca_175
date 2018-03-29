#!/bin/bash
beeline -u  jdbc:hive2:// hive cloudera \
	-e "create database if not exists problem5;"

beeline -u  jdbc:hive2:// hive cloudera \
	-e "create table if not exists problem5.products_hive (product_id int, product_category_id int, product_name string, product_description string, product_price float, product_image string,product_grade int,  product_sentiment string); truncate table problem5.products_hive"
mysql -u "retail_dba" --password="cloudera"  --database="retail_db" \
        -e "delete from products_replica where product_id > 1350;"

sqoop job --delete incremental_2

sqoop job --create incremental_2 -- import --direct --connect jdbc:mysql://localhost/retail_db --username retail_dba --password cloudera \
        --table products_replica --hive-import --hive-database problem5 --hive-table products_hive \
        --check-column product_id --incremental append --last-value 0
sqoop job --exec incremental_2
mysql -u "retail_dba" --password="cloudera"  --database="retail_db" \
        -e "insert into products_replica (product_id) values(1351); insert into products_replica (product_id) values(1352);insert into products_replica (product_id) values(1353);"
wait
sqoop job --exec incremental_2
mysql -u "retail_dba" --password="cloudera"  --database="retail_db" \
        -e "delete from products_replica where product_id > 1353; insert into products_replica (product_id) values(1354); insert into products_replica (product_id) values(1355);"
wait
sqoop job --exec incremental_2
