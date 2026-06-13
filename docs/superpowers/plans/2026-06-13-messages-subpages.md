---
change: messages-subpages
design-doc: docs/superpowers/specs/2026-06-13-messages-subpages-design.md
base-ref: 943ac4efc49c2cb341cf986bbd732f36632b0ab4
---

# Messages Subpages Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 实现 `messages.vue` 相关的四个二级功能页面（交易物流、通知、互动、聊天）及其前端 Mock 数据展示与跳转逻辑。

**Architecture:** 创建 4 个新的独立 `.vue` 组件文件，配置对应的路由，并在 `messages.vue` 增加 `uni.navigateTo` 导航方法。

**Tech Stack:** uniapp, Vue, SCSS

## User Review Required
该计划将直接修改 `pages.json` 注册路由，并在 `pages/messages/` 目录下新增四个二级页面。页面将完全使用前端模拟数据（Mock Data）并实现独立的交互组件（比如聊天页的快捷回复滚动列表和安全区适配）。请确认这些变更细节。

---

### Task 1: 创建物流页面 (Logistics)

**Files:**
- Create: `market-frontend/pages/messages/logistics.vue`
- Modify: `market-frontend/pages.json`

- [x] **Step 1: Write logistics UI component with timeline layout**

```vue
<template>
  <view class="logistics-page">
    <view class="header glass-effect">
      <view class="back-btn active-scale" @click="goBack">
        <text class="material-symbols-outlined">arrow_back</text>
      </view>
      <text class="title">交易物流</text>
    </view>
    <scroll-view scroll-y class="main-content">
      <view class="timeline">
        <view class="timeline-item" v-for="(item, index) in logistics" :key="index">
          <view class="line-container">
            <view class="dot"></view>
            <view class="line" v-if="index !== logistics.length - 1"></view>
          </view>
          <view class="content">
            <text class="status">{{ item.status }}</text>
            <text class="desc">{{ item.desc }}</text>
            <text class="time">{{ item.time }}</text>
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>
<script>
export default {
  data() {
    return {
      logistics: [
        { status: '派送中', desc: '顺丰速运 快递员正在为您派件', time: '10:42 AM' },
        { status: '已发货', desc: '您的包裹已由顺丰速运揽收', time: '昨天 08:30 PM' },
        { status: '已下单', desc: '卖家已确认订单，等待发货', time: '昨天 10:15 AM' }
      ]
    }
  },
  methods: { goBack() { uni.navigateBack() } }
}
</script>
<style lang="scss" scoped>
.logistics-page { min-height: 100vh; background-color: $color-background; display: flex; flex-direction: column; }
.header { position: fixed; top: 0; width: 100%; height: 100rpx; display: flex; align-items: center; padding: 0 32rpx; padding-top: env(safe-area-inset-top); z-index: 50; }
.back-btn { font-size: 48rpx; color: $color-on-surface; margin-right: 32rpx; display: flex; align-items: center;}
.title { font-size: 36rpx; font-weight: 600; color: $color-primary; }
.main-content { margin-top: calc(100rpx + env(safe-area-inset-top)); flex: 1; }
.timeline { padding: 48rpx 32rpx; }
.timeline-item { display: flex; margin-bottom: 32rpx; }
.line-container { display: flex; flex-direction: column; align-items: center; margin-right: 32rpx; }
.dot { width: 24rpx; height: 24rpx; border-radius: 50%; background-color: #4edea3; z-index: 2; }
.line { width: 4rpx; flex: 1; background-color: $color-surface-container-high; margin-top: -12rpx; margin-bottom: -44rpx; z-index: 1; }
.content { flex: 1; padding-bottom: 16rpx; background: $color-surface; padding: 24rpx; border-radius: 24rpx; box-shadow: 0 4rpx 12rpx rgba(0,0,0,0.03); }
.status { display: block; font-weight: 700; font-size: 32rpx; color: $color-on-surface; margin-bottom: 8rpx; }
.desc { display: block; font-size: 28rpx; color: $color-on-surface-variant; margin-bottom: 16rpx; }
.time { display: block; font-size: 24rpx; color: $color-outline; }
</style>
```

