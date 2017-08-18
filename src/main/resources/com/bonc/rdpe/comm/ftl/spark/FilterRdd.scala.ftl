import org.apache.spark.rdd.RDD

object ${objectName} {
	def exec(ds: RDD[Array[String]]): RDD[Array[String]] = {
    ds.filter { line => !"".equals(line) }.filter { line => ${filter}  }
  }
	
}