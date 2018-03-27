drop table if exists products_replica;
create table products_replica as select * from products;
alter table products_replica add primary key (product_id);
alter table products_replica add column (product_grade int, product_sentiment varchar(100))
update products_replica set product_grade = 1  where product_price > 500;
update products_replica set product_sentiment  = 'WEAK'  where product_price between 300 and  500;
