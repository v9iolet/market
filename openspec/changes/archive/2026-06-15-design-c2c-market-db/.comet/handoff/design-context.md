# Comet Design Handoff

- Change: design-c2c-market-db
- Phase: design
- Mode: compact
- Context hash: 3da0887c851e91bd7270d4fa885f3727872c16144dedc03c24633f7b2565f6ba

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/design-c2c-market-db/proposal.md

- Source: openspec/changes/design-c2c-market-db/proposal.md
- Lines: 1-25
- SHA256: 68a1bb2937872f333619214c6ad60018b4cbe3121b7c5af4a18a77f053eacfd6

```md
# 数据库架构设计 - C2C二手交易平台

## 问题背景与目标
前端已经完成了 C2C 交易平台（类似闲鱼、转转）的页面开发（包括首页、详情、发布、分类、订单、聊天、个人中心等）。现需要基于前端页面需求，设计出符合大厂规范的底层数据库逻辑模型，并最终生成建库、建表、测试数据三个 SQL 文件。

## 范围边界
C 端核心交易链路，涵盖：
- 用户域（用户、地址、收藏）
- 商品域（商品、分类、图片）
- 交易域（订单、物流、退款）
- 互动域（消息、聊天）

## 非目标
目前仅完成架构设计与 SQL 文件生成，不编写 Java 代码或接口。

## 关键需求与决策
- **独立建表**：采用独立的 `mkt_user` 体系，不与后台 `sys_user` 强耦合，保持业务独立性。
- **消息过渡方案**：在 MySQL 中建立轻量级的 `mkt_message` 承担初期的消息与聊天存储。
- **仅用逻辑外键**：遵循互联网企业规范，不使用数据库层面的物理外键，依靠代码维持参照完整性。

## 验收场景
生成三个独立的 SQL 文件，并存放于 `market-backend/market-sql`：
1. 建库脚本
2. 包含全面中文注释与逻辑关系的建表脚本
3. 核心表的基础测试数据脚本
```

## openspec/changes/design-c2c-market-db/design.md

- Source: openspec/changes/design-c2c-market-db/design.md
- Lines: 1-26
- SHA256: 7ba213f57a038c4c0c94a3854294af6444554cde22020b963f996198e1785f8a

```md
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
```

## openspec/changes/design-c2c-market-db/tasks.md

- Source: openspec/changes/design-c2c-market-db/tasks.md
- Lines: 1-3
- SHA256: ba2c4dd11bb7b34ac4c248ae8d109eaf99415ca5468ab07c227d69b8dbcacc89

```md
- [ ] 编写数据库建库 SQL 文件：`01_market_database.sql`
- [ ] 编写数据库建表 SQL 文件：`02_market_tables.sql`（包含各表的字段、索引及注释）
- [ ] 编写测试数据 SQL 文件：`03_market_data.sql`
```

## openspec/changes/design-c2c-market-db/specs/schema/spec.md

- Source: openspec/changes/design-c2c-market-db/specs/schema/spec.md
- Lines: 1-3
- SHA256: 85ea1d3d476d3dc12ef3bf09380308e4b744ed4ffa11cf78eafa7b2263c9cc52

```md
# 数据库逻辑架构

定义 C2C 二手平台的数据库结构设计。
```

