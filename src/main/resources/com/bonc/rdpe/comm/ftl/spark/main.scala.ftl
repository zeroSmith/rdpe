import org.apache.spark.SparkConf
import org.apache.spark.streaming.StreamingContext
import org.apache.spark.streaming.Seconds
import org.apache.spark.SparkContext

object main {
  def main(args: Array[String]): Unit = {
     val conf = new SparkConf().setAppName("hdfs")
     val sc = new SparkContext(conf)
     val ssc = new StreamingContext(sc, Seconds(5))
	 ${main}
    ssc.start()
    ssc.awaitTermination()
  }
}