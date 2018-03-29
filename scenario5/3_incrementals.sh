#!/bin/bash
hdfs dfs -rm -r /user/cloudera/problem5/products-incremental

mysql -u "retail_dba" --password="cloudera"  --database="retail_db" \
	-e "delete from products_replica where product_id > 1345;"

sqoop job --delete incremental
sqoop job --create incremental -- import --direct --connect jdbc:mysql://localhost/retail_db --username retail_dba --password cloudera \
	--as-textfile --table products_replica --target-dir /user/cloudera/problem5/products-incremental \
	--check-column product_id --incremental append --last-value 0

sqoop job --exec incremental

mysql -u "retail_dba" --password="cloudera"  --database="retail_db" \
	-e "insert into products_replica (product_id) values(1346); insert into products_replica (product_id) values(1347);insert into products_replica (product_id) values(1348);"

sqoop job --exec incremental

mysql -u "retail_dba" --password="cloudera"  --database="retail_db" \
	-e "delete from products_replica where product_id > 1348; insert into products_replica (product_id) values(1349); insert into products_replica (product_id) values(1350);"

sqoop job --exec incremental
