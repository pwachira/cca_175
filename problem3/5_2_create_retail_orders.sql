insert into table orders_avro
partition (order_year_month)
select  order_id,
        order_customer_id,
        order_status
	concat(year(from_unixtime(bigint(order_date/1000))),
        concat("-",month(from_unixtime(bigint(order_date/1000)))
        )) order_year_month,
from orders_sqoop;

