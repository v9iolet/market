# Proposal: Pure Logistics Notice UI

## 目标 (Goals)
将消息页的“交易物流”页面（`logistics-notices.vue`）改版为纯粹的“物流动态通知”流。不再区分“我买的/我卖的”，取消顶部 Tab 切换，统一按照时间倒序展示最新的物流通知（参考闲鱼/淘宝的物流助手样式）。

## 非目标 (Non-goals)
不影响个人主页（我的页面）中“我买到的”和“我卖出的”订单列表样式，它们继续使用现有的订单卡片。不处理实际的后台物流接口对接，仅实现前端 UI 和 Mock 数据。

## 范围边界 (Scope Boundaries)
修改 `pages/messages/logistics-notices.vue`，新增专属的 `LogisticsNoticeCard.vue` UI 组件，并在 `mockData.js` 中新增专门的物流通知 Mock 数据。

## 验收场景 (Acceptance Scenarios)
1. 用户进入“交易物流”页面，不再看到顶部 Tab，而是直接看到一个纵向排列的物流通知列表。
2. 列表中的每条通知包含：物流状态（如“已发货”、“派送中”）、更新时间、相关商品缩略图及简要物流信息。
3. 点击新的物流通知卡片，默认跳转到系统已有的物流详情页（`/pages/order/logistics-detail`）。
