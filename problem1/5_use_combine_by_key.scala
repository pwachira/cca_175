val o = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/orders").
		withColumn("order_date_dt",from_unixtime($"order_date"/1000,"yyyy-MM-dd")).
		drop("order_date").
		withColumnRenamed("order_date_dt","order_date")

val oi = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/order_items")
val od = o.join(oi,$"order_id" === $"order_item_order_id")
val oRdd = o.rdd
val otmp= o.drop("order_customer_id")
val o = otmp
val oGrp = o.rdd.map {case Row (order_id: Int,order_status: String, order_date: String) => ((order_date,order_status),(order_id)) }



