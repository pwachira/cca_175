#!/bin/bash
beeline -u  jdbc:hive2:// hive cloudera \
	-e "drop table if exists products_hive";

beeline -u  jdbc:hive2:// hive cloudera \
	-e "create table products_hive (product_id int, product_category_id int, product_name string, product_description string, product_price float, product_imaage string,product_grade int,  product_sentiment string);"
