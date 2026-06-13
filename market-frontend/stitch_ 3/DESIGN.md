---
name: Premium Exchange System
colors:
  surface: '#f8f9ff'
  surface-dim: '#cbdbf5'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eff4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dce9ff'
  surface-container-highest: '#d3e4fe'
  on-surface: '#0b1c30'
  on-surface-variant: '#45474c'
  inverse-surface: '#213145'
  inverse-on-surface: '#eaf1ff'
  outline: '#75777d'
  outline-variant: '#c5c6cd'
  surface-tint: '#545f73'
  primary: '#091426'
  on-primary: '#ffffff'
  primary-container: '#1e293b'
  on-primary-container: '#8590a6'
  inverse-primary: '#bcc7de'
  secondary: '#006c49'
  on-secondary: '#ffffff'
  secondary-container: '#6cf8bb'
  on-secondary-container: '#00714d'
  tertiary: '#111516'
  on-tertiary: '#ffffff'
  tertiary-container: '#26292b'
  on-tertiary-container: '#8d9092'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d8e3fb'
  primary-fixed-dim: '#bcc7de'
  on-primary-fixed: '#111c2d'
  on-primary-fixed-variant: '#3c475a'
  secondary-fixed: '#6ffbbe'
  secondary-fixed-dim: '#4edea3'
  on-secondary-fixed: '#002113'
  on-secondary-fixed-variant: '#005236'
  tertiary-fixed: '#e0e3e5'
  tertiary-fixed-dim: '#c4c7c9'
  on-tertiary-fixed: '#191c1e'
  on-tertiary-fixed-variant: '#444749'
  background: '#f8f9ff'
  on-background: '#0b1c30'
  surface-variant: '#d3e4fe'
typography:
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 26px
    fontWeight: '700'
    lineHeight: 32px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.05em
  price-display:
    fontFamily: Inter
    fontSize: 22px
    fontWeight: '700'
    lineHeight: 28px
    letterSpacing: -0.01em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  container-margin: 20px
  gutter: 12px
  stack-sm: 8px
  stack-md: 16px
  stack-lg: 32px
  section-gap: 48px
---

## Brand & Style

The design system is engineered for a high-end second-hand marketplace that prioritizes trust, sustainability, and editorial aesthetics. Moving away from the cluttered, "bargain-bin" feel of traditional marketplaces, this system adopts a **Modern Lifestyle** aesthetic. It treats pre-owned items with the same reverence as luxury retail, evoking a sense of "curated discovery" rather than "used goods."

The emotional response should be one of confidence and calm. By utilizing generous whitespace and a sophisticated palette, the UI disappears to let the high-quality product photography take center stage. The style blends **Corporate Modern** precision with **Glassmorphic** accents, ensuring the platform feels both technologically advanced and human-centric.

## Colors

This design system utilizes a grounded, professional palette to establish immediate credibility.

- **Primary (Dark Slate):** Used for core branding, primary actions, and high-level headings. It provides a stable, "expensive" foundation.
- **Accent (Emerald Green):** Representing growth, sustainability, and "go" signals. Used sparingly for call-to-actions, price highlights, and verification badges to ensure high visibility without fatigue.
- **Neutral / Background:** A range of cool grays (Slate 50 to Slate 900) manages depth. The background is kept strictly off-white (#F8FAFC) to reduce eye strain and maintain a premium feel.
- **Functional Colors:** Error states use a soft Rose (#E11D48), and warnings use Amber (#F59E0B), both calibrated to match the saturation levels of the primary palette.

## Typography

The typography system relies on **Inter** to deliver a systematic, utilitarian, yet modern feel. 

- **Scale:** High contrast between headlines and body text is essential for an editorial feel. 
- **Hierarchy:** Use `headline-lg` for category titles and `headline-md` for product names in listings. 
- **Price Treatment:** The `price-display` role is critical; it should always be paired with the Emerald Green accent or Dark Slate primary to ensure the value proposition is the first thing the user sees.
- **Readability:** Body text uses a slightly increased line height (1.5x) to handle long item descriptions comfortably.

## Layout & Spacing

The layout follows a **Fluid Grid** model optimized for mobile-first consumption. 

- **Margins:** A generous 20px outer margin ensures content doesn't feel cramped against device edges.
- **Grid:** Use a 2-column masonry or fixed-height grid for product feeds to allow for large, clear imagery.
- **Vertical Rhythm:** Use the `stack` variables to maintain consistency. `stack-md` (16px) is the standard distance between related elements (e.g., image and title), while `section-gap` (48px) separates distinct content blocks like "Recommended for You" and "Recent Views."
- **Safe Areas:** Navigation and toolbars must account for notch and home-indicator safe zones, utilizing translucent backgrounds to maintain a sense of space.

## Elevation & Depth

Hierarchy is established through **Ambient Shadows** and **Tonal Layers**. 

- **The "Signature" Shadow:** The primary elevation style is `shadow-xl`, a deeply diffused, low-opacity shadow (e.g., `0 20px 25px -5px rgba(30, 41, 59, 0.1)`). This makes cards appear to float gently above the surface.
- **Glassmorphism:** Navigation bars and bottom sheets use a `backdrop-filter: blur(12px)` with a semi-transparent Slate-50 background (opacity 80%). This maintains context of the scroll position behind the UI.
- **Interaction:** On press, elements should "sink" by reducing shadow spread and slightly scaling down (98%), providing a tactile, responsive feel.

## Shapes

The shape language is defined by **Large Rounded Corners**, creating a soft, approachable, and premium silhouette.

- **Standard Elements:** Buttons and input fields use `rounded-lg` (0.5rem).
- **Surface Containers:** Product cards and bottom sheets use `rounded-2xl` (1.5rem) to differentiate them from the background and signal they are interactive modules.
- **Imagery:** Product photos must always carry the same `rounded-2xl` clipping to maintain visual harmony with the card containers.

## Components

- **Elegant Cards:** The primary product card features a 1:1 aspect ratio image, `rounded-2xl` corners, and a `shadow-xl`. Information is bottom-aligned with a clear price in Emerald Green.
- **Primary Buttons:** High-contrast Dark Slate background with white text, `rounded-lg`, and subtle micro-animations on tap (slight scale down).
- **Refined Icons:** Use thin-stroke (1.5pt) linear icons in Slate-400. Active states in the navigation bar transition to a filled Emerald Green icon.
- **Input Fields:** Minimalist design with a subtle 1px border in Slate-200. On focus, the border transitions to Dark Slate with a soft Emerald glow (outer shadow).
- **Chips & Tags:** Small, low-contrast tags (e.g., "Like New", "Verified") use a soft Slate-100 background with Slate-700 text to avoid distracting from the main product info.
- **Translucent Navigation:** A sticky header with a blur effect that houses the search bar, ensuring the product images are visible as they scroll underneath.