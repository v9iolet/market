# 数据库结构与设计说明

## 实体域划分

1. **User Domain (用户域)**
   - `mkt_user`: 前端用户核心表（同时承载买家和卖家的信用、状态）。
   - `mkt_user_address`: 用户收货地址。
   - `mkt_user_favorite`: 用户收藏的商品。

2. **Product Domain (商品域)**
   - `mkt_category`: 商品分类树（支持父子层级）。
   - `mkt_product`: 商品主记录，包含价格、成色、状态（上架/已售/下架）等 C2C 特有属性。
   - `mkt_product_image`: 商品的多图展示。

3. **Transaction Domain (交易域)**
   - `mkt_order`: 核心交易记录，必须同时关联买家 (`buyer_id`) 和卖家 (`seller_id`)。
   - `mkt_order_logistics`: 订单相关的物流追踪。
   - `mkt_refund`: 交易售后维权与退款。

4. **Interaction Domain (互动域)**
   - `mkt_message`: 聊天与互动消息记录。

## 技术规范
1. **命名规范**：表名统一使用 `mkt_` 前缀，使用小写与下划线。
2. **逻辑外键**：不创建 `CONSTRAINT FOREIGN KEY` 物理关联。
3. **元数据字段**：每张表必须包含主键 `id`，以及 `created_at`、`updated_at`。
