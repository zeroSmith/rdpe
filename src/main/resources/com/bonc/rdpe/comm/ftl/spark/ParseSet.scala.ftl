import scala.collection.mutable.HashSet
object ${objectName} {
def exec(rules: java.util.Set[String]): HashSet[Array[String]] = {
    var itertor = rules.iterator
    val rulesSet = new HashSet[Array[String]]
    while (itertor.hasNext) {
      var line = itertor.next()
      var arr = line.split("${separator}", -1);
      var arrRet = new Array[String](arr.length)
      var arrIndexs = Array(${indexs});
      for (j <- 0 until arrIndexs.length) {
        arrRet(arrIndexs(j)) = arr(arrIndexs(j))
      }
      rulesSet.add(arrRet)
    }
    return rulesSet;
  }
}