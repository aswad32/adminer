# UI Modernization — Task Tracker

This is the master checklist of all UI modernization tasks. Work should proceed in priority order. Each task is described in detail in the corresponding spec file.

---

## Spec Documents

| # | File | Topic | Priority | Risk |
|---|---|---|---|---|
| 00 | [00-architecture-overview.md](00-architecture-overview.md) | Architecture reference (read-only) | — | — |
| 01 | [01-css-design-system.md](01-css-design-system.md) | CSS design token system | 1 | Low |
| 02 | [02-login-screen.md](02-login-screen.md) | Login screen | 2 | Low |
| 03 | [03-layout-shell.md](03-layout-shell.md) | Global layout shell | 3 | Medium |
| 04 | [04-sidebar-navigation.md](04-sidebar-navigation.md) | Sidebar navigation | 4 | Medium |
| 05 | [05-buttons-controls.md](05-buttons-controls.md) | Buttons and form controls | 5 | Low |
| 06 | [06-data-tables.md](06-data-tables.md) | Data tables (browse screen) | 6 | Medium |
| 07 | [07-edit-form.md](07-edit-form.md) | Insert / edit row form | 7 | High |
| 08 | [08-sql-command-screen.md](08-sql-command-screen.md) | SQL command screen | 8 | Medium |
| 09 | [09-select-filter-bar.md](09-select-filter-bar.md) | Select filter/sort/action bar | 9 | High |
| 10 | [10-table-structure-schema.md](10-table-structure-schema.md) | Table structure and ER diagram | 10 | Low–Medium |
| 11 | [11-export-import.md](11-export-import.md) | Export and import screens | 11 | Low |
| 12 | [12-responsive-layout.md](12-responsive-layout.md) | Responsive layout | 12 | Low |
| 13 | [13-dark-mode.md](13-dark-mode.md) | Dark mode | 13 | Low |

---

## Master Task List

### Phase 1 — Foundation (must complete before visual changes)

