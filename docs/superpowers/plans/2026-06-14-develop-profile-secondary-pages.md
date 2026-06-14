---
change: develop-profile-secondary-pages
design-doc: docs/superpowers/specs/2026-06-14-develop-profile-secondary-pages-design.md
base-ref: 4cc2bd9e1c0704ba86de69701edaf15723a92a97
---

# Implementation Plan: Profile Secondary Pages

## 1. Auth Interception Implementation
- **Modify `market-frontend/pages/profile/profile.vue`**
  - Add `checkAuthAndNavigate(url)` method in `methods`.
  - Check `this.isLoggedIn`.
  - If logged out, `uni.navigateTo({ url: '/pages/login/login?redirect=' + encodeURIComponent(url) })`.
  - Bind click events for "我发布的", "我卖出的", "我买到的", "收藏的", and "收货地址" to call `checkAuthAndNavigate` with the respective target URLs.

## 2. Login Redirect Logic
- **Modify `market-frontend/pages/login/login.vue`**
  - Add `redirectUrl` to `data`.
  - In `onLoad(options)`, if `options.redirect` exists, set `this.redirectUrl = decodeURIComponent(options.redirect)`.
  - In `loginSuccess` (or similar method handling successful login), check if `this.redirectUrl` exists.
  - If yes, use `uni.navigateTo({ url: this.redirectUrl })`.

## 3. Secondary Pages Creation
- **Create Vue Components**:
  - `market-frontend/pages/profile/published.vue`
  - `market-frontend/pages/profile/sold.vue`
  - `market-frontend/pages/profile/bought.vue`
  - `market-frontend/pages/profile/favorites.vue`
  - `market-frontend/pages/profile/address.vue`
  - Provide a basic structural layout for each with a top navigation bar (matching existing aesthetics).
- **Register in `market-frontend/pages.json`**:
  - Add the paths to the `pages` array, ensuring navigation styling is consistent.
