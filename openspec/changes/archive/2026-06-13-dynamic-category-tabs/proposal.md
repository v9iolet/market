# 动态子分类菜单配置 Proposal

## 1. 变更动机 (Motivation)
当前 `category-zone.vue` 页面中的子分类数据是硬编码的（只有手机、平板、电脑等），这会导致从主页点击“图书教材”、“美妆护肤”等分类时，子分类依然显示数码产品，与当前主分类完全不符。

## 2. 目标 (Goals)
根据当前进入的分类动态显示对应的子分类选项。例如：
- 图书教材：教材、小说、文学、考研
- 美妆护肤：水乳、彩妆、面膜、精华
- 潮鞋服饰：男装、女装、球鞋、配饰
- 运动户外：骑行、露营、健身、球类

## 3. 变更范围 (Scope)
- 仅修改 `market-frontend/pages/category-zone/category-zone.vue`。
- 新增一个分类映射表（Category Map），并在 `onLoad` 方法中根据页面传入的参数 `type` 动态更新 `subcategories` 的值。
