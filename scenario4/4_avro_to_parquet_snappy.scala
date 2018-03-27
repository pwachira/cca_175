import com.databricks.spark.avro._
sqlContext.setConf("spark.sql.parquet.compression.codec","snappy")
val ord = sqlContext.read.avro("/user/cloudera/problem5/avro").
            write.parquet("/user/cloudera/problem5/parquet-snappy-compress")

