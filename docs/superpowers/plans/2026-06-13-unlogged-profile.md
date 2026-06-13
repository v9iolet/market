---
change: unlogged-profile
design-doc: docs/superpowers/specs/2026-06-13-unlogged-profile-design.md
base-ref: 84f005235999b0eebe20564171fe8d9104f4eb61
archived-with: unlogged-profile
---

# 个人主页与登录流程前端架构 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** 基于 stitch_ 3 和 stitch_ 4 实现未登录状态的主页与登录注册页，构建基于本地 Storage 的纯前端登录状态闭环 Demo。

**Architecture:** 使用 uni-app 的 `v-if` 在 `profile.vue` 根据 Storage 中的 `isLoggedIn` 状态按需渲染。点击跳转到独立的 `login.vue` 并在点击登录时存入缓存后返回，实现跨页面组件通信。

**Tech Stack:** uni-app, Vue 3, SCSS

---

## User Review Required

是否确认使用本地 Storage `isLoggedIn` 作为整个前端 Demo 的流转核心逻辑？由于当前仅需要展示前端能力而不进行后端校验，此方案最为轻量直接。

## 任务拆解与执行步骤

### Task 1: 引入样式 Token

**Files:**
- Modify: `/Users/violet/Documents/gemini-work/market/market-frontend/uni.scss`

- [x] **Step 1: 确认全局设计变量**
在 `uni.scss` 中检查并确保 `$color-surface-container`、`$spacing-stack-md` 等设计 Token 齐备，由于该文件已经包含 `Custom Design Tokens`，我们在此步骤确认即可或进行微调补充。

### Task 2: 创建并配置登录页路由

**Files:**
- Create: `/Users/violet/Documents/gemini-work/market/market-frontend/pages/login/login.vue`
- Modify: `/Users/violet/Documents/gemini-work/market/market-frontend/pages.json`

- [x] **Step 1: 新建基础空页面**
创建 `login.vue`，初始化基础的 `<template>` 和 `<script setup>` 骨架。

- [x] **Step 2: 配置页面路由**
在 `pages.json` 中的 `pages` 数组里增加如下配置：
```json
{
  "path": "pages/login/login",
  "style": {
    "navigationStyle": "custom"
  }
}
```

### Task 3: 实现 Profile 页面的状态结构与退出按钮

**Files:**
- Modify: `/Users/violet/Documents/gemini-work/market/market-frontend/pages/profile/profile.vue`

- [x] **Step 1: 编写 `<script setup>` 状态逻辑**
利用 `@dcloudio/uni-app` 提供的 `onShow` 生命周期，每次进入页面时读取 `uni.getStorageSync('isLoggedIn')`，并赋值给响应式引用 `isLoggedIn`。
- [x] **Step 2: 编写退出功能**
编写 `handleLogout` 函数，调用 `uni.removeStorageSync('isLoggedIn')` 并将 `isLoggedIn.value` 置为 `false`。
- [x] **Step 3: 编写视图切换骨架**
在 `<template>` 中使用 `v-if="!isLoggedIn"` 预留未登录区域；`v-else` 内预留已登录骨架区域，并在页面底部添加“退出当前账号”按钮并绑定 `@click="handleLogout"`。

### Task 4: 1:1 还原 Profile 未登录视图 (stitch_ 3)

**Files:**
- Modify: `/Users/violet/Documents/gemini-work/market/market-frontend/pages/profile/profile.vue`

- [x] **Step 1: 编写静态 UI**
在 `v-if="!isLoggedIn"` 区域内，根据 `stitch_ 3` 设计图，编写头部空白头像占位图、未登录提示文字。
- [x] **Step 2: 绑定跳转事件**
在空白头像外层容器上绑定 `click` 事件，调用 `uni.navigateTo({ url: '/pages/login/login' })`。
- [x] **Step 3: 编写对应的样式**
在 `<style lang="scss">` 中使用全局 `uni.scss` 引入的 `$spacing-stack-md` 等间距与颜色变量，完美复刻 UI 的圆角和留白间距。

### Task 5: 1:1 还原 Login 登录视图 (stitch_ 4) 并绑定登录逻辑

**Files:**
- Modify: `/Users/violet/Documents/gemini-work/market/market-frontend/pages/login/login.vue`

- [x] **Step 1: 编写登录静态 UI**
根据 `stitch_ 4` 规范，实现头部返回按钮、大标题、表单输入框、"Login" 主操作按钮、及其他第三方登录占位图标。
- [x] **Step 2: 编写样式**
完全参考 Premium Exchange System 标准，完善圆角与边框焦点交互样式。
- [x] **Step 3: 绑定前端 Demo 登录事件**
在 "Login" 按钮的 click 事件中，执行 `uni.setStorageSync('isLoggedIn', true)`，随后执行 `uni.navigateBack({ delta: 1 })` 无缝返回主页。

## Verification Plan

### Manual Verification
1. 启动微信开发者工具或浏览器预览。
2. 进入 `pages/profile/profile`。初始状态未登录，应能看到空白头像。
3. 点击头像，触发跳转到达 `pages/login/login`。
4. 在登录页面体验 UI 复原度，点击“登录”按钮。
5. 自动返回主页后，由于 `onShow` 刷新，页面应直接呈现出已登录状态的页面骨架，并在底部带有“退出当前账号”的按钮。
6. 点击该退出按钮，应瞬间切回未登录状态视图。
