---
comet_change: pure-logistics-notice-ui
role: technical-design
canonical_spec: openspec
archived-with: 2026-06-14-pure-logistics-notice-ui
status: final
---
# Design: Pure Logistics Notice UI

## Overview
This design covers the refactoring of the "交易物流" (Transaction Logistics) page in the messages module. The page will transition from a tabbed order-logistics hybrid view to a unified, timeline-based pure logistics notification stream (similar to Taobao/Xianyu logistics assistant).

## Approach
- **Decoupling**: Remove the dependency on `OrderLogisticsCard.vue` in `logistics-notices.vue`.
- **New Component**: Create a dedicated `LogisticsNoticeCard.vue` tailored for pure notifications.
- **Data Source**: Introduce `logisticsNoticesDemoData` in `mockData.js` to simulate pure notification events.

## UI Components
### LogisticsNoticeCard.vue
- **Props**: `notice` Object.
- **Layout**: 
  - **Header**: Left side displays `notice.statusTitle` (e.g., "您的包裹已发货" / "包裹派送中"), right side displays `notice.time`.
  - **Body**: Left side is `notice.productImg`. Right side contains `notice.expressCompany`, `notice.trackingNo`, and `notice.latestDesc` (e.g., "顺丰速运：您的快件已到达【深圳市】").
- **Interaction**: Clicking the card uses `uni.navigateTo` to route to `/pages/order/logistics-detail`.
- **Compatibility**: Built with Vue 2 Options API.

## Page Refactoring
### pages/messages/logistics-notices.vue
- **Layout**: Remove top tabs ("我买到的", "我卖出的") and the inner swiper. Replace with a straightforward `scroll-view`.
- **Data Rendering**: Import `logisticsNoticesDemoData` and render a list of `LogisticsNoticeCard.vue` components.

## Mock Data
### utils/mockData.js
- Add export `logisticsNoticesDemoData`.
- Structure should reflect individual notifications rather than aggregated order statuses. Ensure the mock data is fully wired up to be displayed immediately upon load.

## Testing
- Verify that `logistics-notices.vue` loads without the tabs.
- Verify that mock data successfully renders into `LogisticsNoticeCard.vue`.
- Verify that clicking a notice navigates to `/pages/order/logistics-detail`.
