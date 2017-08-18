import kafka.serializer.StringDecoder
import org.apache.spark.streaming.StreamingContext
import org.apache.spark.streaming.dstream.DStream
import org.apache.spark.streaming.kafka.KafkaUtils

object ${objectName} {
	
	def exec(ssc:StreamingContext):DStream[String]={
		val groupId = "${groupId}"
		val topicSets = "${topicName}".split(",").toSet
		val kafkaParams = Map(
			"metadata.broker.list" -> "${brokerList}",
			"group.id" -> groupId,
			"serializer.class" -> "kafka.serializer.StringEncoder",
			"auto.offset.reset" -> "largest"
		)
		val kafkaDStream = KafkaUtils.createDirectStream[String,String,StringDecoder,StringDecoder](ssc, kafkaParams, topicSets).map(_._2)
		kafkaDStream
	}
}