import org.apache.hadoop.io.Text
import org.apache.hadoop.io.IntWritable
val oDF = sc.sequenceFile("/user/cloudera/problem5/sequence",classOf[IntWritable],classOf[Text]).
	map(o => (o._1.get,o._2.toString.split("\t"))).
	map(o => (o._1,o._2(0),o._2(1),o._2(2))).
	toDF
oDF.write.orc("/user/cloudera/problem5/orc")
