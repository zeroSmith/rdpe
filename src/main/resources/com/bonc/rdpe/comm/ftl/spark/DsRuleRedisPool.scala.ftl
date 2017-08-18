import com.wandoulabs.jodis.JedisResourcePool
import com.wandoulabs.jodis.JedisPoolAdaptor
import org.apache.commons.pool2.impl.GenericObjectPoolConfig

object ${objectName} {
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