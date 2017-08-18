import com.wandoulabs.jodis.JedisResourcePool
import redis.clients.jedis.Jedis
import com.wandoulabs.jodis.JedisPoolAdaptor
import org.apache.commons.pool2.impl.GenericObjectPoolConfig
import org.apache.spark.streaming.StreamingContext
import com.wandoulabs.jodis.JedisResourcePool
import com.wandoulabs.jodis.JedisPoolAdaptor
import org.apache.commons.pool2.impl.GenericObjectPoolConfig

object ${objectName} {

  def exec(ssc:StreamingContext): java.util.Set[String] = {
    var pool: JedisResourcePool = null
    var jedis: Jedis = null
    var rules: java.util.Set[String] = null;
    try {
      pool = DsRuleRedisPool.getRedisPool()
    } catch {
      case t: Throwable => t.printStackTrace()
      case t: Exception =>
        t.printStackTrace()
        pool = DsRuleRedisPool.getRedisPool()
    }
    try {
      if (pool != null) jedis = pool.getResource
    } catch {
      case t: Throwable => t.printStackTrace()
    }
    if (jedis != null) {
      rules = jedis.smembers("${key}")
      if(pool!=null){
      jedis.close()
      }
    }
    return rules;
  }
 object DsRuleRedisPool {
  @transient private var jedisPool: JedisResourcePool = null
  def getRedisPool(): JedisResourcePool = {
   
    if (jedisPool == null) {
      val redisHost = "${ip}"
      val redisPort = ${port}
      val redisTimeout = 30000
      val redisPassword = "${password}"
      jedisPool = new JedisPoolAdaptor(new GenericObjectPoolConfig(), redisHost, redisPort, redisTimeout, redisPassword)
      val hook = new Thread {
        override def run = jedisPool.close()
      }
      sys.addShutdownHook(hook.run)
    }

    return jedisPool
  }
} 
}