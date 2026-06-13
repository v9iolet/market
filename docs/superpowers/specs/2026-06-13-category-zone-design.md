---
status: superseded-by-main-spec
archived-with: category-zone

comet_change: category-zone
role: technical-design
canonical_spec: openspec
---

# Technical Design: Category Zone (二级页面)

## 1. Architecture Approach

We will build an independent `category-zone.vue` page mapped to `pages/category-zone/category-zone` in the `uni-app` framework. To ensure absolute visual consistency with the `index.vue` home page and lower future maintenance costs, we will extract shared components from the existing home page.

### 1.1 Component Extraction (Refactoring)
- **`ProductCard.vue`**: The waterfall product card currently hardcoded in `pages/index/index.vue` will be moved into `components/ProductCard/ProductCard.vue`. Both `index.vue` and `category-zone.vue` will import and use this component.
- **`EmptyState.vue`**: A new shared component `components/EmptyState/EmptyState.vue` will be created to gracefully handle cases where a selected subcategory has no products.

## 2. Component Structure

### `pages/category-zone/category-zone.vue`
1. **Top Navigation Bar (`.header.glass-effect`)**: Includes a back button (left), dynamic category title (center), and search icon (right).
2. **Subcategory Tabs (`.subcategory-tabs`)**: Horizontally scrollable list of secondary categories (e.g., iPhone, iPad, MacBook). Supports active styling (`color-secondary`).
3. **Filter Bar (`.filter-bar`)**: Sticky bar underneath tabs for comprehensive sorting (推荐, 最新, 附近, 只看全新).
4. **Waterfall Grid (`.product-waterfall`)**: A 2-column grid rendering instances of `ProductCard.vue`.
5. **Empty State**: Renders `EmptyState.vue` if the mocked product list is empty.

## 3. Data Flow

- The page will use hardcoded mock data in `data()` to demonstrate the UI features.
- `ProductCard.vue` will accept a `product` object via props:
  ```javascript
  props: {
    product: {
      type: Object,
      required: true
    }
  }
  ```
- Subcategory switching will simply swap out the `mockProducts` array with another mock set (or an empty array to demonstrate the `EmptyState.vue`).

## 4. Key Risks and Mitigation

- **Risk**: Extracting `ProductCard` might break the CSS scoping and layout of the home page waterfall grid.
- **Mitigation**: Ensure that the CSS classes mapped to the `ProductCard` component are fully scoped or specifically targeted in `uni.scss`. We will manually verify the home page visual integrity after the extraction before proceeding with the new page development.

## 5. Testing Strategy

- Exclusively **manual UI testing**.
- Steps:
  1. Verify the home page waterfall grid looks identical after `ProductCard.vue` extraction.
  2. Verify navigating from home page Category Grid icons successfully opens `category-zone`.
  3. Verify the subcategory tabs and filter bars look visually harmonious with the `glass-effect` theme.
  4. Verify the `EmptyState.vue` displays correctly when selecting a subcategory with no products.
