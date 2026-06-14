---
comet_change: decouple-transaction-logistics
role: technical-design
canonical_spec: openspec
---
# Design: Decouple Transaction Logistics

## Overview
在买卖相关的页面及消息页面引入全新的“订单与物流耦合”UI组件，废弃时间线式的纯物流状态，提供类似淘宝/闲鱼的现代电商体验。此外，调整个人中心的入口布局。

## Architecture & Components
1. **组件抽象 (`components/OrderLogisticsCard.vue`)**
   - 负责渲染单个订单及其底部的最新物流状态。
   - 接收 `order` 对象，其中必须包含 `status` (待发货/待付款/待收货/退款中) 和 `latestLogistics`。

2. **Mock 数据 (`utils/mockData.js`)**
   - 导出一个供多个页面复用的订单 Mock 数组，包含这 4 种状态的假数据。

3. **页面改造**
   - `pages/profile/bought.vue` & `pages/profile/sold.vue`: 移除原有的空状态，引入 `OrderLogisticsCard.vue` 遍历渲染 Mock 数据。
   - `pages/messages/messages.vue`: 在交易物流 Tab 中采用相同的结构。
   - `pages/profile/profile.vue`: 修改网格菜单的数据配置。将 `icon` 和 `title` 分别改为“退款/售后”和“我的收藏”，调整路由目标。

4. **路由更新**
   - 创建 `pages/profile/refunds.vue` 页面。
   - 确认 `pages.json` 中的页面注册。

## Data Flow
纯前端静态数据驱动，无真实 API 请求。各页面引入 `mockData.js` 并绑定到模板中。

## Risks
- 确保引入新组件的路径和样式不破坏原页面的其它功能。
