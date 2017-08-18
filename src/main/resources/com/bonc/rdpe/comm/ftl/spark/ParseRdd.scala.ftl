import org.apache.spark.rdd.RDD

object ${objectName} {

  def exec(rdd: RDD[String]): RDD[Array[String]] = {

    val result = rdd.map { x =>
      {
        val words = x.split("${separator}", -1)
        var retArr = new Array[String](words.length)
        var arrIndexs = Array(${indexs})
        for (j <- 0 until arrIndexs.length) {
          retArr(arrIndexs(j)) = words(arrIndexs(j))
        }
        retArr
      }
    }
    result
  }
}