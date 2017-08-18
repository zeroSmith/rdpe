import org.apache.spark.streaming.dstream.DStream
import org.apache.commons.lang3.StringUtils

object ${objectName} {
	def exec(ds: DStream[String]): DStream[Array[String]] = {
	    val dStream = ds.map(line => {
		val colvalues =line.split("${separator}")
	      var arrRet = new Array[String](colvalues.length)
	      var arrIndexs = Array(${indexs});
	      for (j <- 0 until arrIndexs.length) {
	        arrRet(arrIndexs(j)) = colvalues(arrIndexs(j))
	      }
	      arrRet
	    })
	 dStream
  }
}