- [x] **TASK-CSS-01** Define expanded CSS variable set on `html {}` _(merged: PR #44)_
- [x] **TASK-CSS-02** Update `body {}` typography _(merged: PR #44)_
- [x] **TASK-CSS-03** Update `dark.css` dark token overrides _(merged: PR #44)_
- [x] **TASK-CSS-04** Migrate hard-coded colors to tokens _(merged: PR #44)_

### Phase 2 — Login + Global Shell

- [x] **TASK-LOGIN-01** Center the login card _(merged: PR #46)_
- [x] **TASK-LOGIN-02** Style the Login button _(merged: PR #46)_
- [x] **TASK-LOGIN-03** Style the Permanent login checkbox _(merged: PR #46)_
- [x] **TASK-LOGIN-04** Improve sidebar login session list _(merged: PR #46)_
- [x] **TASK-LAYOUT-01** Sidebar visual refresh _(merged: PR #47)_
- [x] **TASK-LAYOUT-02** Header / logo area _(merged: PR #47)_
- [x] **TASK-LAYOUT-03** Breadcrumb bar _(merged: PR #47)_
- [x] **TASK-LAYOUT-04** Content area spacing _(merged: PR #47)_
- [x] **TASK-LAYOUT-05** Page title (h2) _(merged: PR #47)_
- [x] **TASK-LAYOUT-06** Flash messages (.message, .error) _(merged: PR #48)_
- [x] **TASK-LAYOUT-07** Logout area _(merged: PR #48)_
- [x] **TASK-LAYOUT-08** Mobile layout (≤800px) _(merged: PR #53)_

### Phase 3 — Navigation

- [x] **TASK-NAV-01** Table list items _(merged: PR #49)_
- [x] **TASK-NAV-02** Sidebar action links _(merged: PR #49)_
- [x] **TASK-NAV-03** Database list (#dbs) _(merged: PR #49)_
- [x] **TASK-NAV-04** Language switcher (#lang) _(merged: PR #49)_
- [x] **TASK-NAV-05** Mobile hamburger button _(merged: PR #53)_

### Phase 4 — Controls

- [x] **TASK-BTN-01** Primary submit button _(merged: PR #50)_
- [x] **TASK-BTN-02** Danger / destructive button variants _(merged: PR #50)_
- [x] **TASK-BTN-03** Secondary / neutral buttons _(merged: PR #50)_
- [x] **TASK-BTN-04** Icon buttons (.icon) _(merged: PR #50)_
- [x] **TASK-BTN-05** Form action bar (.footer) _(merged: PR #50)_
- [x] **TASK-BTN-06** Text inputs and selects (global) _(merged: PR #50)_

### Phase 5 — Data Tables

- [x] **TASK-TABLE-01** Base table reset and spacing _(merged: PR #51)_
- [x] **TASK-TABLE-02** Column headers (th, thead) _(merged: PR #51)_
- [x] **TASK-TABLE-03** Row hover and selection states _(merged: PR #51)_
- [x] **TASK-TABLE-04** Scrollable table wrapper _(merged: PR #51)_
- [x] **TASK-TABLE-05** Null / special value display _(merged: PR #51)_
- [x] **TASK-TABLE-06** Pagination _(merged: PR #51)_
- [x] **TASK-TABLE-07** Nested tables (td table) _(merged: PR #51)_
- [x] **TASK-TABLE-08** Time display (.time) _(merged: PR #51)_

### Phase 6 — Per-Screen Polish

- [x] **TASK-EDIT-01** Edit table layout _(PR #52)_
- [x] **TASK-EDIT-02** Function column styling _(PR #52)_
- [x] **TASK-EDIT-03** Input cells _(PR #52)_
- [x] **TASK-EDIT-04** Enum/set radio+checkbox _(PR #52)_
- [x] **TASK-EDIT-05** Form action buttons _(PR #52)_
- [x] **TASK-SQL-01** SQL textarea _(PR #52)_
- [x] **TASK-SQL-02** SQL form footer _(PR #52)_
- [x] **TASK-SQL-03** Query result display _(PR #52)_
- [x] **TASK-SQL-04** Query history panel _(PR #52)_
- [x] **TASK-SELECT-01** Fieldset container styling _(PR #52)_
- [x] **TASK-SELECT-02** Fieldset inner div _(PR #52)_
- [x] **TASK-SELECT-03** .size inputs _(PR #52)_
- [x] **TASK-SELECT-04** No-index warning _(PR #52)_
- [x] **TASK-SELECT-05** Action bar below data table _(PR #52)_
- [x] **TASK-SELECT-06** Links bar _(PR #52)_
- [x] **TASK-STRUCT-01** Structure table column widths _(PR #52)_
- [x] **TASK-STRUCT-02** Column editor table (alter table) _(PR #52)_
- [x] **TASK-STRUCT-03** Index table _(PR #52)_
- [x] **TASK-STRUCT-04** Schema table cards (ER diagram) _(PR #52)_
- [x] **TASK-DUMP-01** Export fieldset groups _(PR #52)_
- [x] **TASK-DUMP-02** Radio/checkbox option lists _(PR #52)_
- [x] **TASK-DUMP-04** Import file input _(PR #52)_

### Phase 7 — Responsive + Dark Mode

- [x] **TASK-RESP-01** Improved mobile sidebar overlay _(PR #53)_
- [x] **TASK-RESP-02** Touch targets _(PR #53)_
- [x] **TASK-RESP-03** Responsive breadcrumb _(PR #53)_
- [x] **TASK-RESP-04** Responsive tables _(PR #53)_
- [x] **TASK-RESP-05** Responsive logout area _(PR #53)_
- [x] **TASK-DARK-01** New token dark overrides _(PR #53)_
- [x] **TASK-DARK-02** Dark mode form controls _(PR #53)_
- [x] **TASK-DARK-03** Dark mode icon inversion (verify) _(PR #53)_
- [x] **TASK-DARK-04** Dark mode schema diagram _(PR #53)_
- [x] **TASK-DARK-05** Body class dark toggle compatibility _(PR #53)_

### Phase 8 — PHP HTML Layer

- [ ] **TASK-PHP-01** Login page wrapper — add `.login-page-inner` and `.login-heading` in `auth.inc.php`
- [ ] **TASK-PHP-02** Login form subtitle — add subtitle `<p>` before `<table class='layout'>` in `loginForm()` (`adminer.inc.php` + editor mirror)
- [ ] **TASK-PHP-03** Topbar wrapper — wrap `#menuopen` + `#breadcrumb` in `<div class="topbar">` in `page_header()` (`design.inc.php`)
- [ ] **TASK-PHP-04** Page messages wrapper — wrap `.message`/`.error` output in `<div class="page-messages">` (`design.inc.php`)
- [ ] **TASK-PHP-05** Sidebar nav sections — add `<div class="nav-section">` grouping wrappers in `navigation()` (`adminer.inc.php` + editor mirror)

---

## Implementation Rules

CSS changes are always preferred. PHP changes are limited to **additive HTML wrapper elements only** — no logic, form fields, URLs, or behavior may change.

Allowed PHP changes:
- Add new wrapper `<div>`, `<section>`, or `<header>` elements around existing output
- Add new heading or label elements before/after existing output
- Add `class` attributes to existing elements for CSS targeting

Never touch in PHP:
- Form field names, `action`/`method` attributes, hidden inputs
- JS-locked elements: `<table class="layout">` row order, `#foot > #menu` hierarchy, `<form id="form">`, `<table id="table">`, `<table id="edit-fields">` column indices, `<span id="selected">` inside `<legend>`
- Any existing `id` or `class` attribute (renaming or removal)

Before marking any task complete:
1. Verify the changed element still submits the correct form data
2. Verify JS event handlers still fire (open browser DevTools)
3. Verify dark mode renders correctly
4. Verify mobile layout (≤800px) still works
5. Check existing designs in `designs/` folder do not visually break

---

## Files Modified by This Project

| File | Change type |
|---|---|
| `adminer/static/default.css` | CSS additions/modifications |
| `adminer/static/dark.css` | CSS additions/modifications |
| `adminer/include/auth.inc.php` | Additive HTML wrapper elements only |
| `adminer/include/adminer.inc.php` | Additive HTML wrapper elements only |
| `adminer/include/design.inc.php` | Additive HTML wrapper elements only |
| `editor/include/adminer.inc.php` | Mirror of all changes to `adminer/include/adminer.inc.php` |
