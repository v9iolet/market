USE `market`;

SET NAMES utf8mb4;

-- ----------------------------
-- 1. 插入测试用户数据 (mkt_user)
-- ID 1: 卖家账号
-- ID 2: 买家账号
-- ---------------------------- 初始测试用户
INSERT INTO `mkt_user` (`id`, `email`, `password`, `nickname`, `avatar`, `points`, `membership_level_id`, `status`) VALUES
(1, 'admin@market.local', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '管理员', '', 0, 1, 1),
(2, 'buyer@market.local', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '测试买家', '', 1500, 3, 1),
(3, 'seller@market.local', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '测试卖家', '', 500, 2, 1);

-- ----------------------------
-- 1.5. 插入初始会员等级配置 (mkt_membership_level)
-- ----------------------------
INSERT INTO `mkt_membership_level` (`id`, `level_name`, `point_threshold`, `discount_rate`) VALUES
(1, '普通会员', 0, 1.00),
(2, '白银会员', 500, 0.98),
(3, '黄金会员', 2000, 0.95),
(4, '钻石会员', 5000, 0.90);

-- ----------------------------
-- 2. 插入测试地址数据 (mkt_user_address)
-- 买家的收货地址
-- ----------------------------
INSERT INTO `mkt_user_address` (`id`, `user_id`, `receiver_name`, `receiver_phone`, `province`, `city`, `district`, `detail_address`, `is_default`) VALUES
(1, 2, '王先生', '13900000002', '广东省', '深圳市', '南山区', '科技园中区1栋201', 1);

-- ----------------------------
-- 3. 插入商品分类数据 (mkt_category)
-- ----------------------------
INSERT INTO `mkt_category` (`id`, `parent_id`, `name`, `sort_order`, `status`) VALUES
(1, 0, '数码3C', 1, 1),
(2, 0, '服装鞋帽', 2, 1),
(3, 1, '手机', 1, 1),
(4, 1, '平板电脑', 2, 1);

-- ----------------------------
-- 4. 插入测试商品数据 (mkt_product)
-- ----------------------------
INSERT INTO `mkt_product` (`id`, `seller_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `status`) VALUES
(1, 1, 3, '九成新 iPhone 14 Pro Max 256G', '自用一手闲置，箱说全，电池健康89%，无拆修，急售回血。', 5200.00, 8999.00, '9成新', 1),
(2, 1, 4, '仅拆封 iPad Pro 11寸 M2', '年会奖品，仅拆封试机，带发票，成色充新。', 4800.00, 6799.00, '99新', 2);

-- ----------------------------
-- 5. 插入商品图片数据 (mkt_product_image)
-- ----------------------------
INSERT INTO `mkt_product_image` (`id`, `product_id`, `image_url`, `sort_order`) VALUES
(1, 1, 'https://example.com/images/p1_1.jpg', 1),
(2, 1, 'https://example.com/images/p1_2.jpg', 2),
(3, 2, 'https://example.com/images/p2_1.jpg', 1);

-- ----------------------------
-- 6. 插入测试订单数据 (mkt_order)
-- ID 2 的商品已售，对应产生一笔订单
-- ----------------------------
INSERT INTO `mkt_order` (`id`, `order_no`, `buyer_id`, `seller_id`, `product_id`, `address_id`, `total_amount`, `status`, `payment_time`) VALUES
(1, 'ORD202606150001', 2, 1, 2, 1, 4800.00, 2, CURRENT_TIMESTAMP);

-- ----------------------------
-- 7. 插入测试消息数据 (mkt_message)
-- ----------------------------
INSERT INTO `mkt_message` (`id`, `sender_id`, `receiver_id`, `content`, `type`, `is_read`) VALUES
(1, 2, 1, '老板，这个 iPad 还能便宜点吗？', 1, 1),
(2, 1, 2, '已经是最低价了，带发票的，不议价哦', 1, 1);
