/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.7.20 : Database - dirsir
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dirsir` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `dirsir`;

/*Table structure for table `account` */

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `account_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `account_name` varchar(20) NOT NULL COMMENT '用户名',
  `phone` varchar(11) DEFAULT NULL COMMENT '用户电话',
  `account_password` varchar(20) NOT NULL COMMENT '用户密码',
  `name` varchar(10) NOT NULL COMMENT '真实姓名',
  `gender` int(1) NOT NULL DEFAULT '1' COMMENT '默认为1男',
  `age` int(3) NOT NULL,
  `birthday` date NOT NULL,
  `id_card` varchar(18) NOT NULL,
  `balance` double(10,2) DEFAULT '0.00',
  `email` varchar(30) NOT NULL,
  `picture` varchar(50) DEFAULT NULL,
  `vip` int(1) NOT NULL DEFAULT '0',
  `vip_date` date DEFAULT NULL COMMENT '开通vip日期',
  `vip_birthday` date DEFAULT NULL COMMENT '注册日期',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_name` (`account_name`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `account` */

insert  into `account`(`account_id`,`account_name`,`phone`,`account_password`,`name`,`gender`,`age`,`birthday`,`id_card`,`balance`,`email`,`picture`,`vip`,`vip_date`,`vip_birthday`) values (1,'吉祥','18213229960','account123','吉祥',1,20,'1999-06-18','130722199906184546',0.00,'123456@qq.com',NULL,0,NULL,NULL),(2,'丁二','18827916662','account123','丁二',1,23,'1996-07-12','350181199607126764',0.00,'987654@qq.com',NULL,0,NULL,NULL),(3,'南','18865659090','account123','南',1,21,'1998-10-15','469025199810159090',0.00,'345678@qq.com',NULL,0,NULL,NULL);

/*Table structure for table `account_service` */

DROP TABLE IF EXISTS `account_service`;

CREATE TABLE `account_service` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '售后服务ID',
  `order_id` int(11) DEFAULT NULL COMMENT '订单号ID',
  `return_reason` varchar(100) NOT NULL COMMENT '退货原因',
  `return_date` date NOT NULL COMMENT '退货时间',
  `return_state` int(1) DEFAULT '1' COMMENT '退货状态',
  PRIMARY KEY (`service_id`),
  KEY `ser_list_fk` (`order_id`),
  CONSTRAINT `ser_list_fk` FOREIGN KEY (`order_id`) REFERENCES `order_list` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `account_service` */

insert  into `account_service`(`service_id`,`order_id`,`return_reason`,`return_date`,`return_state`) values (1,1,'商品破损，需要退货','2019-10-09',1),(2,2,'买错了，需要退货','2019-10-09',1);

/*Table structure for table `account_tarding` */

DROP TABLE IF EXISTS `account_tarding`;

CREATE TABLE `account_tarding` (
  `tarding_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '交易记录ID',
  `account_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `trading_date` date DEFAULT NULL COMMENT '交易日期',
  `tarding_prices` double(10,2) DEFAULT NULL COMMENT '交易金额',
  `tarding_type` int(1) DEFAULT NULL COMMENT '交易类型',
  `note` varchar(100) DEFAULT NULL COMMENT '备注 可为空',
  PRIMARY KEY (`tarding_id`),
  KEY `acc_tar_fk` (`account_id`),
  CONSTRAINT `acc_tar_fk` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `account_tarding` */

insert  into `account_tarding`(`tarding_id`,`account_id`,`trading_date`,`tarding_prices`,`tarding_type`,`note`) values (1,1,'2019-10-15',72.00,1,'购物'),(2,2,'2019-10-15',200.00,1,'购物');

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '平台管理员ID',
  `admin_number` int(11) DEFAULT NULL COMMENT '工号',
  `admin_name` varchar(20) DEFAULT NULL COMMENT '用户名',
  `admin_password` varchar(20) DEFAULT NULL COMMENT '密码',
  `real_name` varchar(20) DEFAULT NULL COMMENT '使用人',
  `state` int(1) DEFAULT '1' COMMENT '状态',
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `admin_number` (`admin_number`),
  UNIQUE KEY `admin_name` (`admin_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`admin_id`,`admin_number`,`admin_name`,`admin_password`,`real_name`,`state`) values (1,1001,'艾希','admin123','寒冰',1),(2,1002,'阿卡丽','admin123','暗影之拳',1);

/*Table structure for table `commodity` */

