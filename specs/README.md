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

- [ ] **TASK-CSS-01** Define expanded CSS variable set on `html {}`
- [ ] **TASK-CSS-02** Update `body {}` typography
- [ ] **TASK-CSS-03** Update `dark.css` dark token overrides
- [ ] **TASK-CSS-04** Migrate hard-coded colors to tokens

### Phase 2 — Login + Global Shell

- [ ] **TASK-LOGIN-01** Center the login card
- [ ] **TASK-LOGIN-02** Style the Login button (links to TASK-BTN-01)
- [ ] **TASK-LOGIN-03** Style the Permanent login checkbox
- [ ] **TASK-LOGIN-04** Improve sidebar login session list
- [ ] **TASK-LAYOUT-01** Sidebar visual refresh
- [ ] **TASK-LAYOUT-02** Header / logo area
- [ ] **TASK-LAYOUT-03** Breadcrumb bar
- [ ] **TASK-LAYOUT-04** Content area spacing
- [ ] **TASK-LAYOUT-05** Page title (h2)
- [ ] **TASK-LAYOUT-06** Flash messages (.message, .error)
- [ ] **TASK-LAYOUT-07** Logout area
- [ ] **TASK-LAYOUT-08** Mobile layout (≤800px)

### Phase 3 — Navigation

- [ ] **TASK-NAV-01** Table list items
- [ ] **TASK-NAV-02** Sidebar action links
- [ ] **TASK-NAV-03** Database list (#dbs)
- [ ] **TASK-NAV-04** Language switcher (#lang)
- [ ] **TASK-NAV-05** Mobile hamburger button

### Phase 4 — Controls

- [ ] **TASK-BTN-01** Primary submit button
- [ ] **TASK-BTN-02** Danger / destructive button variants
- [ ] **TASK-BTN-03** Secondary / neutral buttons
- [ ] **TASK-BTN-04** Icon buttons (.icon)
- [ ] **TASK-BTN-05** Form action bar (.footer)
- [ ] **TASK-BTN-06** Text inputs and selects (global)

### Phase 5 — Data Tables

- [ ] **TASK-TABLE-01** Base table reset and spacing
- [ ] **TASK-TABLE-02** Column headers (th, thead)
- [ ] **TASK-TABLE-03** Row hover and selection states
- [ ] **TASK-TABLE-04** Scrollable table wrapper
- [ ] **TASK-TABLE-05** Null / special value display
- [ ] **TASK-TABLE-06** Pagination
- [ ] **TASK-TABLE-07** Nested tables (td table)
- [ ] **TASK-TABLE-08** Time display (.time)

### Phase 6 — Per-Screen Polish

- [ ] **TASK-EDIT-01** Edit table layout
- [ ] **TASK-EDIT-02** Function column styling
- [ ] **TASK-EDIT-03** Input cells
- [ ] **TASK-EDIT-04** Enum/set radio+checkbox
- [ ] **TASK-EDIT-05** Form action buttons
- [ ] **TASK-SQL-01** SQL textarea
- [ ] **TASK-SQL-02** SQL form footer
- [ ] **TASK-SQL-03** Query result display
- [ ] **TASK-SQL-04** Query history panel
- [ ] **TASK-SELECT-01** Fieldset container styling
- [ ] **TASK-SELECT-02** Fieldset inner div
- [ ] **TASK-SELECT-03** .size inputs
- [ ] **TASK-SELECT-04** No-index warning
- [ ] **TASK-SELECT-05** Action bar below data table
- [ ] **TASK-SELECT-06** Links bar
- [ ] **TASK-STRUCT-01** Structure table column widths
- [ ] **TASK-STRUCT-02** Column editor table (alter table)
- [ ] **TASK-STRUCT-03** Index table
- [ ] **TASK-STRUCT-04** Schema table cards (ER diagram)
- [ ] **TASK-DUMP-01** Export fieldset groups
- [ ] **TASK-DUMP-02** Radio/checkbox option lists
- [ ] **TASK-DUMP-04** Import file input

### Phase 7 — Responsive + Dark Mode

- [ ] **TASK-RESP-01** Improved mobile sidebar overlay
- [ ] **TASK-RESP-02** Touch targets
- [ ] **TASK-RESP-03** Responsive breadcrumb
- [ ] **TASK-RESP-04** Responsive tables
- [ ] **TASK-RESP-05** Responsive logout area
- [ ] **TASK-DARK-01** New token dark overrides
- [ ] **TASK-DARK-02** Dark mode form controls
- [ ] **TASK-DARK-03** Dark mode icon inversion (verify)
- [ ] **TASK-DARK-04** Dark mode schema diagram
- [ ] **TASK-DARK-05** Body class dark toggle compatibility

---

## Implementation Rules

All tasks are CSS-only unless explicitly noted otherwise.

When a task says "PHP change acceptable," the allowed PHP change is limited to adding a CSS `class` attribute to a single HTML element. No logic, form fields, URLs, or behavior may change.

Before marking any task complete:
1. Verify the changed element still submits the correct form data
2. Verify JS event handlers still fire (open browser DevTools)
3. Verify dark mode renders correctly
4. Verify mobile layout (≤800px) still works
5. Check existing designs in `designs/` folder do not visually break

---

## Files Modified by This Project

Only these files should be modified:

| File | Change type |
|---|---|
| `adminer/static/default.css` | CSS additions/modifications |
| `adminer/static/dark.css` | CSS additions/modifications |

Optionally (minimal PHP-class additions only):
| File | Change type |
|---|---|
| `adminer/edit.inc.php` | Add `class="danger"` to delete button only |
