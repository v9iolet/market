# 动态子分类菜单配置 Design

## 实现方案
在 `category-zone.vue` 中定义一个完整的 `categoryMap`，将各个主分类映射到对应的子分类列表（含名称和 material 图标）。
在页面的 `onLoad(options)` 生命周期钩子中，根据 `options.type` 获取对应的子分类数组，并赋值给页面的 `subcategories` 数据属性。如果没有匹配到特定分类，则可以提供一个默认的子分类列表或者仅保留“全部”标签。

映射表结构示例：
```javascript
const categoryMap = {
    '手机数码': [
        { name: '全部', icon: 'apps' },
        { name: '手机', icon: 'smartphone' },
        { name: '平板', icon: 'tablet_mac' },
        { name: '电脑', icon: 'laptop_mac' },
        { name: '耳机', icon: 'headphones' },
        { name: '相机', icon: 'photo_camera' }
    ],
    '图书教材': [
        { name: '全部', icon: 'apps' },
        { name: '教材', icon: 'book' },
        { name: '小说', icon: 'auto_stories' },
        { name: '文学', icon: 'history_edu' },
        { name: '考研', icon: 'school' }
    ],
    '美妆护肤': [
        { name: '全部', icon: 'apps' },
        { name: '水乳', icon: 'water_drop' },
        { name: '彩妆', icon: 'face_retouching_natural' },
        { name: '面膜', icon: 'masks' },
        { name: '精华', icon: 'science' }
    ],
    '潮鞋服饰': [
        { name: '全部', icon: 'apps' },
        { name: '男装', icon: 'man' },
        { name: '女装', icon: 'woman' },
        { name: '球鞋', icon: 'snowshoeing' },
        { name: '配饰', icon: 'watch' }
    ],
    '运动户外': [
        { name: '全部', icon: 'apps' },
        { name: '骑行', icon: 'pedal_bike' },
        { name: '露营', icon: 'camping' },
        { name: '健身', icon: 'fitness_center' },
        { name: '球类', icon: 'sports_basketball' }
    ]
};
```
如果传入的分类不在上述映射表内（如“文玩收藏”、“乐器器械”等），可默认展示通用的“全部”以及一些普适的分类项。
