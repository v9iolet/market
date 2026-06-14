---
comet_change: develop-profile-secondary-pages
role: technical-design
canonical_spec: openspec
archived-with: 2026-06-14-develop-profile-secondary-pages
status: implemented
---

# Technical Design: Profile Secondary Pages & Auth Interception

## 1. Overview
This design implements secondary pages for the user profile section and establishes a unified interception mechanism for unauthenticated users, redirecting them to the login page before allowing access.

## 2. Architecture & Data Flow

### 2.1 Auth Interception (`pages/profile/profile.vue`)
- A method `checkAuthAndNavigate(url)` will be implemented.
- Elements such as "My Orders", "Favorites", and "Address" will trigger this method instead of static links.
- Flow:
  - If `isLoggedIn` is true: `uni.navigateTo({ url })`
  - If false: `uni.navigateTo({ url: '/pages/login/login?redirect=' + encodeURIComponent(url) })`

### 2.2 Login Redirect (`pages/login/login.vue`)
- Retrieve `redirect` in `onLoad(options)`.
- Store it in `this.redirectUrl`.
- On `loginSuccess`:
  - If `this.redirectUrl` exists, decode it and call `uni.navigateTo({ url: this.redirectUrl })`.
  - Else proceed with the default post-login behavior (e.g., `uni.navigateBack` or `uni.switchTab`).

### 2.3 Secondary Pages Structure
New Vue components will be created under `pages/profile/`:
- `published.vue`
- `sold.vue`
- `bought.vue`
- `favorites.vue`
- `address.vue`
Each will feature a top App Bar (using standard navigation) and basic layout, allowing future data integration. They must be registered in `pages.json`.

## 3. Risks & Mitigations
- **URL Encoding**: The `redirect` parameter must be correctly encoded to avoid cutting off parameters of the target URL. Use `encodeURIComponent`/`decodeURIComponent`.
- **Navigation Type**: If the `redirectUrl` is a tab bar page, `uni.switchTab` is required. Since our new pages are secondary pages, `uni.navigateTo` is sufficient.

## 4. Testing
- Verify click on "Address" when logged out -> redirects to `/pages/login/login?redirect=...`
- Verify successful login -> correctly jumps to `Address` page.
- Verify click on "Address" when logged in -> immediately jumps to `Address` page.
