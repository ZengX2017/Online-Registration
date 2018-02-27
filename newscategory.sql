/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50638
Source Host           : localhost:3306
Source Database       : online-registration

Target Server Type    : MYSQL
Target Server Version : 50638
File Encoding         : 65001

Date: 2018-02-08 22:06:50
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of newscategory
-- ----------------------------
INSERT INTO `newscategory` VALUES ('1', '首页', '2018-02-08 13:22:01');
INSERT INTO `newscategory` VALUES ('2', '资格考试', '2018-02-08 13:59:59');
INSERT INTO `newscategory` VALUES ('3', '考试动态', '2018-02-08 14:01:07');
INSERT INTO `newscategory` VALUES ('4', '工作动态', '2018-02-08 21:34:52');
