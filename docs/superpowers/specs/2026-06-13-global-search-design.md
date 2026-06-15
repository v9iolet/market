---
comet_change: global-search
role: technical-design
canonical_spec: openspec
archived-with: 2026-06-13-global-search
status: final
---

# 搜索功能前端技术设计

## 1. 架构方案

本次搜索功能完善分为两个部分，针对各自的业务特点采取不同的设计策略：
- **全局商品搜索**：由于首页 (`index.vue`) 和分类页 (`category-zone.vue`) 都需要搜索商品，将搜索功能抽象至一个独立的页面 (`pages/search/search.vue`) 是最易于维护和扩展的做法。这使得原始页面仅保留搜索入口，实际的逻辑（历史记录、输入、过滤显示）统一在搜索页实现。
- **消息过滤搜索**：消息列表页 (`messages.vue`) 具有状态较封闭、列表即数据的特征，无需通过全局路由承载，适合做页内的本地状态实时过滤。

## 2. 详细交互与数据流设计

### 2.1 全局商品搜索 (Global Product Search)

**入口改造**：
在 `pages/index/index.vue` 和 `pages/category-zone/category-zone.vue` 的搜索框绑定 `click` 事件（如果是 `<input>` 元素且无需输入，可替换为带 `readonly` 或利用覆盖一个透明层响应点击）。点击时触发 `uni.navigateTo({ url: '/pages/search/search' })`。

**独立搜索页 (`search.vue`) 结构**：
- **Header**：带返回按钮，右侧是获取焦点的 `<input>` 搜索框，带清空按钮。
- **结果区**：
  - 当 `searchQuery` 为空时，可展示静态的“热门搜索”或“搜索历史”（mock 标签即可）。
  - 当 `searchQuery` 有值时，调用 computed 属性 `filteredProducts` 动态过滤全局的 `mockProducts` 列表，使用已有的 `<ProductCard>` 瀑布流组件展示搜索结果。如果为空展示“暂无相关商品”。

### 2.2 消息本地过滤 (Local Message Filter)

**结构改造**：
1. **数据提取**：将 `messages.vue` 中的 HTML 静态消息块抽象为一个 `mockMessages` 数组，每个对象包含如 `id`, `name`, `avatar`, `time`, `preview`, `isOfficial` 等字段。
2. **交互切换**：点击顶部原有的 search icon，展开或切换显示一个文本 `<input>`。
3. **动态绑定**：
   ```javascript
   computed: {
       filteredMessages() {
           if (!this.searchQuery) return this.mockMessages;
           const lowerQuery = this.searchQuery.toLowerCase();
           return this.mockMessages.filter(msg => 
               msg.name.toLowerCase().includes(lowerQuery) || 
               msg.preview.toLowerCase().includes(lowerQuery)
           );
       }
   }
   ```
4. **渲染**：在 template 中对 `filteredMessages` 进行 `v-for` 循环渲染。

## 3. 测试策略

- **商品搜索入口测试**：分别在首页、分类页点击搜索框，验证页面能够无白屏跳转至 `search.vue` 并且光标自动对焦。
- **搜索页逻辑测试**：在搜索页输入关键字，验证是否实时过滤出了相匹配的商品（如输入 iPhone 出现对应卡片）。
- **消息页搜索测试**：开启搜索栏，输入现有消息的关键词，检查列表是否实时缩减；清空输入框，验证列表是否还原。

## 4. 边界情况处理
- 搜索不到结果时的兜底文案展示（商品页展示 EmptyState 或提示，消息页提示无匹配聊天）。
