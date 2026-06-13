# 动态子分类菜单配置 Tasks

## 任务列表
- [x] 在 `category-zone.vue` 的 `<script>` 中添加各个主分类与其对应子分类数据的映射表（`categoryMap`）。
- [x] 修改 `onLoad` 方法，根据传入的 `type` 从映射表中获取子分类数据并赋值给 `subcategories`；若未找到，则设置一个默认后备分类。
