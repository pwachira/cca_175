import org.apache.hadoop.io.compress.GzipCodec
sqlContext.read.json("/user/cloudera/problem5/json-gzip").
	map(o => o(0)+","+o(1)+","+o(2)+","+o(3)).
	saveAsTextFile("/user/cloudera/problem5/csv-gzip",classOf[GzipCodec])	
