import org.apache.spark.streaming.dstream.DStream
import org.apache.spark.streaming.StreamingContext
import java.util.Properties
import org.apache.kafka.common.serialization.ByteArraySerializer
import org.apache.kafka.common.serialization.StringSerializer
import org.apache.kafka.clients.producer.KafkaProducer
import java.util.concurrent.Future
import org.apache.kafka.clients.producer.ProducerRecord
import org.apache.kafka.clients.producer.RecordMetadata
object ${objectName} {

   def exec
   (ds:DStream[Array[String]],ssc:StreamingContext)={
   val kafkaproducer = { 
      val kafkaProducerConfig = {
        val p = new Properties()
        p.setProperty("bootstrap.servers","${brokers}")
        p.setProperty("key.serializer", classOf[ByteArraySerializer].getName)
        p.setProperty("value.serializer", classOf[StringSerializer].getName)
        p
      }
      MySparkKafkaProducer[Array[Byte], String](kafkaProducerConfig)
    }
   val producer=ssc.sparkContext.broadcast(kafkaproducer)
   
    ds.foreachRDD(rdd =>{
      rdd.foreachPartition { x => {
        x.foreach { x => {
          producer.value.send("${topic}",${data})
        } }
      } }
    })
  }
}


class MySparkKafkaProducer[K, V](createProducer: () => KafkaProducer[K, V]) extends Serializable {
  lazy val producer = createProducer()
  def send(topic: String, key: K, value: V): Future[RecordMetadata] =
    producer.send(new ProducerRecord[K, V](topic, key, value))

  def send(topic: String, value: V): Future[RecordMetadata] =
    producer.send(new ProducerRecord[K, V](topic, value))
}

object MySparkKafkaProducer {
  import scala.collection.JavaConversions._
  def apply[K, V](config: Map[String, Object]): MySparkKafkaProducer[K, V] = {
    val createProducerFunc = () => {
      val producer = new KafkaProducer[K, V](config)
      sys.addShutdownHook {
        producer.close()
      }
      producer
    }
    new MySparkKafkaProducer(createProducerFunc)
  }
  def apply[K, V](config: java.util.Properties): MySparkKafkaProducer[K, V] = apply(config.toMap)
}