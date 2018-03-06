/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : online-registration

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2018-03-06 20:36:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `is_super` smallint(6) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `ix_admin_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', 'AdwardAdmin', 'pbkdf2:sha256:50000$4SJTrOL8$d5cffb5bec07829709788bf3d71e757c12443b7e2e4873b831bde0e8d3053cf5', '0', '2018-02-08 22:54:56');

-- ----------------------------
-- Table structure for adminlog
-- ----------------------------
DROP TABLE IF EXISTS `adminlog`;
CREATE TABLE `adminlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_adminlog_addtime` (`addtime`),
  CONSTRAINT `adminlog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adminlog
-- ----------------------------
INSERT INTO `adminlog` VALUES ('1', '1', '127.0.0.1', '2018-02-12 21:22:37');
INSERT INTO `adminlog` VALUES ('2', '1', '127.0.0.1', '2018-02-27 10:45:34');
INSERT INTO `adminlog` VALUES ('3', '1', '127.0.0.1', '2018-03-02 13:47:49');
INSERT INTO `adminlog` VALUES ('4', '1', '127.0.0.1', '2018-03-03 14:45:58');
INSERT INTO `adminlog` VALUES ('5', '1', '127.0.0.1', '2018-03-04 16:18:57');
INSERT INTO `adminlog` VALUES ('6', '1', '127.0.0.1', '2018-03-05 14:20:50');
INSERT INTO `adminlog` VALUES ('7', '1', '127.0.0.1', '2018-03-06 10:25:10');

