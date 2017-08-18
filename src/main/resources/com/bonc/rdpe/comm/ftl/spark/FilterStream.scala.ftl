import org.apache.spark.streaming.dstream.DStream

object ${objectName} {
	def exec(ds: DStream[Array[String]]): DStream[Array[String]] = {
	    ds.filter { line => !"".equals(line) }.filter { line => ${filter} }
	}
}