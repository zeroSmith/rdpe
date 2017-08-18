import scala.collection.mutable.HashSet

object ${objectName} {
	def exec(ds: HashSet[Array[String]]): HashSet[Array[String]] = {
    var itertor = ds.iterator
    val resultSet = new HashSet[Array[String]]
    while (itertor.hasNext) {
      var line = itertor.next();
      if (${filter}) {
        resultSet.add(line)
      }
      resultSet
    }
    resultSet

  }
}