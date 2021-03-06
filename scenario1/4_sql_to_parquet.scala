val oi = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/order_items")
val o = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/orders").
        withColumn("order_date_dt",from_unixtime($"order_date"/1000,"yyyy-MM-dd")).
		drop("order_date").
		withColumnRenamed("order_date_dt","order_date")
val od = o.join(oi,$"order_id" === $"order_item_order_id").registerTempTable("od")
val og = sqlContext.sql("select order_date,order_status, count(distinct(order_id)) as total_orders, sum(order_item_subtotal) as total_amount from od group by order_date, order_status order by order_date desc , order_status")
og.write.parquet("/user/cloudera/problem1/Result4b-gzip")

