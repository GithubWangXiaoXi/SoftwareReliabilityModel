/*
Navicat MySQL Data Transfer

Source Server         : localDB
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : failuredata

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2020-05-09 15:28:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `aaa`
-- ----------------------------
DROP TABLE IF EXISTS `aaa`;
CREATE TABLE `aaa` (
  `aaa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of aaa
-- ----------------------------

-- ----------------------------
-- Table structure for `bbb`
-- ----------------------------
DROP TABLE IF EXISTS `bbb`;
CREATE TABLE `bbb` (
  `bbb` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bbb
-- ----------------------------

-- ----------------------------
-- Table structure for `combinationmodel`
-- ----------------------------
DROP TABLE IF EXISTS `combinationmodel`;
CREATE TABLE `combinationmodel` (
  `id` int(11) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `lamda` varchar(255) NOT NULL,
  `pi1` varchar(255) NOT NULL,
  `pi2` varchar(255) NOT NULL,
  `pi3` varchar(255) NOT NULL,
  `pi4` varchar(255) NOT NULL,
  `pi5` varchar(255) NOT NULL,
  `pi6` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of combinationmodel
-- ----------------------------

-- ----------------------------
-- Table structure for `dataset`
-- ----------------------------
DROP TABLE IF EXISTS `dataset`;
CREATE TABLE `dataset` (
  `setname` varchar(20) NOT NULL,
  `tablename` varchar(20) NOT NULL,
  `setdesc` varchar(30) DEFAULT NULL,
  `percentage` int(11) DEFAULT NULL,
  `set_id` int(11) NOT NULL AUTO_INCREMENT,
  `datatype` int(11) DEFAULT NULL,
  PRIMARY KEY (`set_id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dataset
-- ----------------------------
INSERT INTO `dataset` VALUES ('musa', 'musa', '经典模型数据集', '10', '170', '0');
INSERT INTO `dataset` VALUES ('classical model', 'sys1', 'classical failure data', '10', '171', '0');
INSERT INTO `dataset` VALUES ('test1', 'combinationmodel', 'soa data', '0', '187', '1');
INSERT INTO `dataset` VALUES ('pool1', 'servicepool', 'pool1 test', '0', '189', '1');
INSERT INTO `dataset` VALUES ('combination', 'combinationmodel', 'test', '0', '191', '1');
INSERT INTO `dataset` VALUES ('pool2', 'servicepool2', 'pool2 test', '10', '193', '1');
INSERT INTO `dataset` VALUES ('22', 'ezrpt_member_user', '22', '10', '195', '0');

-- ----------------------------
-- Table structure for `ezrpt_member_user`
-- ----------------------------
DROP TABLE IF EXISTS `ezrpt_member_user`;
CREATE TABLE `ezrpt_member_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '系统用户标识',
  `roles` varchar(500) NOT NULL COMMENT '系统用户所属角色集合(role_id以英文逗号分隔)',
  `account` varchar(64) NOT NULL COMMENT '系统用户账号',
  `password` varchar(64) NOT NULL COMMENT '系统用户密码',
  `salt` varchar(50) NOT NULL COMMENT '加盐',
  `name` varchar(50) NOT NULL COMMENT '系统用户姓名',
  `email` varchar(64) NOT NULL COMMENT '系统用户电子邮箱',
  `telephone` varchar(36) NOT NULL COMMENT '系统用户用户电话号码,多个用英文逗号分开',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '系统用户的状态,1表示启用,0表示禁用,默认为1,其他保留',
  `comment` varchar(50) NOT NULL COMMENT '系统用户备注',
  `gmt_created` timestamp NOT NULL DEFAULT '1980-01-01 01:01:01' COMMENT '系统用户记录创建时间',
  `gmt_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '系统用户记录更新时间戳',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_account` (`account`),
  UNIQUE KEY `uk_user_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ezrpt_member_user
-- ----------------------------

-- ----------------------------
-- Table structure for `musa`
-- ----------------------------
DROP TABLE IF EXISTS `musa`;
CREATE TABLE `musa` (
  `failuretime` varchar(20) NOT NULL,
  `d_index` int(11) DEFAULT NULL,
  `d_count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of musa
-- ----------------------------
INSERT INTO `musa` VALUES ('1', '2', '1');
INSERT INTO `musa` VALUES ('2', '2', '12');

-- ----------------------------
-- Table structure for `promotion`
-- ----------------------------
DROP TABLE IF EXISTS `promotion`;
CREATE TABLE `promotion` (
  `PROMOTION_ID` int(11) NOT NULL,
  `PROMOTION_DISTRICT_ID` int(11) DEFAULT NULL,
  `PROMOTION_NAME` varchar(30) DEFAULT NULL,
  `MEDIA_TYPE` varchar(30) DEFAULT NULL,
  `COST` decimal(10,4) DEFAULT NULL,
  `START_DATE` timestamp NULL DEFAULT NULL,
  `END_DATE` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`PROMOTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of promotion
-- ----------------------------

-- ----------------------------
-- Table structure for `servicepool`
-- ----------------------------
DROP TABLE IF EXISTS `servicepool`;
CREATE TABLE `servicepool` (
  `snum` int(11) NOT NULL,
  `lamdaf` varchar(255) NOT NULL,
  `lamdac` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of servicepool
-- ----------------------------
INSERT INTO `servicepool` VALUES ('1', '0.029', '0.021');
INSERT INTO `servicepool` VALUES ('2', '0.035', '0.046');
INSERT INTO `servicepool` VALUES ('3', '0.081', '0.054');

-- ----------------------------
-- Table structure for `servicepool2`
-- ----------------------------
DROP TABLE IF EXISTS `servicepool2`;
CREATE TABLE `servicepool2` (
  `snum` int(11) NOT NULL,
  `lamdaf` varchar(255) NOT NULL,
  `lamdac` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of servicepool2
-- ----------------------------
INSERT INTO `servicepool2` VALUES ('1', '0.023', '0.035');
INSERT INTO `servicepool2` VALUES ('2', '0.096', '0.037');
INSERT INTO `servicepool2` VALUES ('3', '0.113', '0.061');

-- ----------------------------
-- Table structure for `sys1`
-- ----------------------------
DROP TABLE IF EXISTS `sys1`;
CREATE TABLE `sys1` (
  `index` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys1
-- ----------------------------
INSERT INTO `sys1` VALUES ('1', '3');
INSERT INTO `sys1` VALUES ('2', '30');
INSERT INTO `sys1` VALUES ('3', '113');
INSERT INTO `sys1` VALUES ('4', '81');
INSERT INTO `sys1` VALUES ('5', '115');
INSERT INTO `sys1` VALUES ('6', '9');
INSERT INTO `sys1` VALUES ('7', '2');
INSERT INTO `sys1` VALUES ('8', '91');
INSERT INTO `sys1` VALUES ('9', '112');
INSERT INTO `sys1` VALUES ('10', '15');
INSERT INTO `sys1` VALUES ('11', '138');
INSERT INTO `sys1` VALUES ('12', '50');
INSERT INTO `sys1` VALUES ('13', '77');
INSERT INTO `sys1` VALUES ('14', '24');
INSERT INTO `sys1` VALUES ('15', '108');
INSERT INTO `sys1` VALUES ('16', '88');
INSERT INTO `sys1` VALUES ('17', '670');
INSERT INTO `sys1` VALUES ('18', '120');
INSERT INTO `sys1` VALUES ('19', '26');
INSERT INTO `sys1` VALUES ('20', '114');
INSERT INTO `sys1` VALUES ('21', '325');
INSERT INTO `sys1` VALUES ('22', '55');
INSERT INTO `sys1` VALUES ('23', '242');
INSERT INTO `sys1` VALUES ('24', '68');
INSERT INTO `sys1` VALUES ('25', '422');
INSERT INTO `sys1` VALUES ('26', '180');
INSERT INTO `sys1` VALUES ('27', '10');
INSERT INTO `sys1` VALUES ('28', '1146');
INSERT INTO `sys1` VALUES ('29', '600');
INSERT INTO `sys1` VALUES ('30', '15');
INSERT INTO `sys1` VALUES ('31', '36');
INSERT INTO `sys1` VALUES ('32', '4');
INSERT INTO `sys1` VALUES ('33', '0');
INSERT INTO `sys1` VALUES ('34', '8');
INSERT INTO `sys1` VALUES ('35', '227');
INSERT INTO `sys1` VALUES ('36', '65');
INSERT INTO `sys1` VALUES ('37', '176');
INSERT INTO `sys1` VALUES ('38', '58');
INSERT INTO `sys1` VALUES ('39', '457');
INSERT INTO `sys1` VALUES ('40', '300');
INSERT INTO `sys1` VALUES ('41', '97');
INSERT INTO `sys1` VALUES ('42', '263');
INSERT INTO `sys1` VALUES ('43', '452');
INSERT INTO `sys1` VALUES ('44', '255');
INSERT INTO `sys1` VALUES ('45', '197');
INSERT INTO `sys1` VALUES ('46', '193');
INSERT INTO `sys1` VALUES ('47', '6');
INSERT INTO `sys1` VALUES ('48', '79');
INSERT INTO `sys1` VALUES ('49', '816');
INSERT INTO `sys1` VALUES ('50', '1351');
INSERT INTO `sys1` VALUES ('51', '148');
INSERT INTO `sys1` VALUES ('52', '21');
INSERT INTO `sys1` VALUES ('53', '233');
INSERT INTO `sys1` VALUES ('54', '134');
INSERT INTO `sys1` VALUES ('55', '357');
INSERT INTO `sys1` VALUES ('56', '193');
INSERT INTO `sys1` VALUES ('57', '236');
INSERT INTO `sys1` VALUES ('58', '31');
INSERT INTO `sys1` VALUES ('59', '369');
INSERT INTO `sys1` VALUES ('60', '748');
INSERT INTO `sys1` VALUES ('61', '0');
INSERT INTO `sys1` VALUES ('62', '232');
INSERT INTO `sys1` VALUES ('63', '330');
INSERT INTO `sys1` VALUES ('64', '365');
INSERT INTO `sys1` VALUES ('65', '1222');
INSERT INTO `sys1` VALUES ('66', '543');
INSERT INTO `sys1` VALUES ('67', '10');
INSERT INTO `sys1` VALUES ('68', '16');
INSERT INTO `sys1` VALUES ('69', '529');
INSERT INTO `sys1` VALUES ('70', '379');
INSERT INTO `sys1` VALUES ('71', '44');
INSERT INTO `sys1` VALUES ('72', '129');
INSERT INTO `sys1` VALUES ('73', '810');
INSERT INTO `sys1` VALUES ('74', '290');
INSERT INTO `sys1` VALUES ('75', '300');
INSERT INTO `sys1` VALUES ('76', '529');
INSERT INTO `sys1` VALUES ('77', '281');
INSERT INTO `sys1` VALUES ('78', '160');
INSERT INTO `sys1` VALUES ('79', '828');
INSERT INTO `sys1` VALUES ('80', '1011');
INSERT INTO `sys1` VALUES ('81', '445');
INSERT INTO `sys1` VALUES ('82', '296');
INSERT INTO `sys1` VALUES ('83', '1755');
INSERT INTO `sys1` VALUES ('84', '1064');
INSERT INTO `sys1` VALUES ('85', '1783');
INSERT INTO `sys1` VALUES ('86', '860');
INSERT INTO `sys1` VALUES ('87', '983');
INSERT INTO `sys1` VALUES ('88', '707');
INSERT INTO `sys1` VALUES ('89', '33');
INSERT INTO `sys1` VALUES ('90', '868');
INSERT INTO `sys1` VALUES ('91', '724');
INSERT INTO `sys1` VALUES ('92', '2323');
INSERT INTO `sys1` VALUES ('93', '2930');
INSERT INTO `sys1` VALUES ('94', '1461');
INSERT INTO `sys1` VALUES ('95', '843');
INSERT INTO `sys1` VALUES ('96', '12');
INSERT INTO `sys1` VALUES ('97', '261');
INSERT INTO `sys1` VALUES ('98', '1800');
INSERT INTO `sys1` VALUES ('99', '865');
INSERT INTO `sys1` VALUES ('100', '1435');
INSERT INTO `sys1` VALUES ('101', '30');
INSERT INTO `sys1` VALUES ('102', '143');
INSERT INTO `sys1` VALUES ('103', '108');
INSERT INTO `sys1` VALUES ('104', '0');
INSERT INTO `sys1` VALUES ('105', '3110');
INSERT INTO `sys1` VALUES ('106', '1247');
INSERT INTO `sys1` VALUES ('107', '943');
INSERT INTO `sys1` VALUES ('108', '700');
INSERT INTO `sys1` VALUES ('109', '875');
INSERT INTO `sys1` VALUES ('110', '245');
INSERT INTO `sys1` VALUES ('111', '729');
INSERT INTO `sys1` VALUES ('112', '1897');
INSERT INTO `sys1` VALUES ('113', '447');
INSERT INTO `sys1` VALUES ('114', '386');
INSERT INTO `sys1` VALUES ('115', '446');
INSERT INTO `sys1` VALUES ('116', '122');
INSERT INTO `sys1` VALUES ('117', '990');
INSERT INTO `sys1` VALUES ('118', '948');
INSERT INTO `sys1` VALUES ('119', '1082');
INSERT INTO `sys1` VALUES ('120', '22');
INSERT INTO `sys1` VALUES ('121', '75');
INSERT INTO `sys1` VALUES ('122', '482');
INSERT INTO `sys1` VALUES ('123', '5509');
INSERT INTO `sys1` VALUES ('124', '100');
INSERT INTO `sys1` VALUES ('125', '10');
INSERT INTO `sys1` VALUES ('126', '1071');
INSERT INTO `sys1` VALUES ('127', '371');
INSERT INTO `sys1` VALUES ('128', '790');
INSERT INTO `sys1` VALUES ('129', '6150');
INSERT INTO `sys1` VALUES ('130', '3321');
INSERT INTO `sys1` VALUES ('131', '1045');
INSERT INTO `sys1` VALUES ('132', '648');
INSERT INTO `sys1` VALUES ('133', '5485');
INSERT INTO `sys1` VALUES ('134', '1160');
INSERT INTO `sys1` VALUES ('135', '1864');
INSERT INTO `sys1` VALUES ('136', '4116');

-- ----------------------------
-- Table structure for `sys1failuecount`
-- ----------------------------
DROP TABLE IF EXISTS `sys1failuecount`;
CREATE TABLE `sys1failuecount` (
  `time` varchar(255) DEFAULT NULL,
  `failurecount` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys1failuecount
-- ----------------------------
INSERT INTO `sys1failuecount` VALUES ('1', '3', '0');
INSERT INTO `sys1failuecount` VALUES ('2', '30', '1');
INSERT INTO `sys1failuecount` VALUES ('3', '113', '0');
INSERT INTO `sys1failuecount` VALUES ('4', '81', '0');
INSERT INTO `sys1failuecount` VALUES ('5', '115', '0');
INSERT INTO `sys1failuecount` VALUES ('6', '9', '1');
INSERT INTO `sys1failuecount` VALUES ('7', '2', '0');
INSERT INTO `sys1failuecount` VALUES ('8', '91', '1');
INSERT INTO `sys1failuecount` VALUES ('9', '112', '1');
INSERT INTO `sys1failuecount` VALUES ('10', '15', '1');
INSERT INTO `sys1failuecount` VALUES ('11', '138', '0');
INSERT INTO `sys1failuecount` VALUES ('12', '50', '0');
INSERT INTO `sys1failuecount` VALUES ('13', '77', '0');
INSERT INTO `sys1failuecount` VALUES ('14', '24', '1');
INSERT INTO `sys1failuecount` VALUES ('15', '108', '0');
INSERT INTO `sys1failuecount` VALUES ('16', '88', '1');
INSERT INTO `sys1failuecount` VALUES ('17', '670', '0');
INSERT INTO `sys1failuecount` VALUES ('18', '120', '0');
INSERT INTO `sys1failuecount` VALUES ('19', '26', '1');
INSERT INTO `sys1failuecount` VALUES ('20', '114', '0');
INSERT INTO `sys1failuecount` VALUES ('21', '325', '1');
INSERT INTO `sys1failuecount` VALUES ('22', '55', '0');
INSERT INTO `sys1failuecount` VALUES ('23', '242', '1');
INSERT INTO `sys1failuecount` VALUES ('24', '68', '0');
INSERT INTO `sys1failuecount` VALUES ('25', '422', '1');
INSERT INTO `sys1failuecount` VALUES ('26', '180', '1');
INSERT INTO `sys1failuecount` VALUES ('27', '10', '0');
INSERT INTO `sys1failuecount` VALUES ('28', '1146', '0');
INSERT INTO `sys1failuecount` VALUES ('29', '600', '1');
INSERT INTO `sys1failuecount` VALUES ('30', '15', '0');
INSERT INTO `sys1failuecount` VALUES ('31', '36', '0');
INSERT INTO `sys1failuecount` VALUES ('32', '4', '1');
INSERT INTO `sys1failuecount` VALUES ('33', '0', '0');
INSERT INTO `sys1failuecount` VALUES ('34', '8', '1');
INSERT INTO `sys1failuecount` VALUES ('35', '227', '0');
INSERT INTO `sys1failuecount` VALUES ('36', '65', '1');
INSERT INTO `sys1failuecount` VALUES ('37', '176', '0');
INSERT INTO `sys1failuecount` VALUES ('38', '58', '1');
INSERT INTO `sys1failuecount` VALUES ('39', '457', '1');
INSERT INTO `sys1failuecount` VALUES ('40', '300', '1');
INSERT INTO `sys1failuecount` VALUES ('41', '97', '0');
INSERT INTO `sys1failuecount` VALUES ('42', '263', '0');
INSERT INTO `sys1failuecount` VALUES ('43', '452', '0');
INSERT INTO `sys1failuecount` VALUES ('44', '255', '1');
INSERT INTO `sys1failuecount` VALUES ('45', '197', '0');
INSERT INTO `sys1failuecount` VALUES ('46', '193', '1');
INSERT INTO `sys1failuecount` VALUES ('47', '6', '0');
INSERT INTO `sys1failuecount` VALUES ('48', '79', '1');
INSERT INTO `sys1failuecount` VALUES ('49', '816', '0');
INSERT INTO `sys1failuecount` VALUES ('50', '1351', '1');
INSERT INTO `sys1failuecount` VALUES ('51', '148', '0');
INSERT INTO `sys1failuecount` VALUES ('52', '21', '0');
INSERT INTO `sys1failuecount` VALUES ('53', '233', '1');
INSERT INTO `sys1failuecount` VALUES ('54', '134', '0');
INSERT INTO `sys1failuecount` VALUES ('55', '357', '1');
INSERT INTO `sys1failuecount` VALUES ('56', '193', '0');
INSERT INTO `sys1failuecount` VALUES ('57', '236', '0');
INSERT INTO `sys1failuecount` VALUES ('58', '31', '1');
INSERT INTO `sys1failuecount` VALUES ('59', '369', '0');
INSERT INTO `sys1failuecount` VALUES ('60', '748', '1');
INSERT INTO `sys1failuecount` VALUES ('61', '0', '0');
INSERT INTO `sys1failuecount` VALUES ('62', '232', '1');
INSERT INTO `sys1failuecount` VALUES ('63', '330', '0');
INSERT INTO `sys1failuecount` VALUES ('64', '365', '0');
INSERT INTO `sys1failuecount` VALUES ('65', '1222', '1');
INSERT INTO `sys1failuecount` VALUES ('66', '543', '1');
INSERT INTO `sys1failuecount` VALUES ('67', '10', '0');
INSERT INTO `sys1failuecount` VALUES ('68', '16', '1');
INSERT INTO `sys1failuecount` VALUES ('69', '529', '0');
INSERT INTO `sys1failuecount` VALUES ('70', '379', '0');
INSERT INTO `sys1failuecount` VALUES ('71', '44', '1');
INSERT INTO `sys1failuecount` VALUES ('72', '129', '0');
INSERT INTO `sys1failuecount` VALUES ('73', '810', '1');
INSERT INTO `sys1failuecount` VALUES ('74', '290', '0');
INSERT INTO `sys1failuecount` VALUES ('75', '300', '1');
INSERT INTO `sys1failuecount` VALUES ('76', '529', '1');
INSERT INTO `sys1failuecount` VALUES ('77', '281', '0');
INSERT INTO `sys1failuecount` VALUES ('78', '160', '0');
INSERT INTO `sys1failuecount` VALUES ('79', '828', '1');
INSERT INTO `sys1failuecount` VALUES ('80', '1011', '1');
INSERT INTO `sys1failuecount` VALUES ('81', '445', '0');
INSERT INTO `sys1failuecount` VALUES ('82', '296', '0');
INSERT INTO `sys1failuecount` VALUES ('83', '1755', '0');
INSERT INTO `sys1failuecount` VALUES ('84', '1064', '1');
INSERT INTO `sys1failuecount` VALUES ('85', '1783', '0');
INSERT INTO `sys1failuecount` VALUES ('86', '860', '0');
INSERT INTO `sys1failuecount` VALUES ('87', '983', '1');
INSERT INTO `sys1failuecount` VALUES ('88', '707', '0');
INSERT INTO `sys1failuecount` VALUES ('89', '33', '1');
INSERT INTO `sys1failuecount` VALUES ('90', '868', '0');
INSERT INTO `sys1failuecount` VALUES ('91', '724', '0');
INSERT INTO `sys1failuecount` VALUES ('92', '2323', '1');
INSERT INTO `sys1failuecount` VALUES ('93', '2930', '1');
INSERT INTO `sys1failuecount` VALUES ('94', '1461', '0');
INSERT INTO `sys1failuecount` VALUES ('95', '843', '0');
INSERT INTO `sys1failuecount` VALUES ('96', '12', '0');
INSERT INTO `sys1failuecount` VALUES ('97', '261', '0');
INSERT INTO `sys1failuecount` VALUES ('98', '1800', '1');
INSERT INTO `sys1failuecount` VALUES ('99', '865', '0');
INSERT INTO `sys1failuecount` VALUES ('100', '1435', '1');
INSERT INTO `sys1failuecount` VALUES ('101', '30', '0');
INSERT INTO `sys1failuecount` VALUES ('102', '143', '1');
INSERT INTO `sys1failuecount` VALUES ('103', '108', '0');
INSERT INTO `sys1failuecount` VALUES ('104', '0', '0');
INSERT INTO `sys1failuecount` VALUES ('105', '3110', '1');
INSERT INTO `sys1failuecount` VALUES ('106', '1247', '1');
INSERT INTO `sys1failuecount` VALUES ('107', '943', '1');
INSERT INTO `sys1failuecount` VALUES ('108', '700', '0');
INSERT INTO `sys1failuecount` VALUES ('109', '875', '0');
INSERT INTO `sys1failuecount` VALUES ('110', '245', '0');
INSERT INTO `sys1failuecount` VALUES ('111', '729', '0');
INSERT INTO `sys1failuecount` VALUES ('112', '1897', '1');
INSERT INTO `sys1failuecount` VALUES ('113', '447', '1');
INSERT INTO `sys1failuecount` VALUES ('114', '386', '0');
INSERT INTO `sys1failuecount` VALUES ('115', '446', '0');
INSERT INTO `sys1failuecount` VALUES ('116', '122', '1');
INSERT INTO `sys1failuecount` VALUES ('117', '990', '1');
INSERT INTO `sys1failuecount` VALUES ('118', '948', '0');
INSERT INTO `sys1failuecount` VALUES ('119', '1082', '0');
INSERT INTO `sys1failuecount` VALUES ('120', '22', '0');
INSERT INTO `sys1failuecount` VALUES ('121', '75', '0');
INSERT INTO `sys1failuecount` VALUES ('122', '482', '0');
INSERT INTO `sys1failuecount` VALUES ('123', '5509', '1');
INSERT INTO `sys1failuecount` VALUES ('124', '100', '0');
INSERT INTO `sys1failuecount` VALUES ('125', '10', '1');
INSERT INTO `sys1failuecount` VALUES ('126', '1071', '0');
INSERT INTO `sys1failuecount` VALUES ('127', '371', '1');
INSERT INTO `sys1failuecount` VALUES ('128', '790', '0');
INSERT INTO `sys1failuecount` VALUES ('129', '6150', '0');
INSERT INTO `sys1failuecount` VALUES ('130', '3321', '0');
INSERT INTO `sys1failuecount` VALUES ('131', '1045', '0');
INSERT INTO `sys1failuecount` VALUES ('132', '648', '0');
INSERT INTO `sys1failuecount` VALUES ('133', '5485', '0');
INSERT INTO `sys1failuecount` VALUES ('134', '1160', '1');
INSERT INTO `sys1failuecount` VALUES ('135', '1864', '1');
INSERT INTO `sys1failuecount` VALUES ('136', '4116', '1');

-- ----------------------------
-- Table structure for `usermanager`
-- ----------------------------
DROP TABLE IF EXISTS `usermanager`;
CREATE TABLE `usermanager` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of usermanager
-- ----------------------------
INSERT INTO `usermanager` VALUES ('a', 'a', 'abc@nuaa.edu.cn');
INSERT INTO `usermanager` VALUES ('admin', 'admin', 'depingzhang@163.com');
INSERT INTO `usermanager` VALUES ('admin1', 'zl33210', 'admin1@nuaa.edu.cn');
INSERT INTO `usermanager` VALUES ('admin2', '111111', 'admin2@163.com');
