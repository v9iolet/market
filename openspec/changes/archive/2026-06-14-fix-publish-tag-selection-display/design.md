# Design: 自定义底部弹窗实现

## 修复方案
在 `TagSelectorPopup.vue` 中移除对 `<uni-popup>` 的依赖，手动使用原生的 `<view>` 标签和 CSS 动画来实现底部弹窗和半透明遮罩层。

1. **状态控制**：
   新增一个 `data` 属性 `visible` 控制弹窗的显示与隐藏，默认值为 `false`。

2. **视图结构修改**：
   - 最外层包裹一个遮罩层 `view.popup-mask`，并在其上绑定点击事件 `@click="close"`。
   - 内层包裹原本的内容 `view.popup-content`，通过绑定类名控制弹出动画。

3. **样式修改**：
   - `popup-mask`: 
     `position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.4); z-index: 999; visibility: hidden; opacity: 0; transition: all 0.3s;`
     当 `visible` 为 `true` 时，`visibility: visible; opacity: 1;`
   - `popup-wrapper`: 
     `position: fixed; bottom: 0; left: 0; right: 0; z-index: 1000; transform: translateY(100%); transition: transform 0.3s ease-out;`
     当 `visible` 为 `true` 时，`transform: translateY(0);`

4. **方法修改**：
   - `open()`: 设置 `this.visible = true`。
   - `close()`: 设置 `this.visible = false`。
