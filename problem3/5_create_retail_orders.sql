
create  table orders_avro (order_id int,
			order_date date,
			order_customer_id int,
			order_status string
)
PARTITIONED BY (order_year_month string)
stored as avro;

set hive.exec.dynamic.partition.mode =  non-strict;

from orders_sqoop
insert overwrite  table orders_avro
partition (order_year_month)

select  order_id,
	from_unixtime(bigint (order_date/1000),"YYYY-MM-dd") order_date,
        order_customer_id,
        order_status,
        substring(from_unixtime(bigint(order_date/1000),"YYYY-MM-dd"),1,7)  order_year_month
;
