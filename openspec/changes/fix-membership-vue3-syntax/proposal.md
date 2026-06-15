# Fix Membership Vue3 Syntax Error

## Problem
The backend membership CRUD functions are reported as completely broken ("都用不了").

## Root Cause
The admin frontend `admin-frontend` uses Vue 3 (RuoYi-Vue3). However, the generated `index.vue` page for the membership configuration uses Vue 2 specific syntax:
- `.sync` modifier (e.g. `:showSearch.sync`, `:visible.sync`)
- `slot-scope="scope"`

These Vue 2 syntaxes result in failure to render or interact with components in a Vue 3 project, preventing the modal from opening and the UI from loading correctly.

## Fix Goal
Update `admin-frontend/src/views/market/membership/index.vue` to use Vue 3 compatible syntax (`v-model` and `#default`).
