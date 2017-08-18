package com.bonc.rdpe.entity;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class FunDef {
	
    private String id;

    private String parentId;

    private String funTypeId;

    private String funName;

    private String inputParam;

    private String outputParam;

    private String dataType;

    private String packageName;
    /**
     * 解析格式
     */
    private String parseFormat;

    private String storePath;

    private String methodDescription;

    private Integer ord;

    private String path;

    private String createId;

    private Date createTime;
    
    private List<FunParam> params;

}