- [x] **Step 2: Add to pages.json**

```json
		{
			"path": "pages/messages/logistics",
			"style": {
				"navigationBarTitleText": "交易物流",
				"navigationStyle": "custom"
			}
		}
```
(Add into the `pages` array of `market-frontend/pages.json`)

---

### Task 2: 创建互动消息页面 (Interactions)

**Files:**
- Create: `market-frontend/pages/messages/interactions.vue`
- Modify: `market-frontend/pages.json`

- [x] **Step 1: Write interactions UI component**
(A list layout featuring a right-side thumbnail for the post/item being interacted with).

```vue
<template>
  <view class="interactions-page">
    <view class="header glass-effect">
      <view class="back-btn active-scale" @click="goBack"><text class="material-symbols-outlined">arrow_back</text></view>
      <text class="title">互动消息</text>
    </view>
    <scroll-view scroll-y class="main-content">
      <view class="list">
        <view class="interaction-item active-scale" v-for="item in items" :key="item.id">
          <image class="avatar" :src="item.avatar" mode="aspectFill"></image>
          <view class="info">
            <view class="text-content">
              <text class="user">{{item.user}}</text> <text class="action">{{item.action}}</text>
            </view>
            <text class="time">{{item.time}}</text>
          </view>
          <image class="cover" :src="item.cover" mode="aspectFill"></image>
        </view>
      </view>
    </scroll-view>
  </view>
</template>
<script>
export default {
  data() {
    return {
      items: [
        { id:1, user:'UserA', action:'赞了你的帖子', time:'1小时前', avatar:'https://lh3.googleusercontent.com/aida-public/AB6AXuBfFZbGJuxvmI2uNx-5IsMX3_uotLPtyHCV8dCtB3iJxfT7HHrqmABoHUV1-emVGdjtg2MaOKvpVUMrk7mwAjqTAXiZdUyvncqwTKC9zZKQqJHU0AXoJ1BKVKLSGr_3IHMyCKA5jGjwmKXNiz1_D9zyJdfQzOZ_ut78T-hiwHE4L9xq_awKh7uQFiPGRcOEa13mCtL1Cvm6SKU88oa_eycwyxIt0PjNDDXIgVsXSwNwL4i6sCyEeHGQZcq6rIHFXx6LSODS19TDRDqx', cover:'https://lh3.googleusercontent.com/aida-public/AB6AXuDZayQbW7Q6gFkqRnSNBpL-M3aW8BrZXWw9026KO1h6HrIDkcLaJpRuBPjjG2TQMxT9Ap-vV3LWemQ67OaXL39Ba0vpueIVNfyJQmfp5zLnALZuI0J1ZmHIqmhnj6rjXz7EH4aYqzF7gz4p2im-IiMGdSdKTVNXrMqb1nf1WAR2n5KoaLl-sSZZ3FlHMQdTUXR6cHxIibC4END5uFyNOzTPYiYIaQ1BD-FIXZGlKvPkVvy1r9XfkDwRa7ubbDJ9EZ_UabL04Beheffx' }
      ]
    }
  },
  methods: { goBack() { uni.navigateBack() } }
}
</script>
<style lang="scss" scoped>
.interactions-page { min-height: 100vh; background-color: $color-background; display: flex; flex-direction: column; }
.header { position: fixed; top: 0; width: 100%; height: 100rpx; display: flex; align-items: center; padding: 0 32rpx; padding-top: env(safe-area-inset-top); z-index: 50; }
.back-btn { font-size: 48rpx; margin-right: 32rpx; }
.title { font-size: 36rpx; font-weight: 600; color: $color-primary; }
.main-content { margin-top: calc(100rpx + env(safe-area-inset-top)); flex: 1; }
.list { padding: 24rpx; }
.interaction-item { display: flex; align-items: center; background: $color-surface; padding: 24rpx; border-radius: 24rpx; margin-bottom: 24rpx; }
.avatar { width: 80rpx; height: 80rpx; border-radius: 50%; margin-right: 24rpx; }
.info { flex: 1; display: flex; flex-direction: column; gap: 8rpx; }
.user { font-weight: bold; font-size: 28rpx; color: $color-on-surface; }
.action { font-size: 28rpx; color: $color-on-surface-variant; }
.time { font-size: 24rpx; color: $color-outline; }
.cover { width: 96rpx; height: 96rpx; border-radius: 12rpx; margin-left: 24rpx; }
</style>
```

