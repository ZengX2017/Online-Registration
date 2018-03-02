/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : online-registration

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2018-03-02 17:04:41
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adminlog
-- ----------------------------
INSERT INTO `adminlog` VALUES ('1', '1', '127.0.0.1', '2018-02-12 21:22:37');
INSERT INTO `adminlog` VALUES ('2', '1', '127.0.0.1', '2018-02-27 10:45:34');
INSERT INTO `adminlog` VALUES ('3', '1', '127.0.0.1', '2018-03-02 13:47:49');

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
INSERT INTO `alembic_version` VALUES ('dace8b10b26b');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

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
  CONSTRAINT `newsinfo_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`),
  CONSTRAINT `newsinfo_ibfk_2` FOREIGN KEY (`newstag_id`) REFERENCES `newstag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newsinfo
-- ----------------------------
INSERT INTO `newsinfo` VALUES ('1', '全国一、二级注册结构工程师执业资格考试', '<div align=\"center\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">全国一、二级注册结构工程师执业资格考试</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\"></span>&nbsp;</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 根据《关于印发《注册结构工程师执业资格暂行规定》的通知》(建办设[1997]222号)文件精神，从1997年起，国家实行注册结构工程师执业资格制度。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师．是指取得中华人民共和国注册结构工程师执业资格证书和注册证书，从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员，注册结构工程师分为一级注册结构工程师和二级注册结构工程师。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 一、组织领导</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师资格制度纳入专业技术人员执业资格制度，由国家确认批准。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 建设部、人事部和省、自治区、直辖市人民政府建设行政主管部门、人事行政主管部门依照有关规定对注册结构工程师的考试、注册和执业实施指导、监督和管理。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"font-weight: 700;\">二、适用范围</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　适用于从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员 。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 三、考试时间及科目设置</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师考试实行全国统一大纲、统一命题、统一组织的办法，原则上每年举行一次。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 一级注册注册结构工程师设《基础考试》和《专业考试》两部分；二级注册注册结构工程师只设《专业考试》。其中，《基础考试》为客观题，在答题卡上作答；《专业考试》采取主、客观相结合的考试方法，即：要求考生在填涂答题卡的同时，在答题纸上写出计算过程。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一级注册结构工程师基础考试为闭卷考试，只允许考生使用统一配发的《考试手册》（考后收回），禁止携带其他参考资料。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一、二级注册结构工程师专业考试为开卷考试，考试时允许考生携带正规出版社出版的各种专业规范和参考书。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><span style=\"font-weight: 700;\">&nbsp;&nbsp;&nbsp; 四、报考条件</span></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（一）全国一级注册结构工程师执业资格考试基础科目考试报考条件</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 2、1971年（含1971年）以后毕业，不具备规定学历的人员,从事建筑工程设计工作累计15年以上，且具备下列条件之一，也可申报一级注册结构工程师资格考试基础科目的考试 ：</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（1）作为专业负责人或主要设计人，完成建筑工程分类标准三级以上项目4项（全过程设计），其中二级以上项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（2）作为专业负责人或主要设计人，完成中型工业建筑工程以上项目4项（全过程设计），其中大型项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><br></div>', '0', '1', '1', '20180210114208622eff7bcd2a4c1a8eff409795566819.jpg', '', '2018-02-10 11:42:09');
INSERT INTO `newsinfo` VALUES ('2', '数据测试TEST', '<div align=\"center\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><b>全国一、二级注册结构工程师执业资格考试</b></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><strong></strong>&nbsp;</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 根据《关于印发《注册结构工程师执业资格暂行规定》的通知》(建办设[1997]222号)文件精神，从1997年起，国家实行注册结构工程师执业资格制度。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师．是指取得中华人民共和国注册结构工程师执业资格证书和注册证书，从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员，注册结构工程师分为一级注册结构工程师和二级注册结构工程师。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><b>&nbsp;&nbsp;&nbsp; 一、组织领导</b></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师资格制度纳入专业技术人员执业资格制度，由国家确认批准。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 建设部、人事部和省、自治区、直辖市人民政府建设行政主管部门、人事行政主管部门依照有关规定对注册结构工程师的考试、注册和执业实施指导、监督和管理。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;<strong>二、适用范围</strong></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　适用于从事房屋结构、桥梁结构及塔架结构等工程设计及相关业务的专业技术人员 。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><b>&nbsp;&nbsp;&nbsp; 三、考试时间及科目设置</b></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师考试实行全国统一大纲、统一命题、统一组织的办法，原则上每年举行一次。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 一级注册注册结构工程师设《基础考试》和《专业考试》两部分；二级注册注册结构工程师只设《专业考试》。其中，《基础考试》为客观题，在答题卡上作答；《专业考试》采取主、客观相结合的考试方法，即：要求考生在填涂答题卡的同时，在答题纸上写出计算过程。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 考试分4个半天进行，具体时间安排是：</div><div align=\"center\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><table cellspacing=\"1\" cellpadding=\"0\" width=\"457\" border=\"1\"><tbody><tr><td width=\"114\"><div align=\"center\">专业名称</div></td><td width=\"115\"><div align=\"center\">考试时间</div></td><td width=\"117\"><div align=\"center\">考试科目</div></td><td width=\"111\"><div align=\"center\">考试形式</div></td></tr><tr><td width=\"114\" rowspan=\"4\"><div align=\"center\">一级注册结构工程师</div></td><td width=\"115\"><div align=\"center\">4小时</div></td><td width=\"117\"><div align=\"center\">基础考试（上）</div></td><td width=\"111\"><div align=\"center\">闭卷</div></td></tr><tr><td valign=\"top\" width=\"115\"><div align=\"center\">4小时</div></td><td width=\"117\"><div align=\"center\">基础考试（下）</div></td><td width=\"111\"><div align=\"center\">闭卷</div></td></tr><tr><td valign=\"top\" width=\"115\"><div align=\"center\">4小时</div></td><td width=\"117\"><div align=\"center\">专业考试（上）</div></td><td width=\"111\"><div align=\"center\">开卷</div></td></tr><tr><td valign=\"top\" width=\"115\"><div align=\"center\">4小时</div></td><td width=\"117\"><div align=\"center\">专业考试（下）</div></td><td width=\"111\"><div align=\"center\">开卷</div></td></tr><tr><td width=\"114\" rowspan=\"2\"><div align=\"center\">二级注册结构工程师</div></td><td valign=\"top\" width=\"115\"><div align=\"center\">4小时</div></td><td width=\"117\"><div align=\"center\">专业考试（上）</div></td><td width=\"111\"><div align=\"center\">开卷</div></td></tr><tr><td valign=\"top\" width=\"115\"><div align=\"center\">4小时</div></td><td width=\"117\"><div align=\"center\">专业考试（下）</div></td><td width=\"111\"><div align=\"center\">开卷</div></td></tr></tbody></table></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一级注册结构工程师基础考试为闭卷考试，只允许考生使用统一配发的《考试手册》（考后收回），禁止携带其他参考资料。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　一、二级注册结构工程师专业考试为开卷考试，考试时允许考生携带正规出版社出版的各种专业规范和参考书。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><b>&nbsp;&nbsp;&nbsp; 四、报考条件</b></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（一）全国一级注册结构工程师执业资格考试基础科目考试报考条件</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　1、具备下列条件人员</div><div align=\"center\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><table cellspacing=\"1\" cellpadding=\"0\" border=\"1\"><tbody><tr><td width=\"38\"><div align=\"center\">类 别</div></td><td width=\"151\"><div align=\"center\">专业名称</div></td><td width=\"227\"><div align=\"center\">学历或学位</div></td><td><div align=\"center\">职业实践最少时间</div></td></tr><tr><td width=\"38\" rowspan=\"4\"><div align=\"center\">本专业</div></td><td width=\"151\"><div align=\"center\">结构工程</div></td><td width=\"227\"><div align=\"center\">工学硕士或研究生毕业及以上学位</div></td><td><div align=\"center\">&nbsp;</div></td></tr><tr><td width=\"151\" rowspan=\"3\"><div align=\"center\">建筑工程</div><div align=\"center\">&nbsp;</div><div align=\"center\">（不含岩土工程）</div></td><td width=\"227\"><div align=\"center\">评估通过并在合格有效期内的工学学士学位</div></td><td><div align=\"center\">&nbsp;</div></td></tr><tr><td width=\"227\"><div align=\"center\">未通过评估的工学学士学位</div></td><td><div align=\"center\">&nbsp;</div></td></tr><tr><td width=\"227\"><div align=\"center\">专科毕业</div></td><td><div align=\"center\">1年</div></td></tr><tr><td width=\"38\" rowspan=\"3\"><div align=\"center\">相近专业</div></td><td width=\"151\" rowspan=\"3\"><div align=\"center\">建筑工程的岩土工程</div><div align=\"center\">&nbsp;</div><div align=\"center\">交通土建工程</div><div align=\"center\">矿井建设</div><div align=\"center\">水利水电建筑工程</div><div align=\"center\">港口航道及治河工程</div><div align=\"center\">海岸与海洋工程</div><div align=\"center\">农业建筑与环境工程</div><div align=\"center\">建筑学</div><div align=\"center\">工程力学</div></td><td width=\"227\"><div align=\"center\">工学硕士或研究生毕业及以上学位</div></td><td><div align=\"center\">&nbsp;</div></td></tr><tr><td width=\"227\"><div align=\"center\">工学学士或本科毕业</div></td><td><div align=\"center\">&nbsp;</div></td></tr><tr><td width=\"227\"><div align=\"center\">专科毕业</div></td><td><div align=\"center\">1年</div></td></tr><tr><td width=\"189\" colspan=\"2\"><div align=\"center\">其它工科专业</div></td><td width=\"227\"><div align=\"center\">工学学士或本科毕业及以上学位</div></td><td><div align=\"center\">1年</div></td></tr></tbody></table></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 2、1971年（含1971年）以后毕业，不具备规定学历的人员,从事建筑工程设计工作累计15年以上，且具备下列条件之一，也可申报一级注册结构工程师资格考试基础科目的考试 ：</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（1）作为专业负责人或主要设计人，完成建筑工程分类标准三级以上项目4项（全过程设计），其中二级以上项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（2）作为专业负责人或主要设计人，完成中型工业建筑工程以上项目4项（全过程设计），其中大型项目不少于1项。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（二）全国一级注册结构工程师执业资格考试专业科目考试报考条件</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　1、具备下列条件人员</div><div align=\"center\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><table cellspacing=\"1\" cellpadding=\"0\" border=\"1\"><tbody><tr><td width=\"38\" rowspan=\"2\"><div align=\"center\">类别</div></td><td width=\"151\" rowspan=\"2\"><div align=\"center\">专业名称</div></td><td width=\"227\" rowspan=\"2\"><div align=\"center\">学历或学位</div></td><td><div align=\"center\">Ⅰ类人员</div></td><td><div align=\"center\">Ⅱ类人员</div></td></tr><tr><td><div align=\"center\">职业实践最少时间</div></td><td><div align=\"center\">职业实践最少时间</div></td></tr><tr><td width=\"38\" rowspan=\"4\"><div align=\"center\">本专业</div></td><td width=\"151\"><div align=\"center\">结构工程</div></td><td width=\"227\"><div align=\"center\">工学硕士或研究生毕业及以上学位</div></td><td><div align=\"center\">4年</div></td><td><div align=\"center\">6年</div></td></tr><tr><td width=\"151\" rowspan=\"3\"><div align=\"center\">建筑工程</div><div align=\"center\">(不含岩土工程)</div></td><td width=\"227\"><div align=\"center\">评估通过并在合格有效期内的工学学士学位</div></td><td><div align=\"center\">4年</div></td><td><div align=\"center\">&nbsp;</div></td></tr><tr><td width=\"227\"><div align=\"center\">未通过评估的工学学士学位或本科毕业</div></td><td><div align=\"center\">5年</div></td><td><div align=\"center\">8年</div></td></tr><tr><td width=\"227\"><div align=\"center\">专科毕业</div></td><td><div align=\"center\">6年</div></td><td><div align=\"center\">9年</div></td></tr><tr><td width=\"38\" rowspan=\"3\"><div align=\"center\">相近专业</div></td><td width=\"151\" rowspan=\"3\"><div align=\"center\">建筑工程的岩土工程</div><div align=\"center\">交通土建工程</div><div align=\"center\">矿井建设</div><div align=\"center\">水利水电建筑工程</div><div align=\"center\">港口航道及治河工程</div><div align=\"center\">农业建筑与环境工程</div><div align=\"center\">海岸与海洋工程</div><div align=\"center\">建筑学</div><div align=\"center\">工程力学</div></td><td width=\"227\"><div align=\"center\">工学硕士或研究生毕业及以上学位</div></td><td><div align=\"center\">5年</div></td><td><div align=\"center\">8年</div></td></tr><tr><td width=\"227\"><div align=\"center\">工学学士或本科毕业</div></td><td><div align=\"center\">6年</div></td><td><div align=\"center\">9年</div></td></tr><tr><td width=\"227\"><div align=\"center\">专科毕业</div></td><td><div align=\"center\">7年</div></td><td><div align=\"center\">10年</div></td></tr><tr><td width=\"151\" colspan=\"2\"><div align=\"center\">其它工科专业</div></td><td width=\"227\"><div align=\"center\">工学学士或本科</div><div align=\"center\">毕业及以上学位</div></td><td><div align=\"center\">8年</div></td><td><div align=\"center\">12年</div></td></tr></tbody></table></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注：表中“Ⅰ类人员”指基础考试已经通过 ，继续申报专业考试的人员：“Ⅱ类人员” 指按建设部、人事部司发文《关于一级注册结构工程师资格考核认定和 1997年资格报考工作有关问题的说明》[（97）建设注字第46号]文件规定，符合免基础考试条件，只参加专业考试的人员 。免考范围不再扩大，该类人员可一直参加专业考试，直至通过为止 。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　2、 1970年（含1970年）以前建筑工程专业大学本科、专科毕业的人员。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　3、1970年（含1970年）以前建筑工程或相近专业中专及以上学历毕业，从事结构设计工作累计10年以上的人员。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　4、 1970 年（含 1970 年）以前参加工作，不具备规定学历要求，从事结构设计工作累计 15 年以上的人员。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（三）全国二级注册结构工程师执业资格考试报考条件</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;&nbsp;&nbsp; 具备下列条件人员</div><div align=\"center\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><table cellspacing=\"1\" cellpadding=\"0\" border=\"1\"><tbody><tr><td width=\"114\"><div align=\"center\">类别</div></td><td width=\"227\"><div align=\"center\">专业名称</div></td><td width=\"114\"><div align=\"center\">学 历</div></td><td width=\"114\"><div align=\"center\">职业实践</div><div align=\"center\">&nbsp;</div><div align=\"center\">最少时间 (年)</div></td></tr><tr><td width=\"114\" rowspan=\"5\"><div align=\"center\">本专业</div></td><td width=\"227\" rowspan=\"5\"><div align=\"center\">工业与民用建筑</div></td><td width=\"114\"><div align=\"center\">本科及以上学历</div></td><td width=\"114\"><div align=\"center\">2年</div></td></tr><tr><td width=\"114\"><div align=\"center\">普通大专毕业</div></td><td width=\"114\"><div align=\"center\">3年</div></td></tr><tr><td width=\"114\"><div align=\"center\">成人大专毕业</div></td><td width=\"114\"><div align=\"center\">4年</div></td></tr><tr><td width=\"114\"><div align=\"center\">普通中专毕业</div></td><td width=\"114\"><div align=\"center\">6年</div></td></tr><tr><td width=\"114\"><div align=\"center\">成人中专毕业</div></td><td width=\"114\"><div align=\"center\">7年</div></td></tr><tr><td width=\"114\" rowspan=\"5\"><div align=\"center\">相近专业</div></td><td width=\"227\" rowspan=\"5\"><div align=\"center\">建筑设计技术</div><div align=\"center\">&nbsp;</div><div align=\"center\">村镇建设</div><div align=\"center\">公路与桥梁</div><div align=\"center\">城市地下铁道</div><div align=\"center\">铁道工程</div><div align=\"center\">铁道桥梁与隧道</div><div align=\"center\">小型土木工程</div><div align=\"center\">水利水电工程建筑</div><div align=\"center\">水利工程</div><div align=\"center\">港口与航道工程</div></td><td width=\"114\"><div align=\"center\">本科及以上学历</div></td><td width=\"114\"><div align=\"center\">4年</div></td></tr><tr><td width=\"114\"><div align=\"center\">普通大专毕业</div></td><td width=\"114\"><div align=\"center\">6年</div></td></tr><tr><td width=\"114\"><div align=\"center\">成人大专毕业</div></td><td width=\"114\"><div align=\"center\">7年</div></td></tr><tr><td width=\"114\"><div align=\"center\">普通中专毕业</div></td><td width=\"114\"><div align=\"center\">9年</div></td></tr><tr><td width=\"114\"><div align=\"center\">成人中专毕业</div></td><td width=\"114\"><div align=\"center\">10年</div></td></tr><tr><td width=\"114\"><div align=\"center\">不具备规定学历</div></td><td width=\"227\" colspan=\"2\"><div align=\"center\">从事结构设计工作满 13年以上，且作为项目负责人或专业负责人，完成过三级（或中型工业建筑项目）不少于二项</div></td><td width=\"114\"><div align=\"center\">13年</div></td></tr></tbody></table></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">&nbsp;</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（四）上述报考条件中有关学历的要求是指国家教育行政主管部门承认的正规学历或学位。<b>以上报考条件仅供参考，以当次报考文件为准。</b></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　（五）经国务院有关部门同意，获准在中华人民共和国境内就业的外籍人员及港、澳、台地区的专业人员，符合《注册结构工程师执业资格制度暂行规定》和《 注册结构工程师 执业资格考试实施办法》的规定，也可按规定程序申请参加考试。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　报考人员应参照规定的报考条件，结合自身情况，自行确定是否符合报考条件。确认符合报考条件的人员，须经所在单位审查同意后，方可报名。凡不符合基础考试报考条件的人员，其考试成绩无效。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><b>&nbsp;&nbsp;&nbsp; 五、成绩管理</b></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　参加一、二级注册注册结构工程师考试的人员，须在1个考试年度内通过全部科目的考试。</div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\"><b>&nbsp;&nbsp;&nbsp;&nbsp;六、合格证书</b></div><div align=\"left\" style=\"font-size: 12px; font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif; color: rgb(0, 0, 0);\">　　注册结构工程师资格考试合格者，由各省、自治区、直辖市人事（职改）部门颁发人事部统一印制的、人事部与建设部用印的中华人民共和国《注册结构工程师执业资格证书》。该证书在全国范围内有效。</div>', '0', '1', '1', '20180226130429866809cc943b46fe84ca88bdbfe41809.jpg;20180226130430b219a13846b3404fb4378b9fb5ca2a59.jpg;', '', '2018-02-26 13:04:30');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

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
  `id_status` smallint(6) DEFAULT NULL,
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
INSERT INTO `user` VALUES ('1', 'UserTest', 'pbkdf2:sha256:50000$caF9Z7a5$eef64d9593bef1fe763ac6d2d2281ede710336866ff65e0260bda090d1b11b94', '0', '4@1.co', null, null, null, null, '2018-02-28 14:18:43', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userlog
-- ----------------------------
INSERT INTO `userlog` VALUES ('1', '1', '127.0.0.1', '2018-03-01 14:21:37');
INSERT INTO `userlog` VALUES ('3', '1', '127.0.0.1', '2018-03-01 14:59:12');
INSERT INTO `userlog` VALUES ('4', '1', '127.0.0.1', '2018-03-01 15:54:02');
INSERT INTO `userlog` VALUES ('5', '1', '127.0.0.1', '2018-03-01 17:45:49');
INSERT INTO `userlog` VALUES ('6', '1', '127.0.0.1', '2018-03-02 12:11:49');
