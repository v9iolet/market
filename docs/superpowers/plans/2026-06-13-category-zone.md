---
archived-with: category-zone

change: category-zone
design-doc: docs/superpowers/specs/2026-06-13-category-zone-design.md
base-ref: 186b45f0339b61899bd31bb0a4fe3b8ef2f186a1
---

# Category Zone Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the independent `category-zone` product list page and extract reusable components.

**Architecture:** Create reusable `ProductCard.vue` and `EmptyState.vue` components. Update `pages/index/index.vue` to use `ProductCard`. Build `pages/category-zone/category-zone.vue` combining custom navigation, horizontal tabs, filter bar, and the waterfall product grid.

**Tech Stack:** uni-app (Vue 2/3), SCSS.

---

### Task 1: Extract `ProductCard.vue`

**Files:**
- Create: `market-frontend/components/ProductCard/ProductCard.vue`
- Modify: `market-frontend/pages/index/index.vue`

- [ ] **Step 1: Create `ProductCard.vue` component**
- [x] **Step 1: Create `ProductCard.vue` component**
  Move the `.product-card` template and styles from `index.vue` to the new component. Add a `product` prop.

- [x] **Step 2: Update `index.vue` to use `ProductCard`**
  Import the component in `index.vue` and replace the hardcoded `.product-card` blocks with `<ProductCard :product="item" v-for="..." />`.
  *(Provide mock product array in data if not already present).*

- [x] **Step 3: Commit**
  Commit message: `refactor: extract ProductCard component for reuse`

### Task 2: Create `EmptyState.vue` component

**Files:**
- Create: `market-frontend/components/EmptyState/EmptyState.vue`

- [x] **Step 1: Create the empty state template and styles**
  Create an icon and text message layout (e.g., "暂无相关商品").

- [x] **Step 2: Commit**
  Commit message: `feat: add EmptyState component`

### Task 3: Create `category-zone` routing and scaffold

**Files:**
- Modify: `market-frontend/pages.json`
- Create: `market-frontend/pages/category-zone/category-zone.vue`

- [x] **Step 1: Add route to `pages.json`**
  Register `pages/category-zone/category-zone` with `"navigationStyle": "custom"`.

- [x] **Step 2: Scaffold `category-zone.vue`**
  Create basic `<template>`, `<script>`, `<style lang="scss" scoped>` blocks.

- [x] **Step 3: Commit**
  Commit message: `feat: scaffold category-zone page and route`

### Task 4: Implement `category-zone` UI Elements

**Files:**
- Modify: `market-frontend/pages/category-zone/category-zone.vue`

- [x] **Step 1: Add Top Navigation**
  Implement `.header.glass-effect` with back button, dynamic title, and search icon.

- [x] **Step 2: Add Subcategory Tabs and Filter Bar**
  Add a horizontally scrollable list of tabs and a sticky filter bar underneath.

- [x] **Step 3: Commit**
  Commit message: `feat: add navigation and filters to category-zone`

### Task 5: Integrate Waterfall Grid and Mock Logic

**Files:**
- Modify: `market-frontend/pages/category-zone/category-zone.vue`

- [x] **Step 1: Integrate `ProductCard` and `EmptyState`**
  Import both components. Map through a `mockProducts` array in data to render cards, or render `EmptyState` if array is empty.

- [x] **Step 2: Commit**
  Commit message: `feat: integrate waterfall grid and empty state`

### Task 6: Connect Home Page Navigation

**Files:**
- Modify: `market-frontend/pages/index/index.vue`

- [x] **Step 1: Add `@click` navigation to Category Grid**
  In the `category-section` grid items, add `@click="goToCategory(item.name)"` to `uni.navigateTo({ url: '/pages/category-zone/category-zone?type=' + name })`.

- [x] **Step 2: Commit**
  Commit message: `feat: link home page category grid to category-zone`
