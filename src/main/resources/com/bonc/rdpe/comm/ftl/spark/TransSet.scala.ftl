import scala.collection.mutable.HashSet

object ${objectName} {
def exec(set:HashSet[Array[String]]):HashSet[Array[String]]={
   var itertor = set.iterator
    val rulesSet = new HashSet[Array[String]]
    while (itertor.hasNext) {
      var x = itertor.next()
      var endArr =Array[String](${arry})
      rulesSet.add(endArr)
    }
    return rulesSet;
}}