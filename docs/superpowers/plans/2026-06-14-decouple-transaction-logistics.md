---
change: decouple-transaction-logistics
design-doc: docs/superpowers/specs/2026-06-14-decouple-transaction-logistics-design.md
base-ref: c921f22b5815a3432716697f063bc3a4cdc15fb1
---
# Implementation Plan: Decouple Transaction Logistics

## User Review Required
请审查以下代码实现计划。我们采用提取公共卡片组件 + 公共 Mock 数据的方式进行。

## Proposed Changes

### utils
#### [NEW] [mockData.js](file:///Users/violet/Documents/gemini-work/market/market-frontend/utils/mockData.js)
- 导出包含四种状态的静态 Demo 数据。

### components
#### [NEW] [OrderLogisticsCard.vue](file:///Users/violet/Documents/gemini-work/market/market-frontend/components/OrderLogisticsCard.vue)
- 渲染订单列表和最新物流摘要的耦合式 UI。

### pages
#### [MODIFY] [bought.vue](file:///Users/violet/Documents/gemini-work/market/market-frontend/pages/profile/bought.vue)
- 使用 `OrderLogisticsCard.vue` 渲染上述 Mock 数据。
#### [MODIFY] [sold.vue](file:///Users/violet/Documents/gemini-work/market/market-frontend/pages/profile/sold.vue)
- 使用 `OrderLogisticsCard.vue` 渲染。
#### [MODIFY] [messages.vue](file:///Users/violet/Documents/gemini-work/market/market-frontend/pages/messages/messages.vue)
- 在物流 Tab 中使用相同组件和数据展示。
#### [MODIFY] [profile.vue](file:///Users/violet/Documents/gemini-work/market/market-frontend/pages/profile/profile.vue)
- 修改入口索引配置，更新“退款/售后”与“我的收藏”。
#### [NEW] [refunds.vue](file:///Users/violet/Documents/gemini-work/market/market-frontend/pages/profile/refunds.vue)
- 新增页面，展示退款售后占位。
#### [MODIFY] [pages.json](file:///Users/violet/Documents/gemini-work/market/market-frontend/pages.json)
- 配置路由表。

## Verification Plan
1. 手动在模拟器/浏览器预览 `bought.vue`、`sold.vue` 和 `messages.vue` 检查样式。
2. 检查 `profile.vue` 各入口跳转。
