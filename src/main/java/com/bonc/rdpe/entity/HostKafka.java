package com.bonc.rdpe.entity;

import lombok.Data;

@Data
public class HostKafka {
	
    private String id;

    private String hostIp;

    private String hostName;

    private String hostUsername;

    private String hostPassword;

    private String port;

    private String kafkaVersion;

    private String installPath;

}