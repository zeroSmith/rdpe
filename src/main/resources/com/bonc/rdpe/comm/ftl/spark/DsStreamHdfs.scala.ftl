import org.apache.spark.streaming.StreamingContext
import org.apache.spark.streaming.dstream.DStream

object ${objectName} {
	def exec(ssc:StreamingContext):DStream[String]={
	   var data=ssc.textFileStream("${path}");
	   data
	}
}