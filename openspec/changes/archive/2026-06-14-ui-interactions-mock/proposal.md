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
