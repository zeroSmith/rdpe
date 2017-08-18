import org.apache.spark.SparkContext
import org.apache.spark.rdd.RDD
import org.apache.spark.streaming.StreamingContext

object ${objectName} {

  def exec(ssc:StreamingContext):RDD[String]={
    val rules=ssc.sparkContext.textFile("${path}").filter(x => !x.equals(""));
       rules
  }
  
}