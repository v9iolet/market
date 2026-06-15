---
title: UI Interactions Mock Design
status: draft
---

# Design: UI Interactions Mock

## Approach

本次变更的核心是补充交互链路，不涉及复杂的状态管理，采用直接在组件内维护本地状态和通过 `uni.navigateTo` 控制路由的方式。

### 1. 首页通知路由
- 找到 `market-frontend/pages/index/index.vue`（或者如果是自定义 Navbar 的话找到对应的组件）。
- 为铃铛/通知图标元素绑定 `@click` 事件，调用 `uni.navigateTo({ url: '/pages/messages/messages' })` 或使用 `uni.switchTab` (若属于 Tab 页面)。由于之前代码显示消息页包含 CustomTabBar，可能是独立页面。

### 2. 收藏交互 (局部文本提示)
- 定位到 `market-frontend/pages/product/detail.vue` 或者商品详情底部操作组件。
- 增加一个局部状态 `isFavorite: false` 记录收藏状态。
- 增加一个局部状态 `showFavoriteToast: false` 用于控制“已添加至收藏”提示的显示与隐藏。
- 样式上：在底部功能栏 `.bottom-bar` 元素正上方使用绝对或相对定位放置一个提示层（内联提示）。
- 交互流：点击“想要” -> 切换 `isFavorite` -> 触发提示栏展示 `showFavoriteToast = true` -> 设定 `setTimeout` (如 2 秒后) 自动隐藏提示栏。

### 3. 咨询路由跳转
- 找到商品详情页底部操作栏的“咨询”按钮。
- 绑定 `@click` 事件，使用 `uni.navigateTo({ url: '/pages/messages/chat?id=mockUser&name=卖家名字' })` 的方式，跳转并传递 mock 数据。

## Impact

- 纯前端交互模拟，对现有业务流无破坏性影响。
- 新增的内联 Toast 不会阻挡其他页面的操作，由于依赖局部状态，需注意避免内存泄漏（清除定时器）。
