# 任务清单 (Tasks)

- [x] 1. 迁移页面：创建目录 `pages/order`，将 `pages/messages/logistics.vue` 移动/重构至 `pages/order/logistics-detail.vue`。
- [x] 2. 路由更新：在 `pages.json` 中配置新的通用物流详情页 `/pages/order/logistics-detail` 和 新的物流消息列表页 `/pages/messages/logistics-notices`，同时移除旧的 `/pages/messages/logistics` 路由（如果存在）。
- [x] 3. 新建物流消息列表：实现 `pages/messages/logistics-notices.vue`，包含“我买到的”和“我卖出的”两个 Tab 切换，并渲染 mock 通知列表，列表项点击可跳转至 `logistics-detail` 页面。
- [x] 4. 修改入口：在 `pages/messages/messages.vue` 中，将“交易物流”的跳转路径更新为 `/pages/messages/logistics-notices`。
- [x] 5. 清理旧文件：删除不再使用的 `pages/messages/logistics.vue`。
<!-- review skipped: skill unavailable -->
