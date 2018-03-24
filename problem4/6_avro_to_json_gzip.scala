import com.databricks.spark.avro._
import org.apache.hadoop.io.compress.GzipCodec
sqlContext.read.avro("/user/cloudera/problem5/avro-snappy").
	toJSON.saveAsTextFile("/user/cloudera/problem5/json-gzip",classOf[GzipCodec])	
