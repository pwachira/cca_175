#!/bin/bash
hdfs dfs -rm -r /user/cloudera/problem5/products-text

sqoop import --connect jdbc:mysql://localhost/retail_db --username retail_dba \
	--password cloudera --table products_replica --fields-terminated-by '|' \
	--lines-terminated-by '\n' \
	--boundary-query  "select min(product_id), max(product_id) from products_replica where product_id between 1 and 1000" \
	--null-string "NOT-AVAILABLE" --null-non-string -1 \
	--m 3 --as-textfile --target-dir "/user/cloudera/problem5/products-text"

hdfs dfs -rm -r /user/cloudera/problem5/products-text-part1

sqoop import --connect jdbc:mysql://localhost/retail_db --username retail_dba \
	--password cloudera --table products_replica --fields-terminated-by '*' \
	--lines-terminated-by '\n' \
	--boundary-query  "select min(product_id), max(product_id) from products_replica where product_id <=  1111" \
	--null-string "NA" --null-non-string -1000 \
	--m 2 --as-textfile --target-dir "/user/cloudera/problem5/products-text-part1"

hdfs dfs -rm -r /user/cloudera/problem5/products-text-part2

sqoop import --connect jdbc:mysql://localhost/retail_db --username retail_dba \
	--password cloudera --table products_replica --fields-terminated-by '*' \
	--lines-terminated-by '\n' \
	--boundary-query  "select min(product_id), max(product_id) from products_replica where product_id >  1111" \
	--null-string "NA" --null-non-string -1000 \
	--m 5 --as-textfile --target-dir "/user/cloudera/problem5/products-text-part2"

hdfs dfs -rm -r /user/cloudera/problem5/products-text-both-parts

sqoop codegen --connect jdbc:mysql://localhost/retail_db  \
	--table products_replica --username retail_dba --password cloudera --fields-terminated-by '*' \
        --lines-terminated-by '\n'

sqoop merge --new-data "/user/cloudera/problem5/products-text-part2" \
	--onto "/user/cloudera/problem5/products-text-part1" \
        --target-dir "/user/cloudera/problem5/products-text-both-parts" \
	--merge-key product_id --jar-file "/tmp/sqoop-cloudera/compile/0963b4801c1bef2053e20583cfde8323/products_replica.jar" \
	--class-name products_replica 

