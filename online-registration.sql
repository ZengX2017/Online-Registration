/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : online-registration

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2018-02-26 10:20:35
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
  CONSTRAINT `adminlog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adminlog
-- ----------------------------
INSERT INTO `adminlog` VALUES ('1', '1', '127.0.0.1', '2018-02-12 21:22:37');

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
  CONSTRAINT `admission_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `admission_ibfk_2` FOREIGN KEY (`tinfo_id`) REFERENCES `tinfo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admission
-- ----------------------------

-- ----------------------------
-- Table structure for alembic_version
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
INSERT INTO `alembic_version` VALUES ('368fe84fbd16');

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
  KEY `ix_newscategory_addtime` (`addtime`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newscategory
-- ----------------------------
INSERT INTO `newscategory` VALUES ('1', '首页', '2018-02-08 13:22:01');
INSERT INTO `newscategory` VALUES ('2', '资格考试', '2018-02-08 13:59:59');
INSERT INTO `newscategory` VALUES ('3', '考试动态', '2018-02-08 14:01:07');
INSERT INTO `newscategory` VALUES ('4', '工作动态', '2018-02-08 21:34:52');

-- ----------------------------
-- Table structure for newsinfo
-- ----------------------------
DROP TABLE IF EXISTS `newsinfo`;
CREATE TABLE `newsinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `content` varchar(6000) DEFAULT NULL,
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
  CONSTRAINT `newsinfo_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`),
  CONSTRAINT `newsinfo_ibfk_2` FOREIGN KEY (`newstag_id`) REFERENCES `newstag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newsinfo
-- ----------------------------
INSERT INTO `newsinfo` VALUES ('1', '全国一、二级注册结构工程师执业资格考试', '<div align=\"center\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">全国一、二级注册结构工程师执业资格考试</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"></span>&nbsp;</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 根据《关于印发《注册结构工程师执业资格暂行规定》的通知》(建办设[1997]222号)文件精神，从1997年起，国家实行注册结构工程师执业资格制度。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师．是指取得中华人民共和国注册结构工程师执业资格证书和注册证书，从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员，注册结构工程师分为一级注册结构工程师和二级注册结构工程师。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 一、组织领导</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师资格制度纳入专业技术人员执业资格制度，由国家确认批准。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 建设部、人事部和省、自治区、直辖市人民政府建设行政主管部门、人事行政主管部门依照有关规定对注册结构工程师的考试、注册和执业实施指导、监督和管理。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"font-weight: 700;\">二、适用范围</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　适用于从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员 。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 三、考试时间及科目设置</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师考试实行全国统一大纲、统一命题、统一组织的办法，原则上每年举行一次。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 一级注册注册结构工程师设《基础考试》和《专业考试》两部分；二级注册注册结构工程师只设《专业考试》。其中，《基础考试》为客观题，在答题卡上作答；《专业考试》采取主、客观相结合的考试方法，即：要求考生在填涂答题卡的同时，在答题纸上写出计算过程。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一级注册结构工程师基础考试为闭卷考试，只允许考生使用统一配发的《考试手册》（考后收回），禁止携带其他参考资料。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一、二级注册结构工程师专业考试为开卷考试，考试时允许考生携带正规出版社出版的各种专业规范和参考书。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 四、报考条件</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（一）全国一级注册结构工程师执业资格考试基础科目考试报考条件</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 2、1971年（含1971年）以后毕业，不具备规定学历的人员,从事建筑工程设计工作累计15年以上，且具备下列条件之一，也可申报一级注册结构工程师资格考试基础科目的考试 ：</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（1）作为专业负责人或主要设计人，完成建筑工程分类标准三级以上项目4项（全过程设计），其中二级以上项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（2）作为专业负责人或主要设计人，完成中型工业建筑工程以上项目4项（全过程设计），其中大型项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><br></div>', '0', '1', '1', '20180210114208622eff7bcd2a4c1a8eff409795566819.jpg', '', '2018-02-10 11:42:09');

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
  CONSTRAINT `newstag_ibfk_1` FOREIGN KEY (`newscategory_id`) REFERENCES `newscategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oplog
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of refbook
-- ----------------------------
INSERT INTO `refbook` VALUES ('1', '人性记录', '阿加莎·克里斯蒂', '9787513313919', '新星出版社', '276', '20180210213958eb8c2e706c094a0eb8e79ea13e0fd61e.jpg', '21', '2014-01-01', '2018-02-10 21:39:59');
INSERT INTO `refbook` VALUES ('2', '谋杀启事', '阿加莎·克里斯蒂', '9787513315487', '新星出版社', '288', '20180210233019c31e8a3f48bd436d921a2b9d1036faf8.jpg', '22.9', '2014-07-01', '2018-02-10 23:30:19');

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `addtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `ix_test_addtime` (`addtime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------

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
  CONSTRAINT `tinfo_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `tlevel` (`id`),
  CONSTRAINT `tinfo_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `tsubject` (`id`),
  CONSTRAINT `tinfo_ibfk_3` FOREIGN KEY (`refbook_id`) REFERENCES `refbook` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tlevel
-- ----------------------------
INSERT INTO `tlevel` VALUES ('1', '初级', '2018-02-10 14:52:26');

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
  CONSTRAINT `trinfo_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `tlevel` (`id`),
  CONSTRAINT `trinfo_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `tsubject` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

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
  CONSTRAINT `urinfo_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `urinfo_ibfk_2` FOREIGN KEY (`level_id`) REFERENCES `tlevel` (`id`),
  CONSTRAINT `urinfo_ibfk_3` FOREIGN KEY (`subject_id`) REFERENCES `tsubject` (`id`)
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------

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
  CONSTRAINT `userlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlog
-- ----------------------------
