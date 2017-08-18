/*
Navicat MySQL Data Transfer

Source Server         : 172.16.11.56
Source Server Version : 50626
Source Host           : 172.16.11.56:3306
Source Database       : odp

Target Server Type    : MYSQL
Target Server Version : 50626
File Encoding         : 65001

Date: 2017-07-19 09:26:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `enable` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `registerTime` datetime NOT NULL,
  `roleId` int(11) DEFAULT NULL,
  `organizationId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_gex1lmaqpg0ir5g1f5eftyaa1` (`username`),
  KEY `IDX_account_roleId` (`roleId`),
  KEY `IDX_account_organizationId` (`organizationId`),
  KEY `FK_account_role` (`roleId`),
  KEY `FK_account_organization` (`organizationId`),
  CONSTRAINT `FK_account_organization` FOREIGN KEY (`organizationId`) REFERENCES `organization` (`id`),
  CONSTRAINT `FK_account_role` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('23', '5', '1', 'xieqq', '', 'xieqq', 'b08c824609aa85da46df71dbb3319326', '2016-11-28 06:58:09', '8', '8');
INSERT INTO `account` VALUES ('24', '6', '1', 'bianshen', '', 'bianshen', '081b6d969a15be2457ba176f536d06c8', '2016-11-28 07:06:02', '10', '8');
INSERT INTO `account` VALUES ('25', '2', '1', 'admin', '', 'admin', '172eee54aa664e9dd0536b063796e54e', '2016-11-28 07:30:05', '1', '8');
INSERT INTO `account` VALUES ('27', '1', '1', 'spark', '', 'spark', '172eee54aa664e9dd0536b063796e54e', '2016-11-30 14:18:41', '8', '8');
INSERT INTO `account` VALUES ('29', '2', '1', 'superAdmin', '', 'superAdmin', 'd110c80a1bf4420140969a068db0a0ff', '2016-12-26 15:42:55', '9', null);
INSERT INTO `account` VALUES ('31', '2', '1', 'liyongqiang', '', 'liyongqiang', '70be7e0ed1157e20fc37f740c9b9cb2e', '2016-12-26 16:16:21', '8', '8');
INSERT INTO `account` VALUES ('32', '2', '1', 'root', '', 'root', 'e3d5d25da4f074dd12ae19d9bbe0a61d', '2017-01-03 10:51:20', '1', '8');
INSERT INTO `account` VALUES ('33', '2', '1', 'wangxx', '', 'wxx', 'ece4f36703a42113a25a2f2087a489f1', '2017-02-20 19:34:02', '8', '8');
INSERT INTO `account` VALUES ('34', '3', '1', 'POC', '', 'POC', '081b6d969a15be2457ba176f536d06c8', '2017-02-21 10:04:20', '1', '8');
INSERT INTO `account` VALUES ('100', '100', '1', 'wangxx1111', '1111', '222', 'wwwww', '1111-03-07 00:00:00', null, null);
INSERT INTO `account` VALUES ('101', '2', '1', 'jiangpeipei', '957865719@qq.com', 'jiangpeipei', '3d4b4a96732d8b1916fc6c62f6d6a410', '2017-03-20 14:17:26', '8', '7');
INSERT INTO `account` VALUES ('102', '2', '1', '宛莹', 'wanying@bonc.com.cn', 'yingyingwan', 'fd07be081e2ef2dc13fee9e3384f880c', '2017-03-20 14:22:27', '8', null);
INSERT INTO `account` VALUES ('103', '2', '1', '武洋', 'wuyang@bonc.com.cn', '015821', '8d5224b52dc238cf193b1add49b78cbc', '2017-04-01 11:24:56', '8', '7');
INSERT INTO `account` VALUES ('104', '3', '1', '尹元', 'yinyuan@bonc.com.cn', '014945', 'bd735904cca4655c331c59d7309baf7c', '2017-04-01 14:57:57', '11', null);
INSERT INTO `account` VALUES ('105', '2', '1', '周来全', 'zhoulaiquan@bonc.com.cn', '017898', '47ffc5c3f1b9fb3eb3931de3ae165808', '2017-04-06 17:15:56', '1', '7');
INSERT INTO `account` VALUES ('106', '2', '1', '纪文栓', 'jiwenshuan@bonc.com.cn', '012795', '39665cc6833fc6ccbc550135d9956af1', '2017-04-25 15:34:37', '8', null);
INSERT INTO `account` VALUES ('107', '4', '1', 'guojin', 'guojin@bonc.com.cn', '013916', 'e2690208c527bf03373c1ab143b434b6', '2017-06-27 17:46:56', '1', '7');
INSERT INTO `account` VALUES ('108', '3', '1', '高翔', 'gaoxiang@bonc.com.cn', '012251', '556209cfdf7c4be28dcaadc15b9816cf', '2017-06-30 18:22:50', '1', '7');

-- ----------------------------
-- Table structure for `authority`
-- ----------------------------
DROP TABLE IF EXISTS `authority`;
CREATE TABLE `authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `enable` int(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `levelCode` varchar(255) NOT NULL,
  `position` int(11) NOT NULL,
  `theValue` varchar(255) DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `matchUrl` varchar(255) NOT NULL,
  `itemIcon` varchar(255) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_authority_parentId_authority` (`parentId`),
  CONSTRAINT `FK_authority_parentId_authority` FOREIGN KEY (`parentId`) REFERENCES `authority` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of authority
-- ----------------------------
INSERT INTO `authority` VALUES ('1', '3', '0', '实时展示', '1', '1', '1', '/home', '^/home$', 'icon-home', null);
INSERT INTO `authority` VALUES ('2', '2', '0', '首页', '1,2', '2', '1', '/home/index', '/home/index', null, '1');
INSERT INTO `authority` VALUES ('21', '6', '0', '配置管理', '21', '1', '2', '/resource', '^/resource$', 'icon-folder-close-alt', null);
INSERT INTO `authority` VALUES ('22', '5', '0', '集群配置管理', '21,22', '2', '1', '/resource', '^/resource$', '', '21');
INSERT INTO `authority` VALUES ('23', '6', '0', '数据源管理', '21,23', '2', '2', '/resource', '^/resource$', '', '21');
INSERT INTO `authority` VALUES ('25', '5', '0', '实时处理', '25', '1', '3', '/event', '^/event$', 'icon-time', null);
INSERT INTO `authority` VALUES ('26', '6', '0', 'storm事件', '25,26', '2', '1', '/event', '^/event$', '', '25');
INSERT INTO `authority` VALUES ('27', '8', '0', '决策配置', '27', '1', '4', '/decision', '^/decision$', 'icon-time', null);
INSERT INTO `authority` VALUES ('29', '3', '0', '采集配置管理', '21,29', '2', '4', '/resource', '^/resource$', '', '21');
INSERT INTO `authority` VALUES ('38', '5', '0', 'storm集群配置', '21,22,38', '3', '1', '/resource/stormhost/list', '^/resource/stormhost/$', '', '22');
INSERT INTO `authority` VALUES ('39', '3', '0', '数据资源管理', '21,23,39', '3', '1', '/resource/datalink/list', '^/resource/datalink/$', '', '23');
INSERT INTO `authority` VALUES ('40', '3', '0', '数据源管理', '21,23,40', '3', '2', '/resource/datatable/list', '^/resource/datatable/$', '', '23');
INSERT INTO `authority` VALUES ('41', '3', '0', 'storm数据源管理', '21,23,41', '3', '3', '/resource/datastorm/list', '^/resource/datastorm/$', '', '23');
INSERT INTO `authority` VALUES ('42', '2', '0', 'flume配置管理', '21,29,42', '3', '1', '/resource/flume/list', '^/resource/flume/$', '', '29');
INSERT INTO `authority` VALUES ('43', '2', '0', 'kafka配置管理', '21,29,43', '3', '2', '/resource/kafka/list', '^/resource/kafka/$', '', '29');
INSERT INTO `authority` VALUES ('45', '4', '0', 'storm主机列表', '21,22,38,45', '0', '1', '/resource/stormhost/list', '/resource/stormhost/list', '', '38');
INSERT INTO `authority` VALUES ('46', '1', '0', '新增主机', '21,22,38,46', '0', '2', '/resource/stormhost/add', '/resource/stormhost/add', null, '38');
INSERT INTO `authority` VALUES ('47', '1', '0', '编辑主机', '21,22,38,47', '0', '3', '/resource/stormhost/edit', '/resource/stormhost/edit', null, '38');
INSERT INTO `authority` VALUES ('48', '1', '0', '删除主机', '21,22,38,48', '0', '4', '/resource/stormhost/delete', '/resource/stormhost/delete', null, '38');
INSERT INTO `authority` VALUES ('55', '2', '0', '数据资源列表', '21,23,39,55', '0', '1', '/resource/datalink/list', '/resource/datalink/list', '', '39');
INSERT INTO `authority` VALUES ('56', '2', '0', '新增数据资源', '21,23,39,56', '0', '2', '/resource/datalink/add', '/resource/datalink/add', '', '39');
INSERT INTO `authority` VALUES ('57', '2', '0', '编辑数据资源', '21,23,39,57', '0', '3', '/resource/datalink/edit', '/resource/datalink/edit', '', '39');
INSERT INTO `authority` VALUES ('58', '2', '0', '删除数据资源', '21,23,39,58', '0', '4', '/resource/datalink/delete', '/resource/datalink/delete', '', '39');
INSERT INTO `authority` VALUES ('59', '2', '0', '数据源列表', '21,23,40,59', '0', '1', '/resource/datatable/list', '/resource/datatable/list', '', '40');
INSERT INTO `authority` VALUES ('60', '2', '0', '新增数据源', '21,23,40,60', '0', '2', '/resource/datatable/add', '/resource/datatable/add', '', '40');
INSERT INTO `authority` VALUES ('61', '2', '0', '编辑数据源', '21,23,40,61', '0', '3', '/resource/datatable/edit', '/resource/datatable/edit', '', '40');
INSERT INTO `authority` VALUES ('62', '2', '0', '删除数据源', '21,23,40,62', '0', '4', '/resource/datatable/delete', '/resource/datatable/delete', '', '40');
INSERT INTO `authority` VALUES ('63', '2', '0', 'storm数据源列表', '21,23,41,63', '4', '1', '/resource/datastorm/list', '/resource/datastorm/list', '', '41');
INSERT INTO `authority` VALUES ('64', '1', '0', '新增storm数据源', '21,23,41,64', '0', '2', '/resource/datastorm/add', '/resource/datastorm/add', '', '41');
INSERT INTO `authority` VALUES ('65', '1', '0', '编辑storm数据源', '21,23,41,65', '0', '3', '/resource/datastorm/edit', '/resource/datastorm/edit', '', '41');
INSERT INTO `authority` VALUES ('66', '1', '0', '删除storm数据源', '21,23,41,66', '0', '4', '/resource/datastorm/delete', '/resource/datastorm/delete', '', '41');
INSERT INTO `authority` VALUES ('68', '1', '0', 'flume配置列表', '21,29,42,68', '0', '1', '/resource/flume/list', '/resource/flume/list', '', '42');
INSERT INTO `authority` VALUES ('69', '1', '0', 'kafka配置列表', '21,29,43,69', '0', '1', '/resource/kafka/list', '/resource/kafka/list', '', '43');
INSERT INTO `authority` VALUES ('70', '1', '0', '新增kafka配置', '21,29,43,70', '0', '2', '/resource/kafka/add', '/resource/kafka/add', '', '43');
INSERT INTO `authority` VALUES ('71', '1', '0', '编辑kafka配置', '21,29,43,71', '0', '3', '/resource/kafka/edit', '/resource/kafka/edit', '', '43');
INSERT INTO `authority` VALUES ('72', '1', '0', '删除kafka配置', '21,29,43,72', '0', '4', '/resource/kafka/delete', '/resource/kafka/delete', '', '43');
INSERT INTO `authority` VALUES ('73', '1', '0', '新增flume配置', '21,29,42,73', '0', '3', '/resource/flume/add', '/resource/flume/add', '', '42');
INSERT INTO `authority` VALUES ('74', '1', '0', '编辑flume配置', '21,29,42,74', '0', '3', '/resource/flume/edit', '/resource/flume/edit', '', '42');
INSERT INTO `authority` VALUES ('75', '1', '0', '删除flume配置', '21,29,42,75', '0', '4', '/resource/flume/delete', '/resource/flume/delete', '', '42');
INSERT INTO `authority` VALUES ('87', '2', '0', '事件定义', '25,26,87', '3', '1', '/event/list', '^/event$', '', '26');
INSERT INTO `authority` VALUES ('88', '1', '0', '事件列表', '25,26,87,88', '0', '1', '/event/list', '/event/list', '', '87');
INSERT INTO `authority` VALUES ('89', '1', '0', '事件新增', '25,26,87,89', '0', '2', '/event/add', '/event/add', '', '87');
INSERT INTO `authority` VALUES ('90', '1', '0', '事件编辑', '25,26,87,90', '0', '3', '/event/edit', '/event/edit', '', '87');
INSERT INTO `authority` VALUES ('91', '1', '0', '事件删除', '25,26,87,91', '0', '4', '/event/delete', '/event/delete', '', '87');
INSERT INTO `authority` VALUES ('92', '6', '0', '事件调度', '92', '1', '5', '/schedule', '^/schedule$', 'icon-time', null);
INSERT INTO `authority` VALUES ('93', '1', '0', '事件处理', '25,26,93', '3', '2', '/event/process/list', '^/event/process$', '', '26');
INSERT INTO `authority` VALUES ('94', '2', '0', '查看事件', '25,26,93,94', '4', '1', '/event/process/list', '/event/process/list', '', '93');
INSERT INTO `authority` VALUES ('95', '3', '0', '事件响应', '27,95', '3', '1', '/decision/response/list', '^/decision/response/$', '', '27');
INSERT INTO `authority` VALUES ('96', '2', '0', '事件决策', '27,96', '3', '2', '/decision/list', '^/decision/$', '', '27');
INSERT INTO `authority` VALUES ('97', '8', '0', '事件发布', '92,97', '3', '1', '/schedule/publish/list', '^/schedule/publish$', '', '92');
INSERT INTO `authority` VALUES ('98', '4', '0', '事件调度', '92,98', '3', '2', '/schedule/schedulelist', '^/schedule$', '', '92');
INSERT INTO `authority` VALUES ('99', '8', '0', '事件监控', '92,99', '3', '3', '/schedule/monitor/list', '^/schedule/monitor/$', '', '92');
INSERT INTO `authority` VALUES ('100', '4', '0', '响应列表', '27,95,100', '0', '1', '/decision/response/list', '/decision/response/list', '', '95');
INSERT INTO `authority` VALUES ('101', '5', '0', '查看事件', '27,96,101', '0', '1', '/decision/list', '/decision/list', '', '96');
INSERT INTO `authority` VALUES ('103', '3', '0', '单事件操作列表', '25,26,93,103', '4', '2', '/event/process/opt/list', '/event/process/opt/list', '', '93');
INSERT INTO `authority` VALUES ('104', '3', '0', '单事件新增操作', '25,26,93,104', '4', '3', '/event/process/opt/add', '/event/process/opt/add', '', '93');
INSERT INTO `authority` VALUES ('105', '3', '0', '单事件编辑操作', '25,26,93,105', '4', '4', '/event/process/opt/edit', '/event/process/opt/edit', '', '93');
INSERT INTO `authority` VALUES ('106', '3', '0', '单事件删除操作', '25,26,93,106', '4', '5', '/event/process/opt/delete', '/event/process/opt/delete', '', '93');
INSERT INTO `authority` VALUES ('119', '1', '0', '新增响应', '27,95,119', '0', '2', '/decision/response/add', '/decision/response/add', '', '95');
INSERT INTO `authority` VALUES ('120', '1', '0', '编辑响应', '27,95,120', '0', '3', '/decision/response/edit', '/decision/response/edit', '', '95');
INSERT INTO `authority` VALUES ('121', '1', '0', '删除响应', '27,95,121', '0', '4', '/decision/response/delete', '/decision/response/delete', '', '95');
INSERT INTO `authority` VALUES ('122', '2', '0', '决策列表', '27,96,122', '0', '2', '/decision/opt/list', '/decision/opt/list', '', '96');
INSERT INTO `authority` VALUES ('123', '2', '0', '新增决策', '27,96,123', '0', '3', '/decision/opt/add', '/decision/opt/add', '', '96');
INSERT INTO `authority` VALUES ('124', '2', '0', '编辑决策', '27,96,124', '0', '4', '/decision/opt/edit', '/decision/opt/edit', '', '96');
INSERT INTO `authority` VALUES ('125', '2', '0', '删除决策', '27,96,125', '0', '5', '/decision/opt/delete', '/decision/opt/delete', '', '96');
INSERT INTO `authority` VALUES ('126', '1', '0', '查看事件发布', '92,97,126', '0', '1', '/schedule/publish/list', '/schedule/publish/list', '', '97');
INSERT INTO `authority` VALUES ('127', '3', '0', '查看事件调度', '92,98,127', '0', '1', '/schedule/schedulelist', '/schedule/schedulelist', '', '98');
INSERT INTO `authority` VALUES ('128', '3', '0', '查看事件监控', '92,99,128', '0', '1', '/schedule/monitor/list', '/schedule/monitor/list', '', '99');
INSERT INTO `authority` VALUES ('150', '1', '0', '多事件操作列表', '25,26,93,150', '4', '6', '/event/process/optmulti/list', '/event/process/optmulti/list', '', '93');
INSERT INTO `authority` VALUES ('151', '1', '0', '多事件新增操作', '25,26,93,151', '4', '7', '/event/process/optmulti/add', '/event/process/optmulti/add', '', '93');
INSERT INTO `authority` VALUES ('152', '1', '0', '多事件编辑操作', '25,26,93,152', '4', '8', '/event/process/optmulti/edit', '/event/process/optmulti/edit', '', '93');
INSERT INTO `authority` VALUES ('153', '1', '0', '多事件删除操作', '25,26,93,153', '4', '9', '/event/process/optmulti/delete', '/event/process/optmulti/delete', '', '93');
INSERT INTO `authority` VALUES ('154', '1', '0', '系统设置', '154', '1', '9', '/setting', '^/setting$', 'icon-cogs', null);
INSERT INTO `authority` VALUES ('155', '1', '0', '用户管理', '154,155', '2', '1', '/account/list', '^/account$', '', '154');
INSERT INTO `authority` VALUES ('156', '1', '0', '角色管理', '154,156', '2', '2', '/role/list', '^/role$', '', '154');
INSERT INTO `authority` VALUES ('157', '1', '0', '权限管理', '154,157', '2', '3', '/authority/chain', '^/authority$', '', '154');
INSERT INTO `authority` VALUES ('158', '1', '0', '组织机构管理', '154,158', '2', '4', '/organization/chain', '^/organization$', '', '154');
INSERT INTO `authority` VALUES ('159', '1', '0', '用户列表', '154,155,159', '0', '1', '/account/list', '/account/list', '', '155');
INSERT INTO `authority` VALUES ('160', '1', '0', '账户绑定', '154,155,160', '0', '2', '/account/authorize', '/account/authorize', '', '155');
INSERT INTO `authority` VALUES ('161', '1', '0', '用户启用', '154,155,161', '0', '3', '/account/enable', '/account/enable', '', '155');
INSERT INTO `authority` VALUES ('162', '1', '0', '用户禁用', '154,155,162', '0', '4', '/account/disable', '/account/disable', '', '155');
INSERT INTO `authority` VALUES ('163', '1', '0', '用户删除', '154,155,163', '0', '5', '/account/delete', '/account/delete', '', '155');
INSERT INTO `authority` VALUES ('164', '1', '0', '角色列表', '154,156,164', '0', '1', '/role/list', '/role/list', '', '156');
INSERT INTO `authority` VALUES ('165', '1', '0', '权限绑定', '154,156,165', '0', '2', '/role/bind', '/role/bind', '', '156');
INSERT INTO `authority` VALUES ('166', '1', '0', '角色新建', '154,156,166', '0', '3', '/role/add', '/role/add', '', '156');
INSERT INTO `authority` VALUES ('167', '1', '0', '角色编辑', '154,156,167', '0', '4', '/role/edit', '/role/edit', '', '156');
INSERT INTO `authority` VALUES ('168', '1', '0', '角色启用', '154,156,168', '0', '5', '/role/enable', '/role/enable', '', '156');
INSERT INTO `authority` VALUES ('169', '1', '0', '角色停用', '154,156,169', '0', '6', '/role/disable', '/role/disable', '', '156');
INSERT INTO `authority` VALUES ('170', '1', '0', '角色删除', '154,156,170', '0', '7', '/role/delete', '/role/delete', '', '156');
INSERT INTO `authority` VALUES ('171', '1', '0', '权限添加', '154,157,171', '0', '1', '/authority/add', '/authority/add', '', '157');
INSERT INTO `authority` VALUES ('172', '1', '0', '权限编辑', '154,157,172', '0', '2', '/authority/edit', '/authority/edit', '', '157');
INSERT INTO `authority` VALUES ('173', '1', '0', '权限删除', '154,157,173', '0', '3', '/authority/delete', '/authority/delete', '', '157');
INSERT INTO `authority` VALUES ('174', '1', '0', '权限树', '154,157,174', '0', '4', '/authority/chain', '/authority/chain', '', '157');
INSERT INTO `authority` VALUES ('175', '1', '0', '组织机构树', '154,158,175', '0', '1', '/organization/chain', '/organization/chain', '', '158');
INSERT INTO `authority` VALUES ('176', '1', '0', '组织机构添加', '154,158,176', '0', '2', '/organization/add', '/organization/add', '', '158');
INSERT INTO `authority` VALUES ('177', '1', '0', '组织机构编辑', '154,158,177', '0', '3', '/organization/edit', '/organization/edit', '', '158');
INSERT INTO `authority` VALUES ('178', '1', '0', '组织机构删除', '154,158,178', '0', '4', '/organization/delete', '/organization/delete', '', '158');
INSERT INTO `authority` VALUES ('179', '3', '0', 'spark集群配置', '21,22,179', '3', '2', '/resource/sparkhost/list', '^/resource/sparkhost/$', '', '22');
INSERT INTO `authority` VALUES ('180', '1', '0', 'kafka集群配置', '21,22,180', '3', '3', '/resource/kafkahost/list', '^/resource/kafkahost/$', '', '22');
INSERT INTO `authority` VALUES ('181', '1', '0', 'flume集群配置', '21,22,181', '3', '4', '/resource/flumehost/list', '^/resource/flumehost/$', '', '22');
INSERT INTO `authority` VALUES ('183', '2', '0', 'spark主机列表', '21,22,179,183', '0', '1', '/resource/sparkhost/list', '/resource/sparkhost/list', '', '179');
INSERT INTO `authority` VALUES ('185', '1', '0', 'flume主机列表', '21,22,181,185', '4', '1', '/resource/flumehost/list', '/resource/flumehost/list', '', '181');
INSERT INTO `authority` VALUES ('186', '2', '0', 'spark数据源管理', '21,23,186', '3', '4', '/resource/dataspark/list', '^/resource/dataspark/$', '', '23');
INSERT INTO `authority` VALUES ('187', '1', '0', 'spark数据源列表', '21,23,186,187', '4', '1', '/resource/dataspark/list', '/resource/dataspark/list', '', '186');
INSERT INTO `authority` VALUES ('188', '2', '0', 'spark事件', '25,188', '2', '2', '/sparkevent', '^/sparkevent$', '', '25');
INSERT INTO `authority` VALUES ('189', '2', '0', '事件定义', '25,188,189', '3', '1', '/sparkevent/list', '^/sparkevent$', '', '188');
INSERT INTO `authority` VALUES ('190', '3', '0', '事件处理', '25,188,190', '3', '2', '/sparkevent/process/list', '^/sparkevent/process$', '', '188');
INSERT INTO `authority` VALUES ('191', '1', '0', '新增主机', '21,22,179,191', '0', '2', '/resource/sparkhost/add', '/resource/sparkhost/add', '', '179');
INSERT INTO `authority` VALUES ('192', '1', '0', '编辑主机', '21,22,179,192', '0', '3', '/resource/sparkhost/edit', '/resource/sparkhost/edit', '', '179');
INSERT INTO `authority` VALUES ('193', '1', '0', '删除主机', '21,22,179,193', '0', '4', '/resource/sparkhost/delete', '/resource/sparkhost/delete', '', '179');
INSERT INTO `authority` VALUES ('194', '2', '0', 'kafka主机列表', '21,22,180,194', '4', '1', '/resource/kafkahost/list', '/resource/kafkahost/list', '', '180');
INSERT INTO `authority` VALUES ('195', '1', '0', '新增spark数据源', '21,23,186,195', '4', '2', '/resource/dataspark/add', '/resource/dataspark/add', '', '186');
INSERT INTO `authority` VALUES ('196', '1', '0', '编辑spark数据源', '21,23,186,196', '4', '3', '/resource/dataspark/edit', '/resource/dataspark/edit', '', '186');
INSERT INTO `authority` VALUES ('197', '1', '0', '删除spark数据源', '21,23,186,197', '4', '4', '/resource/dataspark/delete', '/resource/dataspark/delete', '', '186');
INSERT INTO `authority` VALUES ('198', '1', '0', '新增主机', '21,22,180,198', '4', '2', '/resource/kafkahost/add', '/resource/kafkahost/add', '', '180');
INSERT INTO `authority` VALUES ('199', '1', '0', '编辑主机', '21,22,180,199', '4', '3', '/resource/kafkahost/edit', '/resource/kafkahost/edit', '', '180');
INSERT INTO `authority` VALUES ('200', '1', '0', '删除主机', '21,22,180,200', '4', '4', '/resource/kafkahost/delete', '/resource/kafkahost/delete', '', '180');
INSERT INTO `authority` VALUES ('201', '2', '0', '函数定义', '25,26,201', '3', '3', '/stormFunction/list', '^/stormFunction/$', '', '26');
INSERT INTO `authority` VALUES ('202', '2', '0', '函数列表', '25,26,201,202', '4', '1', '/stormFunction/list', '/stormFunction/list', '', '201');
INSERT INTO `authority` VALUES ('203', '2', '0', '函数新增', '25,26,201,203', '4', '2', '/stormFunction/add', '/stormFunction/add', '', '201');
INSERT INTO `authority` VALUES ('204', '2', '0', '函数编辑', '25,26,201,204', '4', '3', '/stormFunction/edit', '/stormFunction/edit', '', '201');
INSERT INTO `authority` VALUES ('205', '2', '0', '函数删除', '25,26,201,205', '4', '4', '/stormFunction/delete', '/stormFunction/delete', '', '201');
INSERT INTO `authority` VALUES ('206', '1', '0', '函数下载', '25,26,201,206', '4', '5', '/stormFunction/downFile', '/stormFunction/downFile', '', '201');
INSERT INTO `authority` VALUES ('207', '1', '0', '函数名验证', '25,26,201,207', '4', '6', '/stormFunction/validateName', '/stormFunction/validateName', '', '201');
INSERT INTO `authority` VALUES ('208', '1', '0', '函数定义', '25,188,208', '3', '3', '/sparkfunction/list', '^/sparkfunction$', '', '188');
INSERT INTO `authority` VALUES ('209', '1', '0', '函数列表', '25,188,208,209', '4', '1', '/sparkfunction/list', '/sparkfunction/list', '', '208');
INSERT INTO `authority` VALUES ('210', '1', '0', '增加函数', '25,188,208,210', '4', '2', '/sparkfunction/add', '/sparkfunction/add', '', '208');
INSERT INTO `authority` VALUES ('211', '1', '0', '编辑函数', '25,188,208,211', '4', '3', '/sparkfunction/edit', '/sparkfunction/edit', '', '208');
INSERT INTO `authority` VALUES ('212', '1', '0', '删除函数', '25,188,208,212', '4', '4', '/sparkfunction/delete', '/sparkfunction/delete', '', '208');
INSERT INTO `authority` VALUES ('213', '1', '0', '名称检测', '25,188,208,213', '4', '5', '/sparkfunction/ajax', '/sparkfunction/ajax', '', '208');
INSERT INTO `authority` VALUES ('214', '1', '0', '列表', '25,188,189,214', '0', '1', '/sparkevent/list', '/sparkevent/list', '', '189');
INSERT INTO `authority` VALUES ('215', '1', '0', '新增', '25,188,189,215', '0', '2', '/sparkevent/add', '/sparkevent/add', '', '189');
INSERT INTO `authority` VALUES ('216', '1', '0', '编辑', '25,188,189,216', '0', '3', '/sparkevent/edit', '/sparkevent/edit', '', '189');
INSERT INTO `authority` VALUES ('217', '1', '0', '删除', '25,188,189,217', '0', '4', '/sparkevent/delete', '/sparkevent/delete', '', '189');
INSERT INTO `authority` VALUES ('218', '1', '0', '查看事件', '25,188,190,218', '4', '1', '/sparkevent/process/list', '/sparkevent/process/list', '', '190');
INSERT INTO `authority` VALUES ('219', '1', '0', '单事件查看', '25,188,190,219', '4', '2', '/sparkevent/process/opt/list', '/sparkevent/process/opt/list', '', '190');
INSERT INTO `authority` VALUES ('220', '1', '0', '事件增加', '25,188,190,220', '4', '3', '/sparkevent/process/opt/add', '/sparkevent/process/opt/add', '', '190');
INSERT INTO `authority` VALUES ('221', '1', '0', '编辑事件', '25,188,190,221', '4', '4', '/sparkevent/process/opt/edit', '/sparkevent/process/opt/edit', '', '190');
INSERT INTO `authority` VALUES ('222', '1', '0', '删除事件', '25,188,190,222', '4', '5', '/sparkevent/process/opt/delete', '/sparkevent/process/opt/delete', '', '190');
INSERT INTO `authority` VALUES ('223', '1', '0', '新增主机', '21,22,181,223', '4', '2', '/resource/flumehost/add', '/resource/flumehost/add', '', '181');
INSERT INTO `authority` VALUES ('224', '1', '0', '编辑主机', '21,22,181,224', '4', '3', '/resource/flumehost/edit', '/resource/flumehost/edit', '', '181');
INSERT INTO `authority` VALUES ('225', '1', '0', '删除主机', '21,22,181,225', '4', '4', '/resource/flumehost/delete', '/resource/flumehost/delete', '', '181');
INSERT INTO `authority` VALUES ('226', '1', '0', 'zookeeper集群配置', '21,22,226', '3', '1', '/resource/zookeeperHost/list', '^/resource/zookeeperHost/$', '', '22');
INSERT INTO `authority` VALUES ('227', '1', '0', 'zookeeper主机列表', '21,22,226,227', '4', '1', '/resource/zookeeperHost/list', '/resource/zookeeperHost/list', '', '226');
INSERT INTO `authority` VALUES ('228', '1', '0', '新增主机', '21,22,226,228', '4', '2', '/resource/zookeeperHost/add', '/resource/zookeeperHost/add', '', '226');
INSERT INTO `authority` VALUES ('229', '2', '0', '编辑主机', '21,22,226,229', '4', '3', '/resource/zookeeperHost/edit', '/resource/zookeeperHost/edit', '', '226');
INSERT INTO `authority` VALUES ('230', '1', '0', '删除主机', '21,22,226,230', '4', '4', '/resource/zookeeperHost/delete', '/resource/zookeeperHost/delete', '', '226');
INSERT INTO `authority` VALUES ('232', '1', '0', '事件处理', '25,26,232', '3', '4', '/event/process/list1', '^/event/process$', '', '26');
INSERT INTO `authority` VALUES ('233', '1', '0', '查看事件', '25,26,232,233', '4', '1', '/event/process/list1', '/event/process/list1', '', '232');
INSERT INTO `authority` VALUES ('234', '1', '0', '新增事件', '25,26,232,234', '4', '2', '/event/process/addsplit', '/event/process/addsplit', '', '232');
INSERT INTO `authority` VALUES ('235', '1', '0', '删除事件', '25,26,232,235', '4', '3', '/event/process/deletesplit', '/event/process/deletesplit', '', '232');

-- ----------------------------
-- Table structure for `cluster`
-- ----------------------------
DROP TABLE IF EXISTS `cluster`;
CREATE TABLE `cluster` (
  `cluster_id` int(11) NOT NULL,
  `cluster_name` varchar(50) DEFAULT NULL,
  `cluster_description` varchar(200) DEFAULT NULL,
  `organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`cluster_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cluster
-- ----------------------------
INSERT INTO `cluster` VALUES ('1', '测试集群', '测试集群', '8');
INSERT INTO `cluster` VALUES ('2', 'x_test', 'x_test', '9');
INSERT INTO `cluster` VALUES ('3', '测试test', '测试test', '8');

-- ----------------------------
-- Table structure for `event_poc`
-- ----------------------------
DROP TABLE IF EXISTS `event_poc`;
CREATE TABLE `event_poc` (
  `event_id` varchar(20) NOT NULL,
  `event_name` varchar(20) DEFAULT NULL,
  `event_type` varchar(2) DEFAULT NULL COMMENT '01-简单事件; 02-trident事件;03-外部事件',
  `event_desc` varchar(50) DEFAULT NULL,
  `event_note` varchar(50) DEFAULT NULL,
  `event_user_id` int(11) DEFAULT NULL,
  `event_user_name` varchar(20) DEFAULT NULL,
  `event_publish_status` varchar(1) DEFAULT NULL,
  `event_run_status` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of event_poc
-- ----------------------------

-- ----------------------------
-- Table structure for `organization`
-- ----------------------------
DROP TABLE IF EXISTS `organization`;
CREATE TABLE `organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `enable` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `levelCode` varchar(255) NOT NULL,
  `position` int(11) NOT NULL,
  `theValue` varchar(255) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_organization_parentId_organization` (`parentId`),
  CONSTRAINT `FK_organization_parentId_organization` FOREIGN KEY (`parentId`) REFERENCES `organization` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of organization
-- ----------------------------
INSERT INTO `organization` VALUES ('7', '3', '1', '应用创新部', '7', '0', 'aa', null);
INSERT INTO `organization` VALUES ('8', '1', '1', '实时流引擎项目组', '7,8', '0', '', '7');
INSERT INTO `organization` VALUES ('9', '2', '1', 'x_test', '7,9', '0', 'x_test', '7');

-- ----------------------------
-- Table structure for `poc_link_def`
-- ----------------------------
DROP TABLE IF EXISTS `poc_link_def`;
CREATE TABLE `poc_link_def` (
  `source_table_name` varchar(64) DEFAULT NULL COMMENT '来源表名称',
  `target_tables` text COMMENT '目标表名称(json格式)',
  `mapping_id` varchar(128) DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='源表到目标表的定义';

-- ----------------------------
-- Records of poc_link_def
-- ----------------------------
INSERT INTO `poc_link_def` VALUES ('XZX_AUDIT_TEST_REF', '[\"DMC_TASK_JOB_PROC_LOG\",\"DMC_CHECK_WAVE_CACHE\"]', '175d651c-7e46-4080-93c7-b2b03830305c', '1');
INSERT INTO `poc_link_def` VALUES ('XZX_AUDIT_TEST', '[\"DMC_CHECK_WAVE_CACHE\",\"DMC_TASK_JOB_PROC_LOG\"]', '175d651c-7e46-4080-93c7-b2b03830305c', '2');

-- ----------------------------
-- Table structure for `poc_map_def`
-- ----------------------------
DROP TABLE IF EXISTS `poc_map_def`;
CREATE TABLE `poc_map_def` (
  `target_table_name` varchar(64) DEFAULT NULL COMMENT '目标表名称',
  `source_table_name` varchar(64) DEFAULT NULL COMMENT '源表名称',
  `map_def` text COMMENT '映射关系(json格式)',
  `mapping_id` varchar(128) DEFAULT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poc_map_def
-- ----------------------------
INSERT INTO `poc_map_def` VALUES ('DMC_TASK_JOB_PROC_LOG', 'XZX_AUDIT_TEST_REF', '{\"CHECK_TYPE_SQL_4\":\"IMEI\",\"CHECK_TYPE_SQL_3\":\"CALL_TYPE\",\"CHECK_TYPE_SQL_2\":\"TICKET_TYPE\",\"CHECK_TYPE_SQL_1\":\"SUBS_INSTANCE_ID\",\"DELETE_FLAG\":\"DEVICE_NUMBER\"}', '175d651c-7e46-4080-93c7-b2b03830305c', '1');
INSERT INTO `poc_map_def` VALUES ('DMC_TASK_JOB_PROC_LOG', 'XZX_AUDIT_TEST', '{\"BEGIN_TIME\":\"IMEI\",\"PROC_NAME\":\"SUBS_INSTANCE_ID\",\"RESULT_DESC\":\"CALL_TYPE\",\"END_TIME\":\"CALL_AREA_TYPE\",\"EXEC_STATUS\":\"DEVICE_NUMBER\",\"RESULT_STATUS\":\"TICKET_TYPE\",\"ERROR_SQL\":\"ROAM_TYPE\"}', '175d651c-7e46-4080-93c7-b2b03830305c', '2');
INSERT INTO `poc_map_def` VALUES ('DMC_CHECK_WAVE_CACHE', 'XZX_AUDIT_TEST', '{\"CHECK_VALUE\":\"CDR_NUM\",\"TIME_CONDITION\":\"OPPOSE_SERVICE_TYPE\",\"INSERT_TIME\":\"BILL_TIMES\",\"CHECK_SQL\":\"CALL_DURATION\",\"END_TIME\":\"OPPOSE_DEALER\",\"START_TIME\":\"LAND_TYPE\",\"OTHER_CONDITION\":\"FREE_TYPE\"}', '175d651c-7e46-4080-93c7-b2b03830305c', '3');
INSERT INTO `poc_map_def` VALUES ('DMC_CHECK_WAVE_CACHE', 'XZX_AUDIT_TEST_REF', '{\"CYCLE_TYPE\":\"IMEI\",\"BRANCH_TYPE\":\"CALL_TYPE\",\"CHECK_FUNC\":\"CALL_AREA_TYPE\",\"USERNAME\":\"DEVICE_NUMBER\",\"CHECK_EXP\":\"ROAM_TYPE\",\"TABLENAME\":\"TICKET_TYPE\",\"RESOURCE_ID\":\"SUBS_INSTANCE_ID\"}', '175d651c-7e46-4080-93c7-b2b03830305c', '4');

-- ----------------------------
-- Table structure for `poc_mapping_def`
-- ----------------------------
DROP TABLE IF EXISTS `poc_mapping_def`;
CREATE TABLE `poc_mapping_def` (
  `cb_table` varchar(64) DEFAULT NULL,
  `cb_field` varchar(64) DEFAULT NULL,
  `sh_table` varchar(64) DEFAULT NULL,
  `sh_field` varchar(64) DEFAULT NULL,
  `xj_table` varchar(64) DEFAULT NULL,
  `xj_field` varchar(64) DEFAULT NULL,
  `target_table` varchar(128) DEFAULT NULL,
  `target_field` varchar(128) DEFAULT NULL,
  `target_desc` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poc_mapping_def
-- ----------------------------
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'CUST_ID', 'UCS_CUSTOMER', 'CUSTOMER_ID', 'dcustdoc', 'CUST_ID', 'PERSON_BASIC_INFO', 'PARTY_ID', '自然人标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'CUST_NAME', 'UCS_CUSTOMER', 'CUSTOMER_NAME', 'dcustdoc', 'CUST_NAME', 'PERSON_BASIC_INFO', 'CUST_NAME', '全名');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'CUST_NAME_SPELL', '姓名全拼');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'FIRST_NAME', '姓');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'MIDDLE_NAME', '中间名');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'LAST_NAME', '名字');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'CUST_TYPE', 'UCS_CUSTOMER', 'CUSTOMER_TYPE', 'dcustdoc', 'OWNER_TYPE', 'PERSON_BASIC_INFO', 'CUST_TYPE', '自然人类型');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'RSRV_TAG2', 'UCS_CUSTOMER', 'CUSTOMER_INQ_LEVEL', '', '', 'PERSON_BASIC_INFO', 'CUST_LEVLE', '自然人等级');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'SEX', 'UCS_CUSTOMER', 'CUSTOMER_SEX', 'dcustdocinadd', 'CUST_SEX', 'PERSON_BASIC_INFO', 'SEX', '性别');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'BIRTHDAY', 'UCS_CUSTOMER', 'CUSTOMER_BIRTH', 'dcustdocinadd', 'BIRTHDAY', 'PERSON_BASIC_INFO', 'BIRTHDAY', '阳历生日');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'BIRTHDAY_LUNAR', '农历生日');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'NATIONALITY_CODE', '', '', '', '', 'PERSON_BASIC_INFO', 'NATIONALITY_CODE', '国籍');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'LOCAL_NATIVE_CODE', '', '', '', '', 'PERSON_BASIC_INFO', 'LOCAL_NATIVE_CODE', '籍贯');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'FOLK_CODE', '', '', 'dcustdocinadd', 'NATION_ID', 'PERSON_BASIC_INFO', 'FOLK_CODE', '民族');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'RELIGION_CODE', '', '', '', '', 'PERSON_BASIC_INFO', 'RELIGION_CODE', '信仰');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'POLITICAL_STATUS', '政治面貌');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'REVENUE_LEVEL_CODE', '', '', '', '', 'PERSON_BASIC_INFO', 'REVENUE_LEVEL_CODE', '收入等级');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'EDUCATE_DEGREE_CODE', '', '', 'dcustdocinadd', 'EDU_LEVEL', 'PERSON_BASIC_INFO', 'EDUCATE_DEGREE_CODE', '教育程度');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'EDUCATE_GRADE_CODE', '学历');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'GRADUATE_SCHOOL', '', '', '', '', 'PERSON_BASIC_INFO', 'GRADUATE_SCHOOL', '毕业院校');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'SPECIALITY', '', '', '', '', 'PERSON_BASIC_INFO', 'SPECIALITY', '专业');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'HEALTH_STATE_CODE', '', '', '', '', 'PERSON_BASIC_INFO', 'MARRIAGE', '婚姻状态');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'HEALTH_STATE_CODE', '', '', '', '', 'PERSON_BASIC_INFO', 'HEALTH_STATE_CODE', '健康状况');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'WRITE_LANGUAGE', '书面语种');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'LANGUAGE_CODE', '', '', '', '', 'PERSON_BASIC_INFO', 'VOICE_LANGUAGE', '语音语种');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'CUST_PASSWD', 'UCS_CUSTOMER', 'CUSTOMER_PASSWORD', '', '', 'PERSON_BASIC_INFO', 'CUST_PASSWORD', '自然人密码');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'FIRST_CONTACT_MODE', '', '', '', '', 'PERSON_BASIC_INFO', 'FIRST_CONTACT_TYPE', '首选联系方式');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'CONTACT_PHONE', 'UCS_CUSTOMER', 'CONTACT_PHONE', 'dcustdoc', 'CONTACT_PHONE', 'PERSON_BASIC_INFO', 'PHONE', '电话');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'EMAIL', 'UCS_CUSTOMER', 'CONTACT_EMAIL', 'dcustdoc', 'CONTACT_EMAILL', 'PERSON_BASIC_INFO', 'EMAIL', '电子邮箱');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'FAX_NBR', '', '', 'dcustdoc', 'CONTACT_FAX', 'PERSON_BASIC_INFO', 'FAX', '传真号码');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'REMARK', '', '', 'dcustdoc', 'CREATE_NOTE', 'PERSON_BASIC_INFO', 'REMARK', '备注');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'DEVELOP_DEPART_ID', '', '', '', '', 'PERSON_BASIC_INFO', 'DEVELOP_CHANNEL_ID', '发展渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'DEVELOP_STAFF_ID', '', '', '', '', 'PERSON_BASIC_INFO', 'DEVELOP_STAFF_ID', '发展员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_DATE', 'UCS_CUSTOMER', 'CREATE_DATE', '', '', 'PERSON_BASIC_INFO', 'DEVELOP_DATE', '发展日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_DEPART_ID', 'ucs_customer', 'OFFICE_ID', 'dcustdoc', 'GROUP_ID', 'PERSON_BASIC_INFO', 'CREATE_CHANNEL_ID', '创建渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_STAFF_ID', 'ucs_customer', 'OPERATOR_ID', '', '', 'PERSON_BASIC_INFO', 'CREATE_STAFF_ID', '创建员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_DATE', 'UCS_CUSTOMER', 'CREATE_DATE', 'dcustdoc', 'CREATE_TIME', 'PERSON_BASIC_INFO', 'CREATE_DATE', '创建日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'UPDATE_DEPART_ID', '', '', '', '', 'PERSON_BASIC_INFO', 'MODITY_CHANNEL_ID', '修改渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'UPDATE_STAFF_ID', 'UCS_CUSTOMER', 'OPERATOR_ID', '', '', 'PERSON_BASIC_INFO', 'MODITY_STAFF_ID', '修改员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'UPDATE_TIME', 'UCS_CUSTOMER', 'MODIFY_DATE', '', '', 'PERSON_BASIC_INFO', 'MODITY_DATE', '修改日期');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'DEACTIVE_CHANNEL_ID', '注销渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'REMOVE_STAFF_ID', '', '', '', '', 'PERSON_BASIC_INFO', 'DEACTIVE_STAFF_ID', '注销员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'REMOVE_DATE', '', '', '', '', 'PERSON_BASIC_INFO', 'DEACTIVE_DATE', '注销日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'REMOVE_CHANGE', '', '', '', '', 'PERSON_BASIC_INFO', 'DEACTIVE_REASON', '注销原因');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_BASIC_INFO', 'COLLECT_FLAG', '清洗标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'CUST_STATE', 'UCS_CUSTOMER', 'CUSTOMER_STATUS', 'dcustdoc', 'CUST_STATUS', 'PERSON_BASIC_INFO', 'CUST_STATE', '状态');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'RSRV_TAG1', 'UCS_CUSTOMER', 'cert_valid_flag', 'dcustdoc', 'CUST_CERT_FLAG', 'PERSON_BASIC_INFO', 'AUTH_TYPE', '认证类型');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'PSPT_TYPE_CODE', 'UCS_CUSTOMER', 'CERT_TYPE', 'dcustdoc', 'id_type', 'PERSON_BASIC_INFO', 'ID_TYPE', '证件类型');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'PSPT_ID', 'UCS_CUSTOMER', 'CERT_NUM', 'dcustdoc', 'id_iccid', 'PERSON_BASIC_INFO', 'ID_NUMBER', '证件号码');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'PSPT_END_DATE', 'UCS_CUSTOMER', 'CERT_EXPIRE_DATE', 'dcustdoc', 'ID_VALIDDATE', 'PERSON_BASIC_INFO', 'ID_VALIDITY', '证件有效期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'PSPT_ADDR', 'UCS_CUSTOMER', 'CERT_ADDR', 'dcustdoc', 'id_address', 'PERSON_BASIC_INFO', 'ID_ADDR', '证件地址');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'PROVINCE_CODE', '', '', '', '', 'PERSON_BASIC_INFO', 'PROVINCE_CODE', '省份');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'EPARCHY_CODE', 'UCS_CUSTOMER', 'region_id', 'dcustdoc', 'REGION_CODE', 'PERSON_BASIC_INFO', 'EPARCHY_CODE', '地市');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'CITY_CODE', 'UCS_CUSTOMER', 'COUNTY_ID', 'dcustdoc', 'DISTRICT_CODE', 'PERSON_BASIC_INFO', 'CITY_CODE', '区县');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'CUST_ID', 'UCS_CUSTOMER', 'CUSTOMER_ID', 'dcustdoc', 'CUST_ID', 'PERSON_ADDRESS_INFO', 'PARTY_ID', '自然人标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'CUST_ID', 'UCS_CUSTOMER', 'CUSTOMER_ID', 'dcustdoc', 'CUST_ID', 'PERSON_CONTACT_INFO', 'PARTY_ID', '自然人标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'CONTACT', 'UCS_CUSTOMER', 'CONTACT_MAN', 'dcustdoc', 'CONTACT_PERSON', 'PERSON_CONTACT_INFO', 'CONTACT_NAME', '联系人姓名');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'CONTACT_TYPE', '联系人类型');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'RELA_ENTITY_TYPE', '关联实体类型');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'RELA_ENTITY_ID', '关联实体标识');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'CONTACT_RELATION', '联系人与自然人关系');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'CONTACT_PRIORY', '联系人优先级');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'CONTACT_PHONE', 'UCS_CUSTOMER', 'CONTACT_PHONE', 'dcustdoc', 'CONTACT_PHONE', 'PERSON_CONTACT_INFO', 'CONTACT_PHONE', '联系人电话');
INSERT INTO `poc_mapping_def` VALUES ('', '', 'UCS_CUSTOMER', 'CONTACT_EMAIL', 'dcustdoc', 'CONTACT_EMAILL', 'PERSON_CONTACT_INFO', 'CONTACT_EMAIL', '联系人邮箱');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', 'dcustdoc', 'CONTACT_FAX', 'PERSON_CONTACT_INFO', 'CONTACT_FAX', '联系人传真');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'CONTACT_ID_TYPE', '联系人证件类型');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'CONTACT_ID_NUMBER', '联系人证件号码');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'CONTACT_ADDRESS', '联系人地址');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'CONTACT_COMPANY', '联系人单位信息');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_CONTACT_INFO', 'CONTACT_WORK', '联系人工作信息');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_DEPART_ID', '', '', 'dcustdoc', 'GROUP_ID', 'PERSON_CONTACT_INFO', 'CREATE_CHANNEL_ID', '创建渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_STAFF_ID', '', '', '', '', 'PERSON_CONTACT_INFO', 'CREATE_STAFF_ID', '创建员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_DATE', 'UCS_CUSTOMER', 'CREATE_DATE', 'dcustdoc', 'CREATE_TIME', 'PERSON_CONTACT_INFO', 'CREATE_DATE', '创建日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'UPDATE_DEPART_ID', '', '', '', '', 'PERSON_CONTACT_INFO', 'MODITY_CHANNEL_ID', '修改渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'UPDATE_STAFF_ID', 'UCS_CUSTOMER', 'OPERATOR_ID', '', '', 'PERSON_CONTACT_INFO', 'MODITY_STAFF_ID', '修改员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'UPDATE_TIME', 'UCS_CUSTOMER', 'MODIFY_DATE', '', '', 'PERSON_CONTACT_INFO', 'MODITY_DATE', '修改日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'HOME_ADDRESS', '', '', 'dcustdoc', 'CONTACT_ADDRESS', 'PERSON_CONTACT_INFO', 'CONTACT_HOME_ADDRESS', '家庭地址');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'HOME_PHONE', '', '', 'dcustdoc', 'CONTACT_PHONE', 'PERSON_CONTACT_INFO', 'CONTACT_HOME_PHONE', '家庭电话');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'POST_ADDRESS', 'UCS_CUSTOMER', 'CONTACT_ADDR', 'dcustdoc', 'CONTACT_MAILADDRESS', 'PERSON_CONTACT_INFO', 'CONTACT_POST_ADDRESS', '通信地址');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'POST_CODE', 'UCS_CUSTOMER', 'CONTACT_ZIP', 'dcustdoc', 'CONTACT_POST', 'PERSON_CONTACT_INFO', 'CONTACT_POST_CODE', '邮编');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'POST_PERSON', '', '', 'dcustdoc', 'CONTACT_PERSON', 'PERSON_CONTACT_INFO', 'CONTACT_POST_PERSON', '收件人');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ADDRESS_INFO', 'ADDRESS_TYPE', '地址类型');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ADDRESS_INFO', 'STANDER_ADDRESS_FLAG', '标准地址标志');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'POST_ADDRESS', 'UCS_CUSTOMER', 'CONTACT_ADDR', 'dcustdoc', 'CONTACT_MAILADDRESS', 'PERSON_ADDRESS_INFO', 'POST_ADDRESS', '通讯地址');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUST_PERSON', 'POST_CODE', 'UCS_CUSTOMER', 'CONTACT_ZIP', 'dcustdoc', 'CONTACT_POST', 'PERSON_ADDRESS_INFO', 'POST_CODE', '邮政编码');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_DEPART_ID', '', '', 'dcustdoc', 'GROUP_ID', 'PERSON_ADDRESS_INFO', 'CREATE_CHANNEL_ID', '创建渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_STAFF_ID', '', '', '', '', 'PERSON_ADDRESS_INFO', 'CREATE_STAFF_ID', '创建员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'IN_DATE', 'UCS_CUSTOMER', 'CREATE_DATE', 'dcustdoc', 'CREATE_TIME', 'PERSON_ADDRESS_INFO', 'CREATE_DATE', '创建日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'UPDATE_DEPART_ID', '', '', '', '', 'PERSON_ADDRESS_INFO', 'MODITY_CHANNEL_ID', '修改渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'UPDATE_STAFF_ID', 'UCS_CUSTOMER', 'OPERATOR_ID', '', '', 'PERSON_ADDRESS_INFO', 'MODITY_STAFF_ID', '修改员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'UPDATE_TIME', 'UCS_CUSTOMER', 'MODIFY_DATE', '', '', 'PERSON_ADDRESS_INFO', 'MODITY_DATE', '修改日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'CUST_ID', '', '', '', '', 'BLACK_LIST', 'PARTY_ID', '自然人标识');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'BLACK_LIST', 'LIST_TYPE', '黑名单类型');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'SERIAL_NUMBER', '', '', '', '', 'BLACK_LIST', 'SERIAL_NUMBER', '黑名单号码');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'BLACK_LIST', 'LIST_CONTROL', '业务控制范围');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'PROVINCE_CODE', '', '', '', '', 'BLACK_LIST', 'PROVINCE_CODE', '来源省分');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'BLACK_LIST', 'SOURCE_SYSTEM', '来源系统');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'BLACK_LIST', 'CREATE_CHANNEL_ID', '创建渠道');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'BLACK_LIST', 'CREATE_STAFF_ID', '创建员工');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'BLACK_LIST', 'CREATE_DATE', '创建日期');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'BLACK_LIST', 'MODITY_CHANNEL_ID', '修改渠道');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'BLACK_LIST', 'MODITY_STAFF_ID', '修改员工');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', 'wlocalblacklist', 'op_time', 'BLACK_LIST', 'MODITY_DATE', '修改日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'CUST_ID', 'UCS_SPECIAL_ACCOUNT', 'CUSTOMER_ID', '', '', 'BLACK_LIST', 'CUST_ID', '客户标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'CUST_NAME', '', '', '', '', 'BLACK_LIST', 'CUST_NAME', '客户名称');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'USER_ID', '', '', '', '', 'BLACK_LIST', 'USER_ID', '用户标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'CONTACT_PHONE', '', '', '', '', 'BLACK_LIST', 'CONTACT_PHONE', '联系电话');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'PSPT_TYPE_CODE', 'UCS_SPECIAL_ACCOUNT', 'CERT_TYPE', 'wlocalblacklist', 'black_type', 'BLACK_LIST', 'ID_TYPE', '证件类型');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'PSPT_ID', 'UCS_SPECIAL_ACCOUNT', 'CERT_NUM', 'wlocalblacklist', 'black_no', 'BLACK_LIST', 'ID_NUMBER', '证件号码');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'PSPT_END_DATE', '', '', '', '', 'BLACK_LIST', 'ID_VALIDITY', '证件有效期');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'PSPT_ADDR', '', '', '', '', 'BLACK_LIST', 'ID_ADDR', '证件地址');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'SOURCE_TYPE', '', '', '', '', 'BLACK_LIST', 'CREATE_TYPE', '来源方式');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'VALID_FLAG', '', '', '', '', 'BLACK_LIST', 'ACT_TAG', '作用标志');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'EPARCHY_CODE', '', '', '', '', 'BLACK_LIST', 'EPARCHY_CODE', '地市');
INSERT INTO `poc_mapping_def` VALUES ('TF_O_CUST_SPECIAL_LIST', 'CITY_CODE', '', '', '', '', 'BLACK_LIST', 'CITY_CODE', '区县');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'USER_ID', 'UCS_SUBSCRIPTION', 'SUBSCRIPTION_ID', 'dcustmsg', 'id_no', 'USER_INFO', 'USER_ID', '用户标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'CUST_ID', 'UCS_SUBSCRIPTION', 'CUSTOMER_ID', 'dcustmsg', 'CUST_ID', 'USER_INFO', 'PARTY_ID', '自然人标识');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', 'USE_TYPE', '使用类型');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'SERIAL_NUMBER', 'UCS_SUBSCRIPTION', 'SERVICE_NUM', 'dcustmsg', 'phone_no', 'USER_INFO', 'SERVICE_NUMBER', '服务号码');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', 'SERVICE_NUMBER_TYPE', '号码类型');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'PRODUCT_ID', 'UCS_SUBS_COMPONENT', 'PRODUCT_ID', 'serv', 'product_id', 'USER_INFO', 'PRODUCT_ID', '主体产品');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'PRODUCT_SPEC', '', '', '', '', 'USER_INFO', 'PRODUCT_SPEC', '产品规格');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', 'PRODUCT_TYPE_CODE', '主体产品类型');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', 'MAIN_DISCNT_CODE', '主资费规格');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'PREPAY_TAG', 'UCS_SUBSCRIPTION', 'ACCT_TYPE', 'dcustmsg', 'sm_code', 'USER_INFO', 'PREPAID_FLAG', '付费标识');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', 'NET_TYPE', '网络类型');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'BRAND_CODE', 'UCS_SUBSCRIPTION', 'brand_id', 'dcustmsg', 'sm_code', 'USER_INFO', 'BRAND_CODE', '用户品牌');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'USER_TYPE_CODE', 'UCS_SUBSCRIPTION', 'SERVICE_TYPE', 'dcustmsg', 'attr_code', 'USER_INFO', 'USER_TYPE_CODE', '用户类型');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'ASSURE_CUST_ID', '', '', '', '', 'USER_INFO', 'ASSURE_CUST_ID', '担保客户');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'ASSURE_DATE', '', '', '', '', 'USER_INFO', 'ASSURE_CUST_DATE', '担保期限');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'ASSURE_TYPE_CODE', '', '', '', '', 'USER_INFO', 'ASSURE_TYPE_CODE', '担保类型');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', '　', '集团责任人');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'PROVINCE_CODE', '', '', '', '', 'USER_INFO', 'PROVINCE_CODE', '归属省份');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'EPARCHY_CODE', 'UCS_SUBSCRIPTION', 'RELE_COUNTY_ID', 'dcustmsg', 'belong_code', 'USER_INFO', 'EPARCHY_CODE', '归属地市');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'CITY_CODE', '', '', 'dcustmsg', 'belong_code', 'USER_INFO', 'CITY_CODE', '归属县市');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'REMARK', '', '', '', '', 'USER_INFO', 'REMARK', '备注');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'USER_STATE_CODESET', 'UCS_SUBSCRIPTION', 'service_status', 'dcustmsg', 'run_code', 'USER_INFO', 'USER_STATE', '用户状态');
INSERT INTO `poc_mapping_def` VALUES ('', '', 'UCS_SUBSCRIPTION', 'SERVICE_STATUS', '', '', 'USER_INFO', 'USER_STATE_DESC', '用户状态描述');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', 'PRE_DESTROY_TIME', '预销号时间');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'DEVELOP_DEPART_ID', 'UCS_SUBSCRIPTION', 'RELE_OFFICE_ID', '', '', 'USER_INFO', 'DEVELOP_CHANNEL_ID', '发展渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'DEVELOP_STAFF_ID', 'UCS_SUBSCRIPTION', 'OPERATOR_ID', '', '', 'USER_INFO', 'DEVELOP_STAFF_ID', '发展员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'IN_DATE', 'UCS_SUBSCRIPTION', 'ACTIVE_DATE', 'dcustmsg', 'open_time', 'USER_INFO', 'DEVELOP_DATE', '发展日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'OPEN_DEPART_ID', '', '', 'dcustmsg', 'group_id', 'USER_INFO', 'CREATE_CHANNEL_ID', '创建渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'IN_STAFF_ID', 'UCS_SUBSCRIPTION', 'OPERATOR_ID', '', '', 'USER_INFO', 'CREATE_STAFF_ID', '创建员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'IN_DATE', 'UCS_SUBSCRIPTION', 'CREATE_DATE', 'dcustmsg', 'open_time', 'USER_INFO', 'CREATE_DATE', '创建日期');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', 'MODITY_CHANNEL_ID', '修改渠道');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', 'MODITY_STAFF_ID', '修改员工');
INSERT INTO `poc_mapping_def` VALUES ('', '', 'UCS_SUBSCRIPTION', 'STATUS_CHG_DATE', 'dcustmsg', 'run_time', 'USER_INFO', 'MODITY_DATE', '修改日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'REMOVE_DEPART_ID', '', '', '', '', 'USER_INFO', 'DEACTIVE_CHANNEL_ID', '注销渠道');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_INFO', 'DEACTIVE_STAFF_ID', '注销员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'DESTROY_TIME', '', '', '', '', 'USER_INFO', 'DEACTIVE_DATE', '注销日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER', 'REMOVE_REASON_CODE', '', '', '', '', 'USER_INFO', 'DEACTIVE_REASON', '离网原因');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_CUSTOMER', 'CUST_TYPE', '', '', 'dcustdoc', 'owner_type', 'USER_INFO', 'IS_GROUP', '是否集团成员');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER_PRODUCT', 'USER_ID', 'UCS_SUBS_COMPONENT', 'SUBSCRIPTION_ID', 'serv', 'SERV_ID', 'USER_PRODUCT_INFO', 'USER_ID', '用户标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_USER_PRODUCT', 'PRODUCT_ID', 'UCS_SUBS_COMPONENT', 'PRODUCT_ID', 'serv', 'product_id', 'USER_PRODUCT_INFO', 'PRODUCT_ID', '产品标识');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'PRODUCT_MODE', '产品模式');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'PRODUCT_NAME', '产品名称');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'PRODUCT_EXPLAIN', '产品解释');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'START_DATE', '产品生效时间');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'END_DATE', '产品失效时间');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'BRAND_CODE', '品牌名称');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'CREATE_CHANNEL_ID', '创建渠道');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'CREATE_STAFF_ID', '创建员工');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'CREATE_DATE', '创建日期');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'MODITY_CHANNEL_ID', '修改渠道');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'MODITY_STAFF_ID', '修改员工');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_PRODUCT_INFO', 'MODITY_DATE', '修改日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'ACCT_ID', 'ucs_account', 'ACCOUNT_ID', 'dconmsg', 'contract_no', 'PERSON_ACCT_INFO', 'ACCT_ID', '帐户标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'CUST_ID', 'ucs_account', 'customer_id', 'dconmsg', 'con_cust_id', 'PERSON_ACCT_INFO', 'CUST_ID', '自然人标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'PAY_NAME', 'ucs_account', 'ACCT_NAME', 'dconmsg', 'bank_cust', 'PERSON_ACCT_INFO', 'ACCT_NAME', '帐户名称');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'PAY_MODE_CODE', 'ucs_account', 'PAY_TYPE                            ', '', '', 'PERSON_ACCT_INFO', 'PAY_MODE', '支付方式');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'PREPAID_FLAG', '付费类型');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'SCORE_VALUE', '帐户积分');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'CREDIT_LEVLE', '帐户信用等级');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'BASIC_CREDIT_VALUE', '帐户初始信用度');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'CREDIT_VALUE', '帐户信用度');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'ACCT_BALANCE', '帐户余额');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'PROVINCE_CODE', '归属省份');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'EPARCHY_CODE', '归属地市');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'CITY_CODE', '归属县市');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'REMOVE_TAG', 'ucs_account', 'ACCOUNT_STATUS', 'dconmsg', '', 'PERSON_ACCT_INFO', 'ACCT_STATE', '帐户状态');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'CREATE_CHANNEL_ID', '创建渠道');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'CREATE_STAFF_ID', '创建员工');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'PERSON_ACCT_INFO', 'CREATE_DATE', '创建日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'UPDATE_DEPART_NAME', 'ucs_account', 'RELE_OFFICE_ID', '', '', 'PERSON_ACCT_INFO', 'MODITY_CHANNEL_ID', '修改渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'UPDATE_STAFF_NAME', 'ucs_account', 'OPERATOR_ID', '', '', 'PERSON_ACCT_INFO', 'MODITY_STAFF_ID', '修改员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'UPDATE_STAFF_NAME', '', '', 'dconmsg', 'prepay_time', 'PERSON_ACCT_INFO', 'MODITY_DATE', '修改日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_A_PAYRELATION', 'ACCT_ID', 'UCS_SUBSCRIPTION', 'account_id', 'dconusermsg', 'contract_no', 'USER_ACCOUNT', 'ACCT_ID', '帐户标识');
INSERT INTO `poc_mapping_def` VALUES ('TF_A_PAYRELATION', 'USER_ID', 'UCS_SUBSCRIPTION', 'subscription_id', 'dconusermsg', 'id_no', 'USER_ACCOUNT', 'USER_ID', '被代付用户');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_ACCOUNT', 'PAYMENT_RELA_TYPE', '代付类型');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_ACCOUNT', 'PAYMENT_STATE', '代付状态');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_ACCOUNT', 'CREATE_CHANNEL_ID', '创建渠道');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_ACCOUNT', 'CREATE_STAFF_ID', '创建员工');
INSERT INTO `poc_mapping_def` VALUES ('', '', '', '', '', '', 'USER_ACCOUNT', 'CREATE_DATE', '创建日期');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'UPDATE_DEPART_NAME', '', '', '', '', 'USER_ACCOUNT', 'MODITY_CHANNEL_ID', '修改渠道');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'UPDATE_STAFF_NAME', '', '', '', '', 'USER_ACCOUNT', 'MODITY_STAFF_ID', '修改员工');
INSERT INTO `poc_mapping_def` VALUES ('TF_F_ACCOUNT', 'UPDATE_STAFF_NAME', '', '', '', '', 'USER_ACCOUNT', 'MODITY_DATE', '修改日期');

-- ----------------------------
-- Table structure for `poc_model_def`
-- ----------------------------
DROP TABLE IF EXISTS `poc_model_def`;
CREATE TABLE `poc_model_def` (
  `table_name` varchar(64) DEFAULT NULL COMMENT '表名称',
  `modle_def` text COMMENT '模型定义(json格式)',
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='模型定义表';

-- ----------------------------
-- Records of poc_model_def
-- ----------------------------
INSERT INTO `poc_model_def` VALUES ('PERSON_BASIC_INFO', '{\"pk\":{\"CUST_NAME\":\"1\"},\"hashkey\":{\"BIRTHDAY\":\"3,空\"},\"time\":{\"CREATE_DATE\":\"4\"},\"fields\":{\"PARTY_ID\":\"0\",\"CUST_NAME\":\"1,空\",\"SEX\":\"2\",\"BIRTHDAY\":\"3,空\",\"CREATE_DATE\":\"4,非空\"}}', '1');
INSERT INTO `poc_model_def` VALUES ('TF_F_CUSTOMER', '{\"pk\":{\"CUST_ID\":\"0\"},\"hashkey\":{\"CUST_NAME\":\"1,非空\"},\"time\":{},\"fields\":{\"CUST_ID\":\"0,空\",\"CUST_NAME\":\"1,非空\",\"PSPT_TYPE_CODE\":\"2\",\"PSPT_ID\":\"3\",\"PROVINCE_CODE\":\"4\",\"EPARCHY_CODE\":\"5\",\"CITY_CODE\":\"6\",\"CREDIT_CLASS\":\"7\",\"CREDIT_VALUE\":\"8,非空\"}}', '2');
INSERT INTO `poc_model_def` VALUES ('test_250', '{\"pk\":{\"id\":\"0\"},\"hashkey\":{},\"time\":{},\"fields\":{\"id\":\"0\",\"name\":\"1\",\"age\":\"2\",\"addr\":\"3\",\"VISIT_ID\":\"4\",\"RESOURCES_ID\":\"5\",\"USER_ID\":\"6\",\"VISIT_DATE\":\"7\",\"TENANT_ID\":\"8\"}}', '3');

-- ----------------------------
-- Table structure for `poc_split`
-- ----------------------------
DROP TABLE IF EXISTS `poc_split`;
CREATE TABLE `poc_split` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `split1` varchar(64) DEFAULT NULL,
  `split2` varchar(64) DEFAULT NULL,
  `split3` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poc_split
-- ----------------------------
INSERT INTO `poc_split` VALUES ('22', '|', '%', '#');

-- ----------------------------
-- Table structure for `publish_info`
-- ----------------------------
DROP TABLE IF EXISTS `publish_info`;
CREATE TABLE `publish_info` (
  `publish_info_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_id` varchar(30) DEFAULT NULL,
  `jar_name` varchar(30) DEFAULT NULL,
  `pakeage_name` varchar(30) DEFAULT NULL,
  `class_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`publish_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of publish_info
-- ----------------------------

-- ----------------------------
-- Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `enable` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '94', '系统管理员', '1');
INSERT INTO `role` VALUES ('8', '12', '普通用户', '1');
INSERT INTO `role` VALUES ('9', '9', '高级系统管理员', '1');
INSERT INTO `role` VALUES ('10', '6', 'POC测试', '1');
INSERT INTO `role` VALUES ('11', '3', '管理员', '1');

-- ----------------------------
-- Table structure for `role_authority`
-- ----------------------------
DROP TABLE IF EXISTS `role_authority`;
CREATE TABLE `role_authority` (
  `authorityId` int(11) NOT NULL,
  `roleId` int(11) NOT NULL,
  KEY `FK_fftr98ew5vtbdpcfetn7xd715` (`roleId`),
  KEY `FK_sccf4fx8omb6jlsy2ra75xxer` (`authorityId`),
  CONSTRAINT `FK_fftr98ew5vtbdpcfetn7xd715` FOREIGN KEY (`roleId`) REFERENCES `role` (`id`),
  CONSTRAINT `FK_sccf4fx8omb6jlsy2ra75xxer` FOREIGN KEY (`authorityId`) REFERENCES `authority` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_authority
-- ----------------------------
INSERT INTO `role_authority` VALUES ('1', '9');
INSERT INTO `role_authority` VALUES ('2', '9');
INSERT INTO `role_authority` VALUES ('154', '9');
INSERT INTO `role_authority` VALUES ('155', '9');
INSERT INTO `role_authority` VALUES ('159', '9');
INSERT INTO `role_authority` VALUES ('160', '9');
INSERT INTO `role_authority` VALUES ('161', '9');
INSERT INTO `role_authority` VALUES ('162', '9');
INSERT INTO `role_authority` VALUES ('163', '9');
INSERT INTO `role_authority` VALUES ('156', '9');
INSERT INTO `role_authority` VALUES ('164', '9');
INSERT INTO `role_authority` VALUES ('165', '9');
INSERT INTO `role_authority` VALUES ('166', '9');
INSERT INTO `role_authority` VALUES ('167', '9');
INSERT INTO `role_authority` VALUES ('168', '9');
INSERT INTO `role_authority` VALUES ('169', '9');
INSERT INTO `role_authority` VALUES ('170', '9');
INSERT INTO `role_authority` VALUES ('157', '9');
INSERT INTO `role_authority` VALUES ('171', '9');
INSERT INTO `role_authority` VALUES ('172', '9');
INSERT INTO `role_authority` VALUES ('173', '9');
INSERT INTO `role_authority` VALUES ('174', '9');
INSERT INTO `role_authority` VALUES ('158', '9');
INSERT INTO `role_authority` VALUES ('175', '9');
INSERT INTO `role_authority` VALUES ('176', '9');
INSERT INTO `role_authority` VALUES ('177', '9');
INSERT INTO `role_authority` VALUES ('178', '9');
INSERT INTO `role_authority` VALUES ('1', '8');
INSERT INTO `role_authority` VALUES ('2', '8');
INSERT INTO `role_authority` VALUES ('21', '8');
INSERT INTO `role_authority` VALUES ('22', '8');
INSERT INTO `role_authority` VALUES ('38', '8');
INSERT INTO `role_authority` VALUES ('45', '8');
INSERT INTO `role_authority` VALUES ('46', '8');
INSERT INTO `role_authority` VALUES ('47', '8');
INSERT INTO `role_authority` VALUES ('48', '8');
INSERT INTO `role_authority` VALUES ('179', '8');
INSERT INTO `role_authority` VALUES ('183', '8');
INSERT INTO `role_authority` VALUES ('191', '8');
INSERT INTO `role_authority` VALUES ('192', '8');
INSERT INTO `role_authority` VALUES ('193', '8');
INSERT INTO `role_authority` VALUES ('180', '8');
INSERT INTO `role_authority` VALUES ('194', '8');
INSERT INTO `role_authority` VALUES ('198', '8');
INSERT INTO `role_authority` VALUES ('199', '8');
INSERT INTO `role_authority` VALUES ('200', '8');
INSERT INTO `role_authority` VALUES ('181', '8');
INSERT INTO `role_authority` VALUES ('185', '8');
INSERT INTO `role_authority` VALUES ('223', '8');
INSERT INTO `role_authority` VALUES ('224', '8');
INSERT INTO `role_authority` VALUES ('225', '8');
INSERT INTO `role_authority` VALUES ('226', '8');
INSERT INTO `role_authority` VALUES ('227', '8');
INSERT INTO `role_authority` VALUES ('228', '8');
INSERT INTO `role_authority` VALUES ('229', '8');
INSERT INTO `role_authority` VALUES ('230', '8');
INSERT INTO `role_authority` VALUES ('23', '8');
INSERT INTO `role_authority` VALUES ('39', '8');
INSERT INTO `role_authority` VALUES ('55', '8');
INSERT INTO `role_authority` VALUES ('56', '8');
INSERT INTO `role_authority` VALUES ('57', '8');
INSERT INTO `role_authority` VALUES ('58', '8');
INSERT INTO `role_authority` VALUES ('40', '8');
INSERT INTO `role_authority` VALUES ('59', '8');
INSERT INTO `role_authority` VALUES ('60', '8');
INSERT INTO `role_authority` VALUES ('61', '8');
INSERT INTO `role_authority` VALUES ('62', '8');
INSERT INTO `role_authority` VALUES ('41', '8');
INSERT INTO `role_authority` VALUES ('63', '8');
INSERT INTO `role_authority` VALUES ('64', '8');
INSERT INTO `role_authority` VALUES ('65', '8');
INSERT INTO `role_authority` VALUES ('66', '8');
INSERT INTO `role_authority` VALUES ('186', '8');
INSERT INTO `role_authority` VALUES ('187', '8');
INSERT INTO `role_authority` VALUES ('195', '8');
INSERT INTO `role_authority` VALUES ('196', '8');
INSERT INTO `role_authority` VALUES ('197', '8');
INSERT INTO `role_authority` VALUES ('29', '8');
INSERT INTO `role_authority` VALUES ('42', '8');
INSERT INTO `role_authority` VALUES ('68', '8');
INSERT INTO `role_authority` VALUES ('73', '8');
INSERT INTO `role_authority` VALUES ('74', '8');
INSERT INTO `role_authority` VALUES ('75', '8');
INSERT INTO `role_authority` VALUES ('43', '8');
INSERT INTO `role_authority` VALUES ('69', '8');
INSERT INTO `role_authority` VALUES ('70', '8');
INSERT INTO `role_authority` VALUES ('71', '8');
INSERT INTO `role_authority` VALUES ('72', '8');
INSERT INTO `role_authority` VALUES ('25', '8');
INSERT INTO `role_authority` VALUES ('26', '8');
INSERT INTO `role_authority` VALUES ('87', '8');
INSERT INTO `role_authority` VALUES ('88', '8');
INSERT INTO `role_authority` VALUES ('89', '8');
INSERT INTO `role_authority` VALUES ('90', '8');
INSERT INTO `role_authority` VALUES ('91', '8');
INSERT INTO `role_authority` VALUES ('93', '8');
INSERT INTO `role_authority` VALUES ('94', '8');
INSERT INTO `role_authority` VALUES ('103', '8');
INSERT INTO `role_authority` VALUES ('104', '8');
INSERT INTO `role_authority` VALUES ('105', '8');
INSERT INTO `role_authority` VALUES ('106', '8');
INSERT INTO `role_authority` VALUES ('150', '8');
INSERT INTO `role_authority` VALUES ('151', '8');
INSERT INTO `role_authority` VALUES ('152', '8');
INSERT INTO `role_authority` VALUES ('153', '8');
INSERT INTO `role_authority` VALUES ('201', '8');
INSERT INTO `role_authority` VALUES ('202', '8');
INSERT INTO `role_authority` VALUES ('203', '8');
INSERT INTO `role_authority` VALUES ('204', '8');
INSERT INTO `role_authority` VALUES ('205', '8');
INSERT INTO `role_authority` VALUES ('206', '8');
INSERT INTO `role_authority` VALUES ('207', '8');
INSERT INTO `role_authority` VALUES ('188', '8');
INSERT INTO `role_authority` VALUES ('189', '8');
INSERT INTO `role_authority` VALUES ('214', '8');
INSERT INTO `role_authority` VALUES ('215', '8');
INSERT INTO `role_authority` VALUES ('216', '8');
INSERT INTO `role_authority` VALUES ('217', '8');
INSERT INTO `role_authority` VALUES ('190', '8');
INSERT INTO `role_authority` VALUES ('218', '8');
INSERT INTO `role_authority` VALUES ('219', '8');
INSERT INTO `role_authority` VALUES ('220', '8');
INSERT INTO `role_authority` VALUES ('221', '8');
INSERT INTO `role_authority` VALUES ('222', '8');
INSERT INTO `role_authority` VALUES ('208', '8');
INSERT INTO `role_authority` VALUES ('209', '8');
INSERT INTO `role_authority` VALUES ('210', '8');
INSERT INTO `role_authority` VALUES ('211', '8');
INSERT INTO `role_authority` VALUES ('212', '8');
INSERT INTO `role_authority` VALUES ('213', '8');
INSERT INTO `role_authority` VALUES ('27', '8');
INSERT INTO `role_authority` VALUES ('95', '8');
INSERT INTO `role_authority` VALUES ('100', '8');
INSERT INTO `role_authority` VALUES ('119', '8');
INSERT INTO `role_authority` VALUES ('120', '8');
INSERT INTO `role_authority` VALUES ('121', '8');
INSERT INTO `role_authority` VALUES ('96', '8');
INSERT INTO `role_authority` VALUES ('101', '8');
INSERT INTO `role_authority` VALUES ('122', '8');
INSERT INTO `role_authority` VALUES ('123', '8');
INSERT INTO `role_authority` VALUES ('124', '8');
INSERT INTO `role_authority` VALUES ('125', '8');
INSERT INTO `role_authority` VALUES ('92', '8');
INSERT INTO `role_authority` VALUES ('97', '8');
INSERT INTO `role_authority` VALUES ('126', '8');
INSERT INTO `role_authority` VALUES ('98', '8');
INSERT INTO `role_authority` VALUES ('127', '8');
INSERT INTO `role_authority` VALUES ('99', '8');
INSERT INTO `role_authority` VALUES ('128', '8');
INSERT INTO `role_authority` VALUES ('1', '10');
INSERT INTO `role_authority` VALUES ('2', '10');
INSERT INTO `role_authority` VALUES ('21', '10');
INSERT INTO `role_authority` VALUES ('22', '10');
INSERT INTO `role_authority` VALUES ('38', '10');
INSERT INTO `role_authority` VALUES ('45', '10');
INSERT INTO `role_authority` VALUES ('46', '10');
INSERT INTO `role_authority` VALUES ('47', '10');
INSERT INTO `role_authority` VALUES ('48', '10');
INSERT INTO `role_authority` VALUES ('25', '10');
INSERT INTO `role_authority` VALUES ('26', '10');
INSERT INTO `role_authority` VALUES ('232', '10');
INSERT INTO `role_authority` VALUES ('233', '10');
INSERT INTO `role_authority` VALUES ('1', '1');
INSERT INTO `role_authority` VALUES ('2', '1');
INSERT INTO `role_authority` VALUES ('21', '1');
INSERT INTO `role_authority` VALUES ('22', '1');
INSERT INTO `role_authority` VALUES ('38', '1');
INSERT INTO `role_authority` VALUES ('45', '1');
INSERT INTO `role_authority` VALUES ('46', '1');
INSERT INTO `role_authority` VALUES ('47', '1');
INSERT INTO `role_authority` VALUES ('48', '1');
INSERT INTO `role_authority` VALUES ('179', '1');
INSERT INTO `role_authority` VALUES ('183', '1');
INSERT INTO `role_authority` VALUES ('191', '1');
INSERT INTO `role_authority` VALUES ('192', '1');
INSERT INTO `role_authority` VALUES ('193', '1');
INSERT INTO `role_authority` VALUES ('180', '1');
INSERT INTO `role_authority` VALUES ('194', '1');
INSERT INTO `role_authority` VALUES ('198', '1');
INSERT INTO `role_authority` VALUES ('199', '1');
INSERT INTO `role_authority` VALUES ('200', '1');
INSERT INTO `role_authority` VALUES ('181', '1');
INSERT INTO `role_authority` VALUES ('185', '1');
INSERT INTO `role_authority` VALUES ('223', '1');
INSERT INTO `role_authority` VALUES ('224', '1');
INSERT INTO `role_authority` VALUES ('225', '1');
INSERT INTO `role_authority` VALUES ('226', '1');
INSERT INTO `role_authority` VALUES ('227', '1');
INSERT INTO `role_authority` VALUES ('228', '1');
INSERT INTO `role_authority` VALUES ('229', '1');
INSERT INTO `role_authority` VALUES ('230', '1');
INSERT INTO `role_authority` VALUES ('23', '1');
INSERT INTO `role_authority` VALUES ('39', '1');
INSERT INTO `role_authority` VALUES ('55', '1');
INSERT INTO `role_authority` VALUES ('56', '1');
INSERT INTO `role_authority` VALUES ('57', '1');
INSERT INTO `role_authority` VALUES ('58', '1');
INSERT INTO `role_authority` VALUES ('40', '1');
INSERT INTO `role_authority` VALUES ('59', '1');
INSERT INTO `role_authority` VALUES ('60', '1');
INSERT INTO `role_authority` VALUES ('61', '1');
INSERT INTO `role_authority` VALUES ('62', '1');
INSERT INTO `role_authority` VALUES ('41', '1');
INSERT INTO `role_authority` VALUES ('63', '1');
INSERT INTO `role_authority` VALUES ('64', '1');
INSERT INTO `role_authority` VALUES ('65', '1');
INSERT INTO `role_authority` VALUES ('66', '1');
INSERT INTO `role_authority` VALUES ('186', '1');
INSERT INTO `role_authority` VALUES ('187', '1');
INSERT INTO `role_authority` VALUES ('195', '1');
INSERT INTO `role_authority` VALUES ('196', '1');
INSERT INTO `role_authority` VALUES ('197', '1');
INSERT INTO `role_authority` VALUES ('29', '1');
INSERT INTO `role_authority` VALUES ('42', '1');
INSERT INTO `role_authority` VALUES ('68', '1');
INSERT INTO `role_authority` VALUES ('73', '1');
INSERT INTO `role_authority` VALUES ('74', '1');
INSERT INTO `role_authority` VALUES ('75', '1');
INSERT INTO `role_authority` VALUES ('43', '1');
INSERT INTO `role_authority` VALUES ('69', '1');
INSERT INTO `role_authority` VALUES ('70', '1');
INSERT INTO `role_authority` VALUES ('71', '1');
INSERT INTO `role_authority` VALUES ('72', '1');
INSERT INTO `role_authority` VALUES ('25', '1');
INSERT INTO `role_authority` VALUES ('26', '1');
INSERT INTO `role_authority` VALUES ('87', '1');
INSERT INTO `role_authority` VALUES ('88', '1');
INSERT INTO `role_authority` VALUES ('89', '1');
INSERT INTO `role_authority` VALUES ('90', '1');
INSERT INTO `role_authority` VALUES ('91', '1');
INSERT INTO `role_authority` VALUES ('93', '1');
INSERT INTO `role_authority` VALUES ('94', '1');
INSERT INTO `role_authority` VALUES ('103', '1');
INSERT INTO `role_authority` VALUES ('104', '1');
INSERT INTO `role_authority` VALUES ('105', '1');
INSERT INTO `role_authority` VALUES ('106', '1');
INSERT INTO `role_authority` VALUES ('150', '1');
INSERT INTO `role_authority` VALUES ('151', '1');
INSERT INTO `role_authority` VALUES ('152', '1');
INSERT INTO `role_authority` VALUES ('153', '1');
INSERT INTO `role_authority` VALUES ('201', '1');
INSERT INTO `role_authority` VALUES ('202', '1');
INSERT INTO `role_authority` VALUES ('203', '1');
INSERT INTO `role_authority` VALUES ('204', '1');
INSERT INTO `role_authority` VALUES ('205', '1');
INSERT INTO `role_authority` VALUES ('206', '1');
INSERT INTO `role_authority` VALUES ('207', '1');
INSERT INTO `role_authority` VALUES ('188', '1');
INSERT INTO `role_authority` VALUES ('189', '1');
INSERT INTO `role_authority` VALUES ('214', '1');
INSERT INTO `role_authority` VALUES ('215', '1');
INSERT INTO `role_authority` VALUES ('216', '1');
INSERT INTO `role_authority` VALUES ('217', '1');
INSERT INTO `role_authority` VALUES ('190', '1');
INSERT INTO `role_authority` VALUES ('218', '1');
INSERT INTO `role_authority` VALUES ('219', '1');
INSERT INTO `role_authority` VALUES ('220', '1');
INSERT INTO `role_authority` VALUES ('221', '1');
INSERT INTO `role_authority` VALUES ('222', '1');
INSERT INTO `role_authority` VALUES ('208', '1');
INSERT INTO `role_authority` VALUES ('209', '1');
INSERT INTO `role_authority` VALUES ('210', '1');
INSERT INTO `role_authority` VALUES ('211', '1');
INSERT INTO `role_authority` VALUES ('212', '1');
INSERT INTO `role_authority` VALUES ('213', '1');
INSERT INTO `role_authority` VALUES ('27', '1');
INSERT INTO `role_authority` VALUES ('95', '1');
INSERT INTO `role_authority` VALUES ('100', '1');
INSERT INTO `role_authority` VALUES ('119', '1');
INSERT INTO `role_authority` VALUES ('120', '1');
INSERT INTO `role_authority` VALUES ('121', '1');
INSERT INTO `role_authority` VALUES ('96', '1');
INSERT INTO `role_authority` VALUES ('101', '1');
INSERT INTO `role_authority` VALUES ('122', '1');
INSERT INTO `role_authority` VALUES ('123', '1');
INSERT INTO `role_authority` VALUES ('124', '1');
INSERT INTO `role_authority` VALUES ('125', '1');
INSERT INTO `role_authority` VALUES ('92', '1');
INSERT INTO `role_authority` VALUES ('97', '1');
INSERT INTO `role_authority` VALUES ('126', '1');
INSERT INTO `role_authority` VALUES ('98', '1');
INSERT INTO `role_authority` VALUES ('127', '1');
INSERT INTO `role_authority` VALUES ('99', '1');
INSERT INTO `role_authority` VALUES ('128', '1');
INSERT INTO `role_authority` VALUES ('154', '1');
INSERT INTO `role_authority` VALUES ('155', '1');
INSERT INTO `role_authority` VALUES ('159', '1');
INSERT INTO `role_authority` VALUES ('160', '1');
INSERT INTO `role_authority` VALUES ('161', '1');
INSERT INTO `role_authority` VALUES ('162', '1');
INSERT INTO `role_authority` VALUES ('163', '1');
INSERT INTO `role_authority` VALUES ('156', '1');
INSERT INTO `role_authority` VALUES ('164', '1');
INSERT INTO `role_authority` VALUES ('165', '1');
INSERT INTO `role_authority` VALUES ('166', '1');
INSERT INTO `role_authority` VALUES ('167', '1');
INSERT INTO `role_authority` VALUES ('168', '1');
INSERT INTO `role_authority` VALUES ('169', '1');
INSERT INTO `role_authority` VALUES ('170', '1');
INSERT INTO `role_authority` VALUES ('157', '1');
INSERT INTO `role_authority` VALUES ('171', '1');
INSERT INTO `role_authority` VALUES ('172', '1');
INSERT INTO `role_authority` VALUES ('173', '1');
INSERT INTO `role_authority` VALUES ('174', '1');
INSERT INTO `role_authority` VALUES ('158', '1');
INSERT INTO `role_authority` VALUES ('175', '1');
INSERT INTO `role_authority` VALUES ('176', '1');
INSERT INTO `role_authority` VALUES ('177', '1');
INSERT INTO `role_authority` VALUES ('178', '1');
INSERT INTO `role_authority` VALUES ('1', '11');
INSERT INTO `role_authority` VALUES ('2', '11');
INSERT INTO `role_authority` VALUES ('21', '11');
INSERT INTO `role_authority` VALUES ('22', '11');
INSERT INTO `role_authority` VALUES ('38', '11');
INSERT INTO `role_authority` VALUES ('45', '11');
INSERT INTO `role_authority` VALUES ('46', '11');
INSERT INTO `role_authority` VALUES ('47', '11');
INSERT INTO `role_authority` VALUES ('48', '11');
INSERT INTO `role_authority` VALUES ('179', '11');
INSERT INTO `role_authority` VALUES ('183', '11');
INSERT INTO `role_authority` VALUES ('191', '11');
INSERT INTO `role_authority` VALUES ('192', '11');
INSERT INTO `role_authority` VALUES ('193', '11');
INSERT INTO `role_authority` VALUES ('180', '11');
INSERT INTO `role_authority` VALUES ('194', '11');
INSERT INTO `role_authority` VALUES ('198', '11');
INSERT INTO `role_authority` VALUES ('199', '11');
INSERT INTO `role_authority` VALUES ('200', '11');
INSERT INTO `role_authority` VALUES ('181', '11');
INSERT INTO `role_authority` VALUES ('185', '11');
INSERT INTO `role_authority` VALUES ('223', '11');
INSERT INTO `role_authority` VALUES ('224', '11');
INSERT INTO `role_authority` VALUES ('225', '11');
INSERT INTO `role_authority` VALUES ('226', '11');
INSERT INTO `role_authority` VALUES ('227', '11');
INSERT INTO `role_authority` VALUES ('228', '11');
INSERT INTO `role_authority` VALUES ('229', '11');
INSERT INTO `role_authority` VALUES ('230', '11');
INSERT INTO `role_authority` VALUES ('23', '11');
INSERT INTO `role_authority` VALUES ('39', '11');
INSERT INTO `role_authority` VALUES ('55', '11');
INSERT INTO `role_authority` VALUES ('56', '11');
INSERT INTO `role_authority` VALUES ('57', '11');
INSERT INTO `role_authority` VALUES ('58', '11');
INSERT INTO `role_authority` VALUES ('40', '11');
INSERT INTO `role_authority` VALUES ('59', '11');
INSERT INTO `role_authority` VALUES ('60', '11');
INSERT INTO `role_authority` VALUES ('61', '11');
INSERT INTO `role_authority` VALUES ('62', '11');
INSERT INTO `role_authority` VALUES ('41', '11');
INSERT INTO `role_authority` VALUES ('63', '11');
INSERT INTO `role_authority` VALUES ('64', '11');
INSERT INTO `role_authority` VALUES ('65', '11');
INSERT INTO `role_authority` VALUES ('66', '11');
INSERT INTO `role_authority` VALUES ('186', '11');
INSERT INTO `role_authority` VALUES ('187', '11');
INSERT INTO `role_authority` VALUES ('195', '11');
INSERT INTO `role_authority` VALUES ('196', '11');
INSERT INTO `role_authority` VALUES ('197', '11');
INSERT INTO `role_authority` VALUES ('29', '11');
INSERT INTO `role_authority` VALUES ('42', '11');
INSERT INTO `role_authority` VALUES ('68', '11');
INSERT INTO `role_authority` VALUES ('73', '11');
INSERT INTO `role_authority` VALUES ('74', '11');
INSERT INTO `role_authority` VALUES ('75', '11');
INSERT INTO `role_authority` VALUES ('43', '11');
INSERT INTO `role_authority` VALUES ('69', '11');
INSERT INTO `role_authority` VALUES ('70', '11');
INSERT INTO `role_authority` VALUES ('71', '11');
INSERT INTO `role_authority` VALUES ('72', '11');
INSERT INTO `role_authority` VALUES ('25', '11');
INSERT INTO `role_authority` VALUES ('26', '11');
INSERT INTO `role_authority` VALUES ('87', '11');
INSERT INTO `role_authority` VALUES ('88', '11');
INSERT INTO `role_authority` VALUES ('89', '11');
INSERT INTO `role_authority` VALUES ('90', '11');
INSERT INTO `role_authority` VALUES ('91', '11');
INSERT INTO `role_authority` VALUES ('93', '11');
INSERT INTO `role_authority` VALUES ('94', '11');
INSERT INTO `role_authority` VALUES ('103', '11');
INSERT INTO `role_authority` VALUES ('104', '11');
INSERT INTO `role_authority` VALUES ('105', '11');
INSERT INTO `role_authority` VALUES ('106', '11');
INSERT INTO `role_authority` VALUES ('150', '11');
INSERT INTO `role_authority` VALUES ('151', '11');
INSERT INTO `role_authority` VALUES ('152', '11');
INSERT INTO `role_authority` VALUES ('153', '11');
INSERT INTO `role_authority` VALUES ('201', '11');
INSERT INTO `role_authority` VALUES ('202', '11');
INSERT INTO `role_authority` VALUES ('203', '11');
INSERT INTO `role_authority` VALUES ('204', '11');
INSERT INTO `role_authority` VALUES ('205', '11');
INSERT INTO `role_authority` VALUES ('206', '11');
INSERT INTO `role_authority` VALUES ('207', '11');
INSERT INTO `role_authority` VALUES ('188', '11');
INSERT INTO `role_authority` VALUES ('189', '11');
INSERT INTO `role_authority` VALUES ('214', '11');
INSERT INTO `role_authority` VALUES ('215', '11');
INSERT INTO `role_authority` VALUES ('216', '11');
INSERT INTO `role_authority` VALUES ('217', '11');
INSERT INTO `role_authority` VALUES ('190', '11');
INSERT INTO `role_authority` VALUES ('218', '11');
INSERT INTO `role_authority` VALUES ('219', '11');
INSERT INTO `role_authority` VALUES ('220', '11');
INSERT INTO `role_authority` VALUES ('221', '11');
INSERT INTO `role_authority` VALUES ('222', '11');
INSERT INTO `role_authority` VALUES ('208', '11');
INSERT INTO `role_authority` VALUES ('209', '11');
INSERT INTO `role_authority` VALUES ('210', '11');
INSERT INTO `role_authority` VALUES ('211', '11');
INSERT INTO `role_authority` VALUES ('212', '11');
INSERT INTO `role_authority` VALUES ('213', '11');
INSERT INTO `role_authority` VALUES ('27', '11');
INSERT INTO `role_authority` VALUES ('95', '11');
INSERT INTO `role_authority` VALUES ('100', '11');
INSERT INTO `role_authority` VALUES ('119', '11');
INSERT INTO `role_authority` VALUES ('120', '11');
INSERT INTO `role_authority` VALUES ('121', '11');
INSERT INTO `role_authority` VALUES ('96', '11');
INSERT INTO `role_authority` VALUES ('101', '11');
INSERT INTO `role_authority` VALUES ('122', '11');
INSERT INTO `role_authority` VALUES ('123', '11');
INSERT INTO `role_authority` VALUES ('124', '11');
INSERT INTO `role_authority` VALUES ('125', '11');
INSERT INTO `role_authority` VALUES ('92', '11');
INSERT INTO `role_authority` VALUES ('97', '11');
INSERT INTO `role_authority` VALUES ('126', '11');
INSERT INTO `role_authority` VALUES ('98', '11');
INSERT INTO `role_authority` VALUES ('127', '11');
INSERT INTO `role_authority` VALUES ('99', '11');
INSERT INTO `role_authority` VALUES ('128', '11');
INSERT INTO `role_authority` VALUES ('154', '11');
INSERT INTO `role_authority` VALUES ('155', '11');
INSERT INTO `role_authority` VALUES ('159', '11');
INSERT INTO `role_authority` VALUES ('160', '11');
INSERT INTO `role_authority` VALUES ('161', '11');
INSERT INTO `role_authority` VALUES ('162', '11');
INSERT INTO `role_authority` VALUES ('163', '11');
INSERT INTO `role_authority` VALUES ('156', '11');
INSERT INTO `role_authority` VALUES ('164', '11');
INSERT INTO `role_authority` VALUES ('165', '11');
INSERT INTO `role_authority` VALUES ('166', '11');
INSERT INTO `role_authority` VALUES ('167', '11');
INSERT INTO `role_authority` VALUES ('168', '11');
INSERT INTO `role_authority` VALUES ('169', '11');
INSERT INTO `role_authority` VALUES ('170', '11');
INSERT INTO `role_authority` VALUES ('157', '11');
INSERT INTO `role_authority` VALUES ('171', '11');
INSERT INTO `role_authority` VALUES ('172', '11');
INSERT INTO `role_authority` VALUES ('173', '11');
INSERT INTO `role_authority` VALUES ('174', '11');
INSERT INTO `role_authority` VALUES ('158', '11');
INSERT INTO `role_authority` VALUES ('175', '11');
INSERT INTO `role_authority` VALUES ('176', '11');
INSERT INTO `role_authority` VALUES ('177', '11');
INSERT INTO `role_authority` VALUES ('178', '11');

-- ----------------------------
-- Table structure for `s_dict`
-- ----------------------------
DROP TABLE IF EXISTS `s_dict`;
CREATE TABLE `s_dict` (
  `DICT_ID` bigint(20) NOT NULL,
  `DICT_NAME` varchar(20) DEFAULT NULL,
  `DICT_TYPE` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`DICT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_dict
-- ----------------------------
INSERT INTO `s_dict` VALUES ('0', 'FTP获取', 'DATA_SOURCE');
INSERT INTO `s_dict` VALUES ('1', 'HDFS', 'DATA_SOURCE');
INSERT INTO `s_dict` VALUES ('2', 'mysql', 'DATA_SOURCE');
INSERT INTO `s_dict` VALUES ('3', 'oracle', 'DATA_SOURCE');
INSERT INTO `s_dict` VALUES ('4', 'hive', 'DATA_SOURCE');
INSERT INTO `s_dict` VALUES ('5', 'hbase', 'DATA_SOURCE');
INSERT INTO `s_dict` VALUES ('6', 'redis', 'DATA_SOURCE');

-- ----------------------------
-- Table structure for `s_ds`
-- ----------------------------
DROP TABLE IF EXISTS `s_ds`;
CREATE TABLE `s_ds` (
  `DS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DS_NAME` varchar(20) DEFAULT NULL,
  `DICT_ID` varchar(20) DEFAULT NULL,
  `DESCRIPTION` varchar(30) DEFAULT NULL,
  `HOST` varchar(20) DEFAULT NULL,
  `PORT` varchar(5) DEFAULT NULL,
  `USER_NAME` varchar(20) DEFAULT NULL,
  `PASSWORD` varchar(20) DEFAULT NULL,
  `DB_NAME` varchar(20) DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `creator_name` varchar(30) DEFAULT NULL,
  `s_organization_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`DS_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_ds
-- ----------------------------
INSERT INTO `s_ds` VALUES ('16', 'MySQL', '2', 'MySQL', '192.168.10.37', '3306', 'root', 'root123', 'target', '33', 'wxx', '8');
INSERT INTO `s_ds` VALUES ('20', 'mysql区域信息关联', '2', '区域信息关联资源', '192.168.10.37', '3306', 'root', 'root123', 'target', '33', 'wxx', '8');
INSERT INTO `s_ds` VALUES ('24', 'test_decode', '2', 'test_decode', '192.168.10.37', '3306', 'root', 'root123', 'target', '33', 'wxx', '8');
INSERT INTO `s_ds` VALUES ('26', 'x_ds', '2', 'x_ds', '192.168.10.37', '3306', 'root', 'root123', 'x_test', null, null, '8');
INSERT INTO `s_ds` VALUES ('27', 'x_ds_redis', '6', 'x_ds_redis', '192.168.10.37', '6379', '', '', '', null, null, '8');
INSERT INTO `s_ds` VALUES ('30', 'x_ds_test2', '2', 'x_ds_test2', '192.168.10.37', '3306', 'root', 'root123', 'x_test2', null, null, '8');

-- ----------------------------
-- Table structure for `s_ds_table`
-- ----------------------------
DROP TABLE IF EXISTS `s_ds_table`;
CREATE TABLE `s_ds_table` (
  `DSTABLE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DSTABLE_NAME` varchar(20) DEFAULT NULL,
  `DESCRIPTION` varchar(30) DEFAULT NULL,
  `DS_ID` int(11) DEFAULT NULL,
  `DS_NAME` varchar(20) DEFAULT NULL,
  `FILE_PATH` varchar(50) DEFAULT NULL,
  `TABLE_NAME` varchar(20) DEFAULT NULL,
  `DICT_ID` int(11) DEFAULT NULL,
  `create_user` varchar(20) DEFAULT NULL,
  `creater_name_id` int(11) DEFAULT NULL,
  `creater_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`DSTABLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_ds_table
-- ----------------------------
INSERT INTO `s_ds_table` VALUES ('11', '区域信息采集tomysql', 'mysql', '16', 'HDFS', '', 'test_station', '2', null, '33', 'wxx');
INSERT INTO `s_ds_table` VALUES ('17', '区域信息关联表mysql', 'relate_table', '20', 'mysql区域信息关联', '', 'relate_table', '2', null, '33', 'wxx');
INSERT INTO `s_ds_table` VALUES ('19', 'test_decode', 'test_decode', '24', 'test_decode', '', 'test_decode', '2', null, '33', 'wxx');
INSERT INTO `s_ds_table` VALUES ('21', 'x_db_mysql_test', 'x_db_mysql_test', '26', 'x_ds', '', 'test', '2', null, '23', 'xieqq');
INSERT INTO `s_ds_table` VALUES ('22', 'x_db_mysql_test2', 'x_db_mysql_test2', '26', 'x_ds', '', 'test2', '2', null, '23', 'xieqq');
INSERT INTO `s_ds_table` VALUES ('23', 'x_db_mysql_test_2', 'x_db_mysql_test_2', '30', 'x_ds_test2', '', 'test', '2', null, '23', 'xieqq');
INSERT INTO `s_ds_table` VALUES ('25', '123', '321', '20', 'mysql区域信息关联', '', 'account', '2', null, '24', 'bianshen');
INSERT INTO `s_ds_table` VALUES ('26', '111', '222', '16', 'MySQL', '', null, '2', null, '25', 'admin');

-- ----------------------------
-- Table structure for `s_event`
-- ----------------------------
DROP TABLE IF EXISTS `s_event`;
CREATE TABLE `s_event` (
  `event_id` varchar(20) NOT NULL,
  `event_name` varchar(200) DEFAULT NULL,
  `event_type` varchar(2) DEFAULT NULL COMMENT '01 - 单事件\n            02 - 多事件',
  `event_topology_path` varchar(50) DEFAULT NULL,
  `event_worker_num` int(2) DEFAULT '1',
  `event_desc` varchar(100) DEFAULT NULL,
  `event_note` varchar(100) DEFAULT NULL,
  `event_user_id` int(11) DEFAULT NULL,
  `event_user_name` varchar(2000) DEFAULT NULL,
  `event_start_time` varchar(20) DEFAULT NULL,
  `event_update_time` varchar(20) DEFAULT NULL,
  `event_publish_status` varchar(2) DEFAULT '0',
  `event_publish_time` varchar(20) DEFAULT NULL,
  `event_run_status` varchar(2) DEFAULT '0',
  `event_run_time` varchar(20) DEFAULT NULL,
  `event_killed_time` varchar(20) DEFAULT NULL,
  `timer_status` varchar(2) DEFAULT '0',
  `event_timer_run_time` varchar(20) DEFAULT NULL,
  `event_timer_killed_time` varchar(20) DEFAULT NULL,
  `s_host_type` varchar(10) DEFAULT NULL,
  `cluster_id` int(11) DEFAULT NULL,
  `s_master` varchar(10) DEFAULT NULL,
  `s_spark_master` varchar(100) DEFAULT NULL,
  `s_spark_class` varchar(100) DEFAULT NULL,
  `s_spark_cores` varchar(10) DEFAULT NULL,
  `s_spark_mode` varchar(20) DEFAULT NULL,
  `s_spark_name` varchar(40) DEFAULT NULL,
  `s_spark_jars` varchar(100) DEFAULT NULL,
  `s_spark_prot` varchar(100) DEFAULT NULL,
  `s_spark_memory` varchar(10) DEFAULT NULL,
  `s_spark_execType` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event
-- ----------------------------
INSERT INTO `s_event` VALUES ('20170420162010', '区域位置信息采集', '02', '', '2', '从kafka实时读取数据，经由storm处理后，推送到kafka', '', '25', '   ', '2017-04-20 16:20:10', null, '1', '2017-04-20 16:28:01', '1', '2017-04-20 16:33:16', null, null, null, null, 'storm', '1', '14', null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for `s_event_decision`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_decision`;
CREATE TABLE `s_event_decision` (
  `decision_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) DEFAULT NULL,
  `decision_name` varchar(20) DEFAULT NULL,
  `decision_desc` varchar(100) DEFAULT NULL,
  `response_num` int(3) DEFAULT '1',
  `response_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`decision_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_decision
-- ----------------------------
INSERT INTO `s_event_decision` VALUES ('1', '20160405141211', '决策测试1', '关联响应', '8', null);
INSERT INTO `s_event_decision` VALUES ('2', '20160616093215', 'test2', 'test2', '1', null);
INSERT INTO `s_event_decision` VALUES ('4', '20160817175429', '决策1', 'aaa', '12', null);
INSERT INTO `s_event_decision` VALUES ('7', '20160805155042', '决策3', 'storm trient事件决策', '8', null);
INSERT INTO `s_event_decision` VALUES ('8', '20160810113627', '决策测试', '决策测试', '10', '20160818181010');
INSERT INTO `s_event_decision` VALUES ('9', '20160809141324', 'spark决策', 'spark决策测试', null, '20160818181010');
INSERT INTO `s_event_decision` VALUES ('10', '20160901171620', 'spark-one1', 'spark-testone1', null, '20160823144329');
INSERT INTO `s_event_decision` VALUES ('11', '20160810113627', '决策测试2', '决策说明', '6', '20160818180926');
INSERT INTO `s_event_decision` VALUES ('12', '20160810113627', '决策3', '决策说明', '4', '20160823144329');
INSERT INTO `s_event_decision` VALUES ('13', '20160905150313', 'spark 9-05', 'spark-9-05事件决策配置', '1', '20160818180926');
INSERT INTO `s_event_decision` VALUES ('16', '20160905201524', 'spark-two', 'spark -response', null, '20160823144329');
INSERT INTO `s_event_decision` VALUES ('17', '20160817175757', 'GGG', 'FFF', '6', '20160818180856');
INSERT INTO `s_event_decision` VALUES ('19', '20160921103844', '存储于hdfs', '存储于hdfs', null, '20160914163001');
INSERT INTO `s_event_decision` VALUES ('20', '20160921120830', 'gch', '', null, '20160914163001');
INSERT INTO `s_event_decision` VALUES ('21', '20160921183338', 'spark-one决策', 'spark -one 决策', null, '20160914163001');
INSERT INTO `s_event_decision` VALUES ('22', '20160922173150', '', '', '1', null);
INSERT INTO `s_event_decision` VALUES ('25', '20160905163806', 'mysql', 'mysql', '4', '20161014103658');
INSERT INTO `s_event_decision` VALUES ('26', '20161017151448', 'spark-10-17', 'spark-10-17', null, '20160914163001');
INSERT INTO `s_event_decision` VALUES ('27', '20160920171126', '响应测试', '响应到mysql测试', '10', '20161014103658');
INSERT INTO `s_event_decision` VALUES ('28', '20161018114155', 'spark-18', 'spark-18', null, '20161014103658');
INSERT INTO `s_event_decision` VALUES ('29', '20160920113644', '决策', 'AAA', '1', '20161014103658');
INSERT INTO `s_event_decision` VALUES ('31', '20161129180114', '新入网用户的信息存入kafka', '符合条件的新入网用户存入到kafka中', '4', '20161129175508');
INSERT INTO `s_event_decision` VALUES ('32', '20161130165030', 'kafka', 'kafka', '4', '20161129175508');
INSERT INTO `s_event_decision` VALUES ('33', '20161028151714', '111', '111', null, '20161129175508');
INSERT INTO `s_event_decision` VALUES ('34', '20161128073549', '结果存到mysql', 'mysql', '4', '20161201081422');
INSERT INTO `s_event_decision` VALUES ('35', '20161206104452', '啊啊', '', null, '20161202034819');
INSERT INTO `s_event_decision` VALUES ('36', '20161206034322', '地区信息推送至kafka', '数据处理结果存储到kafka中', '2', '20170106152505');
INSERT INTO `s_event_decision` VALUES ('37', '20161206070010', '区域信息存储', 'tomysql', '1', '20161201081422');
INSERT INTO `s_event_decision` VALUES ('38', '20161213065237', 'x决策1', '决策说明', '4', '20170112163459');
INSERT INTO `s_event_decision` VALUES ('39', '20161219155710', 'test_decode', 'test_decode', '1', '20161129175508');
INSERT INTO `s_event_decision` VALUES ('41', '20161220161859', '事件1决策', '事件1决策', null, '20161202034819');
INSERT INTO `s_event_decision` VALUES ('42', '20161220162921', '事件demo决策', '事件demo决策', null, '20161202034819');
INSERT INTO `s_event_decision` VALUES ('43', '20161221113515', '啊啊', '', null, '20161202034819');
INSERT INTO `s_event_decision` VALUES ('44', '20161221143359', '', '', null, '20161202034819');
INSERT INTO `s_event_decision` VALUES ('45', '20161221150426', '', '', null, '20161202034819');
INSERT INTO `s_event_decision` VALUES ('46', '20170103113658', '新入网用户', '新入网用户', '1', '20170104163847');
INSERT INTO `s_event_decision` VALUES ('47', '20170109141205', '33', '33', '1', null);
INSERT INTO `s_event_decision` VALUES ('48', '20170111150635', 'oen', 'oen', '2', null);
INSERT INTO `s_event_decision` VALUES ('49', '20170116112705', 'x_localFile_decision', 'x_localFile_decision', '2', '20170116144513');
INSERT INTO `s_event_decision` VALUES ('50', '20170116162644', 'x_hdfs_decision', 'x_hdfs_decision', '2', '20170116144513');
INSERT INTO `s_event_decision` VALUES ('51', '20170117144051', '推送123', '321', '1', null);
INSERT INTO `s_event_decision` VALUES ('52', '20170116174601', 'x_socket_decision', 'x_socket_decision', '1', '20170116144513');
INSERT INTO `s_event_decision` VALUES ('53', '20170303150717', 'storm-决策', 'storm决策树', '1', null);
INSERT INTO `s_event_decision` VALUES ('54', '20170314114532', 'testa', 'testa', null, '20170314115220');
INSERT INTO `s_event_decision` VALUES ('55', '20170420112117', '推送到kafka', '推送到kafka', '1', '20170420114923');
INSERT INTO `s_event_decision` VALUES ('56', '20170420162010', '消息推送', '消息推送', '1', '20170420162547');

-- ----------------------------
-- Table structure for `s_event_decision_rule`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_decision_rule`;
CREATE TABLE `s_event_decision_rule` (
  `rule_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `decision_id` bigint(20) DEFAULT NULL,
  `table_field_engname` varchar(20) DEFAULT NULL,
  `decision_type` varchar(2) DEFAULT NULL COMMENT '决策类型：\r\n01-->基础决策\r\n02-->自定义决策',
  `decision_rule` varchar(100) DEFAULT NULL COMMENT '决策规则',
  `decision_value` varchar(100) DEFAULT NULL COMMENT '规则匹配值',
  `table_field_type` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_decision_rule
-- ----------------------------
INSERT INTO `s_event_decision_rule` VALUES ('2', '11', 'chair_count', '01', '>', '22', null);
INSERT INTO `s_event_decision_rule` VALUES ('3', '11', 'chair_count', '02', '<', '5', null);
INSERT INTO `s_event_decision_rule` VALUES ('4', '11', 'caizhi_count', '02', '<', '6', null);
INSERT INTO `s_event_decision_rule` VALUES ('5', '8', 'desk_count', '01', '>', '22', null);
INSERT INTO `s_event_decision_rule` VALUES ('6', '8', 'desk_count', '01', '==', '26', null);
INSERT INTO `s_event_decision_rule` VALUES ('7', '12', 'caizhi_count', '01', '>', '2', null);
INSERT INTO `s_event_decision_rule` VALUES ('8', '12', 'chair_count', '01', '==', '8', null);
INSERT INTO `s_event_decision_rule` VALUES ('9', '27', 'PROV_CODE', '01', 'like', '1', null);
INSERT INTO `s_event_decision_rule` VALUES ('11', '29', 'ID', '', '', '', 'VARCHAR');
INSERT INTO `s_event_decision_rule` VALUES ('12', '29', 'ID_count', '', '', '', 'INT');

-- ----------------------------
-- Table structure for `s_event_opt`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt`;
CREATE TABLE `s_event_opt` (
  `opt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) DEFAULT NULL,
  `opt_name` varchar(45) DEFAULT NULL,
  `opt_desc` varchar(45) DEFAULT NULL,
  `opt_type` varchar(2) DEFAULT NULL COMMENT 'if(event_type=01) 单事件\n            opt_type=01 提取\n            opt_type=02 过滤\n            opt_type=03 关联\n            if(event_type=02) 多事件\n            opt_type=11 聚合\n            opt_type=12 过滤\n            opt_type=13 关联\n            ',
  `opt_ord` varchar(2) DEFAULT NULL,
  `opt_num` int(3) DEFAULT '1' COMMENT '操作并行数',
  `scala_command` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`opt_id`),
  KEY `FK_Reference_8` (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=284 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt
-- ----------------------------
INSERT INTO `s_event_opt` VALUES ('6', '20160713105411', '过滤配置', '过滤配置', '01', '1', '2', null);
INSERT INTO `s_event_opt` VALUES ('7', '20160713105411', '过滤配置', '过滤配置', '02', '2', '1', null);
INSERT INTO `s_event_opt` VALUES ('8', '20160713164650', 'filter', 'f', '01', '1', '1', null);
INSERT INTO `s_event_opt` VALUES ('9', '20160713164650', 'guolv', 'guolv', '02', '2', '1', null);
INSERT INTO `s_event_opt` VALUES ('10', '20160804173844', '提取', '提取', '01', '1', '1', null);
INSERT INTO `s_event_opt` VALUES ('66', '20160913143804', 'kafka提取操作', 'kafka提取操作', '01', '1', '4', null);
INSERT INTO `s_event_opt` VALUES ('67', '20160913143804', '聚合操作', '聚合操作', '07', '2', '4', null);
INSERT INTO `s_event_opt` VALUES ('162', '20161206034322', '提取数据', '从kafka中提取出元数据', '01', '1', '2', null);
INSERT INTO `s_event_opt` VALUES ('163', '20161206034322', '过滤数据', '过滤北京地区的信息', '02', '2', '2', null);
INSERT INTO `s_event_opt` VALUES ('166', '20161206070010', '提取数据', '从kafka中提取数据', '01', '1', '6', null);
INSERT INTO `s_event_opt` VALUES ('169', '20161213065237', 'x_tq', 'x_tq', '01', '1', '4', null);
INSERT INTO `s_event_opt` VALUES ('171', '20161213065237', 'x_gl', 'storm简单事假过滤', '02', '2', '4', null);
INSERT INTO `s_event_opt` VALUES ('172', '20161213065237', 'x_js', 'storm简单事件计算', '04', '3', '4', null);
INSERT INTO `s_event_opt` VALUES ('179', '20161219113433', '', '', '01', '1', '1', null);
INSERT INTO `s_event_opt` VALUES ('180', '20161219113433', '', '', '02', '2', '1', null);
INSERT INTO `s_event_opt` VALUES ('193', '20161219075247', 'x_tq', 'x_tq', '01', '1', '4', null);
INSERT INTO `s_event_opt` VALUES ('196', '20161219075247', 'x_gl', 'x_gl', '03', '2', '4', null);
INSERT INTO `s_event_opt` VALUES ('207', '20161220023504', 'x_tq', '第一步提取', '01', '1', '4', null);
INSERT INTO `s_event_opt` VALUES ('224', '20161219155710', '', '', '01', '1', '1', null);
INSERT INTO `s_event_opt` VALUES ('226', '20170103113658', '提取', '提取', '01', '1', '3', null);
INSERT INTO `s_event_opt` VALUES ('228', '20170103113658', '过滤新入网用户', '过滤', '02', '2', '1', null);
INSERT INTO `s_event_opt` VALUES ('229', '20170103113658', '自定义操作', '自定义', '08', '3', '1', null);
INSERT INTO `s_event_opt` VALUES ('237', '20161206034322', '分组', '分组', '06', '3', '1', null);
INSERT INTO `s_event_opt` VALUES ('238', '20161206034322', '聚合', '聚合', '07', '4', '1', null);
INSERT INTO `s_event_opt` VALUES ('239', '20161206070010', '33', '33', '04', '2', '1', null);
INSERT INTO `s_event_opt` VALUES ('245', '20170116112705', 'x_TQ', 'x_TQ', '01', '1', '2', null);
INSERT INTO `s_event_opt` VALUES ('246', '20170116112705', 'x_GL', 'x_GL', '02', '2', '2', null);
INSERT INTO `s_event_opt` VALUES ('247', '20170116162644', 'x_TQ', 'x_TQ', '01', '1', '2', null);
INSERT INTO `s_event_opt` VALUES ('248', '20170116162644', 'x_GL', 'x_GL', '02', '2', '2', null);
INSERT INTO `s_event_opt` VALUES ('249', '20170116174601', 'x_TQ', 'x_TQ', '01', '1', '1', null);
INSERT INTO `s_event_opt` VALUES ('250', '20170116174601', 'x_GL', 'x_GL', '02', '2', '1', null);
INSERT INTO `s_event_opt` VALUES ('251', '20170117144051', '提取', '提取', '01', '1', '1', null);
INSERT INTO `s_event_opt` VALUES ('252', '20170117144051', '过滤', '123', '02', '2', '1', null);
INSERT INTO `s_event_opt` VALUES ('253', '20170117154218', 'x_TQ', 'x_TQ', '01', '1', '2', null);
INSERT INTO `s_event_opt` VALUES ('254', '20170117154218', 'x_GL', 'x_GL', '02', '2', '2', null);
INSERT INTO `s_event_opt` VALUES ('256', '20161219155710', '关联', '关联', '03', '2', '1', null);
INSERT INTO `s_event_opt` VALUES ('263', '20170117154218', '', '', '04', '3', '1', null);
INSERT INTO `s_event_opt` VALUES ('270', '20161213065237', 'x_analyze', 'x_analyze', '05', '4', '1', null);
INSERT INTO `s_event_opt` VALUES ('272', '20170303150717', 'getData', 'getData', '01', '1', '2', null);
INSERT INTO `s_event_opt` VALUES ('273', '20170303150717', 'filter', 'getFilter', '02', '2', '2', null);
INSERT INTO `s_event_opt` VALUES ('274', '20170303150717', '', '', '03', '3', '1', null);
INSERT INTO `s_event_opt` VALUES ('275', '20170303150717', '', '', '04', '4', '1', null);
INSERT INTO `s_event_opt` VALUES ('276', '20170303150717', '', '', '05', '5', '1', null);
INSERT INTO `s_event_opt` VALUES ('278', '20170420112117', '提取数据', '从kafka中提取数据', '01', '1', '3', null);
INSERT INTO `s_event_opt` VALUES ('279', '20170420112117', '过滤数据', '过滤出操作类型为新增的数据', '02', '2', '1', null);
INSERT INTO `s_event_opt` VALUES ('280', '20170420112117', '自定义操作', '拆分冒号，得到手机号', '08', '3', '1', null);
INSERT INTO `s_event_opt` VALUES ('281', '20170420112117', '聚合', '', '07', '4', '1', null);
INSERT INTO `s_event_opt` VALUES ('282', '20170420162010', '提取', '提取kafka中的数据', '01', '1', '1', null);
INSERT INTO `s_event_opt` VALUES ('283', '20170420162010', '过滤', '过滤', '02', '2', '1', null);

-- ----------------------------
-- Table structure for `s_event_opt_compute`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_compute`;
CREATE TABLE `s_event_opt_compute` (
  `compute_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) DEFAULT NULL,
  `compute_type` varchar(5) DEFAULT NULL,
  `compute_num` varchar(20) DEFAULT NULL,
  `compute_com` varchar(100) DEFAULT NULL,
  `compute_chnname` varchar(20) DEFAULT NULL,
  `compute_engname` varchar(40) DEFAULT NULL,
  `compute_field_type` varchar(10) DEFAULT NULL,
  `compute_field_length` varchar(10) DEFAULT NULL,
  `compute_field_desc` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`compute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_compute
-- ----------------------------
INSERT INTO `s_event_opt_compute` VALUES ('15', '172', '', '', '', 'ID', 'ID', 'VARCHAR', '50', 'ID');
INSERT INTO `s_event_opt_compute` VALUES ('16', '172', '', '', '', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE');
INSERT INTO `s_event_opt_compute` VALUES ('17', '172', '', '', '', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE');
INSERT INTO `s_event_opt_compute` VALUES ('18', '172', '', '', '', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY');
INSERT INTO `s_event_opt_compute` VALUES ('19', '172', '', '', '', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH');
INSERT INTO `s_event_opt_compute` VALUES ('20', '172', '', '', '', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS');
INSERT INTO `s_event_opt_compute` VALUES ('21', '172', '', '', '', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE');
INSERT INTO `s_event_opt_compute` VALUES ('22', '172', '', '', '', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC');
INSERT INTO `s_event_opt_compute` VALUES ('23', '172', '01', '10', '', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID');

-- ----------------------------
-- Table structure for `s_event_opt_converge`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_converge`;
CREATE TABLE `s_event_opt_converge` (
  `converge_id` bigint(30) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(30) DEFAULT NULL,
  `converge_chnname` varchar(50) DEFAULT NULL,
  `converge_engname` varchar(100) DEFAULT NULL,
  `converge_field_type` varchar(10) DEFAULT NULL,
  `converge_field_length` varchar(10) DEFAULT NULL,
  `converge_field_desc` varchar(50) DEFAULT NULL,
  `converge_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`converge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_converge
-- ----------------------------
INSERT INTO `s_event_opt_converge` VALUES ('290', '238', '编号', 'ID', 'VARCHAR', '50', '编号', '');
INSERT INTO `s_event_opt_converge` VALUES ('291', '238', '省编码', 'PROV_CODE', 'VARCHAR', '50', '省编码', '');
INSERT INTO `s_event_opt_converge` VALUES ('292', '238', '市编码', 'CITY_CODE', 'VARCHAR', '50', '市编码', '');
INSERT INTO `s_event_opt_converge` VALUES ('293', '238', '地区', 'COUNTY', 'VARCHAR', '50', '地区', '');
INSERT INTO `s_event_opt_converge` VALUES ('294', '238', '市分支', 'CITY_BRANCH', 'VARCHAR', '50', '市分支', '');
INSERT INTO `s_event_opt_converge` VALUES ('295', '238', '地址', 'ADDRESS', 'VARCHAR', '50', '地址', '');
INSERT INTO `s_event_opt_converge` VALUES ('296', '238', '编码', 'NODE_CODE', 'VARCHAR', '50', '编码', '');
INSERT INTO `s_event_opt_converge` VALUES ('297', '238', '位置区码', 'LAC', 'VARCHAR', '50', '位置区码', 'sum');
INSERT INTO `s_event_opt_converge` VALUES ('298', '238', '蜂窝ID', 'CELL_ID', 'VARCHAR', '50', '手机信号覆盖区域的的编号ID', '');
INSERT INTO `s_event_opt_converge` VALUES ('299', '238', '站名', 'STATION_NAME', 'VARCHAR', '50', '站名', '');
INSERT INTO `s_event_opt_converge` VALUES ('300', '238', '网络类型', 'NET_TYPE', 'VARCHAR', '50', '网络类型', '');
INSERT INTO `s_event_opt_converge` VALUES ('301', '238', '节点类型', 'NODE_TYPE', 'VARCHAR', '50', '节点类型', '');
INSERT INTO `s_event_opt_converge` VALUES ('302', '238', '经度', 'LONGITUDE', 'VARCHAR', '10', '经度', '');
INSERT INTO `s_event_opt_converge` VALUES ('303', '238', '纬度', 'LATITUDE', 'VARCHAR', '10', '纬度', '');
INSERT INTO `s_event_opt_converge` VALUES ('304', '238', '区域角度', 'SECTION_ANGLE', 'VARCHAR', '10', '区域角度', '');
INSERT INTO `s_event_opt_converge` VALUES ('305', '238', '区域方向', 'SECTION_DIRECT', 'VARCHAR', '10', '区域方向', '');
INSERT INTO `s_event_opt_converge` VALUES ('306', '238', '区域R', 'SECTION_R', 'VARCHAR', '10', '区域R', '');

-- ----------------------------
-- Table structure for `s_event_opt_converge_output_field`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_converge_output_field`;
CREATE TABLE `s_event_opt_converge_output_field` (
  `converge_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) DEFAULT NULL,
  `converge_chnname` varchar(50) DEFAULT NULL,
  `converge_engname` varchar(100) DEFAULT NULL,
  `converge_field_type` varchar(10) DEFAULT NULL,
  `converge_field_length` varchar(10) DEFAULT NULL,
  `converge_field_desc` varchar(50) DEFAULT NULL,
  `converge_keep` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`converge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_converge_output_field
-- ----------------------------
INSERT INTO `s_event_opt_converge_output_field` VALUES ('18', '238', '位置区码_求和', 'LAC_sum', 'INT', '100', '求和', null);

-- ----------------------------
-- Table structure for `s_event_opt_decode`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_decode`;
CREATE TABLE `s_event_opt_decode` (
  `decode_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) DEFAULT NULL,
  `decode_type` varchar(5) DEFAULT NULL,
  `decode_com` varchar(100) DEFAULT NULL,
  `decode_chnname` varchar(20) DEFAULT NULL,
  `decode_engname` varchar(40) DEFAULT NULL,
  `decode_field_type` varchar(10) DEFAULT NULL,
  `decode_field_length` varchar(10) DEFAULT NULL,
  `decode_field_desc` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`decode_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_decode
-- ----------------------------
INSERT INTO `s_event_opt_decode` VALUES ('3', '3', '', '', '手机号码', 'msisdn', 'VARCHAR', '11', '略');
INSERT INTO `s_event_opt_decode` VALUES ('4', '3', '01', '', '网址', 'url', 'VARCHAR', '500', '略');
INSERT INTO `s_event_opt_decode` VALUES ('35', '270', '', '', 'ID', 'ID', 'VARCHAR', '50', 'ID');
INSERT INTO `s_event_opt_decode` VALUES ('36', '270', '', '', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE');
INSERT INTO `s_event_opt_decode` VALUES ('37', '270', '', '', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE');
INSERT INTO `s_event_opt_decode` VALUES ('38', '270', '', '', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY');
INSERT INTO `s_event_opt_decode` VALUES ('39', '270', '', '', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH');
INSERT INTO `s_event_opt_decode` VALUES ('40', '270', '01', '北京市', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS');
INSERT INTO `s_event_opt_decode` VALUES ('41', '270', '', '', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE');
INSERT INTO `s_event_opt_decode` VALUES ('42', '270', '', '', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC');
INSERT INTO `s_event_opt_decode` VALUES ('43', '270', '', '', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID');
INSERT INTO `s_event_opt_decode` VALUES ('44', '270', '', '', 'CELL_ID的累加值', 'SUM_CELL_ID', 'VARCHAR', '50', 'CELL_ID的累加值');

-- ----------------------------
-- Table structure for `s_event_opt_filter`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_filter`;
CREATE TABLE `s_event_opt_filter` (
  `filter_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) NOT NULL,
  `filter_chnname` varchar(50) DEFAULT NULL,
  `filter_engname` varchar(100) DEFAULT NULL,
  `filter_field_type` varchar(10) DEFAULT NULL,
  `filter_field_length` varchar(10) DEFAULT NULL,
  `filter_field_desc` varchar(70) DEFAULT NULL,
  `filter_keep` varchar(1) DEFAULT '1' COMMENT '1 - 保留\n            0 - 不保留',
  `filter_type` varchar(5) DEFAULT NULL COMMENT '01 - 基础规则\n            02 - 自定义规则',
  `filter_rel` varchar(10) DEFAULT NULL,
  `filter_num` varchar(20) DEFAULT NULL,
  `filter_com` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`filter_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1233 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_filter
-- ----------------------------
INSERT INTO `s_event_opt_filter` VALUES ('133', '5', '11', '11', 'INT', '11', '11', '1', '01', '>', '11', '11');
INSERT INTO `s_event_opt_filter` VALUES ('134', '5', '22', '22', 'CHAR', '22', '22', '1', '02', 'like', '22', '22');
INSERT INTO `s_event_opt_filter` VALUES ('190', '9', '', '', '', '', '', '', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('208', '2', '', '', '', '', '', '1', '02', '', '2', '');
INSERT INTO `s_event_opt_filter` VALUES ('237', '19', 'test', 'test', 'VARCHAR', '5', '', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('238', '19', 'ttt', 'ttt', 'VARCHAR', '10', '', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('930', '171', 'ID', 'ID', 'VARCHAR', '50', 'ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('931', '171', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('932', '171', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('933', '171', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('934', '171', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('935', '171', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', '1', '01', 'like', '北京市', '北京市');
INSERT INTO `s_event_opt_filter` VALUES ('936', '171', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('937', '171', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('938', '171', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('939', '171', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('940', '171', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('941', '171', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('942', '171', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('943', '171', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('944', '171', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('945', '171', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('946', '171', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1107', '228', '标识号', 'PID', 'VARCHAR', '50', '进程标识:SCN标识号:事务ID:本地事务Id:事务标识', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1108', '228', '表名', 'TABLE_NAME', 'VARCHAR', '50', '日志发生的表名以及所属的schema', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1109', '228', '操作类型', 'OPT_TYPE', 'CHAR', '1', '操作发生的时间', null, '01', 'like', 'I', '');
INSERT INTO `s_event_opt_filter` VALUES ('1110', '228', '时间戳', 'OPT_TIME', 'VARCHAR', '50', '操作发生的时间', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1111', '228', '手机号', 'PHONENUMBER', 'VARCHAR', '50', '', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1112', '228', '交易码', 'TRADE_TYPE_CODE', 'VARCHAR', '50', '', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1113', '228', '返销', 'CANCEL_TAG', 'VARCHAR', '50', '', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1114', '228', '主键', 'ID', 'VARCHAR', '50', '', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1115', '228', '序列号', 'SERIAL_NUMBER', 'VARCHAR', '50', '', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1116', '163', '编号', 'ID', 'VARCHAR', '50', '编号', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1117', '163', '省编码', 'PROV_CODE', 'VARCHAR', '50', '省编码', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1118', '163', '市编码', 'CITY_CODE', 'VARCHAR', '50', '市编码', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1119', '163', '地区', 'COUNTY', 'VARCHAR', '50', '地区', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1120', '163', '市分支', 'CITY_BRANCH', 'VARCHAR', '50', '市分支', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1121', '163', '地址', 'ADDRESS', 'VARCHAR', '50', '地址', null, '01', 'like', '北京市', '北京');
INSERT INTO `s_event_opt_filter` VALUES ('1122', '163', '编码', 'NODE_CODE', 'VARCHAR', '50', '编码', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1123', '163', '位置区码', 'LAC', 'VARCHAR', '50', '位置区码', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1124', '163', '蜂窝ID', 'CELL_ID', 'VARCHAR', '50', '手机信号覆盖区域的的编号ID', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1125', '163', '站名', 'STATION_NAME', 'VARCHAR', '50', '站名', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1126', '163', '网络类型', 'NET_TYPE', 'VARCHAR', '50', '网络类型', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1127', '163', '节点类型', 'NODE_TYPE', 'VARCHAR', '50', '节点类型', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1128', '163', '经度', 'LONGITUDE', 'VARCHAR', '10', '经度', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1129', '163', '纬度', 'LATITUDE', 'VARCHAR', '10', '纬度', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1130', '163', '区域角度', 'SECTION_ANGLE', 'VARCHAR', '10', '区域角度', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1131', '163', '区域方向', 'SECTION_DIRECT', 'VARCHAR', '10', '区域方向', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1132', '163', '区域R', 'SECTION_R', 'VARCHAR', '10', '区域R', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1150', '246', 'ID', 'ID', 'VARCHAR', '50', 'ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1151', '246', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1152', '246', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1153', '246', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1154', '246', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1155', '246', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', '1', '01', 'like', '北京市', '');
INSERT INTO `s_event_opt_filter` VALUES ('1156', '246', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1157', '246', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1158', '246', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1159', '246', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1160', '246', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1161', '246', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1162', '246', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1163', '246', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1164', '246', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1165', '246', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1166', '246', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1167', '248', 'ID', 'ID', 'VARCHAR', '50', 'ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1168', '248', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1169', '248', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1170', '248', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1171', '248', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1172', '248', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', '1', '01', 'like', '北京市', '');
INSERT INTO `s_event_opt_filter` VALUES ('1173', '248', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1174', '248', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1175', '248', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1176', '248', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1177', '248', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1178', '248', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1179', '248', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1180', '248', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1181', '248', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1182', '248', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1183', '248', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1184', '250', 'ID', 'ID', 'VARCHAR', '50', 'ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1185', '250', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1186', '250', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1187', '250', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1188', '250', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1189', '250', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', '1', '01', 'like', '北京市', '');
INSERT INTO `s_event_opt_filter` VALUES ('1190', '250', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1191', '250', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1192', '250', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1193', '250', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1194', '250', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1195', '250', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1196', '250', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1197', '250', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1198', '250', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1199', '250', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1200', '250', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1201', '252', '姓名', 'name', 'VARCHAR', '128', '', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1202', '252', '电话', 'telno', 'VARCHAR', '64', '', '1', '01', '>', '110', '');
INSERT INTO `s_event_opt_filter` VALUES ('1203', '252', '地址', 'address', 'VARCHAR', '256', '', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1204', '254', 'ID', 'ID', 'VARCHAR', '50', 'ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1205', '254', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1206', '254', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1207', '254', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1208', '254', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1209', '254', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', '1', '01', 'like', '北京市', '');
INSERT INTO `s_event_opt_filter` VALUES ('1210', '254', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1211', '254', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1212', '254', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', '1', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1213', '254', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1214', '254', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1215', '254', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1216', '254', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1217', '254', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1218', '254', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE ', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1219', '254', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1220', '254', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', '0', '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1221', '279', '标识号', 'PID', 'VARCHAR', '50', '进程标识:SCN标识号:事务ID:本地事务Id:事务标识', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1222', '279', '表名', 'TABLE_NAME', 'VARCHAR', '50', '日志发生的表名以及所属的schema', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1223', '279', '操作类型', 'OPT_TYPE', 'CHAR', '1', '操作类型', null, '01', 'like', 'I', '');
INSERT INTO `s_event_opt_filter` VALUES ('1224', '279', '时间戳', 'OPT_TIME', 'VARCHAR', '50', '操作发生的时间', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1225', '279', '手机号', 'PHONENUMBER', 'VARCHAR', '50', '手机号', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1226', '279', '交易码', 'TRADE_TYPE_CODE', 'VARCHAR', '50', '交易码', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1227', '279', '返销', 'CANCEL_TAG', 'VARCHAR', '50', '返销标识', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1228', '279', '编码', 'ID', 'VARCHAR', '50', '编码', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1229', '279', '序列号', 'SERIAL_NUMBER', 'VARCHAR', '50', '序列号', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1230', '283', '手机号码', 'PHONE_NUMBER', 'VARCHAR', '11', '手机号码', null, '', '', '', '');
INSERT INTO `s_event_opt_filter` VALUES ('1231', '283', '蜂窝ID', 'CELL_ID', 'VARCHAR', '5', '蜂窝ID', null, '01', 'like', '40998', '');
INSERT INTO `s_event_opt_filter` VALUES ('1232', '283', '位置区码', 'LAC', 'VARCHAR', '5', '位置区码', null, '01', 'like', '57632', '');

-- ----------------------------
-- Table structure for `s_event_opt_function`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_function`;
CREATE TABLE `s_event_opt_function` (
  `function_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) DEFAULT NULL,
  `function_chnname` varchar(50) DEFAULT NULL,
  `function_engname` varchar(100) DEFAULT NULL,
  `function_field_type` varchar(10) DEFAULT NULL,
  `function_field_length` varchar(10) DEFAULT NULL,
  `function_field_desc` varchar(50) DEFAULT NULL,
  `function_keep` varchar(20) DEFAULT NULL,
  `storm_function_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`function_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_function
-- ----------------------------
INSERT INTO `s_event_opt_function` VALUES ('1', '229', '标识号', 'PID', 'VARCHAR', '50', '进程标识:SCN标识号:事务ID:本地事务Id:事务标识', '0', null);
INSERT INTO `s_event_opt_function` VALUES ('2', '229', '表名', 'TABLE_NAME', 'VARCHAR', '50', '日志发生的表名以及所属的schema', '1', '8');
INSERT INTO `s_event_opt_function` VALUES ('3', '229', '操作类型', 'OPT_TYPE', 'CHAR', '1', '操作发生的时间', '0', null);
INSERT INTO `s_event_opt_function` VALUES ('4', '229', '时间戳', 'OPT_TIME', 'VARCHAR', '50', '操作发生的时间', '0', null);
INSERT INTO `s_event_opt_function` VALUES ('5', '229', '手机号', 'PHONENUMBER', 'VARCHAR', '50', '', '1', '8');
INSERT INTO `s_event_opt_function` VALUES ('6', '229', '交易码', 'TRADE_TYPE_CODE', 'VARCHAR', '50', '', '1', '8');
INSERT INTO `s_event_opt_function` VALUES ('7', '229', '返销', 'CANCEL_TAG', 'VARCHAR', '50', '', '1', '8');
INSERT INTO `s_event_opt_function` VALUES ('8', '229', '主键', 'ID', 'VARCHAR', '50', '', '0', null);
INSERT INTO `s_event_opt_function` VALUES ('9', '229', '序列号', 'SERIAL_NUMBER', 'VARCHAR', '50', '', '1', '8');
INSERT INTO `s_event_opt_function` VALUES ('10', '280', '标识号', 'PID', 'VARCHAR', '50', '进程标识:SCN标识号:事务ID:本地事务Id:事务标识', '0', null);
INSERT INTO `s_event_opt_function` VALUES ('11', '280', '表名', 'TABLE_NAME', 'VARCHAR', '50', '日志发生的表名以及所属的schema', '1', '9');
INSERT INTO `s_event_opt_function` VALUES ('12', '280', '操作类型', 'OPT_TYPE', 'CHAR', '1', '操作类型', '0', null);
INSERT INTO `s_event_opt_function` VALUES ('13', '280', '时间戳', 'OPT_TIME', 'VARCHAR', '50', '操作发生的时间', '0', null);
INSERT INTO `s_event_opt_function` VALUES ('14', '280', '手机号', 'PHONENUMBER', 'VARCHAR', '50', '手机号', '1', '9');
INSERT INTO `s_event_opt_function` VALUES ('15', '280', '交易码', 'TRADE_TYPE_CODE', 'VARCHAR', '50', '交易码', '1', '9');
INSERT INTO `s_event_opt_function` VALUES ('16', '280', '返销', 'CANCEL_TAG', 'VARCHAR', '50', '返销标识', '1', '9');
INSERT INTO `s_event_opt_function` VALUES ('17', '280', '编码', 'ID', 'VARCHAR', '50', '编码', '0', null);
INSERT INTO `s_event_opt_function` VALUES ('18', '280', '序列号', 'SERIAL_NUMBER', 'VARCHAR', '50', '序列号', '1', '9');

-- ----------------------------
-- Table structure for `s_event_opt_function_output_field`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_function_output_field`;
CREATE TABLE `s_event_opt_function_output_field` (
  `function_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) DEFAULT NULL,
  `storm_function_id` bigint(20) DEFAULT NULL,
  `function_chnname` varchar(50) DEFAULT NULL,
  `function_engname` varchar(100) DEFAULT NULL,
  `function_field_type` varchar(10) DEFAULT NULL,
  `function_field_length` varchar(10) DEFAULT NULL,
  `function_field_desc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`function_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_function_output_field
-- ----------------------------
INSERT INTO `s_event_opt_function_output_field` VALUES ('2', '229', '8', '主键编号', 'KEY_ID', 'VARCHAR', '50', '');
INSERT INTO `s_event_opt_function_output_field` VALUES ('3', '229', '8', '手机号码', 'TELEPHONE', 'VARCHAR', '11', '');
INSERT INTO `s_event_opt_function_output_field` VALUES ('4', '280', '9', 'KEY_ID', 'KEY_ID', 'VARCHAR', '50', 'KEY_ID');
INSERT INTO `s_event_opt_function_output_field` VALUES ('5', '280', '9', '手机号码', 'TELEPHONE', 'VARCHAR', '11', '手机号');

-- ----------------------------
-- Table structure for `s_event_opt_get`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_get`;
CREATE TABLE `s_event_opt_get` (
  `get_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) DEFAULT NULL,
  `event_ds_id` bigint(20) DEFAULT NULL,
  `get_sepa` varchar(10) DEFAULT NULL,
  `get_name` varchar(20) DEFAULT NULL,
  `get_desc` varchar(100) DEFAULT NULL,
  `get_path` varchar(100) DEFAULT NULL,
  `get_topic` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`get_id`),
  KEY `FK_Reference_7` (`opt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_get
-- ----------------------------
INSERT INTO `s_event_opt_get` VALUES ('1', '1', '3', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('3', '4', '1', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('4', '4', '1', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('31', '66', '6', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('43', '162', '14', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('44', '164', '8', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('45', '166', '8', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('46', '169', '13', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('48', '185', '0', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('50', '193', '10', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('51', '207', '10', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('52', '226', '12', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('53', '224', '12', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('54', '245', '16', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('55', '247', '17', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('57', '249', '18', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('58', '251', '20', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('59', '253', '21', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('60', '278', '24', null, null, null, null, null);
INSERT INTO `s_event_opt_get` VALUES ('61', '282', '25', null, null, null, null, null);

-- ----------------------------
-- Table structure for `s_event_opt_group`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_group`;
CREATE TABLE `s_event_opt_group` (
  `group_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) NOT NULL,
  `group_chnname` varchar(50) DEFAULT NULL,
  `group_engname` varchar(20) DEFAULT NULL,
  `group_field_type` varchar(10) DEFAULT NULL,
  `group_field_length` varchar(10) DEFAULT NULL,
  `group_field_desc` varchar(20) DEFAULT NULL,
  `group_keep` varchar(15) DEFAULT NULL COMMENT 'true - ±£Áô false - ²»±£Áô',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_group
-- ----------------------------
INSERT INTO `s_event_opt_group` VALUES ('52', '237', '编号', 'ID', 'VARCHAR', '50', '编号', '0');
INSERT INTO `s_event_opt_group` VALUES ('53', '237', '省编码', 'PROV_CODE', 'VARCHAR', '50', '省编码', '0');
INSERT INTO `s_event_opt_group` VALUES ('54', '237', '市编码', 'CITY_CODE', 'VARCHAR', '50', '市编码', '0');
INSERT INTO `s_event_opt_group` VALUES ('55', '237', '地区', 'COUNTY', 'VARCHAR', '50', '地区', '1');
INSERT INTO `s_event_opt_group` VALUES ('56', '237', '市分支', 'CITY_BRANCH', 'VARCHAR', '50', '市分支', '0');
INSERT INTO `s_event_opt_group` VALUES ('57', '237', '地址', 'ADDRESS', 'VARCHAR', '50', '地址', '0');
INSERT INTO `s_event_opt_group` VALUES ('58', '237', '编码', 'NODE_CODE', 'VARCHAR', '50', '编码', '0');
INSERT INTO `s_event_opt_group` VALUES ('59', '237', '位置区码', 'LAC', 'VARCHAR', '50', '位置区码', '0');
INSERT INTO `s_event_opt_group` VALUES ('60', '237', '蜂窝ID', 'CELL_ID', 'VARCHAR', '50', '手机信号覆盖区域的的编号ID', '0');
INSERT INTO `s_event_opt_group` VALUES ('61', '237', '站名', 'STATION_NAME', 'VARCHAR', '50', '站名', '0');
INSERT INTO `s_event_opt_group` VALUES ('62', '237', '网络类型', 'NET_TYPE', 'VARCHAR', '50', '网络类型', '0');
INSERT INTO `s_event_opt_group` VALUES ('63', '237', '节点类型', 'NODE_TYPE', 'VARCHAR', '50', '节点类型', '0');
INSERT INTO `s_event_opt_group` VALUES ('64', '237', '经度', 'LONGITUDE', 'VARCHAR', '10', '经度', '0');
INSERT INTO `s_event_opt_group` VALUES ('65', '237', '纬度', 'LATITUDE', 'VARCHAR', '10', '纬度', '0');
INSERT INTO `s_event_opt_group` VALUES ('66', '237', '区域角度', 'SECTION_ANGLE', 'VARCHAR', '10', '区域角度', '0');
INSERT INTO `s_event_opt_group` VALUES ('67', '237', '区域方向', 'SECTION_DIRECT', 'VARCHAR', '10', '区域方向', '0');
INSERT INTO `s_event_opt_group` VALUES ('68', '237', '区域R', 'SECTION_R', 'VARCHAR', '10', '区域R', '0');

-- ----------------------------
-- Table structure for `s_event_opt_rel`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_rel`;
CREATE TABLE `s_event_opt_rel` (
  `rel_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) DEFAULT NULL,
  `dslink_id` bigint(20) DEFAULT NULL COMMENT '数据源id',
  `table_name` varchar(20) DEFAULT NULL,
  `rel_in_field` varchar(20) DEFAULT NULL COMMENT '关联字段',
  `rel_sour_field` varchar(20) DEFAULT NULL COMMENT '被关联字段',
  `rel_type` varchar(20) DEFAULT NULL COMMENT '连接类型',
  `link_type` varchar(20) DEFAULT NULL COMMENT '关联类型',
  `decode_type` varchar(20) DEFAULT NULL COMMENT '源字段解析方式',
  `dsTable_id` bigint(20) DEFAULT NULL COMMENT 'Êý¾ÝÔ´id',
  PRIMARY KEY (`rel_id`),
  KEY `FK_Reference_10` (`opt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_rel
-- ----------------------------

-- ----------------------------
-- Table structure for `s_event_opt_rel_table_field`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_opt_rel_table_field`;
CREATE TABLE `s_event_opt_rel_table_field` (
  `rel_table_field_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `rel_opt_id` bigint(20) DEFAULT NULL,
  `table_field_id` bigint(20) DEFAULT NULL,
  `ds_id` bigint(20) DEFAULT NULL,
  `rel_table_field_name` varchar(20) DEFAULT NULL,
  `rel_table_field_type` varchar(10) DEFAULT NULL,
  `rel_table_field_length` varchar(20) DEFAULT NULL,
  `ds_link_id` bigint(20) DEFAULT NULL,
  `db_type` varchar(20) DEFAULT NULL,
  `table_name` varchar(45) DEFAULT NULL,
  `rel_keep` varchar(2) DEFAULT '1' COMMENT '1 - 保留\n            0 - 不保留',
  PRIMARY KEY (`rel_table_field_id`),
  KEY `FK_Reference_11` (`rel_opt_id`),
  KEY `FK_Reference_15` (`table_field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1067 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_opt_rel_table_field
-- ----------------------------
INSERT INTO `s_event_opt_rel_table_field` VALUES ('983', '132', null, '16', 'id', 'INT', 'null', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('984', '132', null, '16', 'version', 'INT', 'null', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('985', '132', null, '16', 'enable', 'TINYINT', 'null', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('986', '132', null, '16', 'name', 'VARCHAR', '255', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('987', '132', null, '16', 'email', 'VARCHAR', '255', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('988', '132', null, '16', 'username', 'VARCHAR', '255', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('989', '132', null, '16', 'password', 'VARCHAR', '255', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('990', '132', null, '16', 'registerTime', 'DATETIME', 'null', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('991', '132', null, '16', 'roleId', 'INT', 'null', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('992', '132', null, '16', 'organizationId', 'INT', 'null', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('995', '168', null, '20', 'id', 'VARCHAR', '50', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('996', '168', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('997', '174', null, '20', 'id', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('998', '174', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('999', '178', null, '20', 'id', 'VARCHAR', '50', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1000', '178', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1013', '196', null, '21', 'uuid', 'VARCHAR', '100', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1014', '196', null, '21', 'ID', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1015', '196', null, '21', 'PROV_CODE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1016', '196', null, '21', 'CITY_CODE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1017', '196', null, '21', 'COUNTY', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1018', '196', null, '21', 'CITY_BRANCH', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1019', '196', null, '21', 'ADDRESS', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1020', '196', null, '21', 'NODE_CODE', 'VARCHAR', '50', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1021', '196', null, '21', 'LAC', 'VARCHAR', '50', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1022', '196', null, '21', 'CELL_ID', 'VARCHAR', '50', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1023', '196', null, '21', 'SUM_CELL_ID', 'VARCHAR', '100', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1024', '196', null, '21', 'optTime', 'VARCHAR', '100', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1025', '198', null, '20', 'id', 'VARCHAR', '50', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1026', '198', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1027', '199', null, '20', 'id', 'VARCHAR', '50', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1028', '199', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1029', '200', null, '20', 'id', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1030', '200', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1031', '201', null, '20', 'id', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1032', '201', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1033', '202', null, '20', 'id', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1034', '202', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1035', '203', null, '20', 'id', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1036', '203', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1037', '209', null, '20', 'id', 'VARCHAR', '50', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1038', '209', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1039', '210', null, '20', 'id', 'VARCHAR', '50', null, null, null, '0');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1040', '210', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1041', '242', null, '16', 'uuid', 'VARCHAR', '100', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1042', '242', null, '16', 'ID', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1043', '242', null, '16', 'PROV_CODE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1044', '242', null, '16', 'CITY_CODE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1045', '242', null, '16', 'AVG_CITY_CODE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1046', '242', null, '16', 'COUNTY', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1047', '242', null, '16', 'CITY_BRANCH', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1048', '242', null, '16', 'ADDRESS', 'VARCHAR', '100', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1049', '242', null, '16', 'NODE_CODE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1050', '242', null, '16', 'LAC', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1051', '242', null, '16', 'CELL_ID', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1052', '242', null, '16', 'STATION_NAME', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1053', '242', null, '16', 'NET_TYPE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1054', '242', null, '16', 'NODE_TYPE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1055', '242', null, '16', 'LONGITUDE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1056', '242', null, '16', 'LATITUDE', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1057', '242', null, '16', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1058', '242', null, '16', 'optTime', 'VARCHAR', '30', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1059', '256', null, '20', 'id', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1060', '256', null, '20', 'name', 'VARCHAR', '50', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1061', '255', null, '30', 'id', 'INT', 'null', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1062', '255', null, '30', 'node_code', 'VARCHAR', '255', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1063', '264', null, '30', 'id', 'INT', 'null', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1064', '264', null, '30', 'node_code', 'VARCHAR', '255', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1065', '268', null, '30', 'id', 'INT', 'null', null, null, null, '1');
INSERT INTO `s_event_opt_rel_table_field` VALUES ('1066', '268', null, '30', 'node_code', 'VARCHAR', '255', null, null, null, '1');

-- ----------------------------
-- Table structure for `s_event_response`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_response`;
CREATE TABLE `s_event_response` (
  `response_id` bigint(20) NOT NULL,
  `response_name` varchar(20) DEFAULT NULL,
  `response_type` varchar(2) DEFAULT NULL COMMENT '0---->存文件\r\n1---->存数据库\r\n2---->kafka推送',
  `response_desc` varchar(50) DEFAULT NULL,
  `host_ip` varchar(50) DEFAULT NULL,
  `user_name` varchar(10) DEFAULT NULL,
  `password` varchar(10) DEFAULT NULL,
  `host_path` varchar(20) DEFAULT NULL,
  `host_file_name` varchar(10) DEFAULT NULL,
  `db_table_id` int(11) DEFAULT NULL,
  `db_table_name` varchar(30) DEFAULT NULL,
  `is_compress` varchar(1) DEFAULT NULL,
  `compress_size` bigint(20) DEFAULT NULL,
  `kafka_topic_id` bigint(20) DEFAULT NULL,
  `creater_name_id` int(11) DEFAULT NULL,
  `creater_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`response_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_response
-- ----------------------------
INSERT INTO `s_event_response` VALUES ('20161129175508', '结果推送到kafka', '2', '处理结果储存到kafka', '', '', '', '', '', null, null, null, null, '27', '33', 'wxx');
INSERT INTO `s_event_response` VALUES ('20161201081422', '结果存到mysql', '1', '处理结果储存到mysql数据库中', '', '', '', '', '', '11', null, null, null, null, '33', 'wxx');
INSERT INTO `s_event_response` VALUES ('20161202034819', '结果存到hdfs', '0', 'hdfs', '192.168.10.37', 'hadoop', 'hadoop', 'hdfs://tmp/trident', 'newuser', null, null, '1', '5', null, null, null);
INSERT INTO `s_event_response` VALUES ('20161213082048', 'x_mysql_test', '1', 'storm简单事件响应到mysql数据库', '', '', '', '', '', '18', 'x_dbtable_test', null, null, null, null, null);
INSERT INTO `s_event_response` VALUES ('20161219160835', 'test_decode', '1', 'test_decode', '', '', '', '', '', '19', 'test_decode', null, null, null, null, null);
INSERT INTO `s_event_response` VALUES ('20170104163847', '新入网用户响应', '2', '新入网用户响应', '', '', '', '', '', null, null, null, null, '28', '33', 'wxx');
INSERT INTO `s_event_response` VALUES ('20170106152505', 'storm区域信息响应', '2', 'storm区域信息响应', '', '', '', '', '', null, null, null, null, '30', '33', 'wxx');
INSERT INTO `s_event_response` VALUES ('20170112110120', 'storm相应', '0', '测试storm的响应', 'localhost', '7077', '', '/opt/beh/core/spark', 'opt', null, null, '0', null, null, '31', 'liyongqiang');
INSERT INTO `s_event_response` VALUES ('20170112163459', 'x_response', '1', 'x_response', '', '', '', '', '', '21', 'x_db_mysql_test', null, null, null, '23', 'xieqq');
INSERT INTO `s_event_response` VALUES ('20170116144513', 'x_localFile_response', '1', 'x_localFile_response', '', '', '', '', '', '22', 'x_db_mysql_test2', null, null, null, '23', 'xieqq');
INSERT INTO `s_event_response` VALUES ('20170207144218', '响应1', '1', '', '', '', '', '', '', '25', '123', null, null, null, '24', 'bianshen');
INSERT INTO `s_event_response` VALUES ('20170314115220', 'hdfs', '0', '', '192.168.10.37', '8088', 'beh', '/rdpe', 'asd', null, null, '0', null, null, '33', 'wxx');
INSERT INTO `s_event_response` VALUES ('20170314115335', '15hdfs', '0', '', '182.168.10.15', '', '', '', '', null, null, null, null, null, '33', 'wxx');
INSERT INTO `s_event_response` VALUES ('20170420114923', '新入网用户消息推送', '2', '把处理好的新入网用户信息推送到kafka', '', '', '', '', '', null, null, null, null, '60', '33', 'wxx');
INSERT INTO `s_event_response` VALUES ('20170420162547', '区域位置信息推送', '2', '区域位置信息推送', '', '', '', '', '', null, null, null, null, '61', '25', 'admin');

-- ----------------------------
-- Table structure for `s_event_table_field`
-- ----------------------------
DROP TABLE IF EXISTS `s_event_table_field`;
CREATE TABLE `s_event_table_field` (
  `table_field_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `opt_id` bigint(20) DEFAULT NULL,
  `table_field_chnname` varchar(50) DEFAULT NULL,
  `table_field_engname` varchar(100) DEFAULT NULL,
  `table_field_type` varchar(10) DEFAULT NULL,
  `table_field_length` varchar(10) DEFAULT NULL,
  `table_field_desc` varchar(50) DEFAULT NULL,
  `parent_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`table_field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2508 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_event_table_field
-- ----------------------------
INSERT INTO `s_event_table_field` VALUES ('1353', '164', '编号', 'ID', 'VARCHAR', '50', '编号', null);
INSERT INTO `s_event_table_field` VALUES ('1354', '164', '省编码', 'PROV_CODE', 'VARCHAR', '50', '省编码', null);
INSERT INTO `s_event_table_field` VALUES ('1355', '164', '市编码', 'CITY_CODE', 'VARCHAR', '50', '市编码', null);
INSERT INTO `s_event_table_field` VALUES ('1356', '164', '地区', 'COUNTY', 'VARCHAR', '50', '地区', null);
INSERT INTO `s_event_table_field` VALUES ('1357', '164', '市分支', 'CITY_BRANCH', 'VARCHAR', '50', '市分支', null);
INSERT INTO `s_event_table_field` VALUES ('1358', '164', '地址', 'ADDRESS', 'VARCHAR', '50', '地址', null);
INSERT INTO `s_event_table_field` VALUES ('1359', '164', '编码', 'NODE_CODE', 'VARCHAR', '50', '编码', null);
INSERT INTO `s_event_table_field` VALUES ('1360', '164', '位置区码', 'LAC', 'VARCHAR', '50', '位置区码', null);
INSERT INTO `s_event_table_field` VALUES ('1361', '164', '蜂窝ID', 'CELL_ID', 'VARCHAR', '50', '蜂窝ID', null);
INSERT INTO `s_event_table_field` VALUES ('1362', '164', '站名', 'STATION_NAME', 'VARCHAR', '50', '站名', null);
INSERT INTO `s_event_table_field` VALUES ('1363', '164', '网络类型', 'NET_TYPE', 'VARCHAR', '50', '网络类型', null);
INSERT INTO `s_event_table_field` VALUES ('1364', '164', '节点类型', 'NODE_TYPE', 'VARCHAR', '50', '节点类型', null);
INSERT INTO `s_event_table_field` VALUES ('1365', '164', '经度', 'LONGITUDE', 'VARCHAR', '10', '经度', null);
INSERT INTO `s_event_table_field` VALUES ('1366', '164', '纬度', 'LATITUDE', 'VARCHAR', '10', '纬度', null);
INSERT INTO `s_event_table_field` VALUES ('1367', '164', '区域角度', 'SECTION_ANGLE', 'VARCHAR', '10', '区域角度', null);
INSERT INTO `s_event_table_field` VALUES ('1368', '164', '区域方向', 'SECTION_DIRECT', 'VARCHAR', '10', '区域方向', null);
INSERT INTO `s_event_table_field` VALUES ('1369', '164', '区域R', 'SECTION_R', 'VARCHAR', '10', '区域R', null);
INSERT INTO `s_event_table_field` VALUES ('1418', '166', '编号', 'ID', 'VARCHAR', '50', '编号', null);
INSERT INTO `s_event_table_field` VALUES ('1419', '166', '省编码', 'PROV_CODE', 'VARCHAR', '50', '省编码', null);
INSERT INTO `s_event_table_field` VALUES ('1420', '166', '市编码', 'CITY_CODE', 'VARCHAR', '50', '市编码', null);
INSERT INTO `s_event_table_field` VALUES ('1421', '166', '地区', 'COUNTY', 'VARCHAR', '50', '地区', null);
INSERT INTO `s_event_table_field` VALUES ('1422', '166', '市分支', 'CITY_BRANCH', 'VARCHAR', '50', '市分支', null);
INSERT INTO `s_event_table_field` VALUES ('1423', '166', '地址', 'ADDRESS', 'VARCHAR', '50', '地址', null);
INSERT INTO `s_event_table_field` VALUES ('1424', '166', '编码', 'NODE_CODE', 'VARCHAR', '50', '编码', null);
INSERT INTO `s_event_table_field` VALUES ('1425', '166', '位置区码', 'LAC', 'VARCHAR', '50', '位置区码', null);
INSERT INTO `s_event_table_field` VALUES ('1426', '166', '蜂窝ID', 'CELL_ID', 'VARCHAR', '50', '蜂窝ID', null);
INSERT INTO `s_event_table_field` VALUES ('1427', '166', '站名', 'STATION_NAME', 'VARCHAR', '50', '站名', null);
INSERT INTO `s_event_table_field` VALUES ('1428', '166', '网络类型', 'NET_TYPE', 'VARCHAR', '50', '网络类型', null);
INSERT INTO `s_event_table_field` VALUES ('1429', '166', '节点类型', 'NODE_TYPE', 'VARCHAR', '50', '节点类型', null);
INSERT INTO `s_event_table_field` VALUES ('1430', '166', '经度', 'LONGITUDE', 'VARCHAR', '10', '经度', null);
INSERT INTO `s_event_table_field` VALUES ('1431', '166', '纬度', 'LATITUDE', 'VARCHAR', '10', '纬度', null);
INSERT INTO `s_event_table_field` VALUES ('1432', '166', '区域角度', 'SECTION_ANGLE', 'VARCHAR', '10', '区域角度', null);
INSERT INTO `s_event_table_field` VALUES ('1433', '166', '区域方向', 'SECTION_DIRECT', 'VARCHAR', '10', '区域方向', null);
INSERT INTO `s_event_table_field` VALUES ('1434', '166', '区域R', 'SECTION_R', 'VARCHAR', '10', '区域R', null);
INSERT INTO `s_event_table_field` VALUES ('1563', '172', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('1564', '172', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1565', '172', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1566', '172', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('1567', '172', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('1568', '172', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('1569', '172', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1570', '172', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('1571', '172', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('1572', '172', 'CELL_ID的累加值', 'SUM_CELL_ID', 'VARCHAR', '50', 'CELL_ID的累加值', null);
INSERT INTO `s_event_table_field` VALUES ('1657', '171', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('1658', '171', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1659', '171', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1660', '171', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('1661', '171', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('1662', '171', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('1663', '171', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1664', '171', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('1665', '171', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('1786', '185', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('1787', '185', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1788', '185', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1789', '185', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('1790', '185', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('1791', '185', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('1792', '185', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1793', '185', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('1794', '185', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('1795', '185', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', null);
INSERT INTO `s_event_table_field` VALUES ('1796', '185', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('1797', '185', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('1798', '185', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('1799', '185', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('1800', '185', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', null);
INSERT INTO `s_event_table_field` VALUES ('1801', '185', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', null);
INSERT INTO `s_event_table_field` VALUES ('1802', '185', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', null);
INSERT INTO `s_event_table_field` VALUES ('1804', '193', 'ID', 'ID', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1805', '193', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1806', '193', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1807', '193', 'COUNTY', 'COUNTY', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1808', '193', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1809', '193', 'ADDRESS', 'ADDRESS ', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1810', '193', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1811', '193', 'LAC', 'LAC', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1812', '193', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1813', '193', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1814', '193', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1815', '193', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1816', '193', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1817', '193', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1818', '193', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1819', '193', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1820', '193', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('1877', '207', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('1878', '207', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1879', '207', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1880', '207', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('1881', '207', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('1882', '207', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('1883', '207', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('1884', '207', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('1885', '207', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('1886', '207', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', null);
INSERT INTO `s_event_table_field` VALUES ('1887', '207', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('1888', '207', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('1889', '207', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('1890', '207', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('1891', '207', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', null);
INSERT INTO `s_event_table_field` VALUES ('1892', '207', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', null);
INSERT INTO `s_event_table_field` VALUES ('1893', '207', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', null);
INSERT INTO `s_event_table_field` VALUES ('2035', '226', '标识号', 'PID', 'VARCHAR', '50', '进程标识:SCN标识号:事务ID:本地事务Id:事务标识', null);
INSERT INTO `s_event_table_field` VALUES ('2036', '226', '表名', 'TABLE_NAME', 'VARCHAR', '50', '日志发生的表名以及所属的schema', null);
INSERT INTO `s_event_table_field` VALUES ('2037', '226', '操作类型', 'OPT_TYPE', 'CHAR', '1', '操作发生的时间', null);
INSERT INTO `s_event_table_field` VALUES ('2038', '226', '时间戳', 'OPT_TIME', 'VARCHAR', '50', '操作发生的时间', null);
INSERT INTO `s_event_table_field` VALUES ('2039', '226', '手机号', 'PHONENUMBER', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2040', '226', '交易码', 'TRADE_TYPE_CODE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2041', '226', '返销', 'CANCEL_TAG', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2042', '226', '主键', 'ID', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2043', '226', '序列号', 'SERIAL_NUMBER', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2053', '228', '标识号', 'PID', 'VARCHAR', '50', '进程标识:SCN标识号:事务ID:本地事务Id:事务标识', null);
INSERT INTO `s_event_table_field` VALUES ('2054', '228', '表名', 'TABLE_NAME', 'VARCHAR', '50', '日志发生的表名以及所属的schema', null);
INSERT INTO `s_event_table_field` VALUES ('2055', '228', '操作类型', 'OPT_TYPE', 'CHAR', '1', '操作发生的时间', null);
INSERT INTO `s_event_table_field` VALUES ('2056', '228', '时间戳', 'OPT_TIME', 'VARCHAR', '50', '操作发生的时间', null);
INSERT INTO `s_event_table_field` VALUES ('2057', '228', '手机号', 'PHONENUMBER', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2058', '228', '交易码', 'TRADE_TYPE_CODE', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2059', '228', '返销', 'CANCEL_TAG', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2060', '228', '主键', 'ID', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2061', '228', '序列号', 'SERIAL_NUMBER', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2064', '229', '主键编号', 'KEY_ID', 'VARCHAR', '50', '', null);
INSERT INTO `s_event_table_field` VALUES ('2065', '229', '手机号码', 'TELEPHONE', 'VARCHAR', '11', '', null);
INSERT INTO `s_event_table_field` VALUES ('2085', '162', '编号', 'ID', 'VARCHAR', '50', '编号', null);
INSERT INTO `s_event_table_field` VALUES ('2086', '162', '省编码', 'PROV_CODE', 'VARCHAR', '50', '省编码', null);
INSERT INTO `s_event_table_field` VALUES ('2087', '162', '市编码', 'CITY_CODE', 'VARCHAR', '50', '市编码', null);
INSERT INTO `s_event_table_field` VALUES ('2088', '162', '地区', 'COUNTY', 'VARCHAR', '50', '地区', null);
INSERT INTO `s_event_table_field` VALUES ('2089', '162', '市分支', 'CITY_BRANCH', 'VARCHAR', '50', '市分支', null);
INSERT INTO `s_event_table_field` VALUES ('2090', '162', '地址', 'ADDRESS', 'VARCHAR', '50', '地址', null);
INSERT INTO `s_event_table_field` VALUES ('2091', '162', '编码', 'NODE_CODE', 'VARCHAR', '50', '编码', null);
INSERT INTO `s_event_table_field` VALUES ('2092', '162', '位置区码', 'LAC', 'VARCHAR', '50', '位置区码', null);
INSERT INTO `s_event_table_field` VALUES ('2093', '162', '蜂窝ID', 'CELL_ID', 'VARCHAR', '50', '手机信号覆盖区域的的编号ID', null);
INSERT INTO `s_event_table_field` VALUES ('2094', '162', '站名', 'STATION_NAME', 'VARCHAR', '50', '站名', null);
INSERT INTO `s_event_table_field` VALUES ('2095', '162', '网络类型', 'NET_TYPE', 'VARCHAR', '50', '网络类型', null);
INSERT INTO `s_event_table_field` VALUES ('2096', '162', '节点类型', 'NODE_TYPE', 'VARCHAR', '50', '节点类型', null);
INSERT INTO `s_event_table_field` VALUES ('2097', '162', '经度', 'LONGITUDE', 'VARCHAR', '10', '经度', null);
INSERT INTO `s_event_table_field` VALUES ('2098', '162', '纬度', 'LATITUDE', 'VARCHAR', '10', '纬度', null);
INSERT INTO `s_event_table_field` VALUES ('2099', '162', '区域角度', 'SECTION_ANGLE', 'VARCHAR', '10', '区域角度', null);
INSERT INTO `s_event_table_field` VALUES ('2100', '162', '区域方向', 'SECTION_DIRECT', 'VARCHAR', '10', '区域方向', null);
INSERT INTO `s_event_table_field` VALUES ('2101', '162', '区域R', 'SECTION_R', 'VARCHAR', '10', '区域R', null);
INSERT INTO `s_event_table_field` VALUES ('2230', '163', '编号', 'ID', 'VARCHAR', '50', '编号', null);
INSERT INTO `s_event_table_field` VALUES ('2231', '163', '省编码', 'PROV_CODE', 'VARCHAR', '50', '省编码', null);
INSERT INTO `s_event_table_field` VALUES ('2232', '163', '市编码', 'CITY_CODE', 'VARCHAR', '50', '市编码', null);
INSERT INTO `s_event_table_field` VALUES ('2233', '163', '地区', 'COUNTY', 'VARCHAR', '50', '地区', null);
INSERT INTO `s_event_table_field` VALUES ('2234', '163', '市分支', 'CITY_BRANCH', 'VARCHAR', '50', '市分支', null);
INSERT INTO `s_event_table_field` VALUES ('2235', '163', '地址', 'ADDRESS', 'VARCHAR', '50', '地址', null);
INSERT INTO `s_event_table_field` VALUES ('2236', '163', '编码', 'NODE_CODE', 'VARCHAR', '50', '编码', null);
INSERT INTO `s_event_table_field` VALUES ('2237', '163', '位置区码', 'LAC', 'VARCHAR', '50', '位置区码', null);
INSERT INTO `s_event_table_field` VALUES ('2238', '163', '蜂窝ID', 'CELL_ID', 'VARCHAR', '50', '手机信号覆盖区域的的编号ID', null);
INSERT INTO `s_event_table_field` VALUES ('2239', '163', '站名', 'STATION_NAME', 'VARCHAR', '50', '站名', null);
INSERT INTO `s_event_table_field` VALUES ('2240', '163', '网络类型', 'NET_TYPE', 'VARCHAR', '50', '网络类型', null);
INSERT INTO `s_event_table_field` VALUES ('2241', '163', '节点类型', 'NODE_TYPE', 'VARCHAR', '50', '节点类型', null);
INSERT INTO `s_event_table_field` VALUES ('2242', '163', '经度', 'LONGITUDE', 'VARCHAR', '10', '经度', null);
INSERT INTO `s_event_table_field` VALUES ('2243', '163', '纬度', 'LATITUDE', 'VARCHAR', '10', '纬度', null);
INSERT INTO `s_event_table_field` VALUES ('2244', '163', '区域角度', 'SECTION_ANGLE', 'VARCHAR', '10', '区域角度', null);
INSERT INTO `s_event_table_field` VALUES ('2245', '163', '区域方向', 'SECTION_DIRECT', 'VARCHAR', '10', '区域方向', null);
INSERT INTO `s_event_table_field` VALUES ('2246', '163', '区域R', 'SECTION_R', 'VARCHAR', '10', '区域R', null);
INSERT INTO `s_event_table_field` VALUES ('2247', '237', '编号', 'ID', 'VARCHAR', '50', '编号', null);
INSERT INTO `s_event_table_field` VALUES ('2248', '237', '省编码', 'PROV_CODE', 'VARCHAR', '50', '省编码', null);
INSERT INTO `s_event_table_field` VALUES ('2249', '237', '市编码', 'CITY_CODE', 'VARCHAR', '50', '市编码', null);
INSERT INTO `s_event_table_field` VALUES ('2250', '237', '地区', 'COUNTY', 'VARCHAR', '50', '地区', null);
INSERT INTO `s_event_table_field` VALUES ('2251', '237', '市分支', 'CITY_BRANCH', 'VARCHAR', '50', '市分支', null);
INSERT INTO `s_event_table_field` VALUES ('2252', '237', '地址', 'ADDRESS', 'VARCHAR', '50', '地址', null);
INSERT INTO `s_event_table_field` VALUES ('2253', '237', '编码', 'NODE_CODE', 'VARCHAR', '50', '编码', null);
INSERT INTO `s_event_table_field` VALUES ('2254', '237', '位置区码', 'LAC', 'VARCHAR', '50', '位置区码', null);
INSERT INTO `s_event_table_field` VALUES ('2255', '237', '蜂窝ID', 'CELL_ID', 'VARCHAR', '50', '手机信号覆盖区域的的编号ID', null);
INSERT INTO `s_event_table_field` VALUES ('2256', '237', '站名', 'STATION_NAME', 'VARCHAR', '50', '站名', null);
INSERT INTO `s_event_table_field` VALUES ('2257', '237', '网络类型', 'NET_TYPE', 'VARCHAR', '50', '网络类型', null);
INSERT INTO `s_event_table_field` VALUES ('2258', '237', '节点类型', 'NODE_TYPE', 'VARCHAR', '50', '节点类型', null);
INSERT INTO `s_event_table_field` VALUES ('2259', '237', '经度', 'LONGITUDE', 'VARCHAR', '10', '经度', null);
INSERT INTO `s_event_table_field` VALUES ('2260', '237', '纬度', 'LATITUDE', 'VARCHAR', '10', '纬度', null);
INSERT INTO `s_event_table_field` VALUES ('2261', '237', '区域角度', 'SECTION_ANGLE', 'VARCHAR', '10', '区域角度', null);
INSERT INTO `s_event_table_field` VALUES ('2262', '237', '区域方向', 'SECTION_DIRECT', 'VARCHAR', '10', '区域方向', null);
INSERT INTO `s_event_table_field` VALUES ('2263', '237', '区域R', 'SECTION_R', 'VARCHAR', '10', '区域R', null);
INSERT INTO `s_event_table_field` VALUES ('2268', '238', '地区', 'COUNTY', 'VARCHAR', '50', '地区', null);
INSERT INTO `s_event_table_field` VALUES ('2269', '238', '位置区码_求和', 'LAC_sum', 'INT', '100', '求和', null);
INSERT INTO `s_event_table_field` VALUES ('2276', '169', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2277', '169', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2278', '169', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2279', '169', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2280', '169', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2281', '169', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2282', '169', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2283', '169', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2284', '169', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2285', '169', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', null);
INSERT INTO `s_event_table_field` VALUES ('2286', '169', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2287', '169', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2288', '169', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2289', '169', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2290', '169', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', null);
INSERT INTO `s_event_table_field` VALUES ('2291', '169', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', null);
INSERT INTO `s_event_table_field` VALUES ('2292', '169', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', null);
INSERT INTO `s_event_table_field` VALUES ('2293', '245', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2294', '245', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2295', '245', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2296', '245', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2297', '245', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2298', '245', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2299', '245', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2300', '245', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2301', '245', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2302', '245', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', null);
INSERT INTO `s_event_table_field` VALUES ('2303', '245', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2304', '245', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2305', '245', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2306', '245', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2307', '245', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', null);
INSERT INTO `s_event_table_field` VALUES ('2308', '245', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', null);
INSERT INTO `s_event_table_field` VALUES ('2309', '245', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', null);
INSERT INTO `s_event_table_field` VALUES ('2327', '246', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2328', '246', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2329', '246', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2330', '246', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2331', '246', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2332', '246', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2333', '246', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2334', '246', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2335', '246', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2336', '247', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2337', '247', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2338', '247', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2339', '247', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2340', '247', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2341', '247', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2342', '247', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2343', '247', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2344', '247', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2345', '247', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', null);
INSERT INTO `s_event_table_field` VALUES ('2346', '247', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2347', '247', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2348', '247', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2349', '247', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2350', '247', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', null);
INSERT INTO `s_event_table_field` VALUES ('2351', '247', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', null);
INSERT INTO `s_event_table_field` VALUES ('2352', '247', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', null);
INSERT INTO `s_event_table_field` VALUES ('2353', '248', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2354', '248', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2355', '248', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2356', '248', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2357', '248', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2358', '248', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2359', '248', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2360', '248', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2361', '248', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2372', '249', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2373', '249', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2374', '249', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2375', '249', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2376', '249', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2377', '249', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2378', '249', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2379', '249', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2380', '249', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2381', '249', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', null);
INSERT INTO `s_event_table_field` VALUES ('2382', '249', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2383', '249', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2384', '249', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2385', '249', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2386', '249', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE', null);
INSERT INTO `s_event_table_field` VALUES ('2387', '249', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', null);
INSERT INTO `s_event_table_field` VALUES ('2388', '249', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', null);
INSERT INTO `s_event_table_field` VALUES ('2389', '250', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2390', '250', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2391', '250', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2392', '250', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2393', '250', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2394', '250', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2395', '250', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2396', '250', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2397', '250', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2403', '224', '字段一', 'fieldOne', 'VARCHAR', '20', '', null);
INSERT INTO `s_event_table_field` VALUES ('2404', '224', '字段二', 'fieldTwo', 'VARCHAR', '20', '', null);
INSERT INTO `s_event_table_field` VALUES ('2405', '224', '字段三', 'fieldThree', 'VARCHAR', '20', '', null);
INSERT INTO `s_event_table_field` VALUES ('2406', '224', '字段四', 'fieldFour', 'VARCHAR', '20', '', null);
INSERT INTO `s_event_table_field` VALUES ('2407', '224', '字段五', 'fieldFive', 'VARCHAR', '20', '', null);
INSERT INTO `s_event_table_field` VALUES ('2408', '251', '姓名', 'name', 'VARCHAR', '128', '', null);
INSERT INTO `s_event_table_field` VALUES ('2409', '251', '电话', 'telno', 'VARCHAR', '64', '', null);
INSERT INTO `s_event_table_field` VALUES ('2410', '251', '地址', 'address', 'VARCHAR', '256', '', null);
INSERT INTO `s_event_table_field` VALUES ('2411', '252', '姓名', 'name', 'VARCHAR', '128', '', null);
INSERT INTO `s_event_table_field` VALUES ('2412', '252', '电话', 'telno', 'VARCHAR', '64', '', null);
INSERT INTO `s_event_table_field` VALUES ('2413', '252', '地址', 'address', 'VARCHAR', '256', '', null);
INSERT INTO `s_event_table_field` VALUES ('2414', '253', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2415', '253', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2416', '253', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2417', '253', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2418', '253', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2419', '253', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2420', '253', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2421', '253', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2422', '253', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2423', '253', 'STATION_NAME', 'STATION_NAME', 'VARCHAR', '50', 'STATION_NAME', null);
INSERT INTO `s_event_table_field` VALUES ('2424', '253', 'NET_TYPE', 'NET_TYPE', 'VARCHAR', '50', 'NET_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2425', '253', 'NODE_TYPE', 'NODE_TYPE', 'VARCHAR', '50', 'NODE_TYPE', null);
INSERT INTO `s_event_table_field` VALUES ('2426', '253', 'LONGITUDE', 'LONGITUDE', 'VARCHAR', '50', 'LONGITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2427', '253', 'LATITUDE', 'LATITUDE', 'VARCHAR', '50', 'LATITUDE', null);
INSERT INTO `s_event_table_field` VALUES ('2428', '253', 'SECTION_ANGLE', 'SECTION_ANGLE', 'VARCHAR', '50', 'SECTION_ANGLE ', null);
INSERT INTO `s_event_table_field` VALUES ('2429', '253', 'SECTION_DIRECT', 'SECTION_DIRECT', 'VARCHAR', '50', 'SECTION_DIRECT', null);
INSERT INTO `s_event_table_field` VALUES ('2430', '253', 'SECTION_R', 'SECTION_R', 'VARCHAR', '50', 'SECTION_R', null);
INSERT INTO `s_event_table_field` VALUES ('2431', '254', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2432', '254', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2433', '254', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2434', '254', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2435', '254', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2436', '254', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2437', '254', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2438', '254', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2439', '254', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2471', '270', 'ID', 'ID', 'VARCHAR', '50', 'ID', null);
INSERT INTO `s_event_table_field` VALUES ('2472', '270', 'PROV_CODE', 'PROV_CODE', 'VARCHAR', '50', 'PROV_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2473', '270', 'CITY_CODE', 'CITY_CODE', 'VARCHAR', '50', 'CITY_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2474', '270', 'COUNTY', 'COUNTY', 'VARCHAR', '50', 'COUNTY', null);
INSERT INTO `s_event_table_field` VALUES ('2475', '270', 'CITY_BRANCH', 'CITY_BRANCH', 'VARCHAR', '50', 'CITY_BRANCH', null);
INSERT INTO `s_event_table_field` VALUES ('2476', '270', 'ADDRESS', 'ADDRESS', 'VARCHAR', '50', 'ADDRESS', null);
INSERT INTO `s_event_table_field` VALUES ('2477', '270', 'ADDRESS的解析值', 'DECODE_ADDRESS', 'VARCHAR', '50', 'ADDRESS的解析值', null);
INSERT INTO `s_event_table_field` VALUES ('2478', '270', 'NODE_CODE', 'NODE_CODE', 'VARCHAR', '50', 'NODE_CODE', null);
INSERT INTO `s_event_table_field` VALUES ('2479', '270', 'LAC', 'LAC', 'VARCHAR', '50', 'LAC', null);
INSERT INTO `s_event_table_field` VALUES ('2480', '270', 'CELL_ID', 'CELL_ID', 'VARCHAR', '50', 'CELL_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2481', '270', 'CELL_ID的累加值', 'SUM_CELL_ID', 'VARCHAR', '50', 'CELL_ID的累加值', null);
INSERT INTO `s_event_table_field` VALUES ('2482', '278', '标识号', 'PID', 'VARCHAR', '50', '进程标识:SCN标识号:事务ID:本地事务Id:事务标识', null);
INSERT INTO `s_event_table_field` VALUES ('2483', '278', '表名', 'TABLE_NAME', 'VARCHAR', '50', '日志发生的表名以及所属的schema', null);
INSERT INTO `s_event_table_field` VALUES ('2484', '278', '操作类型', 'OPT_TYPE', 'CHAR', '1', '操作类型', null);
INSERT INTO `s_event_table_field` VALUES ('2485', '278', '时间戳', 'OPT_TIME', 'VARCHAR', '50', '操作发生的时间', null);
INSERT INTO `s_event_table_field` VALUES ('2486', '278', '手机号', 'PHONENUMBER', 'VARCHAR', '50', '手机号', null);
INSERT INTO `s_event_table_field` VALUES ('2487', '278', '交易码', 'TRADE_TYPE_CODE', 'VARCHAR', '50', '交易码', null);
INSERT INTO `s_event_table_field` VALUES ('2488', '278', '返销', 'CANCEL_TAG', 'VARCHAR', '50', '返销标识', null);
INSERT INTO `s_event_table_field` VALUES ('2489', '278', '编码', 'ID', 'VARCHAR', '50', '编码', null);
INSERT INTO `s_event_table_field` VALUES ('2490', '278', '序列号', 'SERIAL_NUMBER', 'VARCHAR', '50', '序列号', null);
INSERT INTO `s_event_table_field` VALUES ('2491', '279', '标识号', 'PID', 'VARCHAR', '50', '进程标识:SCN标识号:事务ID:本地事务Id:事务标识', null);
INSERT INTO `s_event_table_field` VALUES ('2492', '279', '表名', 'TABLE_NAME', 'VARCHAR', '50', '日志发生的表名以及所属的schema', null);
INSERT INTO `s_event_table_field` VALUES ('2493', '279', '操作类型', 'OPT_TYPE', 'CHAR', '1', '操作类型', null);
INSERT INTO `s_event_table_field` VALUES ('2494', '279', '时间戳', 'OPT_TIME', 'VARCHAR', '50', '操作发生的时间', null);
INSERT INTO `s_event_table_field` VALUES ('2495', '279', '手机号', 'PHONENUMBER', 'VARCHAR', '50', '手机号', null);
INSERT INTO `s_event_table_field` VALUES ('2496', '279', '交易码', 'TRADE_TYPE_CODE', 'VARCHAR', '50', '交易码', null);
INSERT INTO `s_event_table_field` VALUES ('2497', '279', '返销', 'CANCEL_TAG', 'VARCHAR', '50', '返销标识', null);
INSERT INTO `s_event_table_field` VALUES ('2498', '279', '编码', 'ID', 'VARCHAR', '50', '编码', null);
INSERT INTO `s_event_table_field` VALUES ('2499', '279', '序列号', 'SERIAL_NUMBER', 'VARCHAR', '50', '序列号', null);
INSERT INTO `s_event_table_field` VALUES ('2500', '280', 'KEY_ID', 'KEY_ID', 'VARCHAR', '50', 'KEY_ID', null);
INSERT INTO `s_event_table_field` VALUES ('2501', '280', '手机号码', 'TELEPHONE', 'VARCHAR', '11', '手机号', null);
INSERT INTO `s_event_table_field` VALUES ('2502', '282', '手机号码', 'PHONE_NUMBER', 'VARCHAR', '11', '手机号码', null);
INSERT INTO `s_event_table_field` VALUES ('2503', '282', '蜂窝ID', 'CELL_ID', 'VARCHAR', '5', '蜂窝ID', null);
INSERT INTO `s_event_table_field` VALUES ('2504', '282', '位置区码', 'LAC', 'VARCHAR', '5', '位置区码', null);
INSERT INTO `s_event_table_field` VALUES ('2505', '283', '手机号码', 'PHONE_NUMBER', 'VARCHAR', '11', '手机号码', null);
INSERT INTO `s_event_table_field` VALUES ('2506', '283', '蜂窝ID', 'CELL_ID', 'VARCHAR', '5', '蜂窝ID', null);
INSERT INTO `s_event_table_field` VALUES ('2507', '283', '位置区码', 'LAC', 'VARCHAR', '5', '位置区码', null);

-- ----------------------------
-- Table structure for `s_flume_cluster`
-- ----------------------------
DROP TABLE IF EXISTS `s_flume_cluster`;
CREATE TABLE `s_flume_cluster` (
  `cluster_id` int(11) NOT NULL AUTO_INCREMENT,
  `cluster_name` varchar(255) NOT NULL,
  `cluster_status` varchar(255) NOT NULL,
  `cluster_source` varchar(255) DEFAULT NULL,
  `cluster_sink` varchar(255) DEFAULT NULL,
  `cluster_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cluster_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_flume_cluster
-- ----------------------------
INSERT INTO `s_flume_cluster` VALUES ('1', '测试', '0', null, null, '测试');
INSERT INTO `s_flume_cluster` VALUES ('2', 'first', '0', null, null, '添加测试');
INSERT INTO `s_flume_cluster` VALUES ('3', 'new cluster', '0', null, null, '创建测试');
INSERT INTO `s_flume_cluster` VALUES ('4', 'clusterId', '0', null, null, '返回id测试');
INSERT INTO `s_flume_cluster` VALUES ('5', 'file_hdfs', '0', null, null, '编辑测试');

-- ----------------------------
-- Table structure for `s_flume_cluster_relation`
-- ----------------------------
DROP TABLE IF EXISTS `s_flume_cluster_relation`;
CREATE TABLE `s_flume_cluster_relation` (
  `relation_id` int(11) NOT NULL AUTO_INCREMENT,
  `cluster_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `collector_id` int(11) NOT NULL,
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_flume_cluster_relation
-- ----------------------------

-- ----------------------------
-- Table structure for `s_flume_dataflow`
-- ----------------------------
DROP TABLE IF EXISTS `s_flume_dataflow`;
CREATE TABLE `s_flume_dataflow` (
  `flow_id` int(11) NOT NULL AUTO_INCREMENT,
  `flow_name` varchar(255) NOT NULL,
  `flow_host` int(11) NOT NULL,
  `flow_description` varchar(255) DEFAULT NULL,
  `flow_home` varchar(255) DEFAULT NULL,
  `flow_separator` varchar(255) NOT NULL,
  `flow_status` varchar(255) NOT NULL DEFAULT '0',
  `flow_pid` varchar(255) DEFAULT '',
  `flow_port` varchar(255) DEFAULT NULL,
  `flow_backup` varchar(5) NOT NULL DEFAULT '1',
  `flow_prop` blob,
  `flow_add` varchar(255) DEFAULT NULL,
  `flow_kafkaId` int(11) DEFAULT NULL,
  `flow_propname` varchar(255) DEFAULT NULL,
  `flow_describtion` varchar(255) DEFAULT NULL,
  `flow_monitor_port` varchar(255) DEFAULT NULL,
  `flow_level` varchar(255) DEFAULT NULL,
  `flow_cluster_id` int(11) DEFAULT NULL,
  `flow_user_id` int(20) DEFAULT NULL,
  `flow_user_name` varchar(30) DEFAULT NULL,
  `host_cluster_id` int(30) DEFAULT NULL,
  PRIMARY KEY (`flow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_flume_dataflow
-- ----------------------------
INSERT INTO `s_flume_dataflow` VALUES ('36', 'storm数据流', '2', null, null, '|', '0', null, null, '1', 0x7B226368616E6E656C223A7B7D2C22666C6F774E616D65223A2273746F726DE695B0E68DAEE6B581222C2273696E6B223A7B2253696E6B31223A5B7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE98089E68BA9E599A8E7B1BBE59E8B222C22706172616D56616C7565223A226F72672E6170616368652E666C756D652E73696E6B2E6B61666B612E4B61666B6153696E6B227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2262726F6B65724C697374222C22706172616D5573616765223A2242726F6B657228686F73746E616D653A706F7274E6A0BCE5BC8F29E58897E8A1A8EFBC8CE5A49AE4B8AA42726F6B6572E4B98BE997B4E4BBA5E98097E58FB7E58886E99A94222C22706172616D56616C7565223A223139322E3136382E31302E33373A393039322C3139322E3136382E31302E33383A393039322C3139322E3136382E31302E33393A39303932227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C222C22706172616D5573616765223A22E695B0E68DAEE9809AE98193222C22706172616D56616C7565223A226368616E6E656C227D2C7B22706172616D44656661756C74223A2264656661756C742D666C756D652D746F706963222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22746F706963222C22706172616D5573616765223A22E6B688E681AFE4B8BBE9A298222C22706172616D56616C7565223A224B61666B6153746F726D32227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E5A484E79086E7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2231222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22726571756972656441636B73222C22706172616D5573616765223A22E6B688E681AFE5BA94E7AD94E6A8A1E5BC8FEFBC9A312CE7AD89E5BE856C6561646572E5BA94E7AD943B302CE4B88DE7AD89E5BE85E5BA94E7AD943B2D312CE7AD89E5BE85E68980E69C89736572766572E5BA94E7AD9428E981BFE5858D6C6561646572E5A4B1E69588E697B6E695B0E68DAEE4B8A2E5A4B129222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A224F74686572204B61666B612050726F64756365722050726F70657274696573222C22706172616D5573616765223A2250726F6475636572E58F82E695B0E9858DE7BDAEEFBC8CE4BBA520E280986B61666B612EE2809920E5819AE4B8BAE58F82E695B0E5898DE7BC80222C22706172616D56616C7565223A22227D5D7D2C22736F75726365223A7B22536F7572636531223A5B7B22706172616D44656661756C74223A2273706F6F6C646972222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE6BA90E7B1BBE59E8B222C22706172616D56616C7565223A2273706F6F6C646972227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C73222C22706172616D5573616765223A22E695B0E68DAEE6BA90E9809AE98193222C22706172616D56616C7565223A226368616E6E656C73227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2273706F6F6C446972222C22706172616D5573616765223A22E69687E4BBB6E69DA5E6BA90222C22706172616D56616C7565223A222F6F70742F6265682F636F72652F666C756D652F72647065227D2C7B22706172616D44656661756C74223A222E434F4D504C45544544222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65537566666978222C22706172616D5573616765223A22E69687E4BBB6E5908EE7BC80222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226E65766572222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2264656C657465506F6C696379222C22706172616D5573616765223A22E588A0E999A4E7AD96E795A5EFBC8C6E65766572E68896E88085696D6D656469617465222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E58C85E590ABE5AD98E582A8E7BB9DE5AFB9E8B7AFE5BE84E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266696C65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C654865616465724B6579222C22706172616D5573616765223A22E4B8BAE4BA8BE4BBB6E5A4B4E8BFBDE58AA0E585A8E8B7AFE5BE84E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E5AD98E582A8E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22626173656E616D65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D654865616465724B6579222C22706172616D5573616765223A22E4BA8BE4BBB6E5A4B4E8BFBDE58AA0E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225E24222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2269676E6F72655061747465726E222C22706172616D5573616765223A22E8BF87E6BBA4E8A2ABE5BFBDE795A5E69687E4BBB6E79A84E6ADA3E58899E8A1A8E8BEBEE5BC8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E666C756D6573706F6F6C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22747261636B6572446972222C22706172616D5573616765223A22E5AD98E582A8E8A2ABE5A484E79086E69687E4BBB6E58583E695B0E68DAEE79A84E79BAEE5BD95222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226F6C64657374222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22636F6E73756D654F72646572222C22706172616D5573616765223A22E69687E4BBB6E5A484E79086E9A1BAE5BA8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2234303030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226D61784261636B6F6666222C22706172616D5573616765223A22E9809AE98193E58DA0E6BBA1E697B6E4BA8BE4BBB6E7AD89E5BE85E58699E585A5E9809AE98193E79A84E69C80E5A4A7E697B6E997B4E997B4E99A9428E6AFABE7A79229222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E9878FE8BDACE7A7BBE7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225554462D38222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E70757443686172736574222C22706172616D5573616765223A22E8A7A3E69E90E8BE93E585A5E69687E4BBB6E79A84E5AD97E7ACA6E99B86222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224641494C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226465636F64654572726F72506F6C696379222C22706172616D5573616765223A22E5AD97E7ACA6E8A7A3E7A081E5A4B1E69588E697B6E79A84E5A484E79086E7AD96E795A5222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224C494E45222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22646573657269616C697A6572222C22706172616D5573616765223A22E69687E4BBB6E8A7A3E69E90E4B8BAE4BA8BE4BBB6E697B6E79A84E98086E5BA8FE58897E58C96E599A8222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A227265706C69636174696E67222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2273656C6563746F722E74797065222C22706172616D5573616765223A22E98089E68BA9E599A8E7B1BBE59E8BEFBC8C7265706C69636174696E67E68896E880856D756C7469706C6578696E67222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E746572636570746F7273222C22706172616D5573616765223A22E68BA6E688AAE599A828E5A49AE4B8AAE68BA6E688AAE599A8E4B98BE997B4E794A8E7A9BAE6A0BCE58886E99A9429222C22706172616D56616C7565223A22227D5D7D7D, null, null, null, null, null, 'single', null, '33', 'wxx', '1');
INSERT INTO `s_flume_dataflow` VALUES ('37', '22', '1', null, null, '22', '0', null, null, '1', 0x7B226368616E6E656C223A7B7D2C22666C6F774E616D65223A223232222C2273696E6B223A7B226161223A5B7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE98089E68BA9E599A8E7B1BBE59E8B222C22706172616D56616C7565223A226F72672E6170616368652E666C756D652E73696E6B2E6B61666B612E4B61666B6153696E6B227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2262726F6B65724C697374222C22706172616D5573616765223A2242726F6B657228686F73746E616D653A706F7274E6A0BCE5BC8F29E58897E8A1A8EFBC8CE5A49AE4B8AA42726F6B6572E4B98BE997B4E4BBA5E98097E58FB7E58886E99A94222C22706172616D56616C7565223A223139322E313638227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C222C22706172616D5573616765223A22E695B0E68DAEE9809AE98193222C22706172616D56616C7565223A2261227D2C7B22706172616D44656661756C74223A2264656661756C742D666C756D652D746F706963222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22746F706963222C22706172616D5573616765223A22E6B688E681AFE4B8BBE9A298222C22706172616D56616C7565223A2261227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E5A484E79086E7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2231222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22726571756972656441636B73222C22706172616D5573616765223A22E6B688E681AFE5BA94E7AD94E6A8A1E5BC8FEFBC9A312CE7AD89E5BE856C6561646572E5BA94E7AD943B302CE4B88DE7AD89E5BE85E5BA94E7AD943B2D312CE7AD89E5BE85E68980E69C89736572766572E5BA94E7AD9428E981BFE5858D6C6561646572E5A4B1E69588E697B6E695B0E68DAEE4B8A2E5A4B129222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A224F74686572204B61666B612050726F64756365722050726F70657274696573222C22706172616D5573616765223A2250726F6475636572E58F82E695B0E9858DE7BDAEEFBC8CE4BBA520E280986B61666B612EE2809920E5819AE4B8BAE58F82E695B0E5898DE7BC80222C22706172616D56616C7565223A22227D5D7D2C22736F75726365223A7B226161223A5B7B22706172616D44656661756C74223A2273706F6F6C646972222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE6BA90E7B1BBE59E8B222C22706172616D56616C7565223A2273706F6F6C646972227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C73222C22706172616D5573616765223A22E695B0E68DAEE6BA90E9809AE98193222C22706172616D56616C7565223A226161227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2273706F6F6C446972222C22706172616D5573616765223A22E69687E4BBB6E69DA5E6BA90222C22706172616D56616C7565223A222F6F70742F6265682F636F72652F666C756D652F72647065227D2C7B22706172616D44656661756C74223A222E434F4D504C45544544222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65537566666978222C22706172616D5573616765223A22E69687E4BBB6E5908EE7BC80222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226E65766572222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2264656C657465506F6C696379222C22706172616D5573616765223A22E588A0E999A4E7AD96E795A5EFBC8C6E65766572E68896E88085696D6D656469617465222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E58C85E590ABE5AD98E582A8E7BB9DE5AFB9E8B7AFE5BE84E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266696C65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C654865616465724B6579222C22706172616D5573616765223A22E4B8BAE4BA8BE4BBB6E5A4B4E8BFBDE58AA0E585A8E8B7AFE5BE84E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E5AD98E582A8E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22626173656E616D65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D654865616465724B6579222C22706172616D5573616765223A22E4BA8BE4BBB6E5A4B4E8BFBDE58AA0E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225E24222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2269676E6F72655061747465726E222C22706172616D5573616765223A22E8BF87E6BBA4E8A2ABE5BFBDE795A5E69687E4BBB6E79A84E6ADA3E58899E8A1A8E8BEBEE5BC8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E666C756D6573706F6F6C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22747261636B6572446972222C22706172616D5573616765223A22E5AD98E582A8E8A2ABE5A484E79086E69687E4BBB6E58583E695B0E68DAEE79A84E79BAEE5BD95222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226F6C64657374222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22636F6E73756D654F72646572222C22706172616D5573616765223A22E69687E4BBB6E5A484E79086E9A1BAE5BA8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2234303030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226D61784261636B6F6666222C22706172616D5573616765223A22E9809AE98193E58DA0E6BBA1E697B6E4BA8BE4BBB6E7AD89E5BE85E58699E585A5E9809AE98193E79A84E69C80E5A4A7E697B6E997B4E997B4E99A9428E6AFABE7A79229222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E9878FE8BDACE7A7BBE7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225554462D38222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E70757443686172736574222C22706172616D5573616765223A22E8A7A3E69E90E8BE93E585A5E69687E4BBB6E79A84E5AD97E7ACA6E99B86222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224641494C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226465636F64654572726F72506F6C696379222C22706172616D5573616765223A22E5AD97E7ACA6E8A7A3E7A081E5A4B1E69588E697B6E79A84E5A484E79086E7AD96E795A5222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224C494E45222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22646573657269616C697A6572222C22706172616D5573616765223A22E69687E4BBB6E8A7A3E69E90E4B8BAE4BA8BE4BBB6E697B6E79A84E98086E5BA8FE58897E58C96E599A8222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A227265706C69636174696E67222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2273656C6563746F722E74797065222C22706172616D5573616765223A22E98089E68BA9E599A8E7B1BBE59E8BEFBC8C7265706C69636174696E67E68896E880856D756C7469706C6578696E67222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E746572636570746F7273222C22706172616D5573616765223A22E68BA6E688AAE599A828E5A49AE4B8AAE68BA6E688AAE599A8E4B98BE997B4E794A8E7A9BAE6A0BCE58886E99A9429222C22706172616D56616C7565223A22227D5D7D7D, null, null, null, null, null, 'single', null, '33', 'wxx', '1');
INSERT INTO `s_flume_dataflow` VALUES ('38', '地区位置信息采集', '1', null, null, ',', '1', '8104\n', null, '0', 0x7B226368616E6E656C223A7B7D2C22666C6F774E616D65223A22E59CB0E58CBAE4BD8DE7BDAEE4BFA1E681AFE98787E99B86222C2273696E6B223A7B2273696E6B31223A5B7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE98089E68BA9E599A8E7B1BBE59E8B222C22706172616D56616C7565223A226F72672E6170616368652E666C756D652E73696E6B2E6B61666B612E4B61666B6153696E6B227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2262726F6B65724C697374222C22706172616D5573616765223A2242726F6B657228686F73746E616D653A706F7274E6A0BCE5BC8F29E58897E8A1A8EFBC8CE5A49AE4B8AA42726F6B6572E4B98BE997B4E4BBA5E98097E58FB7E58886E99A94222C22706172616D56616C7565223A223139322E3136382E31302E33373A393039322C3139322E3136382E31302E33383A393039322C3139322E3136382E31302E33393A39303932227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C222C22706172616D5573616765223A22E695B0E68DAEE9809AE98193222C22706172616D56616C7565223A226331227D2C7B22706172616D44656661756C74223A2264656661756C742D666C756D652D746F706963222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22746F706963222C22706172616D5573616765223A22E6B688E681AFE4B8BBE9A298222C22706172616D56616C7565223A224B61666B6153746F726D32227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E5A484E79086E7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2231222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22726571756972656441636B73222C22706172616D5573616765223A22E6B688E681AFE5BA94E7AD94E6A8A1E5BC8FEFBC9A312CE7AD89E5BE856C6561646572E5BA94E7AD943B302CE4B88DE7AD89E5BE85E5BA94E7AD943B2D312CE7AD89E5BE85E68980E69C89736572766572E5BA94E7AD9428E981BFE5858D6C6561646572E5A4B1E69588E697B6E695B0E68DAEE4B8A2E5A4B129222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A224F74686572204B61666B612050726F64756365722050726F70657274696573222C22706172616D5573616765223A2250726F6475636572E58F82E695B0E9858DE7BDAEEFBC8CE4BBA520E280986B61666B612EE2809920E5819AE4B8BAE58F82E695B0E5898DE7BC80222C22706172616D56616C7565223A22227D5D7D2C22736F75726365223A7B22736F7572636531223A5B7B22706172616D44656661756C74223A2273706F6F6C646972222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE6BA90E7B1BBE59E8B222C22706172616D56616C7565223A2273706F6F6C646972227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C73222C22706172616D5573616765223A22E695B0E68DAEE6BA90E9809AE98193222C22706172616D56616C7565223A226331227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2273706F6F6C446972222C22706172616D5573616765223A22E69687E4BBB6E69DA5E6BA90222C22706172616D56616C7565223A222F6F70742F6265682F6C6F67732F666C756D655F636F6C6C6563746F72227D2C7B22706172616D44656661756C74223A222E434F4D504C45544544222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65537566666978222C22706172616D5573616765223A22E69687E4BBB6E5908EE7BC80222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226E65766572222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2264656C657465506F6C696379222C22706172616D5573616765223A22E588A0E999A4E7AD96E795A5EFBC8C6E65766572E68896E88085696D6D656469617465222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E58C85E590ABE5AD98E582A8E7BB9DE5AFB9E8B7AFE5BE84E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266696C65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C654865616465724B6579222C22706172616D5573616765223A22E4B8BAE4BA8BE4BBB6E5A4B4E8BFBDE58AA0E585A8E8B7AFE5BE84E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E5AD98E582A8E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22626173656E616D65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D654865616465724B6579222C22706172616D5573616765223A22E4BA8BE4BBB6E5A4B4E8BFBDE58AA0E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225E24222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2269676E6F72655061747465726E222C22706172616D5573616765223A22E8BF87E6BBA4E8A2ABE5BFBDE795A5E69687E4BBB6E79A84E6ADA3E58899E8A1A8E8BEBEE5BC8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E666C756D6573706F6F6C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22747261636B6572446972222C22706172616D5573616765223A22E5AD98E582A8E8A2ABE5A484E79086E69687E4BBB6E58583E695B0E68DAEE79A84E79BAEE5BD95222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226F6C64657374222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22636F6E73756D654F72646572222C22706172616D5573616765223A22E69687E4BBB6E5A484E79086E9A1BAE5BA8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2234303030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226D61784261636B6F6666222C22706172616D5573616765223A22E9809AE98193E58DA0E6BBA1E697B6E4BA8BE4BBB6E7AD89E5BE85E58699E585A5E9809AE98193E79A84E69C80E5A4A7E697B6E997B4E997B4E99A9428E6AFABE7A79229222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E9878FE8BDACE7A7BBE7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225554462D38222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E70757443686172736574222C22706172616D5573616765223A22E8A7A3E69E90E8BE93E585A5E69687E4BBB6E79A84E5AD97E7ACA6E99B86222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224641494C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226465636F64654572726F72506F6C696379222C22706172616D5573616765223A22E5AD97E7ACA6E8A7A3E7A081E5A4B1E69588E697B6E79A84E5A484E79086E7AD96E795A5222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224C494E45222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22646573657269616C697A6572222C22706172616D5573616765223A22E69687E4BBB6E8A7A3E69E90E4B8BAE4BA8BE4BBB6E697B6E79A84E98086E5BA8FE58897E58C96E599A8222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A227265706C69636174696E67222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2273656C6563746F722E74797065222C22706172616D5573616765223A22E98089E68BA9E599A8E7B1BBE59E8BEFBC8C7265706C69636174696E67E68896E880856D756C7469706C6578696E67222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E746572636570746F7273222C22706172616D5573616765223A22E68BA6E688AAE599A828E5A49AE4B8AAE68BA6E688AAE599A8E4B98BE997B4E794A8E7A9BAE6A0BCE58886E99A9429222C22706172616D56616C7565223A22227D5D7D7D, null, null, null, null, null, 'single', '0', '26', 'root', '1');
INSERT INTO `s_flume_dataflow` VALUES ('39', 'x_flume_test', '1', null, null, '', '1', '1088\n', null, '1', 0x7B226368616E6E656C223A7B7D2C22666C6F774E616D65223A22785F666C756D655F74657374222C2273696E6B223A7B22785F666C756D655F73696E6B223A5B7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE98089E68BA9E599A8E7B1BBE59E8B222C22706172616D56616C7565223A226F72672E6170616368652E666C756D652E73696E6B2E6B61666B612E4B61666B6153696E6B227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2262726F6B65724C697374222C22706172616D5573616765223A2242726F6B657228686F73746E616D653A706F7274E6A0BCE5BC8F29E58897E8A1A8EFBC8CE5A49AE4B8AA42726F6B6572E4B98BE997B4E4BBA5E98097E58FB7E58886E99A94222C22706172616D56616C7565223A223139322E3136382E31302E33373A393039322C3139322E3136382E31302E33383A393039322C3139322E3136382E31302E33393A39303932227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C222C22706172616D5573616765223A22E695B0E68DAEE9809AE98193222C22706172616D56616C7565223A22636363227D2C7B22706172616D44656661756C74223A2264656661756C742D666C756D652D746F706963222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22746F706963222C22706172616D5573616765223A22E6B688E681AFE4B8BBE9A298222C22706172616D56616C7565223A2278466C756D65546F706963227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E5A484E79086E7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2231222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22726571756972656441636B73222C22706172616D5573616765223A22E6B688E681AFE5BA94E7AD94E6A8A1E5BC8FEFBC9A312CE7AD89E5BE856C6561646572E5BA94E7AD943B302CE4B88DE7AD89E5BE85E5BA94E7AD943B2D312CE7AD89E5BE85E68980E69C89736572766572E5BA94E7AD9428E981BFE5858D6C6561646572E5A4B1E69588E697B6E695B0E68DAEE4B8A2E5A4B129222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A224F74686572204B61666B612050726F64756365722050726F70657274696573222C22706172616D5573616765223A2250726F6475636572E58F82E695B0E9858DE7BDAEEFBC8CE4BBA520E280986B61666B612EE2809920E5819AE4B8BAE58F82E695B0E5898DE7BC80222C22706172616D56616C7565223A22227D5D7D2C22736F75726365223A7B22785F666C756D655F736F75726365223A5B7B22706172616D44656661756C74223A2273706F6F6C646972222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE6BA90E7B1BBE59E8B222C22706172616D56616C7565223A2273706F6F6C646972227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C73222C22706172616D5573616765223A22E695B0E68DAEE6BA90E9809AE98193222C22706172616D56616C7565223A22636363227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2273706F6F6C446972222C22706172616D5573616765223A22E69687E4BBB6E69DA5E6BA90222C22706172616D56616C7565223A222F6F70742F6265682F6C6F67732F78466C756D65227D2C7B22706172616D44656661756C74223A222E434F4D504C45544544222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65537566666978222C22706172616D5573616765223A22E69687E4BBB6E5908EE7BC80222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226E65766572222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2264656C657465506F6C696379222C22706172616D5573616765223A22E588A0E999A4E7AD96E795A5EFBC8C6E65766572E68896E88085696D6D656469617465222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E58C85E590ABE5AD98E582A8E7BB9DE5AFB9E8B7AFE5BE84E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266696C65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C654865616465724B6579222C22706172616D5573616765223A22E4B8BAE4BA8BE4BBB6E5A4B4E8BFBDE58AA0E585A8E8B7AFE5BE84E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E5AD98E582A8E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22626173656E616D65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D654865616465724B6579222C22706172616D5573616765223A22E4BA8BE4BBB6E5A4B4E8BFBDE58AA0E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225E24222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2269676E6F72655061747465726E222C22706172616D5573616765223A22E8BF87E6BBA4E8A2ABE5BFBDE795A5E69687E4BBB6E79A84E6ADA3E58899E8A1A8E8BEBEE5BC8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E666C756D6573706F6F6C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22747261636B6572446972222C22706172616D5573616765223A22E5AD98E582A8E8A2ABE5A484E79086E69687E4BBB6E58583E695B0E68DAEE79A84E79BAEE5BD95222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226F6C64657374222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22636F6E73756D654F72646572222C22706172616D5573616765223A22E69687E4BBB6E5A484E79086E9A1BAE5BA8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2234303030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226D61784261636B6F6666222C22706172616D5573616765223A22E9809AE98193E58DA0E6BBA1E697B6E4BA8BE4BBB6E7AD89E5BE85E58699E585A5E9809AE98193E79A84E69C80E5A4A7E697B6E997B4E997B4E99A9428E6AFABE7A79229222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E9878FE8BDACE7A7BBE7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225554462D38222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E70757443686172736574222C22706172616D5573616765223A22E8A7A3E69E90E8BE93E585A5E69687E4BBB6E79A84E5AD97E7ACA6E99B86222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224641494C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226465636F64654572726F72506F6C696379222C22706172616D5573616765223A22E5AD97E7ACA6E8A7A3E7A081E5A4B1E69588E697B6E79A84E5A484E79086E7AD96E795A5222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224C494E45222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22646573657269616C697A6572222C22706172616D5573616765223A22E69687E4BBB6E8A7A3E69E90E4B8BAE4BA8BE4BBB6E697B6E79A84E98086E5BA8FE58897E58C96E599A8222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A227265706C69636174696E67222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2273656C6563746F722E74797065222C22706172616D5573616765223A22E98089E68BA9E599A8E7B1BBE59E8BEFBC8C7265706C69636174696E67E68896E880856D756C7469706C6578696E67222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E746572636570746F7273222C22706172616D5573616765223A22E68BA6E688AAE599A828E5A49AE4B8AAE68BA6E688AAE599A8E4B98BE997B4E794A8E7A9BAE6A0BCE58886E99A9429222C22706172616D56616C7565223A22227D5D7D7D, null, null, null, null, null, 'single', '0', '26', 'root', '1');
INSERT INTO `s_flume_dataflow` VALUES ('41', 'storm区域位置信息', '1', null, null, ',', '1', '27673\n', null, '1', 0x7B226368616E6E656C223A7B7D2C22666C6F774E616D65223A2273746F726DE58CBAE59F9FE4BD8DE7BDAEE4BFA1E681AF222C2273696E6B223A7B2273696E6B31223A5B7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE98089E68BA9E599A8E7B1BBE59E8B222C22706172616D56616C7565223A226F72672E6170616368652E666C756D652E73696E6B2E6B61666B612E4B61666B6153696E6B227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2262726F6B65724C697374222C22706172616D5573616765223A2242726F6B657228686F73746E616D653A706F7274E6A0BCE5BC8F29E58897E8A1A8EFBC8CE5A49AE4B8AA42726F6B6572E4B98BE997B4E4BBA5E98097E58FB7E58886E99A94222C22706172616D56616C7565223A223139322E3136382E31302E33373A393039322C3139322E3136382E31302E33383A393039322C3139322E3136382E31302E33393A39303932227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C222C22706172616D5573616765223A22E695B0E68DAEE9809AE98193222C22706172616D56616C7565223A226331227D2C7B22706172616D44656661756C74223A2264656661756C742D666C756D652D746F706963222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22746F706963222C22706172616D5573616765223A22E6B688E681AFE4B8BBE9A298222C22706172616D56616C7565223A22617265614C6F636174696F6E227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E5A484E79086E7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2231222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22726571756972656441636B73222C22706172616D5573616765223A22E6B688E681AFE5BA94E7AD94E6A8A1E5BC8FEFBC9A312CE7AD89E5BE856C6561646572E5BA94E7AD943B302CE4B88DE7AD89E5BE85E5BA94E7AD943B2D312CE7AD89E5BE85E68980E69C89736572766572E5BA94E7AD9428E981BFE5858D6C6561646572E5A4B1E69588E697B6E695B0E68DAEE4B8A2E5A4B129222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A224F74686572204B61666B612050726F64756365722050726F70657274696573222C22706172616D5573616765223A2250726F6475636572E58F82E695B0E9858DE7BDAEEFBC8CE4BBA520E280986B61666B612EE2809920E5819AE4B8BAE58F82E695B0E5898DE7BC80222C22706172616D56616C7565223A22227D5D7D2C22736F75726365223A7B22736F7572636531223A5B7B22706172616D44656661756C74223A2273706F6F6C646972222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE6BA90E7B1BBE59E8B222C22706172616D56616C7565223A2273706F6F6C646972227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C73222C22706172616D5573616765223A22E695B0E68DAEE6BA90E9809AE98193222C22706172616D56616C7565223A226331227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2273706F6F6C446972222C22706172616D5573616765223A22E69687E4BBB6E69DA5E6BA90222C22706172616D56616C7565223A222F6F70742F6265682F6C6F67732F666C756D655F617265614C6F636174696F6E227D2C7B22706172616D44656661756C74223A222E434F4D504C45544544222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65537566666978222C22706172616D5573616765223A22E69687E4BBB6E5908EE7BC80222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226E65766572222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2264656C657465506F6C696379222C22706172616D5573616765223A22E588A0E999A4E7AD96E795A5EFBC8C6E65766572E68896E88085696D6D656469617465222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E58C85E590ABE5AD98E582A8E7BB9DE5AFB9E8B7AFE5BE84E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266696C65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C654865616465724B6579222C22706172616D5573616765223A22E4B8BAE4BA8BE4BBB6E5A4B4E8BFBDE58AA0E585A8E8B7AFE5BE84E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E5AD98E582A8E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22626173656E616D65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D654865616465724B6579222C22706172616D5573616765223A22E4BA8BE4BBB6E5A4B4E8BFBDE58AA0E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225E24222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2269676E6F72655061747465726E222C22706172616D5573616765223A22E8BF87E6BBA4E8A2ABE5BFBDE795A5E69687E4BBB6E79A84E6ADA3E58899E8A1A8E8BEBEE5BC8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E666C756D6573706F6F6C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22747261636B6572446972222C22706172616D5573616765223A22E5AD98E582A8E8A2ABE5A484E79086E69687E4BBB6E58583E695B0E68DAEE79A84E79BAEE5BD95222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226F6C64657374222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22636F6E73756D654F72646572222C22706172616D5573616765223A22E69687E4BBB6E5A484E79086E9A1BAE5BA8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2234303030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226D61784261636B6F6666222C22706172616D5573616765223A22E9809AE98193E58DA0E6BBA1E697B6E4BA8BE4BBB6E7AD89E5BE85E58699E585A5E9809AE98193E79A84E69C80E5A4A7E697B6E997B4E997B4E99A9428E6AFABE7A79229222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E9878FE8BDACE7A7BBE7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225554462D38222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E70757443686172736574222C22706172616D5573616765223A22E8A7A3E69E90E8BE93E585A5E69687E4BBB6E79A84E5AD97E7ACA6E99B86222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224641494C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226465636F64654572726F72506F6C696379222C22706172616D5573616765223A22E5AD97E7ACA6E8A7A3E7A081E5A4B1E69588E697B6E79A84E5A484E79086E7AD96E795A5222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224C494E45222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22646573657269616C697A6572222C22706172616D5573616765223A22E69687E4BBB6E8A7A3E69E90E4B8BAE4BA8BE4BBB6E697B6E79A84E98086E5BA8FE58897E58C96E599A8222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A227265706C69636174696E67222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2273656C6563746F722E74797065222C22706172616D5573616765223A22E98089E68BA9E599A8E7B1BBE59E8BEFBC8C7265706C69636174696E67E68896E880856D756C7469706C6578696E67222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E746572636570746F7273222C22706172616D5573616765223A22E68BA6E688AAE599A828E5A49AE4B8AAE68BA6E688AAE599A8E4B98BE997B4E794A8E7A9BAE6A0BCE58886E99A9429222C22706172616D56616C7565223A22227D5D7D7D, null, null, null, null, null, 'single', null, '33', 'wxx', '1');
INSERT INTO `s_flume_dataflow` VALUES ('42', '新入网用户flume', '1', null, null, ',', '1', '16219\n', null, '1', 0x7B226368616E6E656C223A7B7D2C22666C6F774E616D65223A22E696B0E585A5E7BD91E794A8E688B7666C756D65222C2273696E6B223A7B2273696E6B31223A5B7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE98089E68BA9E599A8E7B1BBE59E8B222C22706172616D56616C7565223A226F72672E6170616368652E666C756D652E73696E6B2E6B61666B612E4B61666B6153696E6B227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2262726F6B65724C697374222C22706172616D5573616765223A2242726F6B657228686F73746E616D653A706F7274E6A0BCE5BC8F29E58897E8A1A8EFBC8CE5A49AE4B8AA42726F6B6572E4B98BE997B4E4BBA5E98097E58FB7E58886E99A94222C22706172616D56616C7565223A223139322E3136382E31302E33373A393039322C3139322E3136382E31302E33383A393039322C3139322E3136382E31302E33393A39303932227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C222C22706172616D5573616765223A22E695B0E68DAEE9809AE98193222C22706172616D56616C7565223A226331227D2C7B22706172616D44656661756C74223A2264656661756C742D666C756D652D746F706963222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22746F706963222C22706172616D5573616765223A22E6B688E681AFE4B8BBE9A298222C22706172616D56616C7565223A226E657753756273637269626572227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E5A484E79086E7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2231222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22726571756972656441636B73222C22706172616D5573616765223A22E6B688E681AFE5BA94E7AD94E6A8A1E5BC8FEFBC9A312CE7AD89E5BE856C6561646572E5BA94E7AD943B302CE4B88DE7AD89E5BE85E5BA94E7AD943B2D312CE7AD89E5BE85E68980E69C89736572766572E5BA94E7AD9428E981BFE5858D6C6561646572E5A4B1E69588E697B6E695B0E68DAEE4B8A2E5A4B129222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A224F74686572204B61666B612050726F64756365722050726F70657274696573222C22706172616D5573616765223A2250726F6475636572E58F82E695B0E9858DE7BDAEEFBC8CE4BBA520E280986B61666B612EE2809920E5819AE4B8BAE58F82E695B0E5898DE7BC80222C22706172616D56616C7565223A22227D5D7D2C22736F75726365223A7B22736F7572636531223A5B7B22706172616D44656661756C74223A2273706F6F6C646972222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE6BA90E7B1BBE59E8B222C22706172616D56616C7565223A2273706F6F6C646972227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C73222C22706172616D5573616765223A22E695B0E68DAEE6BA90E9809AE98193222C22706172616D56616C7565223A226331227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2273706F6F6C446972222C22706172616D5573616765223A22E69687E4BBB6E69DA5E6BA90222C22706172616D56616C7565223A222F6F70742F6265682F6C6F67732F666C756D655F6E657753756273637269626572227D2C7B22706172616D44656661756C74223A222E434F4D504C45544544222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65537566666978222C22706172616D5573616765223A22E69687E4BBB6E5908EE7BC80222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226E65766572222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2264656C657465506F6C696379222C22706172616D5573616765223A22E588A0E999A4E7AD96E795A5EFBC8C6E65766572E68896E88085696D6D656469617465222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E58C85E590ABE5AD98E582A8E7BB9DE5AFB9E8B7AFE5BE84E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266696C65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C654865616465724B6579222C22706172616D5573616765223A22E4B8BAE4BA8BE4BBB6E5A4B4E8BFBDE58AA0E585A8E8B7AFE5BE84E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E5AD98E582A8E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22626173656E616D65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D654865616465724B6579222C22706172616D5573616765223A22E4BA8BE4BBB6E5A4B4E8BFBDE58AA0E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225E24222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2269676E6F72655061747465726E222C22706172616D5573616765223A22E8BF87E6BBA4E8A2ABE5BFBDE795A5E69687E4BBB6E79A84E6ADA3E58899E8A1A8E8BEBEE5BC8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E666C756D6573706F6F6C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22747261636B6572446972222C22706172616D5573616765223A22E5AD98E582A8E8A2ABE5A484E79086E69687E4BBB6E58583E695B0E68DAEE79A84E79BAEE5BD95222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226F6C64657374222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22636F6E73756D654F72646572222C22706172616D5573616765223A22E69687E4BBB6E5A484E79086E9A1BAE5BA8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2234303030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226D61784261636B6F6666222C22706172616D5573616765223A22E9809AE98193E58DA0E6BBA1E697B6E4BA8BE4BBB6E7AD89E5BE85E58699E585A5E9809AE98193E79A84E69C80E5A4A7E697B6E997B4E997B4E99A9428E6AFABE7A79229222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E9878FE8BDACE7A7BBE7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225554462D38222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E70757443686172736574222C22706172616D5573616765223A22E8A7A3E69E90E8BE93E585A5E69687E4BBB6E79A84E5AD97E7ACA6E99B86222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224641494C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226465636F64654572726F72506F6C696379222C22706172616D5573616765223A22E5AD97E7ACA6E8A7A3E7A081E5A4B1E69588E697B6E79A84E5A484E79086E7AD96E795A5222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224C494E45222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22646573657269616C697A6572222C22706172616D5573616765223A22E69687E4BBB6E8A7A3E69E90E4B8BAE4BA8BE4BBB6E697B6E79A84E98086E5BA8FE58897E58C96E599A8222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A227265706C69636174696E67222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2273656C6563746F722E74797065222C22706172616D5573616765223A22E98089E68BA9E599A8E7B1BBE59E8BEFBC8C7265706C69636174696E67E68896E880856D756C7469706C6578696E67222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E746572636570746F7273222C22706172616D5573616765223A22E68BA6E688AAE599A828E5A49AE4B8AAE68BA6E688AAE599A8E4B98BE997B4E794A8E7A9BAE6A0BCE58886E99A9429222C22706172616D56616C7565223A22227D5D7D7D, null, null, null, null, null, 'single', '0', '33', 'wxx', '1');
INSERT INTO `s_flume_dataflow` VALUES ('46', 'x_flume', '1', null, null, '|', '1', '13941\n', null, '1', 0x7B226368616E6E656C223A7B7D2C22666C6F774E616D65223A22785F666C756D65222C2273696E6B223A7B22785F666C756D655F73696E6B223A5B7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE98089E68BA9E599A8E7B1BBE59E8B222C22706172616D56616C7565223A226F72672E6170616368652E666C756D652E73696E6B2E6B61666B612E4B61666B6153696E6B227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2262726F6B65724C697374222C22706172616D5573616765223A2242726F6B657228686F73746E616D653A706F7274E6A0BCE5BC8F29E58897E8A1A8EFBC8CE5A49AE4B8AA42726F6B6572E4B98BE997B4E4BBA5E98097E58FB7E58886E99A94222C22706172616D56616C7565223A223139322E3136382E31302E33373A393039322C3139322E3136382E31302E33383A393039322C3139322E3136382E31302E33393A39303932227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C222C22706172616D5573616765223A22E695B0E68DAEE9809AE98193222C22706172616D56616C7565223A226368616E6E656C54657374227D2C7B22706172616D44656661756C74223A2264656661756C742D666C756D652D746F706963222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22746F706963222C22706172616D5573616765223A22E6B688E681AFE4B8BBE9A298222C22706172616D56616C7565223A22785F6B61666B61227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E5A484E79086E7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2231222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22726571756972656441636B73222C22706172616D5573616765223A22E6B688E681AFE5BA94E7AD94E6A8A1E5BC8FEFBC9A312CE7AD89E5BE856C6561646572E5BA94E7AD943B302CE4B88DE7AD89E5BE85E5BA94E7AD943B2D312CE7AD89E5BE85E68980E69C89736572766572E5BA94E7AD9428E981BFE5858D6C6561646572E5A4B1E69588E697B6E695B0E68DAEE4B8A2E5A4B129222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A224F74686572204B61666B612050726F64756365722050726F70657274696573222C22706172616D5573616765223A2250726F6475636572E58F82E695B0E9858DE7BDAEEFBC8CE4BBA520E280986B61666B612EE2809920E5819AE4B8BAE58F82E695B0E5898DE7BC80222C22706172616D56616C7565223A22227D5D7D2C22736F75726365223A7B22785F666C756D655F736F75726365223A5B7B22706172616D44656661756C74223A2273706F6F6C646972222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE6BA90E7B1BBE59E8B222C22706172616D56616C7565223A2273706F6F6C646972227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C73222C22706172616D5573616765223A22E695B0E68DAEE6BA90E9809AE98193222C22706172616D56616C7565223A226368616E6E656C54657374227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2273706F6F6C446972222C22706172616D5573616765223A22E69687E4BBB6E69DA5E6BA90222C22706172616D56616C7565223A222F6F70742F6265682F6C6F67732F78466C756D65227D2C7B22706172616D44656661756C74223A222E434F4D504C45544544222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65537566666978222C22706172616D5573616765223A22E69687E4BBB6E5908EE7BC80222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226E65766572222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2264656C657465506F6C696379222C22706172616D5573616765223A22E588A0E999A4E7AD96E795A5EFBC8C6E65766572E68896E88085696D6D656469617465222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E58C85E590ABE5AD98E582A8E7BB9DE5AFB9E8B7AFE5BE84E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266696C65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C654865616465724B6579222C22706172616D5573616765223A22E4B8BAE4BA8BE4BBB6E5A4B4E8BFBDE58AA0E585A8E8B7AFE5BE84E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E5AD98E582A8E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22626173656E616D65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D654865616465724B6579222C22706172616D5573616765223A22E4BA8BE4BBB6E5A4B4E8BFBDE58AA0E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225E24222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2269676E6F72655061747465726E222C22706172616D5573616765223A22E8BF87E6BBA4E8A2ABE5BFBDE795A5E69687E4BBB6E79A84E6ADA3E58899E8A1A8E8BEBEE5BC8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E666C756D6573706F6F6C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22747261636B6572446972222C22706172616D5573616765223A22E5AD98E582A8E8A2ABE5A484E79086E69687E4BBB6E58583E695B0E68DAEE79A84E79BAEE5BD95222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226F6C64657374222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22636F6E73756D654F72646572222C22706172616D5573616765223A22E69687E4BBB6E5A484E79086E9A1BAE5BA8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2234303030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226D61784261636B6F6666222C22706172616D5573616765223A22E9809AE98193E58DA0E6BBA1E697B6E4BA8BE4BBB6E7AD89E5BE85E58699E585A5E9809AE98193E79A84E69C80E5A4A7E697B6E997B4E997B4E99A9428E6AFABE7A79229222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E9878FE8BDACE7A7BBE7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225554462D38222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E70757443686172736574222C22706172616D5573616765223A22E8A7A3E69E90E8BE93E585A5E69687E4BBB6E79A84E5AD97E7ACA6E99B86222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224641494C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226465636F64654572726F72506F6C696379222C22706172616D5573616765223A22E5AD97E7ACA6E8A7A3E7A081E5A4B1E69588E697B6E79A84E5A484E79086E7AD96E795A5222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224C494E45222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22646573657269616C697A6572222C22706172616D5573616765223A22E69687E4BBB6E8A7A3E69E90E4B8BAE4BA8BE4BBB6E697B6E79A84E98086E5BA8FE58897E58C96E599A8222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A227265706C69636174696E67222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2273656C6563746F722E74797065222C22706172616D5573616765223A22E98089E68BA9E599A8E7B1BBE59E8BEFBC8C7265706C69636174696E67E68896E880856D756C7469706C6578696E67222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E746572636570746F7273222C22706172616D5573616765223A22E68BA6E688AAE599A828E5A49AE4B8AAE68BA6E688AAE599A8E4B98BE997B4E794A8E7A9BAE6A0BCE58886E99A9429222C22706172616D56616C7565223A22227D5D7D7D, null, null, null, null, null, 'single', null, '23', 'xieqq', '1');
INSERT INTO `s_flume_dataflow` VALUES ('47', '11', '5', null, null, '11', '0', null, null, '1', 0x7B226368616E6E656C223A7B7D2C22666C6F774E616D65223A223131222C2273696E6B223A7B223131223A5B7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22CAFDBEDDD1A1D4F1C6F7C0E0D0CD222C22706172616D56616C7565223A226176726F227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C222C22706172616D5573616765223A22CAFDBEDDCDA8B5C0222C22706172616D56616C7565223A223131227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A22686F73746E616D65222C22706172616D5573616765223A22B0F3B6A8B5C4D6F7BBFAC3FBBBF24950222C22706172616D56616C7565223A223131227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A22706F7274222C22706172616D5573616765223A22BCE0CCFDB5C4B6CBBFDA222C22706172616D56616C7565223A223131227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2262617463682D73697A65222C22706172616D5573616765223A22C5FAC1BFB7A2CBCD6576656E74CAFDC1BF222C22706172616D56616C7565223A223131227D5D7D2C22736F75726365223A7B223131223A5B7B22706172616D44656661756C74223A2273706F6F6C646972222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22CAFDBEDDD4B4C0E0D0CD222C22706172616D56616C7565223A2273706F6F6C646972227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C73222C22706172616D5573616765223A22CAFDBEDDD4B4CDA8B5C0222C22706172616D56616C7565223A223131227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2273706F6F6C446972222C22706172616D5573616765223A22CEC4BCFEC0B4D4B4222C22706172616D56616C7565223A223131227D2C7B22706172616D44656661756C74223A222E434F4D504C45544544222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65537566666978222C22706172616D5573616765223A22CEC4BCFEBAF3D7BA222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226E65766572222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2264656C657465506F6C696379222C22706172616D5573616765223A22C9BEB3FDB2DFC2D4A3AC6E65766572BBF2D5DF696D6D656469617465222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65486561646572222C22706172616D5573616765223A22CAC7B7F1D7B7BCD3B0FCBAACB4E6B4A2BEF8B6D4C2B7BEB6CEC4BCFEC3FBB5C4D0C5CFA2CDB7222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266696C65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C654865616465724B6579222C22706172616D5573616765223A22CEAACAC2BCFECDB7D7B7BCD3C8ABC2B7BEB6CEC4BCFEC3FBCAB1B5C4D0C5CFA2CDB7B9D8BCFCD7D6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D65486561646572222C22706172616D5573616765223A22CAC7B7F1D7B7BCD3B4E6B4A2CEC4BCFEC3FBB5C4D0C5CFA2CDB7222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22626173656E616D65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D654865616465724B6579222C22706172616D5573616765223A22CAC2BCFECDB7D7B7BCD3CEC4BCFEC3FBCAB1B5C4D0C5CFA2CDB7B9D8BCFCD7D6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225E24222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2269676E6F72655061747465726E222C22706172616D5573616765223A22B9FDC2CBB1BBBAF6C2D4CEC4BCFEB5C4D5FDD4F2B1EDB4EFCABD222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E666C756D6573706F6F6C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22747261636B6572446972222C22706172616D5573616765223A22B4E6B4A2B1BBB4A6C0EDCEC4BCFED4AACAFDBEDDB5C4C4BFC2BC222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226F6C64657374222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22636F6E73756D654F72646572222C22706172616D5573616765223A22CEC4BCFEB4A6C0EDCBB3D0F2222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2234303030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226D61784261636B6F6666222C22706172616D5573616765223A22CDA8B5C0D5BCC2FACAB1CAC2BCFEB5C8B4FDD0B4C8EBCDA8B5C0B5C4D7EEB4F3CAB1BCE4BCE4B8F428BAC1C3EB29222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22C5FAC1BFD7AAD2C6C1A3B6C8222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225554462D38222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E70757443686172736574222C22706172616D5573616765223A22BDE2CEF6CAE4C8EBCEC4BCFEB5C4D7D6B7FBBCAF222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224641494C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226465636F64654572726F72506F6C696379222C22706172616D5573616765223A22D7D6B7FBBDE2C2EBCAA7D0A7CAB1B5C4B4A6C0EDB2DFC2D4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224C494E45222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22646573657269616C697A6572222C22706172616D5573616765223A22CEC4BCFEBDE2CEF6CEAACAC2BCFECAB1B5C4C4E6D0F2C1D0BBAFC6F7222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A227265706C69636174696E67222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2273656C6563746F722E74797065222C22706172616D5573616765223A22D1A1D4F1C6F7C0E0D0CDA3AC7265706C69636174696E67BBF2D5DF6D756C7469706C6578696E67222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E746572636570746F7273222C22706172616D5573616765223A22C0B9BDD8C6F728B6E0B8F6C0B9BDD8C6F7D6AEBCE4D3C3BFD5B8F1B7D6B8F429222C22706172616D56616C7565223A22227D5D7D7D, null, null, null, null, null, 'client', null, '25', 'admin', '3');
INSERT INTO `s_flume_dataflow` VALUES ('48', '测试', '1', null, null, '|', '0', null, null, '1', 0x7B226368616E6E656C223A7B7D2C22666C6F774E616D65223A22E6B58BE8AF95222C2273696E6B223A7B7D2C22736F75726365223A7B2273706F6F6C646972223A5B7B22706172616D44656661756C74223A2273706F6F6C646972222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2274797065222C22706172616D5573616765223A22E695B0E68DAEE6BA90E7B1BBE59E8B222C22706172616D56616C7565223A2273706F6F6C646972227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A226368616E6E656C73222C22706172616D5573616765223A22E695B0E68DAEE6BA90E9809AE98193222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A222A222C22706172616D4E616D65223A2273706F6F6C446972222C22706172616D5573616765223A22E69687E4BBB6E69DA5E6BA90222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E434F4D504C45544544222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65537566666978222C22706172616D5573616765223A22E69687E4BBB6E5908EE7BC80222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226E65766572222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2264656C657465506F6C696379222C22706172616D5573616765223A22E588A0E999A4E7AD96E795A5EFBC8C6E65766572E68896E88085696D6D656469617465222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E58C85E590ABE5AD98E582A8E7BB9DE5AFB9E8B7AFE5BE84E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266696C65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2266696C654865616465724B6579222C22706172616D5573616765223A22E4B8BAE4BA8BE4BBB6E5A4B4E8BFBDE58AA0E585A8E8B7AFE5BE84E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2266616C7365222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D65486561646572222C22706172616D5573616765223A22E698AFE590A6E8BFBDE58AA0E5AD98E582A8E69687E4BBB6E5908DE79A84E4BFA1E681AFE5A4B4222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22626173656E616D65222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626173656E616D654865616465724B6579222C22706172616D5573616765223A22E4BA8BE4BBB6E5A4B4E8BFBDE58AA0E69687E4BBB6E5908DE697B6E79A84E4BFA1E681AFE5A4B4E585B3E994AEE5AD97222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225E24222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2269676E6F72655061747465726E222C22706172616D5573616765223A22E8BF87E6BBA4E8A2ABE5BFBDE795A5E69687E4BBB6E79A84E6ADA3E58899E8A1A8E8BEBEE5BC8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A222E666C756D6573706F6F6C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22747261636B6572446972222C22706172616D5573616765223A22E5AD98E582A8E8A2ABE5A484E79086E69687E4BBB6E58583E695B0E68DAEE79A84E79BAEE5BD95222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A226F6C64657374222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22636F6E73756D654F72646572222C22706172616D5573616765223A22E69687E4BBB6E5A484E79086E9A1BAE5BA8F222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A2234303030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226D61784261636B6F6666222C22706172616D5573616765223A22E9809AE98193E58DA0E6BBA1E697B6E4BA8BE4BBB6E7AD89E5BE85E58699E585A5E9809AE98193E79A84E69C80E5A4A7E697B6E997B4E997B4E99A9428E6AFABE7A79229222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22313030222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22626174636853697A65222C22706172616D5573616765223A22E689B9E9878FE8BDACE7A7BBE7B292E5BAA6222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A225554462D38222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E70757443686172736574222C22706172616D5573616765223A22E8A7A3E69E90E8BE93E585A5E69687E4BBB6E79A84E5AD97E7ACA6E99B86222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224641494C222C22706172616D49734D757374223A22222C22706172616D4E616D65223A226465636F64654572726F72506F6C696379222C22706172616D5573616765223A22E5AD97E7ACA6E8A7A3E7A081E5A4B1E69588E697B6E79A84E5A484E79086E7AD96E795A5222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A224C494E45222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22646573657269616C697A6572222C22706172616D5573616765223A22E69687E4BBB6E8A7A3E69E90E4B8BAE4BA8BE4BBB6E697B6E79A84E98086E5BA8FE58897E58C96E599A8222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A227265706C69636174696E67222C22706172616D49734D757374223A22222C22706172616D4E616D65223A2273656C6563746F722E74797065222C22706172616D5573616765223A22E98089E68BA9E599A8E7B1BBE59E8BEFBC8C7265706C69636174696E67E68896E880856D756C7469706C6578696E67222C22706172616D56616C7565223A22227D2C7B22706172616D44656661756C74223A22222C22706172616D49734D757374223A22222C22706172616D4E616D65223A22696E746572636570746F7273222C22706172616D5573616765223A22E68BA6E688AAE599A828E5A49AE4B8AAE68BA6E688AAE599A8E4B98BE997B4E794A8E7A9BAE6A0BCE58886E99A9429222C22706172616D56616C7565223A22227D5D7D7D, null, null, null, null, null, 'single', null, '24', 'bianshen', '1');

-- ----------------------------
-- Table structure for `s_flume_host`
-- ----------------------------
DROP TABLE IF EXISTS `s_flume_host`;
CREATE TABLE `s_flume_host` (
  `s_host_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_host_ip` varchar(255) DEFAULT NULL,
  `s_host_user` varchar(255) DEFAULT NULL,
  `s_host_password` varchar(255) DEFAULT NULL,
  `s_flume_home` varchar(255) DEFAULT NULL,
  `s_flume_monitor_port` varchar(255) DEFAULT NULL,
  `s_cluster_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_esperanto_ci DEFAULT NULL,
  `s_organization_id` int(11) DEFAULT NULL,
  `s_cluster_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`s_host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_flume_host
-- ----------------------------
INSERT INTO `s_flume_host` VALUES ('1', '192.168.10.37', 'hadoop', 'hadoop', '/opt/beh/core/flume/', '18089', '测试集群', '8', '1');
INSERT INTO `s_flume_host` VALUES ('2', '192.168.10.38', 'hadoop', 'hadoop', '/opt/beh/core/flume/', '18089', '测试集群', '8', '1');
INSERT INTO `s_flume_host` VALUES ('3', '192.168.10.39', 'hadoop', 'hadoop', '/opt/beh/core/flume/', '18089', '测试集群', '8', '1');
INSERT INTO `s_flume_host` VALUES ('5', '192.168.10.137', 'hadoop', 'hadoop', '/opt/beh/core/flume/', '18089', '测试test', '8', '3');
INSERT INTO `s_flume_host` VALUES ('6', '192.168.10.138', 'hadoop', 'hadoop', '/opt/beh/core/flume/', '18089', '测试test', '8', '3');
INSERT INTO `s_flume_host` VALUES ('7', '192.168.10.139', 'hadoop', 'hadoop', '/opt/beh/core/flume/', '18089', '测试test', '8', '3');

-- ----------------------------
-- Table structure for `s_kafka_host`
-- ----------------------------
DROP TABLE IF EXISTS `s_kafka_host`;
CREATE TABLE `s_kafka_host` (
  `kafka_host_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `broker_id` int(11) NOT NULL,
  `broker_host` varchar(20) NOT NULL,
  `broker_port` varchar(20) NOT NULL,
  `log_dir` varchar(500) NOT NULL,
  `s_cluster_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_esperanto_ci DEFAULT NULL,
  `s_organization_id` int(11) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `s_cluster_ID` int(11) DEFAULT NULL,
  `kafka_path` varchar(100) NOT NULL,
  `s_isrunning` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`kafka_host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_kafka_host
-- ----------------------------
INSERT INTO `s_kafka_host` VALUES ('2', '12', '192.168.10.37', '9092', '/opt/beh/logs/kafka/kafka-logs', '测试集群', '8', 'hadoop', 'hadoop', '1', '', null);
INSERT INTO `s_kafka_host` VALUES ('7', '11', '192.168.10.38', '9092', '/opt/beh/logs/kafka/kafka-logs', '测试集群', '8', 'hadoop', 'hadoop', '1', '', null);
INSERT INTO `s_kafka_host` VALUES ('8', '13', '192.168.10.39', '9092', '/opt/beh/logs/kafka/kafka-logs', '测试集群', '8', 'hadoop', 'hadoop', '1', '', null);
INSERT INTO `s_kafka_host` VALUES ('9', '1', '172.16.11.55', '9092', '/opt/beh/core/kafka/kafka-logs', '测试集群测试test', '8', 'rdpe7', 'hadoop', '1', '', null);

-- ----------------------------
-- Table structure for `s_kafka_prop`
-- ----------------------------
DROP TABLE IF EXISTS `s_kafka_prop`;
CREATE TABLE `s_kafka_prop` (
  `kafka_topic_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `broker_list` varchar(500) NOT NULL,
  `topic` varchar(50) NOT NULL,
  `group_id` varchar(50) NOT NULL,
  `topic_desc` varchar(500) DEFAULT NULL,
  `zookeeper_host` varchar(100) DEFAULT NULL,
  `zookeeper_port` varchar(20) DEFAULT NULL,
  `zookeeper_session_timeout_ms` varchar(10) DEFAULT NULL,
  `zookeeper_sync_time_ms` varchar(10) DEFAULT NULL,
  `auto_commit_interval_ms` varchar(10) DEFAULT NULL,
  `partitions` varchar(10) DEFAULT NULL,
  `replications` varchar(10) DEFAULT NULL,
  `isrunning` varchar(10) DEFAULT NULL,
  `user_id` int(10) DEFAULT NULL,
  `userName` varchar(20) DEFAULT NULL,
  `kafka_cluster_id` int(10) DEFAULT NULL,
  `zookeeper_cluster_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`kafka_topic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_kafka_prop
-- ----------------------------
INSERT INTO `s_kafka_prop` VALUES ('27', '192.168.10.37:9092,192.168.10.38:9092,192.168.10.39:9092', 'newSubscriber', '', '', '192.168.10.37:2181,192.168.10.38:2181,192.168.10.39:2181', '2181', '6000', '200', '4000', '3', '3', '1', '33', 'wxx', '1', '1');
INSERT INTO `s_kafka_prop` VALUES ('28', '192.168.10.37:9092,192.168.10.38:9092,192.168.10.39:9092', 'subscriberOut', '', '', '192.168.10.37:2181,192.168.10.38:2181,192.168.10.39:2181', '2181', '6000', '200', '4000', '3', '3', '1', '33', 'wxx', '1', '1');
INSERT INTO `s_kafka_prop` VALUES ('29', '192.168.10.37:9092,192.168.10.38:9092,192.168.10.39:9092', 'areaLocation', '', 'storm区域信息', 'rdpe1:2181,rdpe2:2181,rdpe3:2181', '2181', '6000', '200', '4000', '3', '3', '1', '33', 'wxx', '1', '1');
INSERT INTO `s_kafka_prop` VALUES ('30', '192.168.10.37:9092,192.168.10.38:9092,192.168.10.39:9092', 'areaLocationOut', '', '', 'rdpe1:2181,rdpe2:2181,rdpe3:2181', '2181', '6000', '200', '4000', '3', '3', '1', '33', 'wxx', '1', '1');
INSERT INTO `s_kafka_prop` VALUES ('31', '192.168.10.37:9092,192.168.10.38:9092', 'x_kafka', 'XGroup', 'XGroup', '192.168.10.38:2181,192.168.10.39:2181', '2181', '6000', '200', '4000', '6', '2', '1', '23', 'xieqq', '1', '1');
INSERT INTO `s_kafka_prop` VALUES ('56', '192.168.10.37:9092,192.168.10.38:9092,192.168.10.39:9092', 'CB', 'CB1', 'cbss', '192.168.10.37:2181,192.168.10.38:2181,192.168.10.39:2181', '2181', '6000', '200', '4000', '1', '1', null, '33', 'wxx', '1', '1');
INSERT INTO `s_kafka_prop` VALUES ('57', '192.168.10.37:9092', '111', '222', '111', '', '2181', '6000', '200', '4000', '', '', null, '24', 'bianshen', '1', '-1');
INSERT INTO `s_kafka_prop` VALUES ('58', '', '1', '1', '1', '192.168.10.37:2181', '2181', '6000', '200', '4000', '1', '1', null, '31', 'liyongqiang', '-1', '1');
INSERT INTO `s_kafka_prop` VALUES ('61', '172.16.11.55:9092', 'areaOut', '', '区域位置信息输入的topic', '172.16.11.55:2181,172.16.11.56:2181,172.16.11.58:2181', '2181', '6000', '200', '4000', '1', '1', null, '25', 'admin', '1', '1');
INSERT INTO `s_kafka_prop` VALUES ('62', '172.16.11.55:9092', 'area', '', '区域位置信息采集', '172.16.11.55:2181,172.16.11.56:2181,172.16.11.58:2181', '2181', '6000', '200', '4000', '1', '1', null, '25', 'admin', '1', '1');

-- ----------------------------
-- Table structure for `s_spark_datasource`
-- ----------------------------
DROP TABLE IF EXISTS `s_spark_datasource`;
CREATE TABLE `s_spark_datasource` (
  `spark_event_ds_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `spark_event_ds_type` char(1) DEFAULT NULL,
  `spark_event_ds_name` varchar(20) DEFAULT NULL,
  `spark_event_ds_desc` varchar(100) DEFAULT NULL,
  `spark_event_kafka_id` bigint(20) DEFAULT NULL,
  `spark_event_kafka_name` varchar(20) DEFAULT NULL,
  `server_ip` varchar(20) DEFAULT NULL,
  `server_port` varchar(20) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `file_path` varchar(100) DEFAULT NULL,
  `separator_all` varchar(10) DEFAULT NULL,
  `spark_event_ds_run_status` varchar(5) DEFAULT NULL,
  `spark_event_ds_run_pid` varchar(5) DEFAULT NULL,
  `create_user` varchar(20) DEFAULT NULL,
  `creater_name_id` int(11) DEFAULT NULL,
  `creater_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`spark_event_ds_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_spark_datasource
-- ----------------------------
INSERT INTO `s_spark_datasource` VALUES ('10', '0', 'kafka', 'aa', '10', 'KafkaStorm2', '', '', '', '', '', '|', null, null, null, null, null);
INSERT INTO `s_spark_datasource` VALUES ('11', '1', 'j-test', 'socket', null, '', '192.168.10.37', '10002', '', '', '', '|', null, null, null, null, null);
INSERT INTO `s_spark_datasource` VALUES ('12', '2', 'HDFS', '', null, '', '', '', '', '', '/opt/beh', '|', null, null, null, '24', 'bianshen');
INSERT INTO `s_spark_datasource` VALUES ('13', '1', 'testa', '', null, '', '192.168.10.40', '9999', '', '', '', '|', null, null, null, '25', 'admin');

-- ----------------------------
-- Table structure for `s_spark_event_opt`
-- ----------------------------
DROP TABLE IF EXISTS `s_spark_event_opt`;
CREATE TABLE `s_spark_event_opt` (
  `sparkopt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_id` varchar(120) DEFAULT NULL,
  `sparkopt_name` varchar(300) DEFAULT NULL,
  `sparkopt_desc` varchar(300) DEFAULT NULL,
  `sparkopt_type` varchar(60) DEFAULT NULL,
  `sparkopt_func` varchar(300) DEFAULT NULL,
  `scala_command` varchar(20000) DEFAULT NULL,
  `sparkopt_bl` varchar(30) DEFAULT NULL,
  `sparkopt_zdyhs` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`sparkopt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_spark_event_opt
-- ----------------------------
INSERT INTO `s_spark_event_opt` VALUES ('61', '20160809144048', '11', '11', '2', 'map', 'val 11=rdd1.sortbykey(\'\')', '11', null);
INSERT INTO `s_spark_event_opt` VALUES ('79', '20160812103539', '11', '11', '2', 'filter', 'val 11=rdd1.filter(\'\')', '11', null);
INSERT INTO `s_spark_event_opt` VALUES ('84', '20160817103419', '', '', '3', '', 'val dd=rdd1.map(\'\').first(\'\').union(\'\').first(\'\').reduce(\'\').(\'\').map(\'\')', 'dd', '9');
INSERT INTO `s_spark_event_opt` VALUES ('85', '20160817103419', '', '', '3', 'reduce', 'val sdas =dd.reduce(a)', 'sdas ', '9,10');
INSERT INTO `s_spark_event_opt` VALUES ('93', '20160905201524', 'rr', '', '2', 'filter', 'val rdd2=rdd2.filter(\'\')', 'rdd2', '1');
INSERT INTO `s_spark_event_opt` VALUES ('94', '20160921103844', '提取数据', '提取数据', '1', '7', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('95', '20160921103844', 'map', 'map', '2', 'map', 'val rdd2=rdd1.map(x => (x,1))', 'rdd2', '1');
INSERT INTO `s_spark_event_opt` VALUES ('96', '20160921120830', 'tiqu ', '', '1', '7', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('97', '20160921183338', 'data', 'data', '1', '7', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('98', '20161014143629', '10-14', '', '1', '7', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('99', '20161014155656', '10-14-2', '10-14-2', '1', '2', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('102', '20161017151448', 'one', '11', '1', '7', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('104', '20161018102248', '1', '1', '1', '2', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('105', '20161018114155', 'spark-18', '', '1', '7', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('106', '20161028151714', '333', '33', '1', '2', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('110', '20161206104452', '提取', '', '1', '10', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('111', '20161206104452', '对对对', 'dd', '2', 'map', 'ddd', 'dd', '1');
INSERT INTO `s_spark_event_opt` VALUES ('115', '20161220092212', '提取', '', '1', '10', '', 'rdd1', '1');
INSERT INTO `s_spark_event_opt` VALUES ('118', '20161221143359', 'a', '', '1', '11', '', 'rdd1', '4');
INSERT INTO `s_spark_event_opt` VALUES ('119', '20161221143359', 'aa', '', '2', 'map', '            var num=0\r\n	    var str=\"\"\r\n	    var phoneNum=\"\"\r\n	    rdd1.foreachRDD(x=>{\r\n          x.foreach { x =>  \r\n	         val phone=x.split(\":\")\r\n	         val rs=getDayNumber(phone)\r\n	         if(phone.length>=4&&phone(3)==\"N\"){//18799889098:2016-10-3:17899098765:Y:messagexxxxxxx\r\n	           var sums=\"\"\r\n	           var date=\"\"\r\n	           var number=\"\"\r\n	           \r\n	           while(rs!=null&&rs.next()){\r\n	             number=rs.getString(\"number1\")\r\n	             sums=rs.getString(\"sum\")\r\n	             date=rs.getString(\"time\")\r\n	           }\r\n	           if(sums!=\"\"&& sums!=null&&date==phone(1)&&number==phone(0)){\r\n	           //  val rs=getDayNumber(phone)\r\n	           var number=(Integer.parseInt(sums)+1)+\"\"\r\n	              val str=\"the number :\"+ phone(0)+\" is called by \"+phone(2)+\"at \"+phone(1)+\" if all is \"+number +\" times..\"\r\n	              val array=new ArrayBuffer[String]\r\n    	          for(i<-phone){\r\n    	            if(i!=null&&i!=\"\")\r\n    	            array+=i+\"\"//data to string\r\n    	          }\r\n  	          updateMysql(array.toArray,number)\r\n  	          saveKafka(str)\r\n	         }else{\r\n	           //if the numberphone appear once again..\r\n	           var  number=1\r\n	              val str=\"the number :\"+ phone(0)+\" is called by \"+phone(2)+\"at \"+phone(1)+\" else all is \"+number +\" times..\"\r\n	              val array=new ArrayBuffer[String]\r\n    	          for(i<-phone){\r\n    	            if(i!=null&&i!=\"\")\r\n    	            array+=i+\"\"//data to string\r\n    	          }\r\n  	          saveMysql(array.toArray,number+\"\")\r\n  	          saveKafka(str)\r\n	         }\r\n	           }\r\n	         \r\n	       }\r\n	    })', 'a', '5,6,7,8');
INSERT INTO `s_spark_event_opt` VALUES ('120', '20161221150426', 'a ', '', '1', '11', '', 'rdd1', '4');
INSERT INTO `s_spark_event_opt` VALUES ('121', '20161221150426', 'a ', 'a ', '2', 'map', '            var num=0\r\n	    var str=\"\"\r\n	    var phoneNum=\"\"\r\n	    rdd1.foreachRDD(x=>{\r\n          x.foreach { x =>  \r\n	         val phone=x.split(\":\")\r\n	         val rs=getDayNumber(phone)\r\n	         if(phone.length>=4&&phone(3)==\"N\"){//18799889098:2016-10-3:17899098765:Y:messagexxxxxxx\r\n	           var sums=\"\"\r\n	           var date=\"\"\r\n	           var number=\"\"\r\n	           \r\n	           while(rs!=null&&rs.next()){\r\n	             number=rs.getString(\"number1\")\r\n	             sums=rs.getString(\"sum\")\r\n	             date=rs.getString(\"time\")\r\n	           }\r\n	           if(sums!=\"\"&& sums!=null&&date==phone(1)&&number==phone(0)){\r\n	           //  val rs=getDayNumber(phone)\r\n	           var number=(Integer.parseInt(sums)+1)+\"\"\r\n	              val str=\"the number :\"+ phone(0)+\" is called by \"+phone(2)+\"at \"+phone(1)+\" if all is \"+number +\" times..\"\r\n	              val array=new ArrayBuffer[String]\r\n    	          for(i<-phone){\r\n    	            if(i!=null&&i!=\"\")\r\n    	            array+=i+\"\"//data to string\r\n    	          }\r\n  	          updateMysql(array.toArray,number)\r\n  	          saveKafka(str)\r\n	         }else{\r\n	           //if the numberphone appear once again..\r\n	           var  number=1\r\n	              val str=\"the number :\"+ phone(0)+\" is called by \"+phone(2)+\"at \"+phone(1)+\" else all is \"+number +\" times..\"\r\n	              val array=new ArrayBuffer[String]\r\n    	          for(i<-phone){\r\n    	            if(i!=null&&i!=\"\")\r\n    	            array+=i+\"\"//data to string\r\n    	          }\r\n  	          saveMysql(array.toArray,number+\"\")\r\n  	          saveKafka(str)\r\n	         }\r\n	           }\r\n	         \r\n	       }\r\n	    })', 'a ', '5,6,7,8');
INSERT INTO `s_spark_event_opt` VALUES ('122', '20170303153740', 'tiqu1', 'ones', '1', '10', '', 'rdd1', '4');
INSERT INTO `s_spark_event_opt` VALUES ('125', '20170314114532', 'testa', 'testa', '1', '13', '', 'rdd1', '4');
INSERT INTO `s_spark_event_opt` VALUES ('126', '20170314114532', 'map', '', '2', 'map', '', 'rdd2', '4');

-- ----------------------------
-- Table structure for `s_spark_function`
-- ----------------------------
DROP TABLE IF EXISTS `s_spark_function`;
CREATE TABLE `s_spark_function` (
  `function_id` bigint(200) NOT NULL AUTO_INCREMENT,
  `function_name` varchar(20) DEFAULT NULL,
  `function_desc` varchar(100) DEFAULT NULL,
  `function_input` varchar(100) DEFAULT NULL,
  `function_output` varchar(100) DEFAULT NULL,
  `scala_command` varchar(20000) DEFAULT NULL,
  `function_user_name` varchar(1000) DEFAULT NULL,
  `function_user_id` int(10) DEFAULT NULL,
  `function_produce_time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`function_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_spark_function
-- ----------------------------
INSERT INTO `s_spark_function` VALUES ('4', 'saveToHdfs', '', '', '', ' def saveToHdfs(x:String,y:DStream[String]){\r\n		  y.saveAsTextFiles(\"/opt/beh/core/spark\")\r\n		}', 'admin', '25', '2016-12-21 11:51:36');
INSERT INTO `s_spark_function` VALUES ('5', 'saveKafka', '', '', '', 'def saveKafka(x:String){\r\n  	      var  props=new Properties\r\n          props.put(\"metadata.broker.list\", \"192.168.10.37:9092,192.168.10.38:9092,192.168.10.39:9092\");\r\n          props.put(\"serializer.class\", \"kafka.serializer.StringEncoder\");\r\n          props.put(\"request.required.acks\", \"1\");//wait for admin message from kafka\r\n          val config= new ProducerConfig(props)\r\n          val producer= new Producer[String,String](config)\r\n          val data=new KeyedMessage[String,String](\"spark-phone\",x)\r\n          producer.send(data)\r\n	    }', 'admin', '25', '2016-12-21 11:52:23');
INSERT INTO `s_spark_function` VALUES ('6', 'saveMysql', '', '', '', ' val driver = \"com.mysql.jdbc.Driver\"\r\n		   val url = \"jdbc:mysql://192.168.10.37:3306/phone\"\r\n		   val username = \"root\"\r\n		   val password = \"root123\"\r\n		   var connection:Connection = null\r\n   def saveMysql(x:Array[String],num:String){\r\n                try {\r\n                    Class.forName(driver)\r\n                    connection = DriverManager.getConnection(url, username, password)\r\n                    val str=\"insert into phone(number1,time,number2,message,sum)  values(?,?,?,?,?)\"\r\n                    val  pst=connection.prepareStatement(str)\r\n                    pst.setString(1, x(0))\r\n                    pst.setString(2, x(1))\r\n                    pst.setString(3, x(2))\r\n                    pst.setString(4, x(4))\r\n                    pst.setString(5, num)//time\r\n                    var i=pst.execute()\r\n                }\r\n                catch {\r\n                        case e => e.printStackTrace\r\n                }finally{\r\n                  if(connection!=null){\r\n                	  connection.close()\r\n                  }\r\n                }\r\n   }', 'admin', '25', '2016-12-21 11:52:56');
INSERT INTO `s_spark_function` VALUES ('7', 'updateMysql', '', '', '', 'def updateMysql(x:Array[String],num:String){\r\n                try {\r\n                    Class.forName(driver)\r\n                    connection = DriverManager.getConnection(url, username, password)\r\n                    val str=\"update phone  set number2=? , sum=? , message=? where number1=?\"\r\n                    print(str)\r\n                    val  pst=connection.prepareStatement(str)\r\n                    pst.setString(1, x(2))\r\n                    pst.setString(2, num)\r\n                    pst.setString(3, x(4))\r\n                    pst.setString(4, x(0))\r\n                    var i=pst.execute()\r\n                }\r\n                catch {\r\n                        case e => e.printStackTrace\r\n                }finally{\r\n                  if(connection!=null){\r\n                	  connection.close()\r\n                  }\r\n                }\r\n   }', 'admin', '25', '2016-12-21 11:53:09');
INSERT INTO `s_spark_function` VALUES ('8', 'getDayNumber', '', '', '', ' def getDayNumber(phone:Array[String]): ResultSet={\r\n      try {\r\n            Class.forName(driver)\r\n            connection = DriverManager.getConnection(url, username, password)\r\n            //val str=\"select top1  from phone where number1=  \'\" +phone(0) +\"\'  and time =  \'\"+ phone(1)+\"\'  order by sum desc\"\r\n            val str=\"SELECT * from phone where number1= \"+phone(0)+\" ORDER BY sum DESC limit 1 \"\r\n            println(str+\":sql\")\r\n            val  pst=connection.prepareStatement(str)\r\n            var result=pst.executeQuery(str)\r\n           // val boolean=if(result.next())true else false//when there is number exist before return true ,else return false.\r\n          val rs=if (result!=null) result else null\r\n          rs\r\n      }catch {\r\n                case e => e.printStackTrace\r\n                null//without values\r\n              }finally{\r\n               //results ends here\r\n              }\r\n   }', 'admin', '25', '2016-12-21 11:53:24');

-- ----------------------------
-- Table structure for `s_spark_host`
-- ----------------------------
DROP TABLE IF EXISTS `s_spark_host`;
CREATE TABLE `s_spark_host` (
  `s_host_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `s_host_ip` varchar(20) DEFAULT NULL,
  `s_host_user` varchar(20) DEFAULT NULL,
  `s_host_password` varchar(20) DEFAULT NULL,
  `s_node_name` varchar(20) DEFAULT NULL,
  `s_node_class` varchar(20) DEFAULT NULL,
  `s_spark_path` varchar(50) DEFAULT NULL,
  `s_is_running` char(1) DEFAULT '',
  `s_cluster_name` varchar(20) DEFAULT NULL,
  `s_organization_id` int(11) DEFAULT NULL,
  `s_cluster_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`s_host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_spark_host
-- ----------------------------
INSERT INTO `s_spark_host` VALUES ('21', '192.168.23.14', 'root', '123456', 'node4', 'master', '/soft/spark', '', null, '9', '2');
INSERT INTO `s_spark_host` VALUES ('23', '172.16.11.55', 'hadoop', 'hadoop', 'rdpe7', 'master', '/opt/beh/core/spark', null, '测试集群测试test', '8', '1');
INSERT INTO `s_spark_host` VALUES ('24', '172.16.11.55', 'hadoop', 'hadoop', 'rdpe7', 'slaver', '/opt/beh/core/spark', null, '测试集群测试test', '8', '1');
INSERT INTO `s_spark_host` VALUES ('25', '172.16.11.56', 'hadoop', 'hadoop', 'rdpe8', 'slaver', '/opt/beh/core/spark', null, '测试集群测试test', '8', '1');
INSERT INTO `s_spark_host` VALUES ('26', '172.16.11.58', 'hadoop', 'hadoop', 'rdpe9', 'slaver', '/opt/beh/core/spark', null, '测试集群测试test', '8', '1');

-- ----------------------------
-- Table structure for `s_storm_datasource`
-- ----------------------------
DROP TABLE IF EXISTS `s_storm_datasource`;
CREATE TABLE `s_storm_datasource` (
  `event_ds_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `event_flume_id` bigint(20) DEFAULT NULL,
  `event_kafka_id` bigint(20) DEFAULT NULL,
  `event_flume_name` varchar(20) DEFAULT NULL,
  `event_kafka_name` varchar(20) DEFAULT NULL,
  `event_ds_name` varchar(200) DEFAULT NULL,
  `event_ds_desc` varchar(30) DEFAULT NULL,
  `event_ds_run_status` varchar(1) DEFAULT NULL,
  `event_ds_run_pid` varchar(5) DEFAULT NULL,
  `event_ds_type` varchar(1) DEFAULT NULL,
  `serverIp` varchar(20) DEFAULT NULL,
  `serverPort` varchar(5) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `filepath` varchar(100) DEFAULT NULL,
  `socketSeparator` varchar(4) DEFAULT NULL,
  `create_user` varchar(20) DEFAULT NULL,
  `creater_name_id` int(11) DEFAULT NULL,
  `creater_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`event_ds_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_storm_datasource
-- ----------------------------
INSERT INTO `s_storm_datasource` VALUES ('8', '36', '56', 'storm数据流', '11', 'flume-kafka', '从flume-kafka中获取数据', null, null, '0', '', '', '', '', '', ',', null, '33', 'wxx');
INSERT INTO `s_storm_datasource` VALUES ('11', '37', '27', '22', 'newSubscriber', 'test_decode', 'test_decode', null, null, '0', '', '', '', '', '', ',', null, '33', 'wxx');
INSERT INTO `s_storm_datasource` VALUES ('12', '42', '27', '新入网用户flume', 'newSubscriber', '新入网用户数据源', '新入网用户数据源', null, null, '0', '', '', '', '', '', ',', null, '33', 'wxx');
INSERT INTO `s_storm_datasource` VALUES ('13', '46', '31', 'x_flume', 'x_kafka', 'x_storm_source', 'x_storm_source', null, null, '0', '', '', '', '', '', ',', null, '23', 'xieqq');
INSERT INTO `s_storm_datasource` VALUES ('14', '41', '29', 'storm区域位置信息', 'areaLocation', '区域位置信息数据源', '区域位置信息数据源', null, null, '0', '', '', '', '', '', ',', null, '33', 'wxx');
INSERT INTO `s_storm_datasource` VALUES ('15', null, null, '', '', '测试用例socket', '测试用例socket', null, null, '2', '192.168.10.37', '10000', '', '', '', '|', null, '33', 'wxx');
INSERT INTO `s_storm_datasource` VALUES ('16', null, null, '', '', 'x_storm_source_localFile', 'x_storm_source_localFile', null, null, '3', '192.168.10.37', '', 'hadoop', 'hadoop', '/opt/beh/logs/xFlume2/test_station.txt', ',', null, '23', 'xieqq');
INSERT INTO `s_storm_datasource` VALUES ('17', null, null, '', '', 'x_storm_source_hdfs', 'x_storm_source_hdfs', null, null, '4', '', '', '', '', '/x_test/test_station.txt', ',', null, '23', 'xieqq');
INSERT INTO `s_storm_datasource` VALUES ('18', null, null, '', '', 'x_storm_source_socket', 'x_storm_source_socket', null, null, '2', '192.168.110.199', '8888', '', '', '', ',', null, '23', 'xieqq');
INSERT INTO `s_storm_datasource` VALUES ('19', null, null, '', '', 'storm-hdfs数据源', 'storm-hdfs数据源', null, null, '4', '', '', '', '', 'hdfs://192.168.10.37:9000/test/hello.txt', '|', null, '33', 'wxx');
INSERT INTO `s_storm_datasource` VALUES ('20', null, null, '', '', 'HDFS数据源', '', null, null, '4', '', '', '', '', '/beh/core/hdfs', '|', null, '24', 'bianshen');
INSERT INTO `s_storm_datasource` VALUES ('21', null, '31', '', 'x_kafka', 'x_storm_source_kafka', 'x_storm_source_kafka', null, null, '1', '', '', '', '', '', ',', null, '23', 'xieqq');
INSERT INTO `s_storm_datasource` VALUES ('22', '48', '57', '测试', '111', 'storm数据源111', '', null, null, '1', '', '', '', '', '', '|', null, '24', 'bianshen');
INSERT INTO `s_storm_datasource` VALUES ('23', null, '56', '', '11', 'kafka测试数据源11', 'kafka测试数据源11', null, null, '1', '', '', '', '', '', '|', null, '33', 'wxx');
INSERT INTO `s_storm_datasource` VALUES ('24', null, '59', '', 'newSubscriber', 'storm数据源_新入网用户', '新入网用户', null, null, '1', '', '', '', '', '', ',', null, '33', 'wxx');
INSERT INTO `s_storm_datasource` VALUES ('25', null, '62', '', 'area', 'storm数据源_区域位置信息采集', 'storm数据源_区域位置信息采集', null, null, '1', '', '', '', '', '', ',', null, '25', 'admin');

-- ----------------------------
-- Table structure for `s_storm_function`
-- ----------------------------
DROP TABLE IF EXISTS `s_storm_function`;
CREATE TABLE `s_storm_function` (
  `storm_function_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `function_name` varchar(30) DEFAULT NULL,
  `function_desc` varchar(50) DEFAULT NULL,
  `function_path` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`storm_function_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_storm_function
-- ----------------------------
INSERT INTO `s_storm_function` VALUES ('9', 'SplitFunction', '按冒号拆分字符串', '/opt/beh/core/tomcat/tomcat1/function/storm/SplitFunction.java');

-- ----------------------------
-- Table structure for `s_storm_host`
-- ----------------------------
DROP TABLE IF EXISTS `s_storm_host`;
CREATE TABLE `s_storm_host` (
  `s_host_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `s_host_nimbus` varchar(20) DEFAULT NULL,
  `s_host_ui` varchar(20) DEFAULT NULL,
  `s_host_user` varchar(20) DEFAULT NULL,
  `s_host_password` varchar(20) DEFAULT NULL,
  `s_node_name` varchar(20) DEFAULT NULL,
  `s_node_class` varchar(20) DEFAULT NULL,
  `s_storm_path` varchar(50) DEFAULT NULL,
  `s_is_running` varchar(2) DEFAULT NULL,
  `s_cluster_ID` int(11) DEFAULT NULL,
  `s_cluster_name` varchar(20) DEFAULT NULL,
  `s_organization_id` int(11) DEFAULT NULL,
  `s_total_tasks` varchar(10) DEFAULT NULL,
  `s_running_tasks` varchar(10) DEFAULT NULL,
  `us_cpu` varchar(10) DEFAULT NULL,
  `sy_cpu` varchar(10) DEFAULT NULL,
  `id_cpu` varchar(10) DEFAULT NULL,
  `s_total_memory` varchar(10) DEFAULT NULL,
  `s_used_memory` varchar(10) DEFAULT NULL,
  `s_total_disk` varchar(10) DEFAULT NULL,
  `s_used_disk` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`s_host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_storm_host
-- ----------------------------
INSERT INTO `s_storm_host` VALUES ('11', '192.168.10.10', '8080', 'hadoop', 'hadoop', 'hadoop', 'nimbus', '/opt/beh/core/storm', '0', '2', 'x_test', '9', null, null, null, null, null, '', '', null, null);
INSERT INTO `s_storm_host` VALUES ('12', '192.168.10.11', '', 'hadoop', 'hadoop', 'hadoop', 'supervisor', '/opt/beh/core/storm', '0', '2', 'x_test', '9', null, null, null, null, null, '', '', null, null);
INSERT INTO `s_storm_host` VALUES ('13', '192.168.10.12', '', 'hadoop', 'hadoop', 'hadoop', 'supervisor', '/opt/beh/core/storm', '0', '2', 'x_test', '9', null, null, null, null, null, '', '', null, null);
INSERT INTO `s_storm_host` VALUES ('14', '172.16.11.55', '18088', 'hadoop', 'hadoop', 'rdpe7', 'nimbus', '/opt/beh/core/storm', '1', '1', '测试集群', '8', null, null, null, null, null, '', '', null, null);
INSERT INTO `s_storm_host` VALUES ('15', '172.16.11.55', '', 'hadoop', 'hadoop', 'rdpe7', 'supervisor', '/opt/beh/core/storm', '1', '1', '测试集群', '8', null, null, null, null, null, '', '', null, null);
INSERT INTO `s_storm_host` VALUES ('16', '172.16.11.56', '', 'hadoop', 'hadoop', 'rdpe8', 'supervisor', '/opt/beh/core/storm', '1', '1', '测试集群', '8', null, null, null, null, null, '', '', null, null);
INSERT INTO `s_storm_host` VALUES ('17', '172.16.11.58', '', 'hadoop', 'hadoop', 'rdpe9', 'supervisor', '/opt/beh/core/storm', '1', '1', '测试集群', '8', null, null, null, null, null, '', '', null, null);

-- ----------------------------
-- Table structure for `s_zookeeper_host`
-- ----------------------------
DROP TABLE IF EXISTS `s_zookeeper_host`;
CREATE TABLE `s_zookeeper_host` (
  `s_host_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_host_ip` varchar(20) DEFAULT NULL,
  `s_host_user` varchar(20) DEFAULT NULL,
  `s_host_password` varchar(30) DEFAULT NULL,
  `s_zookeeper_home` varchar(100) DEFAULT NULL,
  `s_zookeeper_client_port` varchar(5) DEFAULT NULL,
  `s_organization_id` int(11) DEFAULT NULL,
  `s_cluster_name` varchar(20) DEFAULT NULL,
  `s_cluster_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`s_host_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of s_zookeeper_host
-- ----------------------------
INSERT INTO `s_zookeeper_host` VALUES ('1', '192.168.10.37', 'hadoop', 'hadoop', '/opt/beh/core/zookeeper', '2181', '8', '测试集群', '1');
INSERT INTO `s_zookeeper_host` VALUES ('2', '192.168.10.38', 'hadoop', 'hadoop', '/opt/beh/core/zookeeper', '2181', '8', '测试集群', '1');
INSERT INTO `s_zookeeper_host` VALUES ('3', '192.168.10.39', 'hadoop', 'hadoop', '/opt/beh/core/zookeeper', '2181', '8', '测试集群', '1');
INSERT INTO `s_zookeeper_host` VALUES ('4', '172.16.11.55', 'hadoop', 'hadoop', '/opt/beh/core/zookeeper', '2181', '8', '测试集群测试test', '1');
INSERT INTO `s_zookeeper_host` VALUES ('5', '172.16.11.56', 'hadoop', 'hadoop', '/opt/beh/core/zookeeper', '2181', '8', '测试集群测试test', '1');
INSERT INTO `s_zookeeper_host` VALUES ('6', '172.16.11.58', 'hadoop', 'hadoop', '/opt/beh/core/zookeeper', '2181', '8', '测试集群测试test', '1');
