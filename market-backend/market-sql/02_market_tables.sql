USE `market_c2c`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- 1. 用户域 (User Domain)
-- ----------------------------

-- Table structure for mkt_user
DROP TABLE IF EXISTS `mkt_user`;
CREATE TABLE `mkt_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `password` varchar(100) NOT NULL COMMENT '密码',
  `nickname` varchar(50) NOT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像URL',
  `credit_score` int(11) DEFAULT '500' COMMENT '信用分（默认500）',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态（1正常 0停用）',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='C端用户表';

-- Table structure for mkt_user_address
DROP TABLE IF EXISTS `mkt_user_address`;
CREATE TABLE `mkt_user_address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '地址ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `receiver_name` varchar(50) NOT NULL COMMENT '收件人姓名',
  `receiver_phone` varchar(20) NOT NULL COMMENT '收件人电话',
  `province` varchar(50) DEFAULT NULL COMMENT '省份',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `district` varchar(50) DEFAULT NULL COMMENT '区县',
  `detail_address` varchar(255) NOT NULL COMMENT '详细地址',
  `is_default` tinyint(4) DEFAULT '0' COMMENT '是否默认（1是 0否）',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户收货地址表';

-- Table structure for mkt_user_favorite
DROP TABLE IF EXISTS `mkt_user_favorite`;
CREATE TABLE `mkt_user_favorite` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `product_id` bigint(20) NOT NULL COMMENT '商品ID',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_product` (`user_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户收藏表';


-- ----------------------------
-- 2. 商品域 (Product Domain)
-- ----------------------------

-- Table structure for mkt_category
DROP TABLE IF EXISTS `mkt_category`;
CREATE TABLE `mkt_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父分类ID',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `icon` varchar(255) DEFAULT NULL COMMENT '分类图标URL',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序（数字越小越靠前）',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态（1正常 0隐藏）',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品分类表';

-- Table structure for mkt_product
DROP TABLE IF EXISTS `mkt_product`;
CREATE TABLE `mkt_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `seller_id` bigint(20) NOT NULL COMMENT '卖家ID(关联mkt_user.id)',
  `category_id` bigint(20) NOT NULL COMMENT '分类ID',
  `title` varchar(100) NOT NULL COMMENT '商品标题',
  `description` text COMMENT '图文描述',
  `price` decimal(10,2) NOT NULL COMMENT '转让价',
  `original_price` decimal(10,2) DEFAULT NULL COMMENT '入手原价',
  `condition` varchar(20) DEFAULT NULL COMMENT '成色（如：全新、9成新）',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态（1上架 2已售出 3下架）',
  `views` int(11) DEFAULT '0' COMMENT '浏览量',
  `likes` int(11) DEFAULT '0' COMMENT '点赞数/想看数',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_seller_id` (`seller_id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品主表';

-- Table structure for mkt_product_image
DROP TABLE IF EXISTS `mkt_product_image`;
CREATE TABLE `mkt_product_image` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '图片ID',
  `product_id` bigint(20) NOT NULL COMMENT '商品ID',
  `image_url` varchar(255) NOT NULL COMMENT '图片链接',
  `sort_order` int(11) DEFAULT '0' COMMENT '排序，首图最小',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品多图表';


-- ----------------------------
-- 3. 交易域 (Transaction Domain)
-- ----------------------------

-- Table structure for mkt_order
DROP TABLE IF EXISTS `mkt_order`;
CREATE TABLE `mkt_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(50) NOT NULL COMMENT '订单编号(唯一)',
  `buyer_id` bigint(20) NOT NULL COMMENT '买家ID',
  `seller_id` bigint(20) NOT NULL COMMENT '卖家ID',
  `product_id` bigint(20) NOT NULL COMMENT '商品ID',
  `address_id` bigint(20) NOT NULL COMMENT '收货地址ID',
  `total_amount` decimal(10,2) NOT NULL COMMENT '订单总价',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态（1待付 2待发 3待收 4完成 5取消 6退款中 7已关闭）',
  `payment_time` datetime DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime DEFAULT NULL COMMENT '收货时间',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_no` (`order_no`),
  KEY `idx_buyer_id` (`buyer_id`),
  KEY `idx_seller_id` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易订单主表';

-- Table structure for mkt_order_logistics
DROP TABLE IF EXISTS `mkt_order_logistics`;
CREATE TABLE `mkt_order_logistics` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `courier_company` varchar(50) DEFAULT NULL COMMENT '快递公司名称',
  `tracking_no` varchar(50) DEFAULT NULL COMMENT '物流单号',
  `status` varchar(20) DEFAULT NULL COMMENT '物流状态',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单物流表';

-- Table structure for mkt_refund
DROP TABLE IF EXISTS `mkt_refund`;
CREATE TABLE `mkt_refund` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `user_id` bigint(20) NOT NULL COMMENT '申请人(买家)ID',
  `amount` decimal(10,2) NOT NULL COMMENT '退款金额',
  `reason` varchar(255) NOT NULL COMMENT '退款原因/维权描述',
  `status` tinyint(4) DEFAULT '1' COMMENT '退款状态（1处理中 2同意退款 3拒绝退款 4已取消）',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易售后退款表';


-- ----------------------------
-- 4. 互动域 (Interaction Domain)
-- ----------------------------

-- Table structure for mkt_message
DROP TABLE IF EXISTS `mkt_message`;
CREATE TABLE `mkt_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '消息ID',
  `sender_id` bigint(20) NOT NULL COMMENT '发送方ID(0表示系统通知)',
  `receiver_id` bigint(20) NOT NULL COMMENT '接收方ID',
  `content` text NOT NULL COMMENT '消息内容',
  `type` tinyint(4) DEFAULT '1' COMMENT '消息类型（1文本 2图片 3系统通知 4交易状态）',
  `is_read` tinyint(4) DEFAULT '0' COMMENT '是否已读（1已读 0未读）',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
  PRIMARY KEY (`id`),
  KEY `idx_sender_receiver` (`sender_id`,`receiver_id`),
  KEY `idx_receiver_id` (`receiver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='轻量级消息与聊天表';

SET FOREIGN_KEY_CHECKS = 1;
