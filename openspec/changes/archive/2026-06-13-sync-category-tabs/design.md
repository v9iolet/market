# 首页和分类页分类同步 Design

## 修复方案
1. 在 `category.vue` 的 `data` 中定义与 `index.vue` 一致的 `categories` 列表：
   `['手机数码', '潮鞋服饰', '图书教材', '运动户外', '美妆护肤', '文玩收藏', '乐器器械', '游戏装备', '办公文具']`
2. 在 `category.vue` 中添加与 `category-zone.vue` 相同的 `categoryMap`。
3. 修改 `category.vue` 的左侧 sidebar，使用 `v-for` 遍历 `categories` 生成列表，并提供 `@click="activeCategory = index"` 的交互逻辑。
4. 修改 `category.vue` 的右侧 main-content，使用 `categoryMap[categories[activeCategory]]` 动态遍历并渲染子分类网格。避免硬编码。