- [x] **Step 2: Add to pages.json**

```json
		{
			"path": "pages/messages/interactions",
			"style": { "navigationBarTitleText": "互动消息", "navigationStyle": "custom" }
		}
```

---

### Task 3: 创建通知消息页面 (Notices)

**Files:**
- Create: `market-frontend/pages/messages/notices.vue`
- Modify: `market-frontend/pages.json`

- [x] **Step 1: Write notices UI component**

```vue
<template>
  <view class="notices-page">
    <view class="header glass-effect">
      <view class="back-btn active-scale" @click="goBack"><text class="material-symbols-outlined">arrow_back</text></view>
      <text class="title">通知消息</text>
    </view>
    <scroll-view scroll-y class="main-content">
      <view class="list">
        <view class="notice-item active-scale" v-for="item in items" :key="item.id">
          <view class="icon-circle">
            <text class="material-symbols-outlined">campaign</text>
          </view>
          <view class="info">
            <view class="title-row">
              <text class="notice-title">{{item.title}}</text>
              <text class="time">{{item.time}}</text>
            </view>
            <text class="desc">{{item.desc}}</text>
          </view>
        </view>
      </view>
    </scroll-view>
  </view>
</template>
<script>
export default {
  data() {
    return {
      items: [
        { id:1, title:'系统维护通知', desc:'今晚凌晨2:00将进行系统升级。', time:'昨天' },
        { id:2, title:'优惠券到账', desc:'您有一张满200减20的优惠券。', time:'12/05' }
      ]
    }
  },
  methods: { goBack() { uni.navigateBack() } }
}
</script>
<style lang="scss" scoped>
.notices-page { min-height: 100vh; background-color: $color-background; display: flex; flex-direction: column; }
.header { position: fixed; top: 0; width: 100%; height: 100rpx; display: flex; align-items: center; padding: 0 32rpx; padding-top: env(safe-area-inset-top); z-index: 50; }
.back-btn { font-size: 48rpx; margin-right: 32rpx; }
.title { font-size: 36rpx; font-weight: 600; color: $color-primary; }
.main-content { margin-top: calc(100rpx + env(safe-area-inset-top)); flex: 1; }
.list { padding: 24rpx; }
.notice-item { display: flex; background: $color-surface; padding: 24rpx; border-radius: 24rpx; margin-bottom: 24rpx; }
.icon-circle { width: 80rpx; height: 80rpx; border-radius: 50%; background: $color-primary-container; color: #8590a6; display: flex; align-items: center; justify-content: center; margin-right: 24rpx; }
.info { flex: 1; display: flex; flex-direction: column; }
.title-row { display: flex; justify-content: space-between; margin-bottom: 8rpx; }
.notice-title { font-weight: bold; font-size: 32rpx; color: $color-on-surface; }
.time { font-size: 24rpx; color: $color-outline; }
.desc { font-size: 28rpx; color: $color-on-surface-variant; }
</style>
```

- [x] **Step 2: Add to pages.json**

```json
		{
			"path": "pages/messages/notices",
			"style": { "navigationBarTitleText": "通知消息", "navigationStyle": "custom" }
		}
```

---

### Task 4: 创建聊天详情页 (Chat Detail)

**Files:**
- Create: `market-frontend/pages/messages/chat.vue`
- Modify: `market-frontend/pages.json`

- [x] **Step 1: Write chat UI component with Quick Replies and Input Bar**

