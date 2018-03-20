import com.databricks.spark.avro._
import org.apache.hadoop.io.compress.GzipCodec
val ord = sqlContext.read.avro("/user/cloudera/problem5/avro").
            map(o => o(0)+"\t"+o(1)+"\t"+o(2)+"\t"+o(3)).
            saveAsTextFile("/user/cloudera/problem5/text-gzip-compress",classOf[GzipCodec])
