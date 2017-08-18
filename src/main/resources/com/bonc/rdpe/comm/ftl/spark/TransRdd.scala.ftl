import org.apache.spark.rdd.RDD

object ${objectName} {
def exec(ds:RDD[Array[String]]):RDD[Array[String]]={
   val result=ds.map {x =>{
     val endArr=Array[String](${arry})
    	  endArr
    } }
    result;
  }
}