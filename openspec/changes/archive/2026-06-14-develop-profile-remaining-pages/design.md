# Design: Profile Remaining Pages & Interception

## 1. 架构方案选项
- **UI 组件事件绑定**: 延续原有架构设计，直接在 `market-frontend/pages/profile/profile.vue` 中对应的功能项上添加 `@click="checkAuthAndNavigate('...')"`。
- **目标路由安排**:
  - 关于我们 -> `/pages/profile/about`
  - 官方客服 -> `/pages/profile/support`
  - 我的账单 -> `/pages/profile/bills`
  - 消息 -> `/pages/messages/messages` (已有路由复用)

## 2. 核心模块与数据流
- 依赖上一期已实现的 `checkAuthAndNavigate` 方法和 `login.vue` 的重定向回跳逻辑，数据流不变。
- 在 `market-frontend/pages/profile/` 目录中新增 3 个基础的结构页面组件 (`about.vue`, `support.vue`, `bills.vue`)，并注册于 `pages.json`。
