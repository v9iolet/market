# Comet Design Handoff

- Change: global-search
- Phase: design
- Mode: compact
- Context hash: e9cf238bbaf39887164fd4b24c79ade8ad4ef0752686764572f52e726a815167

Generated-by: comet-handoff.sh

OpenSpec remains the canonical capability spec. This handoff is a deterministic, source-traceable context pack, not an agent-authored summary.

## openspec/changes/global-search/proposal.md

- Source: openspec/changes/global-search/proposal.md
- Lines: 1-22
- SHA256: 499bacab7f60bee186edb156deb8e6aa3fb58e0b62113ceffcc4db360f224c04

```md
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
```

## openspec/changes/global-search/design.md

- Source: openspec/changes/global-search/design.md
- Lines: 1-21
- SHA256: 529d269e079a326f6b5ab9b4112a70eb491bb36120b5eeca43b1ec363e12cd7a

```md
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
```

## openspec/changes/global-search/tasks.md

- Source: openspec/changes/global-search/tasks.md
- Lines: 1-7
- SHA256: d0327265018292da2bced3f781bc490a4c4d08620fc7e5cdd048ac78faefa786

```md
- [ ] 1. 提取 `messages.vue` 中的静态聊天记录为 Vue data 数组，并通过 `v-for` 重构列表渲染。
- [ ] 2. 在 `messages.vue` 添加搜索框交互逻辑（点击 icon 展开输入框）及基于 `computed` 的列表过滤功能。
- [ ] 3. 新建 `pages/search/search.vue` 页面，实现顶部搜索栏、历史/热门搜索区域以及搜索结果瀑布流展示。
- [ ] 4. 在 `pages.json` 中注册 `/pages/search/search` 路由。
- [ ] 5. 修改 `pages/index/index.vue` 顶部搜索框交互，点击后跳转至 `search.vue`。
- [ ] 6. 修改 `pages/category-zone/category-zone.vue` 顶部搜索框交互，点击后跳转至 `search.vue`。
- [ ] 7. 进行界面的走查与验证搜索和过滤功能是否正确。
```

