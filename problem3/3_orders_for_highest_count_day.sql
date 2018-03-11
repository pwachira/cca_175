select o.* from orders_sqoop o  inner join
    (select  q1.order_date,rank() over (order by q1.order_ct desc) rnk, q1.order_ct
        from    (select from_unixtime(BIGINT(order_date/1000),'YYYY-MM-dd') order_date, count(1) order_ct
                    from orders_sqoop group by from_unixtime(BIGINT(order_date/1000),'YYYY-MM-dd')
                ) q1
    ) q2
    on q2.order_date =from_unixtime(BIGINT( o.order_date/1000),'YYYY-MM-dd')
    where q2.rnk = 1;

