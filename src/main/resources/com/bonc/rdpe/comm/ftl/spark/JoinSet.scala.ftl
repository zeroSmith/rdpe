	import org.apache.spark.streaming.dstream.DStream
	import scala.collection.mutable.HashSet
	import org.apache.spark.SparkContext
	import scala.collection.mutable.HashMap
	import org.apache.spark.streaming.StreamingContext
	
object ${objectName} {

	def exec(ds: DStream[Array[String]], set: HashSet[Array[String]], ssc: StreamingContext): DStream[Array[String]] = {

    val map = new HashMap[String, Array[String]]
    val mapDs = ds.map { x => { (${dskey}, x) } }
    val broSet = ssc.sparkContext.broadcast(set)
    val it = broSet.value.iterator
    while (it.hasNext) {
      val x = it.next();
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
  }}