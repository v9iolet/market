# 架构与设计 (Design)

## 架构拆分方案
我们将交易物流相关的页面进行“三层解耦”：

1. **消息通知层 (Logistics Notices)**
   - 在 `pages/messages/logistics-notices.vue` 中实现物流消息流。
   - 包含顶部选项卡（Tabs），分为“我买到的”和“我卖出的”。
   - 列表仅展示状态变更的摘要（如“已发货”、“正在派件”）。

2. **订单管理层 (Order Management)**
   - `pages/profile/bought.vue` 和 `pages/profile/sold.vue` 作为订单列表。
   - 每个订单卡片中暴露“查看物流”的按钮。

3. **通用物流展示层 (Logistics Timeline)**
   - 将原有的 `pages/messages/logistics.vue` 重构并迁移至 `pages/order/logistics-detail.vue`。
   - 此页面不感知买卖双方上下文，仅根据传入的 `orderId` 或 `trackingNumber` 渲染纯粹的物流轨迹时间线。

## 数据流与路由 (Routing)
- `/pages/messages/messages` -> 点击交易物流 -> `/pages/messages/logistics-notices`
- `/pages/messages/logistics-notices` -> 点击具体通知 -> `/pages/order/logistics-detail?id=xxx`
- 订单列表（买到/卖出） -> 点击查看物流 -> `/pages/order/logistics-detail?id=xxx`
