
import org.apache.spark.streaming.dstream.DStream
import com.wandoulabs.jodis.JedisResourcePool
import scala.collection.mutable.HashMap
import redis.clients.jedis.Response
import java.io.Serializable
import com.wandoulabs.jodis.JedisPoolAdaptor
import org.apache.commons.pool2.impl.GenericObjectPoolConfig

object ${objectName} {
  def exec(keymap: DStream[Array[String]]): DStream[Array[String]] = {
   keymap.foreachRDD(rdd => {
      rdd.foreachPartition { x =>
        {
          var exist: Boolean = true
          var pool: JedisResourcePool = redisHandler.getRedisPool();
          x.foreach {
            arr =>
              {
                val key = ${redisKey}; 
                val jedis2 = pool.getResource
                exist = jedis2.exists(key)
                val sumArr = ${sumIndexArr} 
                val sumName = ${sumEnNameArr}
                val countArr = ${countIndexArr}
                val countName = ${countEnNameArr}
                if (!exist) {
                  if (sumArr != null && sumArr.length > 0) {
                    for (j <- 0 until sumArr.length) {
                      jedis2.hincrBy(key, sumName(j), arr(sumArr(j)).toLong) 
                    }
                  }
                  if (countArr != null && countArr.length > 0) {
                    for (j <- 0 until  countArr.length) {
                      jedis2.hincrBy(key, countName(j), 1l) 
                    }
                  }
                  jedis2.expire(key, 800) 
                } else {
                  if (sumArr != null && sumArr.length > 0) {
                    for (j <- 0 until sumArr.length) {
                      jedis2.hincrBy(key, sumName(j), arr(sumArr(j)).toLong) 
                    }
                  }
                  if (countArr != null && countArr.length > 0) {
                    for (j <- 0 until countArr.length) {
                      jedis2.hincrBy(key, countName(j), 1l)
                    }
                  }
                }
                jedis2.close()
              }
          }

        }
      }

    })
    
    
    val finalds = keymap.map { arr => (${reduceKey}, 0) } 
    val reds = finalds.reduceByKey(_ + _) 
    val dds = reds.map(x => { Array(x._1) })
    val aa = dds.map(arr => {
      var pool: JedisResourcePool = redisHandler.getRedisPool();
      val sumArr1 = ${sumIndexArr} 
      val countArr1 = ${countIndexArr}
      var reArr = new Array[String](arr.length + sumArr1.length + countArr1.length) 
      val jedis = pool.getResource
      val piple = jedis.pipelined() 
      val map = new Array[Response[String]](sumArr1.length + countArr1.length) 
      val map1 = new Array[String](sumArr1.length + countArr1.length) 
      
      val getMap=${aggFieldEnName}
      for (i <- 0 until map.length) {
        map(i) = piple.hget(${redisKeyByReduce}, getMap(i)) 
      }
      piple.sync()
     for(i<- 0 until map.length){
       map1(i)=map(i).get
     }
      if(arr(0).equals("null")){
       reArr =map1
      }else {
      reArr = arr(0).split("@") ++: map1 
      }
      jedis.close()
      var allArr=${indexArr};
      var resultArr= new Array[String](reArr.length)
      
      for(i<- 0 until resultArr.length){
        resultArr(allArr(i))=reArr(i)
      }
      resultArr
    })
    aa
  }
}
object redisHandler extends Serializable {

  @transient private var jedisPool: JedisResourcePool = null
  def getRedisPool(): JedisResourcePool = {
    if (jedisPool == null) {
      val redisHost1 = "172.16.13.185"
      val redisPort = 6379
      val redisTimeout = 30000
      val redisPassword = "root123"
      jedisPool = new JedisPoolAdaptor(new GenericObjectPoolConfig(), redisHost1, redisPort, redisTimeout, redisPassword)
      val hook = new Thread {
        override def run = jedisPool.close()
      }
      sys.addShutdownHook(hook.run)
    }
    return jedisPool
  }
}