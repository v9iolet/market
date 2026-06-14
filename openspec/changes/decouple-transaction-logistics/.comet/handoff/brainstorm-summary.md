# Brainstorm Summary

- Change: decouple-transaction-logistics
- Date: 2026-06-14

## Confirmed Technical Approach

1. 提取公共组件 `OrderLogisticsCard.vue`，实现带有底部物流预览的复合卡片，支持传入不同的订单状态和物流信息。
2. 建立统一的 Mock 数据文件（如 `utils/mockData.js`），在 `bought.vue`、`sold.vue` 和 `messages.vue` 交易物流 Tab 中 import 复用。
3. 更新 `profile.vue`，修改应用网格的菜单项配置，新增 `refunds.vue`，重命名或替换 `bills.vue`。

## Key Trade-offs and Risks

- 暂无明显风险。前端组件抽象可以大幅降低代码冗余。

## Testing Strategy

- UI 测试：手动预览 `bought.vue`、`sold.vue` 和 `messages.vue` 界面，确认卡片是否正常渲染 4 种订单状态及物流动态。
- 路由测试：从 `profile.vue` 点击“退款/售后”与“我的收藏”，检查页面跳转是否正确。

## Spec Patches

None
