/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : online-registration

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2018-03-04 22:45:20
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adminlog
-- ----------------------------
INSERT INTO `adminlog` VALUES ('1', '1', '127.0.0.1', '2018-02-12 21:22:37');
INSERT INTO `adminlog` VALUES ('2', '1', '127.0.0.1', '2018-02-27 10:45:34');
INSERT INTO `adminlog` VALUES ('3', '1', '127.0.0.1', '2018-03-02 13:47:49');
INSERT INTO `adminlog` VALUES ('4', '1', '127.0.0.1', '2018-03-03 14:45:58');
INSERT INTO `adminlog` VALUES ('5', '1', '127.0.0.1', '2018-03-04 16:18:57');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newscategory
-- ----------------------------
INSERT INTO `newscategory` VALUES ('1', '首页', '2018-02-08 13:22:01');
INSERT INTO `newscategory` VALUES ('2', '资格考试', '2018-02-08 13:59:59');
INSERT INTO `newscategory` VALUES ('3', '考试动态', '2018-02-08 14:01:07');
INSERT INTO `newscategory` VALUES ('4', '工作动态', '2018-02-08 21:34:52');
INSERT INTO `newscategory` VALUES ('5', '政策法规', '2018-03-02 13:49:30');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newsinfo
-- ----------------------------
INSERT INTO `newsinfo` VALUES ('1', '全国一、二级注册结构工程师执业资格考试', '<div align=\"center\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">全国一、二级注册结构工程师执业资格考试</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"></span>&nbsp;</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 根据《关于印发《注册结构工程师执业资格暂行规定》的通知》(建办设[1997]222号)文件精神，从1997年起，国家实行注册结构工程师执业资格制度。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师．是指取得中华人民共和国注册结构工程师执业资格证书和注册证书，从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员，注册结构工程师分为一级注册结构工程师和二级注册结构工程师。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 一、组织领导</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师资格制度纳入专业技术人员执业资格制度，由国家确认批准。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 建设部、人事部和省、自治区、直辖市人民政府建设行政主管部门、人事行政主管部门依照有关规定对注册结构工程师的考试、注册和执业实施指导、监督和管理。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"font-weight: 700;\">二、适用范围</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　适用于从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员 。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 三、考试时间及科目设置</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师考试实行全国统一大纲、统一命题、统一组织的办法，原则上每年举行一次。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 一级注册注册结构工程师设《基础考试》和《专业考试》两部分；二级注册注册结构工程师只设《专业考试》。其中，《基础考试》为客观题，在答题卡上作答；《专业考试》采取主、客观相结合的考试方法，即：要求考生在填涂答题卡的同时，在答题纸上写出计算过程。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一级注册结构工程师基础考试为闭卷考试，只允许考生使用统一配发的《考试手册》（考后收回），禁止携带其他参考资料。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一、二级注册结构工程师专业考试为开卷考试，考试时允许考生携带正规出版社出版的各种专业规范和参考书。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 四、报考条件</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（一）全国一级注册结构工程师执业资格考试基础科目考试报考条件</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 2、1971年（含1971年）以后毕业，不具备规定学历的人员,从事建筑工程设计工作累计15年以上，且具备下列条件之一，也可申报一级注册结构工程师资格考试基础科目的考试 ：</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（1）作为专业负责人或主要设计人，完成建筑工程分类标准三级以上项目4项（全过程设计），其中二级以上项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（2）作为专业负责人或主要设计人，完成中型工业建筑工程以上项目4项（全过程设计），其中大型项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><br></div>', '0', '1', '1', '20180304134734466e34d230d9495992d6768ec4960bab.jpg;', '', '2018-02-10 11:42:09');
INSERT INTO `newsinfo` VALUES ('3', '2018年度专业技术人员资格考试工作计划', '<table align=\"center\" border=\"1\" cellpadding=\"0\" cellspacing=\"0\" style=\"color: rgb(45, 2, 1); font-family: 宋体; font-size: 12px; background-color: rgb(255, 255, 255);\"><thead><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; text-align: right; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">序号</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">专业名称</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">考试日期</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">1</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">咨询工程师（投资）</p></th><th style=\"margin: 0px; width: 185px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">4月14、15日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">2</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">房地产经纪人协理、房地产经纪人</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">4月21、22日</p></th></tr><tr><th rowspan=\"2\" style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">3</p></th><th colspan=\"2\" rowspan=\"2\" style=\"margin: 0px; width: 137px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">注册建筑师</p></th><th style=\"margin: 0px; width: 239px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">一级</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月5、6、12、13日</p></th></tr><tr><th style=\"margin: 0px; width: 239px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">二级</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月5、6日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">4</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">护士执业资格</p></th><th style=\"margin: 0px; width: 185px; height: 36px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月5-7日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">会计（初级）</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月12-20日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">监理工程师</p></th><th rowspan=\"3\" style=\"margin: 0px; width: 185px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月19、20日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">7</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 26px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">环境影响评价工程师</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 25px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">8</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 25px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">翻译专业资格（一、二、三级）</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">9</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">卫生（初级、中级）</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月26、27日、</p><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6月2、3日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">10</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">计算机技术与软件（初级、中级、高级）</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">5月26、27日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">11</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">银行业专业人员职业资格（初级、中级）</p></th><th style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6月2、3日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">12</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">助理社会工作师、社会工作师</p></th><th rowspan=\"2\" style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6月9、10日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">13</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">机动车检测维修士、机动车检测维修工程师</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">14</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">注册计量师（一级）</p></th><th rowspan=\"2\" style=\"margin: 0px; width: 185px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">6月23、24日</p></th></tr><tr><th style=\"margin: 0px; width: 53px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">15</p></th><th colspan=\"3\" style=\"margin: 0px; width: 376px; height: 38px;\"><p style=\"margin-top: 10px; margin-bottom: 10px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-weight: normal; font-stretch: normal; font-size: 14px; line-height: 25.2px; text-indent: 2em;\">土地登记代理人</p></th></tr></thead></table>', '0', '1', '1', '', '测试数据', '2018-03-03 16:38:25');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newstag
-- ----------------------------
INSERT INTO `newstag` VALUES ('1', '考试简介', '2', '2018-02-08 22:51:42');

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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

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
INSERT INTO `refbook` VALUES ('3', 'TEST', 'TEST', '1222222222222', 'TEST', '123', '2018030422001789384faa98ef4de9bb040f3db5a7790a.jpg', '34', '2018-03-10', '2018-03-04 17:02:24');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
INSERT INTO `tsubject` VALUES ('3', 'TEST', '2018-03-04 16:17:37');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'UserTest', 'pbkdf2:sha256:50000$caF9Z7a5$eef64d9593bef1fe763ac6d2d2281ede710336866ff65e0260bda090d1b11b94', '0', '4@1.co', null, null, null, null, '0', '2018-02-28 14:18:43');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlog
-- ----------------------------
INSERT INTO `userlog` VALUES ('1', '1', '127.0.0.1', '2018-03-01 14:21:37');
INSERT INTO `userlog` VALUES ('3', '1', '127.0.0.1', '2018-03-01 14:59:12');
INSERT INTO `userlog` VALUES ('4', '1', '127.0.0.1', '2018-03-01 15:54:02');
INSERT INTO `userlog` VALUES ('5', '1', '127.0.0.1', '2018-03-01 17:45:49');
INSERT INTO `userlog` VALUES ('6', '1', '127.0.0.1', '2018-03-02 12:11:49');
INSERT INTO `userlog` VALUES ('7', '1', '127.0.0.1', '2018-03-04 22:21:49');
