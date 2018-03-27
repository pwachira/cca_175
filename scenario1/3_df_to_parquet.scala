val oi = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/order_items")
val o = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/orders").
      withColumn("order_date_dt",from_unixtime($"order_date"/1000,"yyyy-MM-dd")).
      drop("order_date").
      withColumnRenamed("order_date_dt","order_date").
      join(oi,$"order_id" === $"order_item_order_id").
      groupBy("order_status","order_date").
      agg(countDistinct("order_id").as("total_orders"),sum("order_item_subtotal").as("total_amount"))

o. write.parquet("/user/cloudera/problem1/result4a-gzip")
