# Fix Membership Vue3 Syntax Error Design

## Solution
Modify `admin-frontend/src/views/market/membership/index.vue`:
1. Change `:showSearch.sync="showSearch"` to `v-model:showSearch="showSearch"`.
2. Change `<template slot-scope="scope">` to `<template #default="scope">`.
3. Change `:visible.sync="open"` to `v-model="open"`.
