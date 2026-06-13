# Brainstorm Summary

- Change: messages-subpages
- Date: 2026-06-13

## Confirmed Technical Approach
- 页面组件化：在 `pages/messages/` 目录下新增四张页面（logistics.vue, notices.vue, interactions.vue, chat.vue），并在 messages.vue 增加跳转逻辑。
- 差异化布局：物流页采用时间轴 UI，互动消息采用右侧展示封面缩略图的 UI。
- 聊天详情页：采用带快捷回复组件的底部输入栏。纯前端 Mock 数据交互。

## Key Trade-offs and Risks
- 无真实后端，仅限前端 UI 开发及 Mock 数据填充。
- 底部输入栏可能与某些设备的底部安全区发生重叠，需要利用安全区环境变量处理内边距。

## Testing Strategy
- 在首页点击四种消息入口测试跳转逻辑。
- 在 chat.vue 中发送文字和使用快捷回复，测试能否成功追加数据并滚动到底部。

## Spec Patches
- None