DROP TABLE IF EXISTS `commodity`;

CREATE TABLE `commodity` (
  `commodity_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `commodity_name` varchar(20) NOT NULL COMMENT '商品名称',
  `commodity_describe` varchar(100) DEFAULT NULL COMMENT '商品描述',
  `price` double(10,2) DEFAULT NULL COMMENT '商品单价',
  `vip_price` double(10,2) DEFAULT NULL COMMENT 'VIP单价',
  `subtype_id` int(11) DEFAULT NULL COMMENT '子类类型ID',
  `merchant_id` int(11) DEFAULT NULL COMMENT '商家ID',
  `sale_info` int(1) DEFAULT '1' COMMENT '上下架信息',
  `check_info` int(1) DEFAULT '3' COMMENT '审核信息',
  `check_date` date DEFAULT NULL COMMENT '审核时间',
  `admin_id` int(11) DEFAULT NULL COMMENT '审核人ID（管理员）',
  PRIMARY KEY (`commodity_id`),
  KEY `com_sub_fk` (`subtype_id`),
  KEY `mer_commo_fk` (`merchant_id`),
  KEY `admin_commo_fk` (`admin_id`),
  CONSTRAINT `admin_commo_fk` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
  CONSTRAINT `com_sub_fk` FOREIGN KEY (`subtype_id`) REFERENCES `commodity_subtype` (`subtype_id`),
  CONSTRAINT `mer_commo_fk` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `commodity` */

insert  into `commodity`(`commodity_id`,`commodity_name`,`commodity_describe`,`price`,`vip_price`,`subtype_id`,`merchant_id`,`sale_info`,`check_info`,`check_date`,`admin_id`) values (1,'百岁山矿泉水',NULL,3.00,3.00,5,2,1,3,'2019-10-15',1),(2,'百草味零食大礼包',NULL,88.00,85.00,6,2,1,3,'2019-10-15',1);

/*Table structure for table `commodity_picture` */

DROP TABLE IF EXISTS `commodity_picture`;

CREATE TABLE `commodity_picture` (
  `picture_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图片ID',
  `commodity_id` int(11) DEFAULT NULL COMMENT '商品ID',
  `picture_type` int(11) NOT NULL DEFAULT '1' COMMENT '图片类型',
  `picture_url` varchar(50) DEFAULT NULL COMMENT '图片路径',
  `picsort_code` int(11) DEFAULT '1' COMMENT '图片排序码',
  `picture_state` int(11) DEFAULT '3' COMMENT '图片状态',
  PRIMARY KEY (`picture_id`),
  KEY `commo_pic_fk` (`commodity_id`),
  CONSTRAINT `commo_pic_fk` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`commodity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `commodity_picture` */

insert  into `commodity_picture`(`picture_id`,`commodity_id`,`picture_type`,`picture_url`,`picsort_code`,`picture_state`) values (1,1,1,'asd.jpg',1,3),(2,2,1,'abc.jpg',1,3);

/*Table structure for table `commodity_sort` */

DROP TABLE IF EXISTS `commodity_sort`;

CREATE TABLE `commodity_sort` (
  `sort_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '类别ID',
  `commodity_id` int(11) DEFAULT NULL COMMENT '商品ID',
  `sort_name` varchar(30) NOT NULL COMMENT '类别名称',
  `sort_state` int(1) DEFAULT '1' COMMENT '类别状态',
  `sort_code` int(11) DEFAULT '1' COMMENT '排序码',
  PRIMARY KEY (`sort_id`),
  KEY `commo_subsort_fk` (`commodity_id`),
  CONSTRAINT `commo_subsort_fk` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`commodity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `commodity_sort` */

insert  into `commodity_sort`(`sort_id`,`commodity_id`,`sort_name`,`sort_state`,`sort_code`) values (1,1,'规格',1,1),(2,2,'规格',1,1);

/*Table structure for table `commodity_stock` */

DROP TABLE IF EXISTS `commodity_stock`;

CREATE TABLE `commodity_stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品进货id',
  `merchant_id` int(11) DEFAULT NULL COMMENT '商家id',
  `commodity_id` int(11) DEFAULT NULL COMMENT '商品id',
  `subsort` varchar(20) DEFAULT NULL COMMENT '商品类别',
  `stock_number` int(11) DEFAULT NULL COMMENT '商品数量',
  `stock_price` double(10,2) DEFAULT NULL COMMENT '商品单价',
  `stock_prices` double(10,2) DEFAULT NULL COMMENT '商品总价',
  `commodity_name` varchar(30) NOT NULL COMMENT '采购人',
  `buystock_date` date DEFAULT NULL COMMENT '进货日期',
  `supplier` varchar(50) NOT NULL COMMENT '供应商',
  PRIMARY KEY (`stock_id`),
  KEY `merch_stock_fk` (`merchant_id`),
  KEY `commo_stock_fk` (`commodity_id`),
  CONSTRAINT `commo_stock_fk` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`commodity_id`),
  CONSTRAINT `merch_stock_fk` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `commodity_stock` */

