# 搜索功能前端实现设计

## 架构决策 (Architecture Decisions)
- 针对商品搜索：采用独立搜索页模式 (`pages/search/search.vue`)。该模式可以更好地承载搜索历史、热门搜索等独立功能模块，并且让首页和分类页的顶部导航栏变得统一且易维护（仅作为入口）。
- 针对消息搜索：由于消息列表目前可能不会特别庞大且已有 mock 数据，在 `messages.vue` 内部引入本地状态过滤即可。不需要建立独立的搜索页面。

## 交互设计方案 (Interaction Design)
### 全局商品搜索
1. **入口修改**：修改 `index.vue` 和 `category-zone.vue` 顶部搜索框的点击事件，当聚焦或点击时，通过 `uni.navigateTo` 跳转至 `/pages/search/search.vue`。
2. **搜索页组件结构**：
   - 顶部：带返回按钮和真正输入框的 Header。
   - 搜索前状态：展示“历史搜索”或“热门推荐”（使用假数据）。
   - 搜索后状态：展示瀑布流商品列表（复用 `ProductCard` 组件）。基于输入的关键字对全局 mock 数据进行 `filter`。

### 消息列表过滤
1. **入口修改**：修改 `messages.vue` 顶部的 search icon，点击后将 Header 切换为包含输入框的搜索模式，或者在下方展开一个输入框。
2. **过滤机制**：使用 `computed` 属性 `filteredMessages`，根据 `searchQuery` 关键字对原始的消息数组 `mockMessages` 的 `chat-name` 和 `chat-preview` 字段进行匹配过滤。

## 数据流 (Data Flow)
- **商品数据**：为了在搜索页能搜索到所有商品，可考虑在单独的 utils 文件中集中存储 mock 数据或在搜索页本地构造一个稍大的 mock 数组进行演示。
- **消息数据**：提取 `messages.vue` 里的静态 HTML 结构为 `data` 中的数组结构，以便通过 `v-for` 渲染，并与 `searchQuery` 绑定实现响应式过滤。
