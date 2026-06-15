# 首页和分类页分类同步 Tasks

## 任务列表
- [x] 将 `category-zone.vue` 中的 `categoryMap` 复制/导入到 `category.vue` 的 script 中。
- [x] 在 `category.vue` 的 `data` 中定义主分类数组 `categories` 并设置当前的 `activeIndex: 0`。
- [x] 修改 `category.vue` 的左侧栏，用 `v-for` 渲染 `categories`。
- [x] 修改 `category.vue` 的右侧内容区，基于当前选择的主分类和 `categoryMap`，用 `v-for` 渲染动态的子分类。
