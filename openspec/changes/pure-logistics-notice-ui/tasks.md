---
change: pure-logistics-notice-ui
design-doc: docs/superpowers/specs/2026-06-14-pure-logistics-notice-ui-design.md
base-ref: 20e84c73a7fd092584b0fc6627e21b415b976429
---
# Transaction Notice UI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Transform the logistics notices page into a Transaction Notice page where users can click on order statuses to go to the order detail page.

**Architecture:** We will create `TransactionNoticeCard.vue` and `transaction-notices.vue`, and update mock data and routing.

**Tech Stack:** Vue 2 Options API (for uni-app compatibility), SCSS.

---

### Task 1: Update mock data

**Files:**
- Modify: `market-frontend/utils/mockData.js`

- [x] **Step 1: Replace `logisticsNoticesDemoData` with `transactionNoticesDemoData`**
- [x] **Step 2: Commit mock data**

### Task 2: Create TransactionNoticeCard Component

**Files:**
- Delete: `market-frontend/components/LogisticsNoticeCard.vue`
- Create: `market-frontend/components/TransactionNoticeCard.vue`

- [x] **Step 1: Implement TransactionNoticeCard component**
- [x] **Step 2: Delete LogisticsNoticeCard**
- [x] **Step 3: Commit components**

### Task 3: Replace logistics-notices.vue with transaction-notices.vue

**Files:**
- Delete: `market-frontend/pages/messages/logistics-notices.vue`
- Create: `market-frontend/pages/messages/transaction-notices.vue`

- [x] **Step 1: Implement transaction-notices.vue**
- [x] **Step 2: Delete logistics-notices.vue**
- [x] **Step 3: Commit pages**

### Task 4: Update Routing and Navigation

**Files:**
- Modify: `market-frontend/pages.json`
- Modify: `market-frontend/pages/messages/messages.vue`

- [x] **Step 1: Update pages.json path**
- [x] **Step 2: Update messages.vue routing and title**
- [x] **Step 3: Commit routing**
