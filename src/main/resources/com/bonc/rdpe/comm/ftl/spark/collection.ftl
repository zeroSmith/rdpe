package com.bonc

import org.apache.spark.{ SparkConf, SparkContext }
import org.apache.spark.streaming.{ Durations, StreamingContext }
import org.apache.spark.streaming.dstream.DStream
import redis.clients.jedis.JedisPool
import redis.clients.jedis.JedisPoolConfig
import redis.clients.jedis.Jedis
import java.math.BigInteger
import java.math.BigDecimal

object SumCollection extends Serializable {


  //按照某个字段统计，依某个字段分组。
  def operation(ssc: StreamingContext, dStream: DStream[Array[String]]) = {
    val a: Array[Integer] = Array(${open_index}) //进行统计的sum数组
    val group: Array[Integer] = Array(${order_index}) //进行分组的数组。---下标中每个字段进行拼接，作为key
    
    //拼接key
    val keyBuff = new StringBuffer
    if(group.length!=0){
    	keyBuff.append("${applicationID_}").append("${rectID_}")
    	var str=""
    	for (  i <- 0 to group.length-1) {
    		str+group(i)+"_"
    	}
    	str=str+group(group.length-1)  //保证组成的key为 applicationID_rectID_KEY  KEY后边没有"_"
    	keyBuff.append(str)
    }else{
      keyBuff.append("${applicationID_}").append("${rectID_}")
    }
    val key = keyBuff.toString()
    //count
     dStream.foreachRDD(x => {
      x.foreachPartition(ite => {
        val jedis: Jedis=makePool().getResource
        var counts:BigInteger =new BigInteger("0")//对于出现的次数进行统计
        var index = 0
        for (i <- a) {
          var count: Integer = 0 //计数器
          index = i    // index为通过数组传递过来的一个下标值。
          var s: Array[String] = null;
          while (ite.hasNext) {
            s = ite.next()
          }
          if ((jedis.get(key))!=null) { //index作为传递过来的下标。
            counts=counts.add(new BigInteger("1"))
            jedis.set(key, counts+"")
          } else {//没有作为0次。
            jedis.set(key, "0")
          }
        }
      })
    })
//求和bigDecimal
    dStream.foreachRDD(x => {
      x.foreachPartition(ite => {
        val jedis: Jedis=makePool().getResource
        var index = 0
        for (i <- a) {
          var count :BigDecimal =new  BigDecimal(0)  //计数器
          index = i   // index为通过数组传递过来的一个下标值。
          var s: Array[String] = null;
          while (ite.hasNext) {
            s = ite.next()
          }
          if ((jedis.get(key))!=null) { //index作为传递过来的下标。
                val preValue=jedis.get(key)
                count=count.add(new BigDecimal(preValue))
                count=count.add(new BigDecimal(s(index)))
            	jedis.set(key, (count+""))
          } else {
             jedis.set(key, new BigDecimal(s(index)) +"")//第一次数据【流量】
          }
        }
      })
    })
	//max
    dStream.foreachRDD(x => {
      x.foreachPartition(ite => {
        val jedis: Jedis=makePool().getResource
        var index = 0
        for (i <- a) {
          var count: Integer = 0 //计数器
          index = i // index为通过数组传递过来的一个下标值。
          var maxArr: Array[String] = null;
          while (ite.hasNext) {
            maxArr = ite.next()
          }
          if ((jedis.get(key))!=null){ //map这里作为一个内存，实际需要变成redis的连接。
            val preValue=jedis.get(key)
            if (Integer.parseInt(maxArr(index)) >Integer.parseInt(preValue) ) {
               jedis.set(key, Integer.parseInt(maxArr(index))+"")
            }
          }
        }
      })
    })
    //max-end
    dStream.foreachRDD(x => {
      x.foreachPartition(ite => {
        val jedis: Jedis=makePool().getResource
        var index = 0
        for (i <- a) {
          var count: Integer = 0 //计数器
          index = i //index为通过数组传递过来的一个下标值。
          var s: Array[String] = null;
          while (ite.hasNext) {
            s = ite.next()
          }
          if ((jedis.get(key))!=null) { //index作为传递过来的下标。
            val preValue=jedis.get(key)
            jedis.set(key, Integer.parseInt(s(index)) + preValue+"")
          } else {
            jedis.set(key, Integer.parseInt(s(index))+"")
          }
        }

      })
    })
    
     }
  
    
    @transient  var pool: JedisPool = null
  def makePool()={
    if (pool == null) {
      val config = new JedisPoolConfig()
      config.setMaxWaitMillis(1000000) 
      config.setMaxIdle(10000)
      config.setMaxTotal(9000)
      config.setMaxWaitMillis(100000)
      config.setTestOnBorrow(true)
      config.setTestOnReturn(true)
      pool = new JedisPool(config, "${redis_IP}", ${redis_port}, 500000)
    }
    pool
  }
 
}























