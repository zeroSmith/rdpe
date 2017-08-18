import org.apache.spark.streaming.dstream.DStream

object ${objectName} {
  def exec(ds:DStream[Array[String]]):DStream[Array[String]]={
   val result=ds.map {x =>{
     val endArr=Array[String](${arry})
    	  endArr
    } }
    result;
  }
}