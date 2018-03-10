case class product (id: String,category: String,name: String, desc: String,price: Float,image: String)

val productsRDD= sc.textFile("/user/cloudera/problem2/products").map(_.split('|')).map{case Array(id,category,name,desc,price,image) => product(id,category,name,desc,price.toFloat,image)}

val productsDF = productsRDD.toDF

import com.databricks.spark.avro._
sqlContext.setConf("spark.sql.avro.compression.codec","snappy")

productsDF.filter("price < 100").groupBy("category").agg(max("price").as("max_price"),count("id").as("product_count"),avg("price").as("avg_price"),min("price").as("min_product_price")).write.format("com.databricks.spark.avro").save("/user/cloudera/problem2/result-df")

productsDF.registerTempTable("products")


sqlContext.sql("select category, max(price) max_price, count(id) count_id,avg(price) avg_price,min(price) min_price from products where price < 100 group by category").write.avro("problem2/result-sql")

val productsKv = productsRDD.filter(_.price < 100F).map{case product(id,cat,name,desc,price,image) => ((cat),(id,price)) }

val  prodAgg = productsKv.aggregateByKey((Float.MinValue,0,0F,Float.MaxValue))(((acc,v) =>
	(v._2.max(acc._1),acc._2+1,acc._3+v._2,v._2.min(acc._4))),((acc1,acc2) => 
	(acc1._1.max(acc2._1),acc1._2+acc2._2,acc1._3+acc2._3,acc1._4.min(acc2._4)))).
	map(p =>(p._1,p._2._1,p._2._2,p._2._3/p._2._2,p._2._4) )


case class summary(category: String,max_price: Float, count: Int, ang_price: Float, min_price: Float)

prodAgg.map(s => summary(s._1,s._2,s._3,s._4,s._5)).toDF.write.avro("/user/cloudera/problem2/result-rdd")

