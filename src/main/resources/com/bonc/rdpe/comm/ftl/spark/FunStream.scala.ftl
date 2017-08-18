import org.apache.spark.streaming.dstream.DStream

object ${objectName} {

  def exec(ds:DStream[Array[String]]):DStream[String]={
       ${fun}
  }
  
}