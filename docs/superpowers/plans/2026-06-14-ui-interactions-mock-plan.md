---
change: ui-interactions-mock
design-doc: docs/superpowers/specs/2026-06-14-ui-interactions-mock-design.md
base-ref: d46dde76025cc018360f0088516150f7d03a6819
archived-with: 2026-06-14-ui-interactions-mock
---

# UI Interactions Mock Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

### Task 1: 完善首页通知跳转
**Files:**
- Modify: `market-frontend/pages/index/index.vue`

- [x] **Step 1:** 为右上角通知图标添加点击事件 `@click="goToMessages"`
- [x] **Step 2:** 实现 `goToMessages` 跳转到 `/pages/messages/messages`
- [x] **Step 3:** 提交代码 `feat: implement home page notification routing`

### Task 2: 完善商品详情页“想要”功能
**Files:**
- Modify: `market-frontend/pages/product/detail.vue` 或者对应的底部操作栏组件

- [x] **Step 1:** 在 `data` 中添加 `isFavorite` 和 `showFavoriteToast`
- [x] **Step 2:** 添加内联提示框的 DOM 和 CSS（局部绝对定位）
- [x] **Step 3:** 在“想要”按钮绑定点击事件，切换状态并控制提示框显示/隐藏
- [x] **Step 4:** 提交代码 `feat: implement favorite inline toast feedback`

### Task 3: 完善商品详情页“咨询”功能
**Files:**
- Modify: `market-frontend/pages/product/detail.vue` 或者对应的底部操作栏组件

- [x] **Step 1:** 在“咨询”按钮绑定跳转事件，跳转到 `/pages/messages/chat?id=mock&name=mock`
- [x] **Step 2:** 提交代码 `feat: implement consult chat routing`
