# Proposal: Fix Login Redirect and Icons

## Issue
1. Clicking login does not redirect to the logged-in profile page.
2. The third-party login icons are incorrect (currently material symbols like `chat` and `apple`) and need size adjustments.

## Root Cause
1. `uni.navigateBack()` is used for login redirection, which fails or stays on the same page if the login page is loaded without previous stack context or needs to switch to a tab page.
2. Wechat and QQ icons were missing, and the size wasn't properly matching standard designs.

## Fix Goal
1. Use `uni.reLaunch({ url: '/pages/profile/profile' })` in `handleAction`.
2. Update the third-party icons to Wechat and QQ using images.
3. Adjust the sizes of the icon items appropriately.
