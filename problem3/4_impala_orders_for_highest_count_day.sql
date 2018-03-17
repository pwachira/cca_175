invalidate metadata;
refresh orders_sqoop;

select o.* from orders_sqoop o  inner join
    (select  q1.order_date,rank() over (order by q1.order_ct desc) rnk, q1.order_ct
        from    (select  order_date, count(1) order_ct
                    from orders_sqoop group by order_date
                ) q1
    ) q2
    on q2.order_date =o.order_date
    where q2.rnk = 1;

