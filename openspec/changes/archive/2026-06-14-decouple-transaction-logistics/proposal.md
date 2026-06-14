# Proposal: Decouple Transaction Logistics

## Problem Statement
当前系统的交易物流采用时间线状态展示，在“我买到的”和“我卖出的”页面中，物流与订单信息分离且缺乏连贯的 UI 展现。用户在查看订单时，不能直观地在订单卡片中预览到最新的物流进度，这种体验落后于目前主流电商平台（如淘宝、闲鱼、转转等）。同时，“我的”页面结构需要调整，以适应业务上对“退款/售后”入口的提权。

## Goals
1. 在“我买到的”和“我卖出的”订单列表中写入 4 种状态的静态 Demo 数据（待发货、待付款、待收货、退款中）。
2. 将订单状态和最新一条物流动态耦合展示在订单列表卡片内部，点击卡片再进入物流详情，废弃原有的纯物流时间线 UI。
3. 在消息页（messages.vue）的物流消息 Tab 中，同步上述订单与物流耦合的 UI 设计及 Demo 数据。
4. 个人中心页调整：将“我的收藏”替换为“退款/售后”并展示退款中状态，原“我的账单”替换为“我的收藏”，并同步更新相关的路由与页面文件。

## Non-Goals
1. 不涉及真实的后端接口对接，所有数据纯前端静态 Mock。
2. 不涉及真实的退款流程或物流详情页深层级改造，仅聚焦在入口级和列表级卡片 UI 调整。
3. 不更改其他订单状态的深层交互逻辑。

## Scope
- `market-frontend/pages/profile/bought.vue`
- `market-frontend/pages/profile/sold.vue`
- `market-frontend/pages/profile/profile.vue`
- 新增或重命名二级页：`favorites.vue`, `bills.vue` (替换), `refunds.vue`
- `market-frontend/pages/messages/messages.vue`
