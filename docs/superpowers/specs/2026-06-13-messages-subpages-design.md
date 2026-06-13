---
comet_change: messages-subpages
role: technical-design
canonical_spec: openspec
archived-with: 2026-06-13-messages-subpages
status: final
---

# 消息中心二级页面开发 (Messages Subpages)

## Overview
本项目旨在完成 `messages.vue` 附属的四个二级页面的前端开发，包括交易物流、通知消息、互动消息以及聊天详情页。所有数据交互目前均采用纯前端 Mock。

## 1. 差异化布局设计 (Differentiated Layouts)
针对不同类型的通知消息，我们采用具有针对性的 UI 设计以提升体验：
- **交易物流 (logistics.vue)**: 采用左侧带状态原点连线的**时间轴**（Timeline）设计，方便用户追踪订单流转状态。
- **互动消息 (interactions.vue)**: 采用横向图文卡片结构，左侧展示互动者头像，文字说明互动类型，右侧附加互动的**帖子/商品缩略图**。
- **通知消息 (notices.vue)**: 采用统一的系统通知卡片样式。

## 2. 聊天详情页设计 (chat.vue)
- 页面主体为消息气泡列表。对方气泡在左侧（白色背景），我方气泡在右侧（主色背景）。
- 底部输入栏除了基础的输入框和表情扩展按钮，还需在上方额外添加一个**可横向滑动的快捷回复组件**（Quick Replies），包含二手交易常用语（如“你好，这件还在吗？”、“能包邮吗？”等）。
- 数据流：通过本地 `data` 维护消息数组，在发送后 push 新消息，并通过 `$nextTick` 结合 `scroll-into-view` 滚动到列表底部。

## 3. 技术栈与边界约束
- **框架**: uniapp + Vue 2/3 (具体根据项目而定)
- **CSS**: Scss 编写，利用安全区变量 `env(safe-area-inset-bottom)` 处理底部重叠。
- **路由**: 在 `pages.json` 中注册新页面，并从 `messages.vue` 进行 `uni.navigateTo` 跳转。
- **后端联调**: 本阶段不包含，所有接口均为本地静态数据。

## 4. 测试策略
1. **跳转验证**: 在消息主页点击各项能够顺利路由至对应页面。
2. **输入交互验证**: 聊天页内的快捷回复点击后必须追加一条新消息；输入框聚焦时键盘不能遮挡消息流。
