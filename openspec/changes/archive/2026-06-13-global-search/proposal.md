# 完善前端全局商品搜索体验

## 问题背景 (Problem Background)
当前系统首页 (`index.vue`) 和分类页 (`category-zone.vue`) 的顶部搜索框只是一个占位组件，缺少实际的点击响应和跳转逻辑。同时，消息页 (`messages.vue`) 中的搜索功能也未实现。为了提高用户的浏览效率和使用体验，需要对这几个主要页面的搜索功能进行完善。

## 目标 (Goals)
- 完善整个前端的商品和消息搜索体验。
- 支持在首页和分类页点击搜索框跳转至一个独立的全局商品搜索页面 (`pages/search/search.vue`)。
- 支持在消息页点击搜索按钮弹出输入框，并纯前端过滤当前的本地联系人和消息列表。

## 范围边界 (Scope Boundaries)
- 涉及页面：`pages/index/index.vue`, `pages/category-zone/category-zone.vue`, `pages/messages/messages.vue`。
- 新增页面：`pages/search/search.vue`。
- 本次变更仅涉及前端界面和交互逻辑的实现，假设相关的商品搜索和消息过滤为前端处理（无后端搜索 API 接入）。

## 非目标 (Non-goals)
- 本次变更暂不涉及后端搜索接口的开发或修改。
- 暂不涉及基于大语言模型的语义搜索或极其复杂的热门搜索推荐算法（可用 mock 数据）。

## 核心验收场景 (Acceptance Scenarios)
- **商品搜索**：用户在首页或分类页点击搜索框，页面跳转至 `pages/search/search.vue`；用户在独立搜索页输入关键词（如“iPhone”），展示匹配的相关商品卡片（可以使用现有的 mockProducts 过滤）。
- **消息搜索**：用户在消息页点击搜索图标，展示输入框；输入关键词（如“Anna”），消息列表实时过滤仅展示相关记录。
