# Design: category-zone

## Architecture Approach
- Build the new page `pages/category-zone/category-zone` in the `uni-app` framework.
- Reuse styling variables from `uni.scss` to maintain visual consistency (e.g., `$color-primary`, `$color-background`).

## UI/UX Design Details
1. **Top Navigation**: Implement a custom navigation bar with glassmorphism (`glass-effect`), a back button, the current category title, and a search icon.
2. **Subcategory Tabs**: A horizontally scrollable row of subcategories (e.g., for "手机数码" it would have "iPhone", "iPad", "MacBook", "Android", etc.).
3. **Filter Bar**: Sticky filter bar with options like "综合" (Comprehensive), "最新" (Latest), "附近" (Nearest), "只看全新" (Only New).
4. **Product Waterfall**: Reuse the product card design from the home page. Extract it into a reusable component `ProductCard.vue` if needed, or simply duplicate the structure if it's currently hardcoded in `index.vue`. Since we only focus on frontend UI/UX logic, we will mock the waterfall list.

## Data Flow
- Provide hardcoded `mockProducts` data in the component's `data()` to render the waterfall list.
- Handle `@click` events for subcategories and filters to trigger simple visual active state changes.
