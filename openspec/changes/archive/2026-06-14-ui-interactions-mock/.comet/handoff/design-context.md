# Comet Design Handoff

- Change: ui-interactions-mock
- Phase: design
- Mode: compact
- Context hash: e5bdca1db537fdecf2f675a67c621d98dd58ea3a0e320a95d262f9aa5ab005ef

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/ui-interactions-mock/proposal.md

- Source: openspec/changes/ui-interactions-mock/proposal.md
- Lines: 1-47
- SHA256: a7234274578cbf1f2649936107008c8589f65fe8b2d117c3c9b595b738f0e879

```md
---
name: ui-interactions-mock
title: UI Interactions Mock (通知路由与收藏交互)
status: draft
---

# UI Interactions Mock

## Why

目前首页右上角通知图标路由跳转未完善，商品详情页的收藏和咨询功能的交互反馈需要建立连接。为了提升用户体验并模拟真实流程，需要打通这些核心基础链路并在前端予以临时模拟反馈。

## What Changes

1. **首页通知路由**：完善首页右上角通知图标的路由，点击后跳转至消息中心。
2. **收藏交互**：完善商品详情页的“想要/收藏”按钮交互，点击后在底部功能栏的上方出现一行“已添加至收藏”的文本提示（非系统 Toast），以模拟状态切换。
3. **咨询路由**：完善商品详情页的“咨询”按钮，点击后带上必要参数跳转至通知相关的聊天二级页面。

以上均不涉及真实的后端接口联调与数据持久化，仅在前端进行状态模拟和交互反馈。

## Scope

- **In Scope**:
  - `market-frontend/pages/index/index.vue`（或对应包含通知图标的首页组件）。
  - `market-frontend/pages/product/detail.vue`（或对应商品详情页的底部操作栏组件）。
  - 相关的路由配置及点击事件绑定。
- **Out of Scope**:
  - 真实的后端 API 接口对接和数据持久化。
  - 完整的聊天功能或即时通讯 SDK 接入（仅需完成页面跳转即可）。
  - 系统原生居中 Toast 提示（用户指定使用局部内联提示）。

## Acceptance Criteria

1. **SCENARIO 1**: 点击首页通知图标
   - **GIVEN** 用户处于首页
   - **WHEN** 用户点击右上角铃铛/通知图标
   - **THEN** 页面应正确跳转进入消息页（`/pages/messages/messages`）

2. **SCENARIO 2**: 点击“想要”
   - **GIVEN** 用户处于商品详情页
   - **WHEN** 用户点击底部操作栏的“想要”按钮
   - **THEN** 按钮的显示状态（图标颜色/文字）切换，并在底部功能栏正上方滑出或显示一行“已添加至收藏”的文字提示。

3. **SCENARIO 3**: 点击“咨询”
   - **GIVEN** 用户处于商品详情页
   - **WHEN** 用户点击底部操作栏的“咨询”按钮
   - **THEN** 页面跳转至聊天对话框页面（如 `/pages/messages/chat`），并能通过 URL 参数传递基本的卖家/商品信息以便于 mock。
```

## openspec/changes/ui-interactions-mock/design.md

- Source: openspec/changes/ui-interactions-mock/design.md
- Lines: 1-30
- SHA256: 73c0c66fa0d4f60b3bd4499284447847d35ad1795dd702750c5efe0ef8965e75

```md
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
```

## openspec/changes/ui-interactions-mock/tasks.md

- Source: openspec/changes/ui-interactions-mock/tasks.md
- Lines: 1-5
- SHA256: 5eca215dcaf181c8c3dabf482f1c4897a473132d24cf497ed39847ef095c212e

```md
# Tasks: UI Interactions Mock

- [ ] Task 1: 完善首页通知跳转。为首页右上角通知图标添加点击事件，跳转至消息页。
- [ ] Task 2: 完善商品详情页“想要”功能。在商品详情页底部状态栏上方添加“已添加至收藏”局部文字提示组件，实现状态切换和两秒后自动隐藏。
- [ ] Task 3: 完善商品详情页“咨询”功能。为“咨询”按钮添加点击事件，携带 mock 参数跳转至聊天页。
```

