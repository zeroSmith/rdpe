package com.bonc.rdpe.entity;

import java.util.Date;

import lombok.Data;
@Data
public class EventStorm {
    private String id;

    private String eventEnName;

    private String eventCnName;

    private String eventType;

    private String submitHostId;

    private String flowDefMd5;

    private String externalMainClass;

    private String uploadJarPath;

    private String publishJarPath;

    private String genCodeStatus;

    private String runStatus;

    private String createId;

    private Date createTime;

    private String flowDef;

    private String executeDef;

}