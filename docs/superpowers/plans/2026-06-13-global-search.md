---
change: global-search
design-doc: docs/superpowers/specs/2026-06-13-global-search-design.md
base-ref: 70e3d56bf5064b19c7ddda1cb64ddafef8671f66
---

# 全局搜索与消息搜索前端实现计划

## 1. 提取消息列表并重构 `messages.vue` 结构
-[x] 将 `pages/messages/messages.vue` 中的静态聊天记录节点转换为 `data` 中的 `mockMessages` 数组，每个元素包含 id, name, avatar/icon, time, preview, isOfficial 等字段。
-[x] 将 HTML 结构改为使用 `v-for="msg in filteredMessages"` 进行渲染。

## 2. 在 `messages.vue` 实现搜索过滤
-[x] 顶部导航栏替换现有的搜索按钮为搜索输入框（点击图标后展开 `input` 并自动聚焦，或者直接在下方增加搜索栏）。
-[x] 绑定 `v-model="searchQuery"`。
-[x] 添加 computed 属性 `filteredMessages`，如果 `searchQuery` 为空则返回全部，否则通过过滤 `name` 和 `preview` 中包含关键字的项返回。

## 3. 创建独立商品搜索页 `search.vue`
-[x] 在 `market-frontend/pages/search/` 目录下创建 `search.vue`。
-[x] 实现顶部的带返回按钮和搜索输入框的 Header，绑定 `v-model="searchQuery"` 并在 `@confirm` 或 `@input` 时执行搜索逻辑。
-[x] 引入并使用已有的 `ProductCard` 组件。
-[x] 准备一组 `mockProducts` 数组用于搜索。使用 computed 属性 `filteredProducts` 动态匹配商品 title。
-[x] 在 `pages.json` 中配置该页面的路由 `/pages/search/search`。

## 4. 修改现有页面的搜索入口
-[x] 修改 `pages/index/index.vue` 顶部的搜索框 `<input>`，改为绑定点击事件或 focus 事件跳转到 `/pages/search/search`。
-[x] 修改 `pages/category-zone/category-zone.vue` 顶部的搜索按钮（原先是只有 icon），添加点击事件跳转到 `/pages/search/search`。

## 5. 走查与测试
-[x] 启动前端应用，测试各页面的跳转是否正常。
-[x] 验证商品搜索页面中输入不同关键字是否能过滤结果。
-[x] 验证消息页面搜索功能，输入不同关键字能否实时过滤聊天列表。
