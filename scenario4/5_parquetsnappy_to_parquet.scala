sqlContext.setConf("spark.sql.parquet.compression.codec","uncompressed")
sqlContext.read.parquet("/user/cloudera/problem5/parquet-snappy-compress").
            write.parquet("/user/cloudera/problem5/parquet-no-compress")

