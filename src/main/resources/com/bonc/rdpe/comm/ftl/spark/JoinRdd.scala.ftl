import org.apache.spark.streaming.dstream.DStream
import org.apache.spark.rdd.RDD
import org.apache.spark.SparkContext
import scala.collection.mutable.HashMap
import org.apache.spark.streaming.StreamingContext
object ${objectName}{
   def exec(ds2: DStream[Array[String]], rdd1: RDD[Array[String]], ssc: StreamingContext): DStream[Array[String]] = {
    if (${isBroadCast}) {
      val ds3 = ds2.map { x => { (${dskey}, x) } }
      val rdd2 = rdd1.map { x => { (${rulekey}, x) } }
      val ds4 = ds3.transform(rdd => rdd.join(rdd2))
      val ds5 = ds4.map(tuple => {
        val key = tuple._1
        val x = tuple._2._1
        val y = tuple._2._2
        val reArr = x++:y
        reArr
      })
      ds5
    } else {
      val mapDs = ds2.map { x => { (${dskey}, x) } }
      val broadRdd = ssc.sparkContext.broadcast(rdd1.collect());
      val map = new HashMap[String, Array[String]]
      val broadArr = broadRdd.value
      for (x <- broadArr) {
        map.put(${rulekey}, x)
      }
      var endArr: Array[String] = null
      val endDs = mapDs.map(tuple => {
        val arrRule = map.getOrElse(tuple._1, null)
        val arrDS = tuple._2
        if (arrRule != null && !arrRule.isEmpty) {
          endArr = arrDS ++: arrRule
        }
        endArr
      })
      endDs
    }

  }
}