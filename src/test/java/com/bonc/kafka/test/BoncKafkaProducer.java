package com.bonc.kafka.test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.Properties;

import org.apache.kafka.clients.producer.Callback;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.Producer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;

public class BoncKafkaProducer extends Thread {

	private String topic;

	public BoncKafkaProducer(String topic) {
		this.topic = topic;
	}

	@Override
	public void run() {
		KafkaProducer<String, String> producer = createProducer();
		try {
			FileReader fr = new FileReader(new File("E:\\opt\\111.txt"));
			BufferedReader br = new BufferedReader(fr);
			while (true) {
				String line = br.readLine();
				if (line != null) {
					sendMsg(producer,line);
				} else {
					break;
				}
			}
			br.close();
			producer.close();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
	}

	private void sendMsg(Producer<String, String> producer,String line) {
		ProducerRecord<String, String> record = new ProducerRecord<String, String>(topic,0,null,line);
		producer.send(record, new Callback() {
			public void onCompletion(RecordMetadata metadata, Exception e) {
				if (e != null) {
					e.printStackTrace();
				} else {
					System.out.println("The partition of the record is: " + metadata.partition());
					System.out.println("The offset of the record is: " + metadata.offset());
				}
			}
		});
	}

	private KafkaProducer<String, String> createProducer() {
		Properties properties = new Properties();
		properties.put("bootstrap.servers", "rdpe3:9092,rdpe4:9092,rdpe5:9092");
		properties.put("value.serializer", "org.apache.kafka.common.serialization.StringSerializer");
		properties.put("key.serializer", "org.apache.kafka.common.serialization.StringSerializer");
		return new KafkaProducer<String, String>(properties);
	}

	public static void main(String[] args) {
		new BoncKafkaProducer("source").start();
	}
}
