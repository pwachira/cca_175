
val o = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/orders")
val oi = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/order_items")
val orders = o.withColumn("order_date_dt",from_unixtime($"order_date"/1000,"yyyy-MM-dd"))
val nodt = orders.drop("order_date")
val o = nodt.withColumnRenamed("order_date_dt","order_date")
val od = o.join(oi,$"order_id" === $"order_item_order_id")
val og = od.groupBy("order_status","order_date").agg(countDistinct("order_id").as("total_orders"),sum("order_item_subtotal").as("total_amount"))

og.write.parquet("/user/cloudera/problem1/result4a-gzip")





