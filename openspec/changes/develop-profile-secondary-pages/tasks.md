# Tasks

- [x] 1. 在 `pages.json` 中配置并初始化核心二级页面：`published`（我发布的）、`sold`（我卖出的）、`bought`（我买到的）、`favorites`（收藏的）、`address`（收货地址）。
- [x] 2. 在 `profile.vue` 中封装统一的拦截跳转方法 `checkAuthAndNavigate(targetUrl)`。
- [x] 3. 修改 `profile.vue`，为“我的交易”模块和“收货地址”等入口绑定点击事件，调用统一的拦截跳转方法。
- [x] 4. 修改 `login.vue`：在 `onLoad` 获取 `redirect` 参数，并在登录成功后优先执行重定向跳转。
- [x] 5. 完善 `address` (收货地址) 静态页面及交互。
- [x] 6. 完善 `published`, `sold`, `bought`, `favorites` 等核心交易二级页面的基本结构或 Mock 数据展示。
