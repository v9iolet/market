# 首页和分类页分类同步 (Hotfix Proposal)

## 1. 问题描述
`category.vue`（总分类页）的左侧主分类列表与 `index.vue`（首页）不一致，导致用户体验割裂。并且 `category.vue` 中的子分类目前也是硬编码的，没有和首页的分类逻辑对应。

## 2. 根本原因 (Root Cause)
`category.vue` 的模板和数据是静态硬编码的，没有提取共享配置或保持与首页（及分类详情页 `category-zone.vue`）一致的数据结构。

## 3. 修复目标 (Fix Goal)
将 `category.vue` 的主分类列表完全对齐 `index.vue` 的主分类。同时，在 `category.vue` 中引入类似于 `category-zone.vue` 的子分类映射逻辑，使得点击左侧主分类时，右侧能动态渲染属于该分类的子分类（以首页的分类结构为主）。
