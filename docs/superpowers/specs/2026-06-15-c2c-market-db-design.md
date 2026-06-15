---
comet_change: design-c2c-market-db
role: technical-design
canonical_spec: openspec
archived-with: 2026-06-15-design-c2c-market-db
status: final
---

# C2C 市场数据库架构设计方案

## 1. 架构选型与策略

根据前端业务需求与大厂设计规范，我们确立以下架构策略：
- **独立域划分**：C端用户的交易数据完全独立于 B 端管理后台 (`sys_user`)，所有 C 端表以 `mkt_` 为前缀。
- **关联机制**：数据库内不建立物理的外键约束（FOREIGN KEY），全部使用逻辑外键，以提升写入和修改的性能。
- **消息临时方案**：考虑到前期研发成本，暂时在 MySQL 建立轻量级表 `mkt_message`，后期数据量爆发后再做冷热分离或迁移。

## 2. 核心表结构规划

### 2.1 用户域 (User Domain)
- `mkt_user`: `id`, `phone`, `password`, `nickname`, `avatar`, `credit_score`, `status`, `created_at`, `updated_at`
- `mkt_user_address`: `id`, `user_id`, `receiver_name`, `receiver_phone`, `province`, `city`, `district`, `detail_address`, `is_default`, `created_at`, `updated_at`
- `mkt_user_favorite`: `id`, `user_id`, `product_id`, `created_at`

### 2.2 商品域 (Product Domain)
- `mkt_category`: `id`, `parent_id`, `name`, `icon`, `sort_order`, `status`, `created_at`, `updated_at`
- `mkt_product`: `id`, `seller_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `status`, `views`, `likes`, `created_at`, `updated_at`
- `mkt_product_image`: `id`, `product_id`, `image_url`, `sort_order`, `created_at`

### 2.3 交易域 (Transaction Domain)
- `mkt_order`: `id`, `order_no`, `buyer_id`, `seller_id`, `product_id`, `address_id`, `total_amount`, `status`, `payment_time`, `delivery_time`, `receive_time`, `created_at`, `updated_at`
- `mkt_order_logistics`: `id`, `order_id`, `courier_company`, `tracking_no`, `status`, `created_at`, `updated_at`
- `mkt_refund`: `id`, `order_id`, `user_id`, `amount`, `reason`, `status`, `created_at`, `updated_at`

### 2.4 互动域 (Interaction Domain)
- `mkt_message`: `id`, `sender_id`, `receiver_id`, `content`, `type`, `is_read`, `created_at`

## 3. 测试策略
将在 `03_market_data.sql` 中写入覆盖以下场景的测试数据：
- 买家和卖家测试账号各一名
- 一至两级分类数据
- 2-3 个商品（部分上架，部分已售）
- 至少一个包含完整买家卖家信息的订单

## 4. 后续任务安排
由 `/comet-build` 阶段实际负责创建和编写对应的 3 个 SQL 脚本，并存放于 `market-backend/market-sql` 目录。
