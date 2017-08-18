package com.bonc.rdpe.service.impl.host;


import org.springframework.stereotype.Service;

import com.bonc.rdpe.entity.HostKafka;
import com.bonc.rdpe.service.host.HostKafkaService;
import com.bonc.rdpe.service.impl.base.BaseServiceImpl;

/**
 * kafka主机配置
 * 
 * @author xieqianqian
 *
 */
@Service("hostKafkaService")
public class HostKafkaServiceImpl extends BaseServiceImpl<HostKafka, String> implements HostKafkaService {
}
