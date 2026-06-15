---
comet_change: ui-interactions-mock
role: technical-design
canonical_spec: openspec
archived-with: 2026-06-14-ui-interactions-mock
status: final
---

# UI Interactions Mock - Design Document

## 1. 架构与实现方案

本变更核心在于打通关键 UI 交互与路由流转，不涉及复杂的后端架构。

### 1.1 首页通知图标路由
- 定位：`market-frontend/pages/index/index.vue` (或其 Navbar 组件)。
- 行为：为通知图标绑定 `@click`，使用 `uni.navigateTo` 导航至 `/pages/messages/messages`。

### 1.2 商品详情页“收藏/想要”交互反馈
- 定位：`market-frontend/pages/product/detail.vue` 底部操作栏（可能在组件内如 `BottomBar.vue` 或直接在 `detail.vue` 中）。
- 实现：
  - 添加响应式数据：`isFavorite` 控制图标状态，`showFavoriteToast` 控制内联提示显示。
  - 布局：在 `.bottom-bar` (需设为 `position: relative`) 内添加一个使用 `position: absolute; bottom: 100%;` 的 `<view class="inline-toast">已添加至收藏</view>`。
  - 逻辑：点击触发 `toggleFavorite` 方法，设置 `isFavorite = true` 及 `showFavoriteToast = true`，并设立定时器在 2 秒后将 `showFavoriteToast` 恢复为 `false`。

### 1.3 咨询功能路由
- 定位：商品详情页的“咨询”按钮。
- 行为：调用 `uni.navigateTo({ url: '/pages/messages/chat?id=mockUser&name=卖家' })` 模拟向卖家发起咨询的过程。

## 2. 风险与注意事项

- **样式冲突**：局部绝对定位需注意商品详情页 `scroll-view` 到底部时的遮挡问题，确保其附着于固定的 bottom bar 而不是随内容滚动。
- **内存防漏**：在组件销毁前（`beforeDestroy`）应清除正在运行的 setTimeout，避免导致报错或状态不同步。

## 3. 测试策略
- 纯手工 UI 交互验证，确认各路径均可正常访问且收藏提示按预期渲染与淡出。