-- ----------------------------
-- Table structure for admission
-- ----------------------------
DROP TABLE IF EXISTS `admission`;
CREATE TABLE `admission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admission_id` varchar(18) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `tinfo_id` int(11) DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admission_id` (`admission_id`),
  UNIQUE KEY `admission_id_2` (`admission_id`),
  KEY `user_id` (`user_id`),
  KEY `tinfo_id` (`tinfo_id`),
  KEY `ix_admission_addtime` (`addtime`),
  CONSTRAINT `admission_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `admission_ibfk_2` FOREIGN KEY (`tinfo_id`) REFERENCES `tinfo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admission
-- ----------------------------

-- ----------------------------
-- Table structure for newscategory
-- ----------------------------
DROP TABLE IF EXISTS `newscategory`;
CREATE TABLE `newscategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `ix_newscategory_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newscategory
-- ----------------------------
INSERT INTO `newscategory` VALUES ('1', '首页', '2018-02-08 13:22:01');
INSERT INTO `newscategory` VALUES ('2', '资格考试', '2018-02-08 13:59:59');
INSERT INTO `newscategory` VALUES ('3', '考试动态', '2018-02-08 14:01:07');
INSERT INTO `newscategory` VALUES ('4', '工作动态', '2018-02-08 21:34:52');
INSERT INTO `newscategory` VALUES ('5', '政策法规', '2018-03-02 13:49:30');
INSERT INTO `newscategory` VALUES ('7', '政务公开', '2018-03-06 18:05:26');

-- ----------------------------
-- Table structure for newsinfo
-- ----------------------------
DROP TABLE IF EXISTS `newsinfo`;
CREATE TABLE `newsinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `content` varchar(20000) DEFAULT NULL,
  `view_num` int(11) DEFAULT NULL,
  `admin_id` int(11) DEFAULT NULL,
  `newstag_id` int(11) DEFAULT NULL,
  `img` varchar(300) DEFAULT NULL,
  `remark` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `title_2` (`title`),
  KEY `admin_id` (`admin_id`),
  KEY `newstag_id` (`newstag_id`),
  KEY `ix_newsinfo_addtime` (`addtime`),
  CONSTRAINT `newsinfo_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE CASCADE,
  CONSTRAINT `newsinfo_ibfk_2` FOREIGN KEY (`newstag_id`) REFERENCES `newstag` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newsinfo
-- ----------------------------
INSERT INTO `newsinfo` VALUES ('1', '全国一、二级注册结构工程师执业资格考试', '<div align=\"center\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">全国一、二级注册结构工程师执业资格考试</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"></span>&nbsp;</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 根据《关于印发《注册结构工程师执业资格暂行规定》的通知》(建办设[1997]222号)文件精神，从1997年起，国家实行注册结构工程师执业资格制度。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师．是指取得中华人民共和国注册结构工程师执业资格证书和注册证书，从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员，注册结构工程师分为一级注册结构工程师和二级注册结构工程师。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 一、组织领导</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师资格制度纳入专业技术人员执业资格制度，由国家确认批准。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 建设部、人事部和省、自治区、直辖市人民政府建设行政主管部门、人事行政主管部门依照有关规定对注册结构工程师的考试、注册和执业实施指导、监督和管理。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"font-weight: 700;\">二、适用范围</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　适用于从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员 。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 三、考试时间及科目设置</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师考试实行全国统一大纲、统一命题、统一组织的办法，原则上每年举行一次。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 一级注册注册结构工程师设《基础考试》和《专业考试》两部分；二级注册注册结构工程师只设《专业考试》。其中，《基础考试》为客观题，在答题卡上作答；《专业考试》采取主、客观相结合的考试方法，即：要求考生在填涂答题卡的同时，在答题纸上写出计算过程。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一级注册结构工程师基础考试为闭卷考试，只允许考生使用统一配发的《考试手册》（考后收回），禁止携带其他参考资料。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一、二级注册结构工程师专业考试为开卷考试，考试时允许考生携带正规出版社出版的各种专业规范和参考书。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 四、报考条件</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（一）全国一级注册结构工程师执业资格考试基础科目考试报考条件</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 2、1971年（含1971年）以后毕业，不具备规定学历的人员,从事建筑工程设计工作累计15年以上，且具备下列条件之一，也可申报一级注册结构工程师资格考试基础科目的考试 ：</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（1）作为专业负责人或主要设计人，完成建筑工程分类标准三级以上项目4项（全过程设计），其中二级以上项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（2）作为专业负责人或主要设计人，完成中型工业建筑工程以上项目4项（全过程设计），其中大型项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><br></div>', '0', '1', '1', '20180304134734466e34d230d9495992d6768ec4960bab.jpg;', '', '2018-02-10 11:42:09');
INSERT INTO `newsinfo` VALUES ('3', '2018年度专业技术人员资格考试工作计划', '<table align=\"center\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"color: rgb(45, 2, 1); font-family: 宋体; font-size: 12px; background-color: rgb(255, 255, 255);\"><thead><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; text-align: right; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">序号</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">专业名称</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">考试日期</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">1</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">咨询工程师（投资）</p></th><th style=\"margin: 0px; width: 185px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">4月14、15日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">2</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">房地产经纪人协理、房地产经纪人</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">4月21、22日</p></th></tr><tr><th rowspan=\"2\" style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">3</p></th><th colspan=\"2\" rowspan=\"2\" style=\"margin: 0px; width: 137px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">注册建筑师</p></th><th style=\"margin: 0px; width: 239px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">一级</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月5、6、12、13日</p></th></tr><tr><th style=\"margin: 0px; width: 239px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">二级</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月5、6日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">4</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">护士执业资格</p></th><th style=\"margin: 0px; width: 185px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月5-7日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">会计（初级）</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月12-20日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">监理工程师</p></th><th rowspan=\"3\" style=\"margin: 0px; width: 185px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月19、20日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">7</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">环境影响评价工程师</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 25px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">8</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 25px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">翻译专业资格（一、二、三级）</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">9</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">卫生（初级、中级）</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月26、27日、</p><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6月2、3日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">10</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">计算机技术与软件（初级、中级、高级）</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月26、27日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">11</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">银行业专业人员职业资格（初级、中级）</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6月2、3日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">12</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">助理社会工作师、社会工作师</p></th><th rowspan=\"2\" style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6月9、10日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">13</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">机动车检测维修士、机动车检测维修工程师</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">14</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">注册计量师（一级）</p></th><th rowspan=\"2\" style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6月23、24日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">15</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">土地登记代理人</p></th></tr></thead></table>', '10', '1', '7', '', '声明：【测试数据】本网所刊载的所有信息，包括文字、图片、软件、声音、相片、录相、图表，广告、商业信息及电子邮件的全部内容，除特别标明之外，版权归中国计算机技术职业资格网所有。未经本网的明确书面许可，任何单位或个人不得以任何方式作全部或局部复制、转载、引用，再造或创造与该内容有关的任何派生产品，否则本网将追究其法律责任。 本网凡特别注明稿件来源的文/图等稿件为转载稿，本网转载出于传递更多信息之目的，并不意味着赞同其观点或证实其内容的真实性。如对稿件内容有疑议，请及时与我们联系。 如本网转载稿涉及版权问题，请作者在两周内速来电或来函与我们联系，我们将及时按作者意愿予以更正。', '2018-03-03 16:38:25');
INSERT INTO `newsinfo` VALUES ('5', '关于2018年上半年计算机技术与软件专业技术资格（水平）考试报名的通知', '<div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><div>&nbsp;&nbsp;&nbsp;<strong>一、考试报名</strong></div><div>&nbsp;&nbsp;&nbsp; 考试采取网上报名和网上缴费的方式进行。报考人员可直接登录内蒙古人事考试信息网（<a href=\"http://www.impta.com/\">www.impta.com</a>）报名。网上报名时间:2018年3月1日—3月23日；网上缴费时间：2018年3月1日—3月25日。</div><div>&nbsp;&nbsp;&nbsp;&nbsp;<strong>二、考试时间</strong></div><div>&nbsp;&nbsp;&nbsp; 2018年5月26日</div><div>&nbsp;&nbsp;&nbsp;&nbsp;<strong>三、考试级别和各级别专业资格</strong></div><div>&nbsp;&nbsp;&nbsp; 计算机技术与软件专业技术资格（水平）考试分为高级、中级、初级3个级别。其中高级级别设信息系统项目管理师、系统分析师和系统规划与管理师3个专业资格；中级级别设软件设计师、网络工程师、信息系统监理师、系统集成项目管理工程师、信息系统管理工程师、信息安全工程师和数据库系统工程师7个专业资格；初级级别设程序员、网络管理员和信息处理技术员3个专业资格。</div><div>&nbsp;&nbsp;&nbsp;&nbsp;<strong>四、考试科目</strong></div><div>&nbsp;&nbsp;&nbsp; 高级级别3个专业资格考试科目为综合知识、案例分析和论文3个考试科目；中级和初级10个专业资格考试科目为基础知识和应用技术2个考试科目。</div><div>&nbsp;&nbsp;&nbsp;&nbsp;<strong>五、考区设置</strong></div><div>&nbsp;&nbsp;&nbsp; 2018年上半年计算机技术与软件专业资格（水平）考试全区只在呼和浩特市设区直考区。</div><div>&nbsp;&nbsp;&nbsp;&nbsp;<strong>六、考试费用</strong></div><div>&nbsp;&nbsp;&nbsp; 根据原自治区发展计划委员会《关于核定各类专业技术资格、执业资格考试等收费的批复》（内计费字〔2002〕887号）规定，每人收取报名费20元，每人每科次收取考务费50元。</div><div>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><div align=\"right\">&nbsp;&nbsp; 内蒙古自治区人事考试中心</div><div align=\"right\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2018年2月24日</div></div>', '0', '1', '7', '', '', '2018-03-06 10:40:42');
INSERT INTO `newsinfo` VALUES ('6', '关于2018年上半年翻译专业资格（水平）考试笔译考试报名的通知', '<div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><strong>一、考试报名</strong></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 凡符合人力资源和社会保障部《关于印发〈资深翻译和一级翻译专业资格（水平）评价办法（试行）〉的通知》（人社部发〔2011〕51号）文件规定报考条件的人员，均可报名参加一级翻译专业资格（水平）考试笔译考试。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 根据原人事部《关于印发〈翻译专业资格（水平）考试暂行规定〉的通知》（人发〔2003〕21号）、原人事部办公厅《关于印发〈二级、三级翻译专业资格（水平）考试实施办法〉的通知》（国人厅发〔2003〕17号），二、三级翻译专业资格（水平）考试笔译考试不限制报名条件。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; &nbsp;考试报名采用网上报名、现场审核、网上缴费的方式进行。报考人员完成网上缴费后，方可视为报名成功。网上报名时间：2018年2月28日—3月20日；现场审核时间：2018年3月19日—21日；网上缴费时间：2018年2月28日—3月22日。报名网址为中国人事考试网（www.cpta.com.cn）或全国专业技术人员资格考试报名服务平台(zg.cpta.com.cn/examfront）。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp; &nbsp;&nbsp;<strong>二、部分科目免试条件</strong></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; &nbsp;根据国务院学位委员会、教育部、人力资源和社会保障部《关于翻译硕士专业学位教育与翻译专业资格（水平）证书衔接有关事项的通知》（学位〔2008〕28号）规定，在校翻译硕士专业学位研究生，凭学校开具的“翻译硕士专业学位研究生在读证明”（样式见附件，加盖学校公章）在报考二级笔译专业资格（水平）考试时免试《笔译综合能力》科目，只参加《笔译实务》科目考试，网上报名时必须选择级别为“笔译1科”。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 全国现有215所翻译硕士专业学位（MTI）教育试点单位，我区内蒙古大学、内蒙古师范大学为翻译硕士专业学位（MTI）教育试点单位。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>三、考试科目及成绩管理</strong></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 一级笔译考试设《笔译实务》1个科目，二、三级笔译考试设《笔译综合能力》和《笔译实务》2个科目。参加考试的人员必须一次性通过全部考试科目，方可取得《中华人民共和国翻译专业资格（水平）证书》。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>四、考试时间</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 5月20日上午 9:30—11:30&nbsp; 二、三级《笔译综合能力》&nbsp;&nbsp;</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;下午 14:00—17:00 一、二、三级《笔译实务》</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>五、应试人员须知</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; （一）应试人员应考时，应携带黑色墨水笔、橡皮和2B铅笔。参加《笔译实务》科目考试，应试人员可携带纸质中英、英中词典各一本。试卷袋中每份试卷配草稿纸一张。考场备有草稿纸，供应试人员使用。所有草稿纸考后统一收回。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; （二）一、二、三级《笔译实务》科目均在专用答题卡上作答；二、三级《笔译综合能力》科目均在答题卡上作答。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp; &nbsp;&nbsp;应试人员在答题前要仔细阅读注意事项（试卷封二）和作答须知（专用答题卡首页）；要使用规定的作答工具作答；要在专用答题卡指定的区域内作答。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; （三）考试结束后将进行雷同试卷的检测和认定，对认定为雷同试卷的，按规定给予成绩无效的处理。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>六、</strong>有关考试大纲、考试用书等相关事项请与中国外交局翻译专业资格考评中心联系。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>七、考区设置</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 2018年上半年全国翻译专业资格（水平）考试笔译考试全区只在呼和浩特市设区直考区。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>八、成绩查询</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 考试结束60天后，应试人员可通过中国人事考试网（www.cpta.com.cn）或全国翻译专业资格（水平）考试网（www.catti.net.cn）查询考试成绩。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>九、考试费用</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 根据《关于调整全国翻译专业资格（水平）考试考务费收费标准的通知》（外文考办字〔2016〕6号）和内蒙古自治区原发展计划委员会《关于核定各类专业技术资格、执业资格考试等收费的批复》（内计费字〔2002〕887号）规定，每人收取报名费20元，各级别笔译综合能力科目每人收取考务费61元，各级别笔译实务科目每人收取考务费65元。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;</div><div align=\"right\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;</div><div align=\"right\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">内蒙古自治区人事考试中心</div><div align=\"right\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2018年2月24日&nbsp; &nbsp; &nbsp;</div>', '6', '1', '7', '', '', '2018-03-06 11:35:28');
INSERT INTO `newsinfo` VALUES ('7', '关于2018年度全国一、二级注册建筑师资格考试报名的通知', '<div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;<strong>&nbsp;一、考试报名</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 考试采取网上报名和网上缴费的方式进行。报考人员需登录全国专业技术人员资格考试报名服务平台报名。网上报名链接地址：<a href=\"http://www.cpta.com.cn/\">www.cpta.com.cn</a>（中国人事考试网）或zg.cpta.com.cn/examfront(报名登录界面）。网上报名时间：2018年2月26日—3月13日；资格审查时间：2018年3月12日—14日；网上缴费时间：2018年2月26日—3月15日。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 以前年度在我区报名参加过此项考试且本年度报考级别不变的不再进行资格审查，可直接报名缴费。报考人员完成网上缴费后，方可视为报名成功。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>二、报考条件</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; （一）一级注册建筑师资格考试报考条件。一级注册建筑师资格考试首次报考人员需满足下列条件：</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 1.专业、学历及工作时间要求</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; （1）本文附件1所列学位或学历毕业人员按该表要求执行；</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; （2）不具备本文附件1所规定学历的申请报名考试人员应从事工程设计工作满15年且应具备下列条件之一：</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; a.在注册建筑师职业制度实施之前，作为项目负责人或专业负责人完成民用建筑设计三级及以上项目四项全过程设计，其中二级以上项目不少于一项。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; b.在注册建筑师执业制度实施前，作为项目负责人或专业负责人完成其它类型建筑设计中型及以上项目四项全过程设计，其中大型项目或特种建筑项目不少于一项。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 说明：民用建筑设计、其它类型建筑设计等级的划分参见国家物价局、建设部《关于发布工程勘察和工程设计收费标准的通知》（〔1992〕价费字375号）及《工程设计收费标准（1992年修订本）》中的工程等级划分部分。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 2.职业实践要求</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 按照一级注册建筑师职业实践标准，申请报考人员应完成不少于700个单元的职业实践训练。报考人员应提供全国注册建筑建筑师管理委员会统一印制或个人下载打印的《一级注册建筑师职业实践登记手册》，以供审查。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; （二）二级注册建筑师资格考试报考条件。二级注册建筑师资格考试首次报考人员需满足下列条件之一：</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 1.专业、学历及工作时间按本文附件2要求执行；</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 2.具有助理建筑师、助理工程师以上专业技术职称，并从事建筑设计或者相关业务3年（含3年）以上；</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 3.不具备本文附件2所规定学历的申请报名考试人员应从事工程设计工作满13年且应具备下列条件之一：</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; （1）在注册建筑师执业制度实施之前，作为项目负责人或专业负责人完成民用建筑设计四级及以上项目四项全过程设计，其中三级以上项目不少于一项。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; （2）在注册建筑师执业制度实施之前，作为项目负责人或专业负责人完成其它类型建筑设计小型及以上项目四项全过程设计，其中中型项目不少于一项。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>三、考试时间及科目</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 考试时间及科目见“2018年度全国一、二级注册建筑师资格考试考试时间及科目表”（附件3）。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>四、考前准备</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 为帮助应试人员做好2018年度考试准备工作，人力资源社会保障部人事考试中心已经在部级报名须知中提示报考人员下载并认真阅读《2018年度全国一、二级注册建筑师资格考试应试人员注意事项》（附件4）。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; &nbsp;<strong>五、考区设置</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; &nbsp;2018年度全国一、二级注册建筑师资格考试全区只在呼和浩特市设区直考区。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; &nbsp;<strong>六、考试收费</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; &nbsp;根据《住房城乡建设部关于重新发布有关专业技术人员资格考试项目收费标准的通知》（建计〔2016〕82号）和《内蒙古自治区发展计划委员会关于核定各类专业技术资格、执业资格考试等收费的批复》（内计费字〔2002〕887号）规定，每人收取报名费20元。其中一级建筑师知识题（选择题）考试每科63元，一级注册建筑师作图题考试每科152元；二级注册建筑师知识题（选择题）考试每科70元，二级注册建筑师作图题考试每科75元。</div>', '5', '1', '7', '', '', '2018-03-06 11:36:25');
INSERT INTO `newsinfo` VALUES ('8', '关于2018年度全国监理工程师资格考试报名的通知', '<div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><strong>&nbsp; 一、考试报名</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; 凡符合原人事部办公厅、建设部办公厅联合下发的《关于做好1998年度全国监理工程师执业资格考试工作的通知》（人办发〔1997〕105号）文件规定报考条件的人员，均可报名参加监理工程师资格考试。考试采取网上报名和网上缴费的方式进行。报考人员需登录全国专业技术人员资格考试报名服务平台报名。网上报名链接地址：www.cpta.com.cn（中国人事考试网）或zg.cpta.com.cn/examfront(报名登录界面）。网上报名时间：2018年2月28日—3月20日；资格审查时间：2018年3月19日—21日；网上缴费时间：2018年2月28日—3月22日。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 以前年度在自治区参加过此项考试的人员可直接报名缴费，不再进行资格审查。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>二、考试科目及成绩管理</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 监理工程师资格考试设置4个科目：建设工程合同管理（客观题），建设工程质量、投资、进度控制（客观题），建设工程监理基本理论与相关法规（客观题）和建设工程监理案例分析（主观题）。监理工程师资格考试成绩实行滚动管理，参加4个科目考试（级别为考全科）的人员必须在连续2个考试年度内通过全部应试科目为合格；符合免试条件，参加2个科目考试（级别为免2科）的人员必须在1个考试年度内通过应试科目为合格。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>三、考试时间</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 5月19日</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 上午 &nbsp;9:00—11:00 建设工程合同管理</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 下午 14:00—17:00建设工程质量、投资、进度控制</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 5月20日</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 上午 &nbsp;9:00—11:00建设工程监理基本理论与相关法规&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 下午 14:00—18:00建设工程监理案例分析</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>四</strong>、2018年继续使用2014年版监理工程师资格考试大纲和考试用书，有关事宜请与中国建设监理协会或中国建筑工业出版社联系。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>五、应试人员须知</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; (一)应试考试人员应考时，应携带黑色墨水笔、2B铅笔、橡皮、无声无文本编辑功能的计算器。考场备有草稿纸，供应试人员使用，考后收回。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; (二)客观题在答题卡上作答。主观题《建设工程监理案例分析》科目在专用答题卡上作答。应试人员在答题前要仔细阅读应试人员注意事项（试卷封二）和作答须知（专用答题卡首页）；要使用规定的作答工具作答；要在答题卡划定的区域内作答。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp; &nbsp;&nbsp;(三)考试结束后将进行雷同试卷的检测和认定,对认定为雷同试卷的,按规定给予成绩无效的处理。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><strong>&nbsp;&nbsp;&nbsp; 六、考区设置</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp; &nbsp;&nbsp;2018年度全国监理工程师资格考试全区只在呼和浩特市设区直考区。</div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp; &nbsp;<strong>七、考试收费</strong></div><div style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 根据《人力资源社会保障部办公厅关于下发执业药师资格考试等18项专业技术人员资格考试考务费收费标准的通知》（人社厅函〔2015〕278号）和内蒙古自治区原发展计划委员会《关于核定各类专业技术资格、执业资格考试等收费标准的批复》（内计费字〔2002〕887号）的规定，每人收取考试报名费20元。客观题科目每人每科收取考务费61元，主观题科目每人每科收取考务费69元。</div><div align=\"right\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><a name=\"OLE_LINK2\"></a><a name=\"OLE_LINK1\">&nbsp;</a></div><div align=\"right\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;</div><div align=\"right\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">内蒙古自治区人事考试中心</div><div align=\"right\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;2018年2月24日&nbsp; &nbsp;</div>', '1', '1', '7', '', '', '2018-03-06 11:47:30');

-- ----------------------------
-- Table structure for newstag
-- ----------------------------
DROP TABLE IF EXISTS `newstag`;
CREATE TABLE `newstag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `newscategory_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `name_2` (`name`),
  KEY `newscategory_id` (`newscategory_id`),
  KEY `ix_newstag_addtime` (`addtime`),
  CONSTRAINT `newstag_ibfk_1` FOREIGN KEY (`newscategory_id`) REFERENCES `newscategory` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newstag
-- ----------------------------
INSERT INTO `newstag` VALUES ('1', '考试简介', '2', '2018-02-08 22:51:42');
INSERT INTO `newstag` VALUES ('6', 'TEST', '3', '2018-03-05 14:12:26');
INSERT INTO `newstag` VALUES ('7', '公告栏', '4', '2018-03-06 10:27:10');
INSERT INTO `newstag` VALUES ('8', '工作计划', '4', '2018-03-06 10:27:47');
INSERT INTO `newstag` VALUES ('9', '通知公告', '7', '2018-03-06 18:08:27');
INSERT INTO `newstag` VALUES ('10', '办事指南', '7', '2018-03-06 18:08:38');
INSERT INTO `newstag` VALUES ('11', '政策法规', '7', '2018-03-06 18:08:52');
INSERT INTO `newstag` VALUES ('12', '合格标准', '7', '2018-03-06 18:09:05');

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `opdetail` varchar(600) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `ix_oplog_addtime` (`addtime`),
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oplog
-- ----------------------------
INSERT INTO `oplog` VALUES ('2', '1', '127.0.0.1', '修改了新闻类别，原类别名为：政策法规，新类别名为：政策法规', '2018-03-02 14:08:56');
INSERT INTO `oplog` VALUES ('3', '1', '127.0.0.1', '添加了新闻类别，名为：Test', '2018-03-02 14:18:40');
INSERT INTO `oplog` VALUES ('4', '1', '127.0.0.1', '删除了新闻类别，名为：Test', '2018-03-02 14:18:53');
INSERT INTO `oplog` VALUES ('5', '1', '127.0.0.1', '添加了新闻标签，名为：TEST', '2018-03-02 14:48:13');
INSERT INTO `oplog` VALUES ('6', '1', '127.0.0.1', '修改了新闻类别，原类别名为：政策法规，新类别名为：政策法规', '2018-03-02 15:13:22');
INSERT INTO `oplog` VALUES ('7', '1', '127.0.0.1', '修改了新闻标签，原标签名为：TEST，新标签名为：TEST_TEST。原所属类别为：资格考试，新所属类别为：考试动态。', '2018-03-02 15:55:27');
INSERT INTO `oplog` VALUES ('8', '1', '127.0.0.1', '添加了新闻类别，名为：TEST', '2018-03-02 15:59:23');
INSERT INTO `oplog` VALUES ('9', '1', '127.0.0.1', '修改了新闻标签，原标签名为：TEST_TEST，新标签名为：TEST_TEST。原所属类别为：考试动态，新所属类别为：TEST。', '2018-03-02 16:25:23');
INSERT INTO `oplog` VALUES ('10', '1', '127.0.0.1', '删除了新闻标签，名为：TEST_TEST', '2018-03-02 16:27:36');
INSERT INTO `oplog` VALUES ('11', '1', '127.0.0.1', '添加了新闻标签，名为：TEST', '2018-03-02 16:36:24');
INSERT INTO `oplog` VALUES ('12', '1', '127.0.0.1', '删除了新闻标签，名为：TEST', '2018-03-02 16:36:29');
INSERT INTO `oplog` VALUES ('13', '1', '127.0.0.1', '添加了新闻标签，名为：TESGDSGS', '2018-03-02 16:36:57');
INSERT INTO `oplog` VALUES ('14', '1', '127.0.0.1', '修改了新闻标签，原标签名为：TESGDSGS，新标签名为：TESGDSGST。原所属类别为：TEST，新所属类别为：TEST。', '2018-03-02 16:37:05');
INSERT INTO `oplog` VALUES ('15', '1', '127.0.0.1', '删除了新闻类别，名为：TEST', '2018-03-02 16:37:41');
INSERT INTO `oplog` VALUES ('16', '1', '127.0.0.1', '添加了新闻类别，名为：TESTTEST', '2018-03-03 13:45:03');
INSERT INTO `oplog` VALUES ('17', '1', '127.0.0.1', '添加了新闻标签，名为：TEST', '2018-03-03 13:45:12');
INSERT INTO `oplog` VALUES ('18', '1', '127.0.0.1', '删除了新闻类别，名为：TESTTEST', '2018-03-03 13:48:31');
INSERT INTO `oplog` VALUES ('19', '1', '127.0.0.1', '添加了新闻类别，名为：TEST', '2018-03-03 16:27:34');
INSERT INTO `oplog` VALUES ('20', '1', '127.0.0.1', '修改了新闻标签，原标签名为：TEST，新标签名为：TEST。原所属类别为：工作动态，新所属类别为：TEST。', '2018-03-03 16:27:43');
INSERT INTO `oplog` VALUES ('21', '1', '127.0.0.1', '删除了新闻类别，名为：TEST', '2018-03-03 16:27:52');
INSERT INTO `oplog` VALUES ('22', '1', '127.0.0.1', '添加了新闻资讯，名为：2018年度专业技术人员资格考试工作计划', '2018-03-03 16:38:25');
INSERT INTO `oplog` VALUES ('35', '1', '127.0.0.1', '修改了新闻资讯，原标题名为：数据测试TEST，新标题名为：数据测试TEST', '2018-03-04 14:46:40');
INSERT INTO `oplog` VALUES ('36', '1', '127.0.0.1', '修改了新闻资讯，原标题名为：数据测试TEST，新标题名为：数据测试TEST', '2018-03-04 14:47:23');
INSERT INTO `oplog` VALUES ('37', '1', '127.0.0.1', '修改了新闻资讯，原标题名为：数据测试TEST，新标题名为：数据测试TEST', '2018-03-04 14:48:03');
INSERT INTO `oplog` VALUES ('38', '1', '127.0.0.1', '修改了新闻资讯，原标题名为：数据测试TEST，新标题名为：数据测试TEST', '2018-03-04 15:14:32');
INSERT INTO `oplog` VALUES ('39', '1', '127.0.0.1', '删除了新闻资讯，标题为：数据测试TEST', '2018-03-04 15:23:21');
INSERT INTO `oplog` VALUES ('40', '1', '127.0.0.1', '添加了新闻资讯，名为：新闻资讯TEST', '2018-03-04 15:24:23');
INSERT INTO `oplog` VALUES ('41', '1', '127.0.0.1', '删除了新闻资讯，标题为：新闻资讯TEST', '2018-03-04 15:24:29');
INSERT INTO `oplog` VALUES ('42', '1', '127.0.0.1', '删除了考试级别，级别名为：TEST', '2018-03-04 15:51:17');
INSERT INTO `oplog` VALUES ('43', '1', '127.0.0.1', '添加了考试级别，级别名为：TEST', '2018-03-04 15:51:37');
INSERT INTO `oplog` VALUES ('44', '1', '127.0.0.1', '修改了考试级别，原级别名为：TEST，新级别名为：TESTT', '2018-03-04 15:56:08');
INSERT INTO `oplog` VALUES ('45', '1', '127.0.0.1', '修改了考试科目，原科目名为：TESTTTT，新科目名为：TEST', '2018-03-04 16:21:25');
INSERT INTO `oplog` VALUES ('46', '1', '127.0.0.1', '添加了参考书，书名为：TEST，ISBN为：1222222222222', '2018-03-04 17:02:24');
INSERT INTO `oplog` VALUES ('47', '1', '127.0.0.1', '修改了参考书，原书名为：TEST，原ISBN为：1222222222222。现书名为：TEST，现ISBN为：1222222222222', '2018-03-04 17:09:58');
INSERT INTO `oplog` VALUES ('48', '1', '127.0.0.1', '修改了参考书，原书名为：TEST，原ISBN为：1222222222222。现书名为：TESTT，现ISBN为：1222222222222', '2018-03-04 21:48:57');
INSERT INTO `oplog` VALUES ('49', '1', '127.0.0.1', '修改了参考书，原书名为：TESTT，原ISBN为：1222222222222。现书名为：TEST，现ISBN为：1222222222222', '2018-03-04 22:00:04');
INSERT INTO `oplog` VALUES ('50', '1', '127.0.0.1', '修改了参考书，原书名为：TEST，原ISBN为：1222222222222。现书名为：TEST，现ISBN为：1222222222222', '2018-03-04 22:00:18');
INSERT INTO `oplog` VALUES ('51', '1', '127.0.0.1', '删除了用户，姓名为：，账号为：4@3.co', '2018-03-05 10:54:14');
INSERT INTO `oplog` VALUES ('52', '1', '127.0.0.1', '删除了用户，姓名为：，账号为：4@3.co', '2018-03-05 10:57:39');
INSERT INTO `oplog` VALUES ('53', '1', '127.0.0.1', '修改了参考书，原书名为：TEST，原ISBN为：1222222222222。现书名为：TEST，现ISBN为：1222222222222', '2018-03-05 11:23:18');
INSERT INTO `oplog` VALUES ('54', '1', '127.0.0.1', '修改了考试信息，级别为：1，考试科目为：3，考试时间为：2018-03-06 11:15:00，考试地点为：上海市-上海市-复旦大学-第一教学楼', '2018-03-05 12:20:52');
INSERT INTO `oplog` VALUES ('55', '1', '127.0.0.1', '修改了考试信息，级别为：1，考试科目为：3，考试时间为：2018-03-06 11:15:00，考试地点为：上海市-上海市-上海健康医学院-第一教学楼', '2018-03-05 13:49:11');
INSERT INTO `oplog` VALUES ('56', '1', '127.0.0.1', '修改了考试信息，级别为：1，考试科目为：3，考试时间为：2018-03-06 11:15:00，考试地点为：湖南省-怀化市-怀化职业技术学院-第一教学楼', '2018-03-05 13:49:33');
INSERT INTO `oplog` VALUES ('57', '1', '127.0.0.1', '删除了考试信息，级别为：TESTT，考试科目为：注册结构工程师，考试时间为：2018-03-05 14:00:00，考试地点为：山西省-阳泉市-山西工程技术学院-第二考场', '2018-03-05 14:03:38');
INSERT INTO `oplog` VALUES ('58', '1', '127.0.0.1', '删除了考试科目，科目名为：TEST', '2018-03-05 14:04:52');
INSERT INTO `oplog` VALUES ('59', '1', '127.0.0.1', '添加了新闻标签，名为：TEST', '2018-03-05 14:12:26');
INSERT INTO `oplog` VALUES ('60', '1', '127.0.0.1', '修改了新闻资讯，原标题名为：2018年度专业技术人员资格考试工作计划，新标题名为：2018年度专业技术人员资格考试工作计划', '2018-03-05 14:12:45');
INSERT INTO `oplog` VALUES ('61', '1', '127.0.0.1', '添加了新闻标签，名为：公告栏', '2018-03-06 10:27:10');
INSERT INTO `oplog` VALUES ('62', '1', '127.0.0.1', '添加了新闻标签，名为：工作计划', '2018-03-06 10:27:47');
INSERT INTO `oplog` VALUES ('63', '1', '127.0.0.1', '添加了新闻资讯，名为：关于2018年上半年计算机技术与软件专业技术资格（水平）考试报名的通知', '2018-03-06 10:40:42');
INSERT INTO `oplog` VALUES ('64', '1', '127.0.0.1', '添加了新闻资讯，名为：关于2018年上半年翻译专业资格（水平）考试笔译考试报名的通知', '2018-03-06 11:35:28');
INSERT INTO `oplog` VALUES ('65', '1', '127.0.0.1', '添加了新闻资讯，名为：关于2018年度全国一、二级注册建筑师资格考试报名的通知', '2018-03-06 11:36:25');
INSERT INTO `oplog` VALUES ('66', '1', '127.0.0.1', '添加了新闻资讯，名为：关于2018年度全国监理工程师资格考试报名的通知', '2018-03-06 11:47:30');
INSERT INTO `oplog` VALUES ('67', '1', '127.0.0.1', '修改了新闻资讯，原标题名为：2018年度专业技术人员资格考试工作计划，新标题名为：2018年度专业技术人员资格考试工作计划', '2018-03-06 17:19:03');
INSERT INTO `oplog` VALUES ('68', '1', '127.0.0.1', '修改了新闻资讯，原标题名为：2018年度专业技术人员资格考试工作计划，新标题名为：2018年度专业技术人员资格考试工作计划', '2018-03-06 17:19:14');
INSERT INTO `oplog` VALUES ('69', '1', '127.0.0.1', '修改了新闻资讯，原标题名为：2018年度专业技术人员资格考试工作计划，新标题名为：2018年度专业技术人员资格考试工作计划', '2018-03-06 17:22:29');
INSERT INTO `oplog` VALUES ('70', '1', '127.0.0.1', '添加了新闻类别，名为：政务公开', '2018-03-06 18:05:26');
INSERT INTO `oplog` VALUES ('71', '1', '127.0.0.1', '添加了新闻标签，名为：通知公告', '2018-03-06 18:08:27');
INSERT INTO `oplog` VALUES ('72', '1', '127.0.0.1', '添加了新闻标签，名为：办事指南', '2018-03-06 18:08:38');
INSERT INTO `oplog` VALUES ('73', '1', '127.0.0.1', '添加了新闻标签，名为：政策法规', '2018-03-06 18:08:52');
INSERT INTO `oplog` VALUES ('74', '1', '127.0.0.1', '添加了新闻标签，名为：合格标准', '2018-03-06 18:09:05');

-- ----------------------------
-- Table structure for refbook
-- ----------------------------
DROP TABLE IF EXISTS `refbook`;
CREATE TABLE `refbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `ISBN` varchar(13) DEFAULT NULL,
  `public` varchar(100) DEFAULT NULL,
  `pages` int(11) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `pubdate` date DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ISBN` (`ISBN`),
  UNIQUE KEY `logo` (`logo`),
  UNIQUE KEY `ISBN_2` (`ISBN`),
  UNIQUE KEY `logo_2` (`logo`),
  KEY `ix_refbook_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of refbook
