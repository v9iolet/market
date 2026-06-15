---
change: develop-profile-remaining-pages
design-doc: docs/superpowers/specs/2026-06-14-develop-profile-remaining-pages-design.md
base-ref: 13b81efc31c738e5201630d28a1e168f262769cb
archived-with: 2026-06-14-develop-profile-remaining-pages
---

# Implementation Plan: Profile Remaining Pages

- [x] 1. 结构与组件搭建: 在 `market-frontend/pages/profile/` 下创建 `about.vue`, `support.vue`, `bills.vue`。
- [x] 2. 路由配置: 在 `pages.json` 中配置上述 3 个新页面的路由。
- [x] 3. 事件绑定: 在 `profile.vue` 中找到对应元素并添加 `@click="checkAuthAndNavigate('...')"`。
