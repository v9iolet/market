# 数据库逻辑架构

定义 C2C 二手平台的数据库结构设计。

## [ADDED]

新增针对 C2C 二手交易的数据库表，使用 `mkt_` 前缀，包含核心四大域：

1. **用户域**
   - `mkt_user`: 买家与卖家用户表
   - `mkt_user_address`: 收货地址表
   - `mkt_user_favorite`: 用户收藏表

2. **商品域**
   - `mkt_category`: 商品分类表
   - `mkt_product`: 二手商品主表
   - `mkt_product_image`: 二手商品多图表

3. **交易域**
   - `mkt_order`: 交易订单主表
   - `mkt_order_logistics`: 订单物流表
   - `mkt_refund`: 交易售后退款表

4. **互动域**
   - `mkt_message`: 轻量级聊天及消息通知表

采用逻辑外键设计，包含完整的审计字段(`created_at`, `updated_at`)。
