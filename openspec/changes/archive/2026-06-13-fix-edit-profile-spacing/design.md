# Design: Fix Undefined Variable in Edit Profile Page

## Fix Solution
We will add the missing spacing token `$spacing-stack-xl` to the Custom Design Tokens section in `market-frontend/uni.scss`.

**Changes:**
1. In `market-frontend/uni.scss`, locate the `Spacing (1px = 2rpx)` section.
2. Add `$spacing-stack-xl: 80rpx;` below `$spacing-stack-lg`.

This will allow the existing CSS in `pages/profile/edit.vue` to resolve the variable correctly and fix the page load issue.
