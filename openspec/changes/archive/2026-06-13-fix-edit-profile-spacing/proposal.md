# Proposal: Fix Undefined Variable in Edit Profile Page

## Problem Description
Opening the edit profile page (`pages/profile/edit.vue`) causes a build error: `Undefined variable $spacing-stack-xl`.

## Root Cause Analysis
The page `market-frontend/pages/profile/edit.vue` uses the `$spacing-stack-xl` variable on line 185, but this variable is not defined in `market-frontend/uni.scss` or anywhere else in the styling.

## Fix Goal
Eliminate the build error by defining the missing spacing variable. We will define `$spacing-stack-xl: 80rpx;` in `uni.scss` to provide the necessary spacing for the main content without breaking existing layouts.
