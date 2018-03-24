import com.databricks.spark.avro._

sqlContext.read.avro("/user/cloudera/problem5/avro-snappy").
	toJSON.saveAsTextFile("/user/cloudera/problem5/json-no-compress")	