```vue
<template>
  <view class="chat-page">
    <view class="header glass-effect">
      <view class="back-btn active-scale" @click="goBack"><text class="material-symbols-outlined">arrow_back</text></view>
      <text class="title">{{ contactName }}</text>
    </view>
    <scroll-view scroll-y class="chat-area" :scroll-into-view="lastId">
      <view class="bubble-wrapper" v-for="msg in messages" :key="msg.id" :id="'msg-'+msg.id" :class="{'me': msg.isMe, 'other': !msg.isMe}">
        <image class="avatar" v-if="!msg.isMe" :src="contactAvatar" mode="aspectFill"></image>
        <view class="bubble">
          <text>{{ msg.text }}</text>
        </view>
        <image class="avatar me-avatar" v-if="msg.isMe" src="https://lh3.googleusercontent.com/aida-public/AB6AXuDZayQbW7Q6gFkqRnSNBpL-M3aW8BrZXWw9026KO1h6HrIDkcLaJpRuBPjjG2TQMxT9Ap-vV3LWemQ67OaXL39Ba0vpueIVNfyJQmfp5zLnALZuI0J1ZmHIqmhnj6rjXz7EH4aYqzF7gz4p2im-IiMGdSdKTVNXrMqb1nf1WAR2n5KoaLl-sSZZ3FlHMQdTUXR6cHxIibC4END5uFyNOzTPYiYIaQ1BD-FIXZGlKvPkVvy1r9XfkDwRa7ubbDJ9EZ_UabL04Beheffx" mode="aspectFill"></image>
      </view>
      <view class="safe-bottom-pad"></view>
    </scroll-view>

    <!-- Bottom Input Area -->
    <view class="input-area">
      <!-- Quick Replies -->
      <scroll-view scroll-x class="quick-replies" :show-scrollbar="false">
        <view class="chip active-scale" @click="sendQuick('你好，这件还在吗？')">你好，这件还在吗？</view>
        <view class="chip active-scale" @click="sendQuick('能包邮吗？')">能包邮吗？</view>
        <view class="chip active-scale" @click="sendQuick('有实物图吗？')">有实物图吗？</view>
      </scroll-view>
      
      <view class="input-bar">
        <text class="material-symbols-outlined icon-btn">mic</text>
        <input class="input-box" v-model="inputText" placeholder="输入消息..." @confirm="sendMsg" confirm-type="send" />
        <text class="material-symbols-outlined icon-btn">sentiment_satisfied</text>
        <text class="material-symbols-outlined icon-btn">add_circle</text>
      </view>
    </view>
  </view>
</template>
<script>
export default {
  data() {
    return {
      contactName: 'Anna Studio',
      contactAvatar: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBfFZbGJuxvmI2uNx-5IsMX3_uotLPtyHCV8dCtB3iJxfT7HHrqmABoHUV1-emVGdjtg2MaOKvpVUMrk7mwAjqTAXiZdUyvncqwTKC9zZKQqJHU0AXoJ1BKVKLSGr_3IHMyCKA5jGjwmKXNiz1_D9zyJdfQzOZ_ut78T-hiwHE4L9xq_awKh7uQFiPGRcOEa13mCtL1Cvm6SKU88oa_eycwyxIt0PjNDDXIgVsXSwNwL4i6sCyEeHGQZcq6rIHFXx6LSODS19TDRDqx',
      inputText: '',
      messages: [
        { id: 1, text: '您好，这款Vintage包包还在吗？', isMe: false },
        { id: 2, text: '在的，直接拍即可。', isMe: true }
      ]
    }
  },
  computed: {
    lastId() { return this.messages.length > 0 ? 'msg-' + this.messages[this.messages.length - 1].id : ''; }
  },
  methods: {
    goBack() { uni.navigateBack() },
    sendQuick(text) {
      this.messages.push({ id: Date.now(), text, isMe: true });
    },
    sendMsg() {
      if (!this.inputText.trim()) return;
      this.messages.push({ id: Date.now(), text: this.inputText, isMe: true });
      this.inputText = '';
    }
  }
}
</script>
<style lang="scss" scoped>
.chat-page { height: 100vh; background-color: $color-background; display: flex; flex-direction: column; overflow: hidden; }
.header { position: fixed; top: 0; width: 100%; height: 100rpx; display: flex; align-items: center; padding: 0 32rpx; padding-top: env(safe-area-inset-top); z-index: 50; }
.back-btn { font-size: 48rpx; margin-right: 32rpx; }
.title { font-size: 36rpx; font-weight: 600; color: $color-primary; }
.chat-area { flex: 1; margin-top: calc(100rpx + env(safe-area-inset-top)); padding: 24rpx; box-sizing: border-box; }
.bubble-wrapper { display: flex; align-items: flex-start; margin-bottom: 32rpx; }
.bubble-wrapper.me { justify-content: flex-end; }
.avatar { width: 80rpx; height: 80rpx; border-radius: 50%; }
.me-avatar { margin-left: 16rpx; }
.bubble-wrapper.other .avatar { margin-right: 16rpx; }
.bubble { max-width: 60%; padding: 20rpx 32rpx; border-radius: 32rpx; font-size: 28rpx; word-break: break-all; }
.bubble-wrapper.other .bubble { background: $color-surface; color: $color-on-surface; border-top-left-radius: 8rpx; }
.bubble-wrapper.me .bubble { background: $color-primary; color: $color-on-primary; border-top-right-radius: 8rpx; }
.safe-bottom-pad { height: 200rpx; }

.input-area { background: $color-surface-container-low; padding-bottom: env(safe-area-inset-bottom); display: flex; flex-direction: column; }
.quick-replies { white-space: nowrap; padding: 16rpx 24rpx; }
.chip { display: inline-block; background: $color-surface-container-high; color: $color-on-surface; padding: 12rpx 24rpx; border-radius: 32rpx; font-size: 24rpx; margin-right: 16rpx; }
.input-bar { display: flex; align-items: center; padding: 16rpx 24rpx; }
.input-box { flex: 1; background: $color-surface; height: 72rpx; border-radius: 36rpx; padding: 0 32rpx; font-size: 28rpx; color: $color-on-surface; margin: 0 16rpx; }
.icon-btn { font-size: 56rpx; color: $color-on-surface-variant; }
</style>
```

