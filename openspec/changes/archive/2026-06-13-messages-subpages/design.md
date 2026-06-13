# Design Doc: 消息中心分类页与聊天详情页

## Architecture Decisions
- 创建四个独立的页面文件对应四种场景：
  - `pages/messages/logistics.vue`
  - `pages/messages/notices.vue`
  - `pages/messages/interactions.vue`
  - `pages/messages/chat.vue`
- 在 `messages.vue` 中配置路由导航（`uni.navigateTo`）跳转到这些页面。
- 数据流采用前端 Mock 数据，定义在组件内部的 `data` 或者独立的方法中。

## Approach Selection
聊天界面将采用典型的滚动列表加底部固定输入栏的布局，并配合 `scroll-into-view` 或页面滚动到底部的逻辑来实现新消息的展示。