-- ----------------------------
INSERT INTO `refbook` VALUES ('1', '人性记录', '阿加莎·克里斯蒂', '9787513313919', '新星出版社', '276', '20180210213958eb8c2e706c094a0eb8e79ea13e0fd61e.jpg', '21', '2014-01-01', '2018-02-10 21:39:59');
INSERT INTO `refbook` VALUES ('2', '谋杀启事', '阿加莎·克里斯蒂', '9787513315487', '新星出版社', '288', '20180210233019c31e8a3f48bd436d921a2b9d1036faf8.jpg', '22.9', '2014-07-01', '2018-02-10 23:30:19');
INSERT INTO `refbook` VALUES ('3', 'TEST', 'TEST', '1222222222222', 'TEST', '123', '20180305112317761b67e7400b470dbfb578f4aee3cbba.jpg', '34', '2018-03-10', '2018-03-04 17:02:24');

-- ----------------------------
-- Table structure for tinfo
-- ----------------------------
DROP TABLE IF EXISTS `tinfo`;
CREATE TABLE `tinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `t_time` datetime DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `examroom` varchar(100) DEFAULT NULL,
  `personnum` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `refbook_id` int(11) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `level_id` (`level_id`),
  KEY `subject_id` (`subject_id`),
  KEY `refbook_id` (`refbook_id`),
  KEY `ix_tinfo_addtime` (`addtime`),
  CONSTRAINT `tinfo_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `tlevel` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tinfo_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `tsubject` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tinfo_ibfk_3` FOREIGN KEY (`refbook_id`) REFERENCES `refbook` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tinfo
-- ----------------------------
INSERT INTO `tinfo` VALUES ('1', '1', '1', '2018-07-01 14:00:00', '上海市-上海市-上海电机学院', '临港校区A教406', '20', '46.9', '1', '2018-02-11 23:14:28');

-- ----------------------------
-- Table structure for tlevel
-- ----------------------------
DROP TABLE IF EXISTS `tlevel`;
CREATE TABLE `tlevel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` varchar(10) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `level` (`level`),
  UNIQUE KEY `level_2` (`level`),
  KEY `ix_tlevel_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tlevel