- [x] **Step 2: Add to pages.json**

```json
		{
			"path": "pages/messages/chat",
			"style": { "navigationBarTitleText": "聊天", "navigationStyle": "custom" }
		}
```

---

### Task 5: 接入首页导航跳转

**Files:**
- Modify: `market-frontend/pages/messages/messages.vue`

- [x] **Step 1: Modify functional group templates to attach `@click` handlers**

```diff
-				<view class="func-item active-scale">
+				<view class="func-item active-scale" @click="navTo('logistics')">
					<view class="icon-circle logistics">
						<text class="material-symbols-outlined icon-fill">local_shipping</text>
					</view>
					<text class="func-label">交易物流</text>
				</view>
-				<view class="func-item active-scale">
+				<view class="func-item active-scale" @click="navTo('notices')">
					<view class="icon-circle notices">
						<text class="material-symbols-outlined icon-fill">notifications</text>
						<view class="badge"></view>
					</view>
					<text class="func-label">通知消息</text>
				</view>
-				<view class="func-item active-scale">
+				<view class="func-item active-scale" @click="navTo('interactions')">
					<view class="icon-circle interactions">
						<text class="material-symbols-outlined icon-fill">favorite</text>
					</view>
					<text class="func-label">互动消息</text>
				</view>
```

- [x] **Step 2: Modify message list items to attach `@click`**

```diff
-				<view class="chat-entry active-scale" v-for="(msg, index) in filteredMessages" :key="msg.id" :class="{'opacity-80': msg.isOfficial}">
+				<view class="chat-entry active-scale" v-for="(msg, index) in filteredMessages" :key="msg.id" :class="{'opacity-80': msg.isOfficial}" @click="navToChat(msg)">
```

- [x] **Step 3: Add `navTo` and `navToChat` methods in `<script>`**

```javascript
// Add these methods inside methods: {} block
navTo(type) {
    uni.navigateTo({ url: `/pages/messages/${type}` });
},
navToChat(msg) {
    uni.navigateTo({ url: `/pages/messages/chat?id=${msg.id}&name=${encodeURIComponent(msg.name)}` });
}
```
