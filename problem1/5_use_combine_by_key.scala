val o = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/orders").
		withColumn("order_date_dt",from_unixtime($"order_date"/1000,"yyyy-MM-dd")).
		drop("order_date").
		withColumnRenamed("order_date_dt","order_date")

val oi = sqlContext.read.format("com.databricks.spark.avro").load("/user/cloudera/problem1/order_items")
import org.apache.spark.sql.Row
val idRdd = o.drop("order_customer_id").rdd.
		map {case Row (order_id: Int,order_status: String, order_date: String) => ((order_date,order_status),(order_id)) }.
		combineByKey((v => 1),(c: Int,v: Int)=>c+1,(c1: Int,c2: Int)=>c1+c2)
val amtRdd = o.join(oi,$"order_id" === $"order_item_order_id").
		select($"order_date",$"order_status",$"order_item_subtotal".as("amount")).
		map{case Row (order_date: String, order_status: String, amount: Float) => ((order_date, order_status),amount)}.
		combineByKey((v: Float) => v,(c: Float,v: Float) => c + v,(c1: Float, c2: Float) => c1+c2 )

case class amtClass (order_date: String, order_status: String, total_amount: Float)
case class orderClass (order_date: String, order_status: String, total_orders: Int)

val idDF = sqlContext.createDataFrame(idRdd.map(rd => orderClass(rd._1._1,rd._1._2,rd._2)))
val amtDF = sqlContext.createDataFrame(amtRdd.map(rd => amtClass(rd._1._1,rd._1._2,rd._2)))
idDF.join(amtDF,Seq("order_date","order_status")).
	write.parquet("/user/cloudera/problem1/result4c-gzip")
