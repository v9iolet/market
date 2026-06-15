# Proposal: Login/Register Page Hotfix

## Issue
The login/register page (`login.vue`) currently only has a login form and no registration form. 
The user requested to add a registration feature, restoring the Premium Exchange System (`stitch_ 4`) design 1:1.
Additionally, the login button needs to use the frontend project's green theme color.

## Root Cause
The `login.vue` page was implemented with only the login view and missed the registration switch functionality. 
The login button currently uses the default primary color instead of the requested green theme.

## Fix Goal
1. Add a tab or toggle to switch between Login and Register views on the `login.vue` page.
2. Ensure it mirrors the 1:1 `stitch_ 4` styling, providing a high-quality register UI.
3. Update the login/register button to use the frontend project's `$color-secondary` (the green theme).
