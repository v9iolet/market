---
comet_change: develop-profile-remaining-pages
role: technical-design
canonical_spec: openspec
archived-with: 2026-06-14-develop-profile-remaining-pages
status: final
---

# Technical Design: Profile Remaining Secondary Pages & Auth Interception

## 1. 架构与数据流
- **鉴权重定向**：复用 `checkAuthAndNavigate` 鉴权方法。当触发目标操作时，若状态为未登录，则在路由级别附加 `redirect` URL 参数转至 `/pages/login/login`。
- **消息模块**：目标绑定于 `profile.vue` 顶部的通知按钮（`notifications` 图标）。由于项目中已存在 `/pages/messages/messages` 路由，此处无需重复新建文件，仅应用拦截方法。
- **补充页面**：新增 `/pages/profile/bills`, `/pages/profile/support`, `/pages/profile/about` 基础组件并完成路由注册。

## 2. 具体修改点
- `market-frontend/pages/profile/profile.vue`:
  - 添加事件处理器：
    - `<view class="icon-btn active-scale">` (通知图标) -> `@click="checkAuthAndNavigate('/pages/messages/messages')"`
    - `<view class="list-item active-scale">` (我的账单) -> `@click="checkAuthAndNavigate('/pages/profile/bills')"`
    - `<view class="list-item active-scale">` (官方客服) -> `@click="checkAuthAndNavigate('/pages/profile/support')"`
    - `<view class="list-item active-scale">` (关于我们) -> `@click="checkAuthAndNavigate('/pages/profile/about')"`
- `market-frontend/pages.json`:
  - 增加三条新路由信息。
- `market-frontend/pages/profile/bills.vue` 等:
  - 新建标准二级结构的基础静态页面。
