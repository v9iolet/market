# Brainstorm Summary

- Change: decouple-transaction-logistics
- Date: 2026-06-14

## Confirmed Technical Approach

1. 页面迁移与重构：新建 `pages/order/logistics-detail.vue` 页面，将原 `messages/logistics.vue` 中的静态时间线代码迁移过去，使其成为通用组件（未来可通过 URL 参数传入订单ID查询）。
2. 消息通知页 (`logistics-notices.vue`)：顶部实现自定义 Tab 栏（我买到的 / 我卖出的），下方使用 `<swiper>` 包裹两个 `<scroll-view>`，实现滑动切换体验。页面内使用 mock 数据渲染列表，点击列表项均调用 `uni.navigateTo` 跳转至 `/pages/order/logistics-detail`。
3. 入口改造：修改 `messages.vue` 里的“交易物流”入口，将路由指向 `/pages/messages/logistics-notices`。

## Key Trade-offs and Risks

- 权衡：使用 `<swiper>` 会略微增加页面的 DOM 复杂度，但带来了类似原生 App 的流畅切换体验，优于单纯的 `v-if`。
- 风险：旧的 `/pages/messages/logistics` 路由需要在 `pages.json` 中删除。如果有其他地方硬编码了这个旧路由，可能会导致 404（目前分析仅 `messages.vue` 引用了它，风险可控）。

## Testing Strategy

- 验证消息页点击“交易物流”是否正确进入带 Tab 的通知列表页。
- 验证左右滑动和点击 Tab 切换是否正常工作，数据是否各自独立。
- 验证点击列表里的通知卡片，是否能正确跳转到纯粹的物流详情页 (logistics-detail)。

## Spec Patches

None
