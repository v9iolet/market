# 页面右侧展示不全问题修复 Design

## 1. 修复方案 (Fix Solution)

在 `checkout.vue` 的样式表中，通过通配符或者专门针对 `.checkout-page` 及其所有子元素添加 `box-sizing: border-box;` 样式，以确保 padding 被包含在指定的宽度之中，避免撑破容器。

为了确保不影响全局或者为了局部安全起见，我们将直接在 `checkout.vue` 的 `<style scoped>` 顶部添加：

```scss
* {
    box-sizing: border-box;
}
```
或者针对当前页面的根元素及所有子元素应用：
```scss
.checkout-page, .checkout-page * {
    box-sizing: border-box;
}
```

考虑到它是一个 scoped style，使用 `*` 或是特定类名都是安全的，我们选择在 `<style scoped>` 的最开头添加 `box-sizing: border-box;` 声明：
```scss
view, scroll-view, text, image {
    box-sizing: border-box;
}
```

综合考理解 uni-app 机制，最稳妥的修复是在 `<style lang="scss" scoped>` 下使用 `view, scroll-view, text, image` 等基础组件选择器或者 `*` 应用 `box-sizing: border-box;`。我们将直接在样式表最前面加上：

```scss
view, scroll-view, text, image, label {
    box-sizing: border-box;
}
```
这样可以完美覆盖组件内的元素，并解决因为 padding 导致的宽度溢出问题。
