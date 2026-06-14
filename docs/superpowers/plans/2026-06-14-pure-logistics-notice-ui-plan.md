---
change: pure-logistics-notice-ui
design-doc: docs/superpowers/specs/2026-06-14-pure-logistics-notice-ui-design.md
base-ref: 20e84c73a7fd092584b0fc6627e21b415b976429
---
# Pure Logistics Notice UI Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** Transform the logistics notices page into a pure, timeline-based logistics notification stream (like Taobao/Xianyu logistics assistant) with a new dedicated component.

**Architecture:** We will create `LogisticsNoticeCard.vue` to show individual logistics notifications with a product image and status text. `logistics-notices.vue` will render a list of these cards using newly added mock data.

**Tech Stack:** Vue 2 Options API (for uni-app compatibility), SCSS.

---

### Task 1: Create mock data

**Files:**
- Modify: `market-frontend/utils/mockData.js`

- [x] **Step 1: Add `logisticsNoticesDemoData` to `mockData.js`**

```javascript
export const logisticsNoticesDemoData = [
  {
    id: 'n1',
    statusTitle: '包裹派送中',
    time: '2026-06-14 10:30',
    productImg: '/static/products/laptop.jpg',
    expressCompany: '顺丰速运',
    trackingNo: 'SF1234567890',
    latestDesc: '顺丰速运：您的快件已到达【深圳市】'
  },
  {
    id: 'n2',
    statusTitle: '您的包裹已发货',
    time: '2026-06-13 14:20',
    productImg: '/static/products/phone.jpg',
    expressCompany: '中通快递',
    trackingNo: 'ZT0987654321',
    latestDesc: '中通快递：您的快件已由【杭州集散中心】发出'
  }
];
```

- [x] **Step 2: Export `logisticsNoticesDemoData` in `mockData.js`**

```javascript
module.exports = {
  // ... existing exports
  logisticsNoticesDemoData,
};
```

- [x] **Step 3: Commit**

```bash
git add market-frontend/utils/mockData.js
git commit -m "feat: add logistics notices mock data"
```

### Task 2: Create LogisticsNoticeCard Component

**Files:**
- Create: `market-frontend/components/LogisticsNoticeCard.vue`

- [x] **Step 1: Create component template and script**

```vue
<template>
  <view class="notice-card" @click="handleCardClick">
    <view class="card-header">
      <text class="status-title">{{ notice.statusTitle }}</text>
      <text class="time-text">{{ notice.time }}</text>
    </view>
    <view class="card-content">
      <image class="product-img" :src="notice.productImg" mode="aspectFill"></image>
      <view class="logistics-info">
        <text class="express-info">{{ notice.expressCompany }} {{ notice.trackingNo }}</text>
        <text class="latest-desc">{{ notice.latestDesc }}</text>
      </view>
    </view>
  </view>
</template>

<script>
export default {
  name: 'LogisticsNoticeCard',
  props: {
    notice: {
      type: Object,
      required: true
    }
  },
  methods: {
    handleCardClick() {
      uni.navigateTo({
        url: `/pages/order/logistics-detail?id=${this.notice.id}`
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.notice-card {
  background-color: #ffffff;
  border-radius: 12px;
  padding: 16px;
  margin-bottom: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;

    .status-title {
      font-size: 16px;
      font-weight: 600;
      color: #333;
    }

    .time-text {
      font-size: 12px;
      color: #999;
    }
  }

  .card-content {
    display: flex;
    align-items: center;

    .product-img {
      width: 48px;
      height: 48px;
      border-radius: 6px;
      margin-right: 12px;
      flex-shrink: 0;
      background-color: #f5f5f5;
    }

    .logistics-info {
      flex: 1;
      display: flex;
      flex-direction: column;

      .express-info {
        font-size: 12px;
        color: #666;
        margin-bottom: 4px;
      }

      .latest-desc {
        font-size: 14px;
        color: #333;
        line-height: 1.4;
      }
    }
  }
}
</style>
```

- [x] **Step 2: Commit**

```bash
git add market-frontend/components/LogisticsNoticeCard.vue
git commit -m "feat: create LogisticsNoticeCard component"
```

### Task 3: Refactor logistics-notices.vue

**Files:**
- Modify: `market-frontend/pages/messages/logistics-notices.vue`

- [x] **Step 1: Replace entire file content to use new layout and component**

```vue
<template>
  <view class="container">
    <scroll-view scroll-y class="scroll-area">
      <view class="notice-list">
        <LogisticsNoticeCard 
          v-for="item in notices" 
          :key="item.id" 
          :notice="item" 
        />
      </view>
    </scroll-view>
  </view>
</template>

<script>
import LogisticsNoticeCard from '@/components/LogisticsNoticeCard.vue';
import { logisticsNoticesDemoData } from '@/utils/mockData.js';

export default {
  components: {
    LogisticsNoticeCard
  },
  data() {
    return {
      notices: []
    }
  },
  onLoad() {
    this.notices = logisticsNoticesDemoData;
  }
}
</script>

<style lang="scss" scoped>
.container {
  min-height: 100vh;
  background-color: #f5f5f5;
  display: flex;
  flex-direction: column;
}

.scroll-area {
  flex: 1;
}

.notice-list {
  padding: 16px;
}
</style>
```

- [x] **Step 2: Commit**

```bash
git add market-frontend/pages/messages/logistics-notices.vue
git commit -m "refactor: convert logistics-notices to pure notice stream"
```