insert  into `commodity_stock`(`stock_id`,`merchant_id`,`commodity_id`,`subsort`,`stock_number`,`stock_price`,`stock_prices`,`commodity_name`,`buystock_date`,`supplier`) values (1,1,2,'200包/一箱',100,1.00,20000.00,'百草味零食大礼包','2019-10-08','南老板有限恭喜'),(2,2,1,'24瓶/一箱',100,3.00,7200.00,'百岁山矿泉水','2019-10-08','吴老板有限公司');

/*Table structure for table `commodity_subsort` */

DROP TABLE IF EXISTS `commodity_subsort`;

CREATE TABLE `commodity_subsort` (
  `subsort_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '详细类别ID',
  `sort_id` int(11) DEFAULT NULL COMMENT '类别ID',
  `subsort_name` varchar(30) DEFAULT NULL COMMENT '详细类别名称',
  `subsort_price` double(10,2) DEFAULT NULL COMMENT '价格',
  `vip_price` double(10,2) DEFAULT NULL COMMENT 'VIP价格',
  `subsort_state` int(1) DEFAULT '1' COMMENT '详细类别状态',
  `subsort_code` int(11) DEFAULT '1' COMMENT '排序码',
  PRIMARY KEY (`subsort_id`),
  KEY `sort_sub_fk` (`sort_id`),
  CONSTRAINT `sort_sub_fk` FOREIGN KEY (`sort_id`) REFERENCES `commodity_sort` (`sort_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `commodity_subsort` */

insert  into `commodity_subsort`(`subsort_id`,`sort_id`,`subsort_name`,`subsort_price`,`vip_price`,`subsort_state`,`subsort_code`) values (1,1,'24瓶/箱',72.00,68.00,1,1),(2,2,'200包/箱',88.00,85.00,1,1),(3,1,'12瓶/箱',36.00,35.00,1,1),(4,2,'248包/箱',108.00,105.00,1,1);

/*Table structure for table `commodity_subtype` */

DROP TABLE IF EXISTS `commodity_subtype`;

CREATE TABLE `commodity_subtype` (
  `subtype_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '子类类型ID',
  `type_id` int(11) DEFAULT NULL COMMENT '主类类型ID',
  `subtype_name` varchar(30) NOT NULL COMMENT '子类类型名称',
  `subtype_describe` varchar(100) DEFAULT NULL COMMENT '子类类型描述',
  `subtype_state` int(11) DEFAULT '1' COMMENT '子类类型状态',
  `subsort_code` int(11) DEFAULT '1' COMMENT '子类排序码',
  PRIMARY KEY (`subtype_id`),
  KEY `sub_type_fk` (`type_id`),
  CONSTRAINT `sub_type_fk` FOREIGN KEY (`type_id`) REFERENCES `commodity_type` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `commodity_subtype` */

insert  into `commodity_subtype`(`subtype_id`,`type_id`,`subtype_name`,`subtype_describe`,`subtype_state`,`subsort_code`) values (1,1,'衬衫',NULL,1,1),(2,1,'连衣裙',NULL,1,1),(3,2,'衬衫',NULL,1,1),(4,2,'风衣',NULL,1,1),(5,3,'饮料',NULL,1,1),(6,3,'零食大礼包',NULL,1,1),(7,4,'热带水果',NULL,1,1),(8,4,'新鲜猪肉',NULL,1,1),(9,5,'户外运动',NULL,1,1),(10,5,'运动穿搭',NULL,1,1),(11,6,'收纳整理',NULL,1,1),(12,6,'餐饮用具',NULL,1,1),(13,7,'手机',NULL,1,1),(14,7,'手机配件',NULL,1,1),(15,8,'女鞋',NULL,1,1),(16,8,'男鞋',NULL,1,1),(17,9,'吸尘器',NULL,1,1),(18,9,'烤箱',NULL,1,1);

/*Table structure for table `commodity_type` */

DROP TABLE IF EXISTS `commodity_type`;

CREATE TABLE `commodity_type` (
  `type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主类类型ID',
  `type_name` varchar(30) NOT NULL COMMENT '主类型名称',
  `type_describe` varchar(100) DEFAULT NULL COMMENT '主类类型描述',
  `type_state` int(11) DEFAULT '1' COMMENT '主类类型状态',
  `sort_code` int(11) DEFAULT '1' COMMENT '主类排序码',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `commodity_type` */

insert  into `commodity_type`(`type_id`,`type_name`,`type_describe`,`type_state`,`sort_code`) values (1,'女装','女士的衣服',1,1),(2,'男装','男人的衣柜',1,1),(3,'食品','民以食为天',1,1),(4,'生鲜','健康美味',1,1),(5,'运动','生命在于运动',1,1),(6,'百货','应有尽有',1,1),(7,'手机','一机在手，天下我有',1,1),(8,'鞋靴','只要能装，整个世界就是你的',1,1),(9,'家电','智能家居等你挑',1,1),(10,'数码','发现美的存在',1,1);

/*Table structure for table `evaluate` */

DROP TABLE IF EXISTS `evaluate`;

CREATE TABLE `evaluate` (
  `evaluate_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评价id',
  `order_id` int(11) DEFAULT NULL COMMENT '订单号id',
  `commodity_score` int(11) DEFAULT '10' COMMENT '商品评分',
  `logistic_score` int(11) DEFAULT '10' COMMENT '物流评分',
  `service_score` int(11) DEFAULT '10' COMMENT '服务评分',
  `evaluate` varchar(100) DEFAULT NULL COMMENT '评价内容',
  `evlauate_date` date DEFAULT NULL COMMENT '评价日期',
  PRIMARY KEY (`evaluate_id`),
  KEY `eval_oreder_fk` (`order_id`),
  CONSTRAINT `eval_oreder_fk` FOREIGN KEY (`order_id`) REFERENCES `order_list` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `evaluate` */

insert  into `evaluate`(`evaluate_id`,`order_id`,`commodity_score`,`logistic_score`,`service_score`,`evaluate`,`evlauate_date`) values (1,2,10,10,10,'这个商品我很喜欢','2009-07-31'),(2,1,10,10,10,'这个商品不错','2019-10-08');

/*Table structure for table `location` */

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `account_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `provinces` varchar(20) NOT NULL COMMENT '省',
  `city` varchar(20) NOT NULL COMMENT '市',
  `county` varchar(20) NOT NULL COMMENT '县',
  `specific_location` varchar(100) NOT NULL COMMENT '具体地址',
  `default_location` int(1) DEFAULT '0' COMMENT '是否为默认收获地址',
  `consignee` varchar(20) NOT NULL COMMENT '收件人',
  `phone` varchar(11) NOT NULL COMMENT '收货人电话',
  PRIMARY KEY (`location_id`),
  KEY `location_acc_fk` (`account_id`),
  CONSTRAINT `location_acc_fk` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `location` */

insert  into `location`(`location_id`,`account_id`,`provinces`,`city`,`county`,`specific_location`,`default_location`,`consignee`,`phone`) values (1,1,'江西省','九江市','共青城市','青年大道69号',0,'吉祥','18213229960'),(2,2,'河北省','张家口市','张北县','张北大道76号',0,'丁二','18827190000'),(3,3,'山西省','大同市','年区','同地锦园78号',0,'南','18800005656');

/*Table structure for table `merchant` */

DROP TABLE IF EXISTS `merchant`;

CREATE TABLE `merchant` (
  `merchant_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商家ID',
  `merchant_name` varchar(50) NOT NULL,
  `account` varchar(30) NOT NULL COMMENT '商家登录账户',
  `merchant_password` varchar(30) NOT NULL COMMENT '商家登录密码',
  `unify_code` varchar(20) NOT NULL COMMENT '社会征信统一代码',
  `manage` varchar(100) NOT NULL COMMENT '经营范围',
  `location` varchar(100) NOT NULL COMMENT '商家地址',
  `money` double(10,2) NOT NULL COMMENT '注册资金',
  `corp` varchar(20) NOT NULL COMMENT '法人',
  `corp_phone` varchar(11) NOT NULL COMMENT '法人电话',
  `director` varchar(20) DEFAULT NULL COMMENT '主管',
  `director_phone` varchar(11) DEFAULT NULL COMMENT '主管电话',
  `merchant_balance` double(10,2) DEFAULT '0.00' COMMENT '商家余额',
  `record_date` date NOT NULL COMMENT '注册日期',
  `record_state` int(1) DEFAULT '3' COMMENT '注册状态',
  `admin_id` int(11) DEFAULT NULL COMMENT '平台管理员',
  `check_date` date DEFAULT NULL COMMENT '审核日期',
  `license_picture` varchar(50) NOT NULL COMMENT '营业与可证图片',
  `corp_picture` varchar(50) NOT NULL COMMENT ' 法人ID_card图片',
  PRIMARY KEY (`merchant_id`),
  UNIQUE KEY `account` (`account`),
  KEY `admin_mer_fk` (`admin_id`),
  CONSTRAINT `admin_mer_fk` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `merchant` */

insert  into `merchant`(`merchant_id`,`merchant_name`,`account`,`merchant_password`,`unify_code`,`manage`,`location`,`money`,`corp`,`corp_phone`,`director`,`director_phone`,`merchant_balance`,`record_date`,`record_state`,`admin_id`,`check_date`,`license_picture`,`corp_picture`) values (1,'百草味','baicaowei','bcw123','123456789123456789','零食大礼包','北京市',10000000.00,'吴老板','13799720000',NULL,NULL,0.00,'2019-10-15',3,1,'2019-10-16','1.jpg','2.jpg'),(2,'百岁山','baisuishan','bss123','123456789123456789','矿泉水','上海市',1000000.00,'南老板','18827910000',NULL,NULL,0.00,'2018-11-23',3,1,'2018-11-24','3.jpg','4.jpg');

/*Table structure for table `merchant_repertory` */

DROP TABLE IF EXISTS `merchant_repertory`;

CREATE TABLE `merchant_repertory` (
  `repertory_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '库存id',
  `commodity_id` int(11) DEFAULT NULL COMMENT '商品id',
  `subsort` varchar(20) DEFAULT NULL COMMENT '商品详细类别',
  `check_repertory` int(11) DEFAULT NULL COMMENT '检查库存',
  `count_repertory` int(11) DEFAULT NULL COMMENT '统计库存',
  `check_date` date NOT NULL COMMENT '检查日期',
  `check_name` varchar(20) NOT NULL COMMENT '检查人',
  PRIMARY KEY (`repertory_id`),
  KEY `commo_reper_fk` (`commodity_id`),
  CONSTRAINT `commo_reper_fk` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`commodity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `merchant_repertory` */

insert  into `merchant_repertory`(`repertory_id`,`commodity_id`,`subsort`,`check_repertory`,`count_repertory`,`check_date`,`check_name`) values (1,1,'规格一箱24瓶',100,100,'2019-10-31','泰达米尔'),(2,2,'规格一箱两百包',100,100,'2019-10-31','亚索');

/*Table structure for table `merchant_return` */

DROP TABLE IF EXISTS `merchant_return`;

CREATE TABLE `merchant_return` (
  `return_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '退货id',
  `stock_id` int(11) DEFAULT NULL COMMENT '商家进货id',
  `return_cause` varchar(100) NOT NULL COMMENT '退货原因',
  `return_date` date NOT NULL COMMENT '退货时间',
  `return_number` int(11) DEFAULT NULL COMMENT '退货数量',
  `return_price` double(10,2) DEFAULT NULL COMMENT '退货单价',
  `return_prices` double(10,2) DEFAULT NULL COMMENT '退货总价',
  PRIMARY KEY (`return_id`),
  KEY `commo_return_fk` (`stock_id`),
  CONSTRAINT `commo_return_fk` FOREIGN KEY (`stock_id`) REFERENCES `commodity_stock` (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `merchant_return` */

/*Table structure for table `merchant_tarding` */

DROP TABLE IF EXISTS `merchant_tarding`;

CREATE TABLE `merchant_tarding` (
  `tarding_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商家交易ID',
  `merchant_id` int(11) DEFAULT NULL COMMENT '商家ID  FK',
  `tarding_date` date DEFAULT NULL COMMENT ' 商家交易时间',
  `tarding_prices` double(10,2) DEFAULT NULL COMMENT '商家交易金额',
  `tarding_state` int(1) DEFAULT NULL COMMENT '交易类型',
  `tarding_note` varchar(100) DEFAULT NULL COMMENT '备注  可为空',
  PRIMARY KEY (`tarding_id`),
  KEY `mer_tar_fk` (`merchant_id`),
  CONSTRAINT `mer_tar_fk` FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `merchant_tarding` */

insert  into `merchant_tarding`(`tarding_id`,`merchant_id`,`tarding_date`,`tarding_prices`,`tarding_state`,`tarding_note`) values (1,1,'2019-10-08',20000.00,1,'进货'),(2,2,'2019-10-08',7200.00,1,'进货');

/*Table structure for table `order_list` */

DROP TABLE IF EXISTS `order_list`;

CREATE TABLE `order_list` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单id',
  `order_number` varchar(50) DEFAULT NULL COMMENT '订单号',
  `account_id` int(11) DEFAULT NULL COMMENT '用户id',
  `prices` double(10,2) DEFAULT NULL COMMENT '总价',
  `location_id` int(11) DEFAULT NULL COMMENT '收货地址id',
  `order_date` date DEFAULT NULL COMMENT '订单日期',
  PRIMARY KEY (`order_id`),
  KEY `order_acc_fk` (`account_id`),
  KEY `loca_order_fk` (`location_id`),
  CONSTRAINT `loca_order_fk` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  CONSTRAINT `order_acc_fk` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `order_list` */

insert  into `order_list`(`order_id`,`order_number`,`account_id`,`prices`,`location_id`,`order_date`) values (1,'201902191001',1,30.00,1,'2019-10-22'),(2,'200907241002',3,1000.00,3,'2009-07-24');

/*Table structure for table `order_list_particulars` */

DROP TABLE IF EXISTS `order_list_particulars`;

CREATE TABLE `order_list_particulars` (
  `particulars_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单详情ID',
  `order_id` int(11) DEFAULT NULL COMMENT '订单id',
  `commodity_id` int(11) DEFAULT NULL COMMENT '商品id',
  `subsort` varchar(20) DEFAULT NULL COMMENT '商品详细类别',
  `commodity_number` int(11) DEFAULT NULL COMMENT '商品数量',
  `commodity_price` double(10,2) DEFAULT NULL COMMENT '商品单价',
  `commodity_prices` double(10,2) DEFAULT NULL COMMENT '商品总价',
  `buy_date` date DEFAULT NULL COMMENT '购买日期',
  `state` int(1) DEFAULT '1' COMMENT '订单状态',
  PRIMARY KEY (`particulars_id`),
  KEY `comm_parti_fk` (`commodity_id`),
  KEY `order_parti_fk` (`order_id`),
  CONSTRAINT `comm_parti_fk` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`commodity_id`),
  CONSTRAINT `order_parti_fk` FOREIGN KEY (`order_id`) REFERENCES `order_list` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `order_list_particulars` */

insert  into `order_list_particulars`(`particulars_id`,`order_id`,`commodity_id`,`subsort`,`commodity_number`,`commodity_price`,`commodity_prices`,`buy_date`,`state`) values (1,1,1,'一箱',24,3.00,72.00,'2019-10-08',1),(2,2,2,'一箱',1,1.00,200.00,'2019-10-08',1);

/*Table structure for table `shopping_cart` */

DROP TABLE IF EXISTS `shopping_cart`;

CREATE TABLE `shopping_cart` (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `account_id` int(11) DEFAULT NULL COMMENT '用户id',
  `commodity_id` int(11) DEFAULT NULL COMMENT '商品id',
  `subsort` varchar(20) DEFAULT NULL COMMENT '商品详细类别',
  `commodity_number` int(11) DEFAULT '1' COMMENT '商品数量',
  `commodity_price` double(10,2) DEFAULT NULL COMMENT '商品单价',
  `commodity_prices` double(10,2) DEFAULT NULL COMMENT '商品总价',
  PRIMARY KEY (`cart_id`),
  KEY `com_shopp_fk` (`commodity_id`),
  KEY `acc_shopp_fk` (`account_id`),
  CONSTRAINT `acc_shopp_fk` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `com_shopp_fk` FOREIGN KEY (`commodity_id`) REFERENCES `commodity` (`commodity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `shopping_cart` */

insert  into `shopping_cart`(`cart_id`,`account_id`,`commodity_id`,`subsort`,`commodity_number`,`commodity_price`,`commodity_prices`) values (1,1,1,'规格:24瓶/箱',1,3.00,72.00),(2,2,2,'规格一箱两百包',200,1.00,200.00);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
