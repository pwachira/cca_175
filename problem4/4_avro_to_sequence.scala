import com.databricks.spark.avro._

sqlContext.read.avro("/user/cloudera/problem5/avro").
            map(o => (o(0).toString,o(1)+"\t"+o(2)+"\t"+o(3))).
            saveAsSequenceFile("/user/cloudera/problem5/sequence")
