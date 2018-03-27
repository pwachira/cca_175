import com.databricks.spark.avro._
sqlContext.setConf("spark.sql.avro.compression.codec","snappy")
sqlContext.read.parquet("/user/cloudera/problem5/parquet-snappy-compress").
            write.avro("/user/cloudera/problem5/avro-snappy")

