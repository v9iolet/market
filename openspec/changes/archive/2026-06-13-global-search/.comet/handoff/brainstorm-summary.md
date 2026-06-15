# Brainstorm Summary

- Change: global-search
- Date: 2026-06-13

## Confirmed Technical Approach

1. **商品搜索**：在首页 (`index.vue`) 和分类页 (`category-zone.vue`) 的顶部搜索框添加点击交互，跳转至独立的 `pages/search/search.vue` 页面进行搜索。
2. **消息搜索**：在 `messages.vue` 提取静态 HTML 的消息记录至 Vue `data()` 数组，并绑定顶部搜索框输入的关键字，利用 `computed` 属性实现前端按姓名和聊天预览内容的本地过滤。

## Key Trade-offs and Risks

- 采用纯前端假数据过滤，未接入真实后端搜索接口，仅作功能流程演示和前端组件完善。
- 独立搜索页需要复用 `ProductCard` 组件，注意确保数据格式兼容。

## Testing Strategy

- 页面内组件点击的路由跳转测试。
- 搜索页功能测试（输入关键字是否能正确通过 filter 返回 mock 数据的对应结果）。
- 消息页无刷新、即时输入响应过滤测试。

## Spec Patches

None
