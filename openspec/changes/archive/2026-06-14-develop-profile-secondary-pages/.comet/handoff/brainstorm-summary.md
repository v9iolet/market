# Brainstorm Summary

- Change: develop-profile-secondary-pages
- Date: 2026-06-14

## Confirmed Technical Approach

1. 统一拦截：在 `pages/profile/profile.vue` 中封装 `checkAuthAndNavigate(url)` 方法，通过判断 `isLoggedIn` 执行页面跳转或重定向拦截。
2. 登录回跳：在 `pages/login/login.vue` 中获取 `redirect` 并在登录成功后进行 `uni.navigateTo`。
3. 完善页面：新增并注册 `published.vue`, `sold.vue`, `bought.vue`, `favorites.vue`, `address.vue`。

## Key Trade-offs and Risks

- 若用户在登录页直接返回或取消登录，原本暂存的 `redirect` 需要清除或随页面销毁而自动失效（通常在页面状态中存储即可）。
- 如果 `redirect` 中的路径包含问号参数，在使用 `encodeURIComponent` 时需确保解析完整。

## Testing Strategy

- 针对未登录点击拦截、登录后自动跳转目标页面、已登录直接进入二级页面进行核心路径测试。

## Spec Patches

None
