# Design: Pure Logistics Notice UI

## 整体思路 (Approach)
放弃在消息中心的物流通知页复用订单管理卡片 (`OrderLogisticsCard.vue`)。改为引入一个更加轻量化、专门用于消息通知的卡片组件 `LogisticsNoticeCard.vue`。

## UI 与交互设计 (UI & Interaction Design)
- **LogisticsNoticeCard.vue**: 
  - 顶部显示：物流状态标题（例如：“您的包裹已发货”、“包裹派送中”），右侧带时间戳。
  - 中间内容区：商品缩略图 + 快递公司与单号或最新的流转文本（例如：“顺丰速运：您的快件已到达【深圳市】”）。
  - 点击卡片：使用 `uni.navigateTo` 跳转到 `/pages/order/logistics-detail`，传递运单相关参数（演示数据即可）。
- **logistics-notices.vue**:
  - 移除原有的 Tabs 和 Swiper 结构。
  - 仅保留一个简单的 `scroll-view` 列表页。
  - 引入并使用 `LogisticsNoticeCard` 渲染 Mock 的物流通知数组。

## 数据设计 (Data Design)
在 `mockData.js` 中新增 `logisticsNoticesDemoData`，专门用于驱动这条通知流。结构应当更侧重于时间线上的单条事件，而非按订单聚合的状态。