-- ----------------------------
INSERT INTO `tlevel` VALUES ('1', '初级', '2018-02-10 14:52:26');
INSERT INTO `tlevel` VALUES ('3', 'TESTT', '2018-03-04 15:51:37');

-- ----------------------------
-- Table structure for trinfo
-- ----------------------------
DROP TABLE IF EXISTS `trinfo`;
CREATE TABLE `trinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `status` smallint(6) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `level_id` (`level_id`),
  KEY `subject_id` (`subject_id`),
  KEY `ix_trinfo_addtime` (`addtime`),
  CONSTRAINT `trinfo_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `tlevel` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trinfo_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `tsubject` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of trinfo
-- ----------------------------

-- ----------------------------
-- Table structure for tsubject
-- ----------------------------
DROP TABLE IF EXISTS `tsubject`;
CREATE TABLE `tsubject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `subject` (`subject`),
  UNIQUE KEY `subject_2` (`subject`),
  KEY `ix_tsubject_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tsubject
-- ----------------------------
INSERT INTO `tsubject` VALUES ('1', '注册结构工程师', '2018-02-10 15:09:39');

-- ----------------------------
-- Table structure for urinfo
-- ----------------------------
DROP TABLE IF EXISTS `urinfo`;
CREATE TABLE `urinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `level_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `level_id` (`level_id`),
  KEY `subject_id` (`subject_id`),
  KEY `ix_urinfo_addtime` (`addtime`),
  CONSTRAINT `urinfo_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `urinfo_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `tlevel` (`id`) ON DELETE CASCADE,
  CONSTRAINT `urinfo_ibfk_3` FOREIGN KEY (`subject_id`) REFERENCES `tsubject` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of urinfo
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `pwd` varchar(100) DEFAULT NULL,
  `gender` smallint(6) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `id_card` varchar(18) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `face` varchar(255) DEFAULT NULL,
  `area` varchar(200) DEFAULT NULL,
  `id_status` smallint(6) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `id_card` (`id_card`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `face` (`face`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `id_card_2` (`id_card`),
  UNIQUE KEY `phone_2` (`phone`),
  UNIQUE KEY `face_2` (`face`),
  KEY `ix_user_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'UserTest', 'pbkdf2:sha256:50000$caF9Z7a5$eef64d9593bef1fe763ac6d2d2281ede710336866ff65e0260bda090d1b11b94', '0', '4@1.co', null, null, null, null, '0', '2018-02-28 14:18:43');
INSERT INTO `user` VALUES ('2', 'TEST', 'pbkdf2:sha256:50000$KkyosNAr$2361b8a402ed8014fef0fc2b4570d91f71c19817de8107fc36fbf81f323e12ee', '1', '4@2.co', '431128199999999999', '13222222222', null, '', '0', '2018-03-05 10:20:37');

-- ----------------------------
-- Table structure for userlog
-- ----------------------------
DROP TABLE IF EXISTS `userlog`;
CREATE TABLE `userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `ix_userlog_addtime` (`addtime`),
  CONSTRAINT `userlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlog
-- ----------------------------
INSERT INTO `userlog` VALUES ('1', '1', '127.0.0.1', '2018-03-01 14:21:37');
INSERT INTO `userlog` VALUES ('3', '1', '127.0.0.1', '2018-03-01 14:59:12');
INSERT INTO `userlog` VALUES ('4', '1', '127.0.0.1', '2018-03-01 15:54:02');
INSERT INTO `userlog` VALUES ('5', '1', '127.0.0.1', '2018-03-01 17:45:49');
INSERT INTO `userlog` VALUES ('6', '1', '127.0.0.1', '2018-03-02 12:11:49');
INSERT INTO `userlog` VALUES ('7', '1', '127.0.0.1', '2018-03-04 22:21:49');
INSERT INTO `userlog` VALUES ('8', '2', '127.0.0.1', '2018-03-05 10:20:45');
INSERT INTO `userlog` VALUES ('10', '1', '127.0.0.1', '2018-03-05 11:56:45');
