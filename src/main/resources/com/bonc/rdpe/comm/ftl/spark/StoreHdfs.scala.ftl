
import org.apache.spark.streaming.StreamingContext
import org.apache.spark.streaming.dstream.DStream

object ${objectName} {
  def exec
  (ds:DStream[Array[String]], ssc:StreamingContext)={
    val sc=ssc.sparkContext
    ds.foreachRDD(x=>{
        x.saveAsTextFile("${path}")
    })
  }
}